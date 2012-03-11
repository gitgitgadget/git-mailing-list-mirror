From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] commit: pass author/committer info to hooks
Date: Sun, 11 Mar 2012 04:11:38 -0700
Message-ID: <7vsjhfxuhh.fsf_-_@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
 <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 12:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6ggl-0004yh-5L
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab2CKLLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:11:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2CKLLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:11:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0A96E9A;
	Sun, 11 Mar 2012 07:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WyskbLDNamczAe/tbKjcikHEJzs=; b=GIqBcG
	gDCyJ7hDVG17ixl6QGS1LnKuqM66GiLsByy+TDvByraqjs43M8vTxMSUECoL+qMu
	iqu5CFyI/RQkPT9+bOvL8PSBepXNlF5miMI1hoJrFWDVhnyHEd/EkmnUaEZWod4r
	tLHDT6UNie7PUzkNJEqsb84NOSYI845l7kYUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oq7mN7ZvbnxXo6x9X3UQ6DEb00zuJ3rH
	rnx9VPuBOXqL6UMyVqn/06eFLjaVcWAK3KjVcC8ooZ9amxBkAxozJ7176z9cw9H/
	fP8nK7BmD4cHtJpRUmEcmiae5XD/DPkvFMImC2BTozh+nkS0pS3/I8W13GkWJyh3
	zm9sox/oDQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8578D6E99;
	Sun, 11 Mar 2012 07:11:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3C996E98; Sun, 11 Mar 2012
 07:11:39 -0400 (EDT)
In-Reply-To: <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 04:09:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9CC4AEA-6B6A-11E1-8C0A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192805>

When lying the author name via GIT_AUTHOR_NAME environment variable
to "git commit", the hooks run by the command saw it and could act
on the name that will be recorded in the final commit. When the user
uses the "--author" option from the command line, the command should
give the same information to the hook, and back when "git command"
was a scripted Porcelain, it did set the environment variable and
hooks can learn the author name from it.

However, when the command was reimplemented in C, the rewritten code
was not very faithful to the original, and hooks stopped getting the
authorship information given with "--author".  Fix this by exporting
the necessary environment variables.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is the last patch of the simpler of the two approaches, that
   builds on top of the two common preparatory patches.  It uses setenv()
   to directly affect the execution environment of "git commit" process,
   which is closer to the original scripted Porcelain implementation.

 builtin/commit.c           |   22 +++++++++++++++++++---
 t/t7503-pre-commit-hook.sh |    2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eae5a29..57a60f9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -533,9 +533,20 @@ static int is_a_merge(const struct commit *current_head)
 
 static const char sign_off_header[] = "Signed-off-by: ";
 
+static void export_one(const char *var, const char *s, const char *e, int hack)
+{
+	struct strbuf buf = STRBUF_INIT;
+	if (hack)
+		strbuf_addch(&buf, hack);
+	strbuf_addf(&buf, "%.*s", (int)(e - s), s);
+	setenv(var, buf.buf, 1);
+	strbuf_release(&buf);
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
+	struct ident_split author;
 
 	name = getenv("GIT_AUTHOR_NAME");
 	email = getenv("GIT_AUTHOR_EMAIL");
@@ -585,6 +596,11 @@ static void determine_author_info(struct strbuf *author_ident)
 		date = force_date;
 	strbuf_addstr(author_ident, fmt_ident(name, email, date,
 					      IDENT_ERROR_ON_NO_NAME));
+	if (!split_ident_line(&author, author_ident->buf, author_ident->len)) {
+		export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
+		export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
+		export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
+	}
 }
 
 static int ends_rfc2822_footer(struct strbuf *sb)
@@ -652,6 +668,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int ident_shown = 0;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 
+	/* This checks and barfs if author is badly specified */
+	determine_author_info(author_ident);
+
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
 
@@ -771,9 +790,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	strbuf_release(&sb);
 
-	/* This checks and barfs if author is badly specified */
-	determine_author_info(author_ident);
-
 	/* This checks if committer ident is explicitly given */
 	strbuf_addstr(&committer_ident, git_committer_info(0));
 	if (use_editor && include_status) {
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index fc6de5b..9301a0c 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -118,7 +118,7 @@ test_expect_success 'with failing hook requiring GIT_PREFIX' '
 	git checkout -- file
 '
 
-test_expect_failure 'check the author in hook' '
+test_expect_success 'check the author in hook' '
 	cat >"$HOOK" <<-\EOF &&
 	test "$GIT_AUTHOR_NAME" = "New Author" &&
 	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
-- 
1.7.10.rc0.33.g8866af
