From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] diff: introduce diff.submoduleFormat configuration variable
Date: Tue,  2 Oct 2012 22:21:09 +0530
Message-ID: <1349196670-2844-5-git-send-email-artagnon@gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5hg-0007bu-DH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2JBQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:51:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61183 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab2JBQvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:51:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8944010pbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ifg/acLKgHmQiYg0i6hZf7SJ0p/ifOF1mgRjJiQ793k=;
        b=vWvelPJbNdHNts/bc+x7fNBzZckMDsZ5UNf1Zo1dS4WZNenRYq7ypos4gfeLfcjwAZ
         T6pmPQVdNiJnfmydx9OLoGc1o27nAKqYMOY1yfxLLtfIeTrLTBUdOKMMB9rzScoyR4lM
         /1VuJwBUCq5x1SzmFCyPpqTVwyfte0vVrcV4mcIino5byhCZJg1t0tiAHpbSCCv9OXvU
         /g3rNMx/CMbPlPZvKhk7JYDCdyw+cNJ8mR8LFWEjj/1bV0t04kIMm6ncFwEVJfoqnf2B
         TJRrF4qVIxIZ8m5tD5CWjnVxGhrZs1KYXR2Jl+RoysgA0T/e164qHCq4enpXt3DmUxxB
         IjeA==
Received: by 10.68.227.162 with SMTP id sb2mr6026274pbc.4.1349196700694;
        Tue, 02 Oct 2012 09:51:40 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id qd9sm1151524pbb.31.2012.10.02.09.51.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:51:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206818>

Introduce a diff.submoduleFormat configuration variable corresponding
to the '--submodule' command-line option of 'git diff'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt    |    7 +++++++
 Documentation/diff-options.txt   |    3 ++-
 diff.c                           |   25 ++++++++++++++++---------
 t/t4041-diff-submodule-option.sh |   10 ++++++++++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 04574f9..e445cc8 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -103,6 +103,13 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.submoduleFormat::
+	Specify the format in which differences in submodules are
+	shown.  The "log" format lists the commits in the range like
+	linkgit:git-submodule[1] `summary` does.  The "short" format
+	format just shows the names of the commits at the beginning
+	and end of the range.  Defaults to short.
+
 diff.wordRegex::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index cf4b216..034c4e7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -170,7 +170,8 @@ any of those replacements occurred.
 	the commits in the range like linkgit:git-submodule[1] `summary` does.
 	Omitting the `--submodule` option or specifying `--submodule=short`,
 	uses the 'short' format. This format just shows the names of the commits
-	at the beginning and end of the range.
+	at the beginning and end of the range.  Can be tweaked via the
+	`diff.submoduleFormat` configuration variable.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/diff.c b/diff.c
index 8ea40f9..4cb8dd2 100644
--- a/diff.c
+++ b/diff.c
@@ -28,6 +28,7 @@ static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+static const char *submodule_format_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -161,6 +162,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_stat_graph_width = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.submoduleformat"))
+		return git_config_string(&submodule_format_cfg, var, value);
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
@@ -2227,15 +2230,19 @@ static void builtin_diff(const char *name_a,
 		line_prefix = msgbuf->buf;
 	}
 
-	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
-			(!one->mode || S_ISGITLINK(one->mode)) &&
-			(!two->mode || S_ISGITLINK(two->mode))) {
-		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
-		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one ? one->path : two->path,
-				one->sha1, two->sha1, two->dirty_submodule,
-				del, add, reset);
-		return;
+	if (!DIFF_OPT_TST(o, SUBMODULE_SHORT) &&
+		((!one->mode || S_ISGITLINK(one->mode)) &&
+			(!two->mode || S_ISGITLINK(two->mode)))) {
+		if (DIFF_OPT_TST(o, SUBMODULE_LOG) ||
+			(submodule_format_cfg &&
+				!strcmp(submodule_format_cfg, "log"))) {
+			const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
+			const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
+			show_submodule_summary(o->file, one ? one->path : two->path,
+					one->sha1, two->sha1, two->dirty_submodule,
+					del, add, reset);
+			return;
+		}
 	}
 
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 6c01d0c..ed4f3a8 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -43,6 +43,16 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success 'added submodule, set diff.submoduleFormat' "
+	git config diff.submoduleFormat log &&
+	git add sm1 &&
+	git diff --cached >actual &&
+	cat >expected <<-EOF &&
+Submodule sm1 0000000...$head1 (new submodule)
+EOF
+	test_cmp expected actual
+"
+
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-- 
1.7.8.1.362.g5d6df.dirty
