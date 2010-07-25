From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] commit: split off the piece that writes status
Date: Sat, 24 Jul 2010 19:59:09 -0500
Message-ID: <20100725005909.GE18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 03:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpZi-000868-RB
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860Ab0GYBAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 21:00:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46638 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0GYBAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 21:00:12 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so545688gyg.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=I4KJg0vp/CnODTJixm/PB8O/LRsgRNkiQU7NOi/rPQQ=;
        b=Mwd4tvuc6g0n3+FNLpExwDVXhQjd7iqH4h9ydl6MEudhiMRleGgdOiuAQsHufqkdwN
         qzTxqGWxzCDmeivhuojoN/+ERsY8Ku3ST9FDj+aQDEemnwiaKh2ro5nHoi4hPWiNXwe4
         Ab2CI1QRmvvZ/wTr5Jo1t32EXce1faL5sQhj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BpQE10jw8E0J3zmIYWA3x6LWmYWNvY+UoukR/CGDySmTkzcD6TZopva+RxATKc6RrH
         sJsPx37iuVwZbpK7/reCwCBzYTboz5UMuy12JSQKieKmfnpmzK/2rsajjwWMDkTyApgN
         n5EzuNgO6yhJqtrACYEBCc88I8jygi9waDYG0=
Received: by 10.150.207.1 with SMTP id e1mr599460ybg.307.1280019612314;
        Sat, 24 Jul 2010 18:00:12 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id m13sm2195109ybn.9.2010.07.24.18.00.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 18:00:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151697>

The new write_status function takes care of writing status
information about the pending commit (e.g., author name and
whether a merge is pending) to COMMIT_EDITMSG.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |  158 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 85 insertions(+), 73 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b599486..85e560e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -625,15 +625,94 @@ static void add_committer_signoff(struct strbuf *sb)
 	strbuf_release(&sob);
 }
 
+static int write_status(FILE *fp, const char *index_file,
+				const char *prefix, struct wt_status *s)
+{
+	int commitable, saved_color_setting;
+	char *author_ident;
+	const char *committer_ident;
+	int ident_shown = 0;
+
+	if (in_merge)
+		fprintf(fp,
+			"#\n"
+			"# It looks like you may be committing a MERGE.\n"
+			"# If this is not correct, please remove the file\n"
+			"#	%s\n"
+			"# and try again.\n"
+			"#\n",
+			git_path("MERGE_HEAD"));
+
+	fprintf(fp,
+		"\n"
+		"# Please enter the commit message for your changes.");
+	if (cleanup_mode == CLEANUP_ALL)
+		fprintf(fp,
+			" Lines starting\n"
+			"# with '#' will be ignored, and an empty"
+			" message aborts the commit.\n");
+	else /* CLEANUP_SPACE, that is. */
+		fprintf(fp,
+			" Lines starting\n"
+			"# with '#' will be kept; you may remove them"
+			" yourself if you want to.\n"
+			"# An empty message aborts the commit.\n");
+	if (only_include_assumed)
+		fprintf(fp, "# %s\n", only_include_assumed);
+
+	author_ident = xstrdup(fmt_name(author_name, author_email));
+	committer_ident = fmt_name(getenv("GIT_COMMITTER_NAME"),
+				   getenv("GIT_COMMITTER_EMAIL"));
+	if (strcmp(author_ident, committer_ident))
+		fprintf(fp,
+			"%s"
+			"# Author:    %s\n",
+			ident_shown++ ? "" : "#\n",
+			author_ident);
+	free(author_ident);
+
+	if (!user_ident_sufficiently_given())
+		fprintf(fp,
+			"%s"
+			"# Committer: %s\n",
+			ident_shown++ ? "" : "#\n",
+			committer_ident);
+
+	if (ident_shown)
+		fprintf(fp, "#\n");
+
+	saved_color_setting = s->use_color;
+	s->use_color = 0;
+	commitable = run_status(fp, index_file, prefix, 1, s);
+	s->use_color = saved_color_setting;
+	return commitable;
+}
+
+static int something_is_staged(void)
+{
+	unsigned char sha1[20];
+	const char *parent = "HEAD";
+
+	if (!active_nr && read_cache() < 0)
+		die("Cannot read index");
+
+	if (amend)
+		parent = "HEAD^1";
+
+	if (get_sha1(parent, sha1))
+		return !!active_nr;
+	else
+		return index_differs_from(parent, 0);
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s)
 {
-	int commitable, saved_color_setting;
+	int commitable;
 	struct strbuf sb = STRBUF_INIT;
 	FILE *fp;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
-	int ident_shown = 0;
 
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -659,77 +738,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	/* This checks if committer ident is explicitly given */
 	git_committer_info(0);
-	if (use_editor && include_status) {
-		char *author_ident;
-		const char *committer_ident;
-
-		if (in_merge)
-			fprintf(fp,
-				"#\n"
-				"# It looks like you may be committing a MERGE.\n"
-				"# If this is not correct, please remove the file\n"
-				"#	%s\n"
-				"# and try again.\n"
-				"#\n",
-				git_path("MERGE_HEAD"));
-
-		fprintf(fp,
-			"\n"
-			"# Please enter the commit message for your changes.");
-		if (cleanup_mode == CLEANUP_ALL)
-			fprintf(fp,
-				" Lines starting\n"
-				"# with '#' will be ignored, and an empty"
-				" message aborts the commit.\n");
-		else /* CLEANUP_SPACE, that is. */
-			fprintf(fp,
-				" Lines starting\n"
-				"# with '#' will be kept; you may remove them"
-				" yourself if you want to.\n"
-				"# An empty message aborts the commit.\n");
-		if (only_include_assumed)
-			fprintf(fp, "# %s\n", only_include_assumed);
-
-		author_ident = xstrdup(fmt_name(author_name, author_email));
-		committer_ident = fmt_name(getenv("GIT_COMMITTER_NAME"),
-					   getenv("GIT_COMMITTER_EMAIL"));
-		if (strcmp(author_ident, committer_ident))
-			fprintf(fp,
-				"%s"
-				"# Author:    %s\n",
-				ident_shown++ ? "" : "#\n",
-				author_ident);
-		free(author_ident);
-
-		if (!user_ident_sufficiently_given())
-			fprintf(fp,
-				"%s"
-				"# Committer: %s\n",
-				ident_shown++ ? "" : "#\n",
-				committer_ident);
-
-		if (ident_shown)
-			fprintf(fp, "#\n");
-
-		saved_color_setting = s->use_color;
-		s->use_color = 0;
-		commitable = run_status(fp, index_file, prefix, 1, s);
-		s->use_color = saved_color_setting;
-	} else {
-		unsigned char sha1[20];
-		const char *parent = "HEAD";
-
-		if (!active_nr && read_cache() < 0)
-			die("Cannot read index");
-
-		if (amend)
-			parent = "HEAD^1";
-
-		if (get_sha1(parent, sha1))
-			commitable = !!active_nr;
-		else
-			commitable = index_differs_from(parent, 0);
-	}
+	if (use_editor && include_status)
+		commitable = write_status(fp, index_file, prefix, s);
+	else
+		commitable = something_is_staged();
 
 	fclose(fp);
 
-- 
1.7.2.9.ge3789.dirty
