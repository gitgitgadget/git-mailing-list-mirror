From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ident: die on bogus date format
Date: Mon, 20 Dec 2010 17:00:36 -0800
Message-ID: <7v62uoaqiz.fsf@alter.siamese.dyndns.org>
References: <loom.20101213T161633-993@post.gmane.org>
 <20101213170225.GA16033@sigill.intra.peff.net>
 <7vei9ipusf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 21 02:00:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUqaz-0005R8-VC
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 02:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103Ab0LUBAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 20:00:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab0LUBAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 20:00:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B471538DA;
	Mon, 20 Dec 2010 20:01:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uWHm92o1CK3sdLdYuR6aE7y0fQE=; b=CR+JikkBalKgunEOETTcbks
	4DJgEcrN3Koh5rlYtJZIbmEjJhx2yDl9r2IvNmlMbtR55Slpm/vmG30aoyNJlX/j
	gK4Dy+2ASnYmIQavVbtXshmLrJ1mvfKFDOnf2it6j97k8etbTDfwmQQwwxQy/ilM
	DoKdJHeDmHQGQvIV1avQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ciYBAGf92WFJaAAEjRBn3D9HlSENnWaF38/2aCEwMAxXT6CCX
	aJWL7PVIL+4ljPDJYEm4PAwmcbwNKDO4dxfdCcQK9vySFr02aSYjWLk/CPThOr2i
	qHViTMXYuS0saduDhGeG4qnzOvJvVggKeqpj5jlwOIjH1MRhHFdusJTTA8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83A0038D9;
	Mon, 20 Dec 2010 20:01:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C99A538D8; Mon, 20 Dec 2010
 20:01:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDE727C4-0C9D-11E0-B65D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164022>

Junio C Hamano <gitster@pobox.com> writes:

> After determine_author_info() returns to prepare_to_commit(), we have a
> call to git_committer_info() only to discard the outcome from....
> ...  We can do this by
> adding a new parameter (strbuf) to prepare_to_commit(), I think.

Heh, I was an idiot, and mixed up author and committer in the above.
But I think it is worth trying to avoid asking the user to edit when
we know that a bad author ident will result in an error later.

How about doing it like this?

-- >8 --
Subject: commit: die before asking to edit the log message

When determine_author_info() returns to the calling prepare_to_commit(),
we already know the pieces of information necessary to determine what
author ident will be used in the final message, but deferred making a call
to fmt_ident() before the final commit_tree().  Most importantly, we would
open the editor to ask the user to compose the log message before it.

As one important side effect of fmt_ident() is to error out when the given
information is malformed, this resulted in us spawning the editor first
and then refusing to commit due to error, even though we had enough
information to detect the error before starting the editor, which was
annoying.

Move the fmt_ident() call to the end of determine_author_info() where we
have final determination of author info to rectify this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |   54 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..3bcb4b7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -69,7 +69,6 @@ static enum {
 static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
-static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
@@ -459,7 +458,7 @@ static int is_a_merge(const unsigned char *sha1)
 
 static const char sign_off_header[] = "Signed-off-by: ";
 
-static void determine_author_info(void)
+static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 
@@ -503,10 +502,8 @@ static void determine_author_info(void)
 
 	if (force_date)
 		date = force_date;
-
-	author_name = name;
-	author_email = email;
-	author_date = date;
+	strbuf_addstr(author_ident, fmt_ident(name, email, date,
+					      IDENT_ERROR_ON_NO_NAME));
 }
 
 static int ends_rfc2822_footer(struct strbuf *sb)
@@ -550,10 +547,21 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 	return 1;
 }
 
+static char *cut_ident_timestamp_part(char *string)
+{
+	char *ket = strrchr(string, '>');
+	if (!ket || ket[1] != ' ')
+		die("Malformed ident string: '%s'", string);
+	*++ket = '\0';
+	return ket;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
-			     struct wt_status *s)
+			     struct wt_status *s,
+			     struct strbuf *author_ident)
 {
 	struct stat statbuf;
+	struct strbuf committer_ident = STRBUF_INIT;
 	int commitable, saved_color_setting;
 	struct strbuf sb = STRBUF_INIT;
 	char *buffer;
@@ -637,14 +645,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	strbuf_release(&sb);
 
-	determine_author_info();
+	/* This checks and barfs if author is badly specified */
+	determine_author_info(author_ident);
 
 	/* This checks if committer ident is explicitly given */
-	git_committer_info(0);
+	strbuf_addstr(&committer_ident, git_committer_info(0));
 	if (use_editor && include_status) {
-		char *author_ident;
-		const char *committer_ident;
-
+		char *ai_tmp, *ci_tmp;
 		if (in_merge)
 			fprintf(fp,
 				"#\n"
@@ -672,23 +679,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
 
-		author_ident = xstrdup(fmt_name(author_name, author_email));
-		committer_ident = fmt_name(getenv("GIT_COMMITTER_NAME"),
-					   getenv("GIT_COMMITTER_EMAIL"));
-		if (strcmp(author_ident, committer_ident))
+		ai_tmp = cut_ident_timestamp_part(author_ident->buf);
+		ci_tmp = cut_ident_timestamp_part(committer_ident.buf);
+		if (strcmp(author_ident->buf, committer_ident.buf))
 			fprintf(fp,
 				"%s"
 				"# Author:    %s\n",
 				ident_shown++ ? "" : "#\n",
-				author_ident);
-		free(author_ident);
+				author_ident->buf);
 
 		if (!user_ident_sufficiently_given())
 			fprintf(fp,
 				"%s"
 				"# Committer: %s\n",
 				ident_shown++ ? "" : "#\n",
-				committer_ident);
+				committer_ident.buf);
 
 		if (ident_shown)
 			fprintf(fp, "#\n");
@@ -697,6 +702,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		s->use_color = 0;
 		commitable = run_status(fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
+
+		*ai_tmp = ' ';
+		*ci_tmp = ' ';
 	} else {
 		unsigned char sha1[20];
 		const char *parent = "HEAD";
@@ -712,6 +720,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		else
 			commitable = index_differs_from(parent, 0);
 	}
+	strbuf_release(&committer_ident);
 
 	fclose(fp);
 
@@ -1246,6 +1255,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
@@ -1273,7 +1283,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
-	if (!prepare_to_commit(index_file, prefix, &s)) {
+	if (!prepare_to_commit(index_file, prefix, &s, &author_ident)) {
 		rollback_index_files();
 		return 1;
 	}
@@ -1352,11 +1362,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1,
-			fmt_ident(author_name, author_email, author_date,
-				IDENT_ERROR_ON_NO_NAME))) {
+			author_ident.buf)) {
 		rollback_index_files();
 		die("failed to write commit object");
 	}
+	strbuf_release(&author_ident);
 
 	ref_lock = lock_any_ref_for_update("HEAD",
 					   initial_commit ? NULL : head_sha1,
