From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Thu,  1 Nov 2012 16:13:49 +0530
Message-ID: <1351766630-4837-3-git-send-email-artagnon@gmail.com>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 11:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTsG5-0006qR-HY
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 11:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab2KAKoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 06:44:08 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44883 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab2KAKoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 06:44:06 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1109665dak.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fBgUzYPNtSDnZM8MLKjXJ7ZKHoOX18jVFzRcxk9eBuk=;
        b=Ugbja/TF97o8ItVam4sDcZyE9vy3p4FoJRSzUbCN4kC5LaoxM31hCoXjMw8QKQz7Ny
         S0MPQ5auSqn9/1n9541fQWxtkii20vltdppthkqmm18lFuOSq8mRzAR99nQ8NV0y6S3P
         4lLAANtzCIN4gD7kxoeUIpbV0gySEWKEFxewU2RkUjTHPnVGIGeyzrq4zKHaObNp936v
         7Mycmfe1mH2K9wkpl1Kbf8iSMzoZcoxhNfStcRSN+kQ4R1nxRijhPwXPIhHON/VLX0BM
         luHrCs56vNusDka3Ry7GJWMY5mlt+UEsd2gNUCTpUQH0VCNo33k7R3osk5HhLgvB364E
         xf4g==
Received: by 10.68.200.33 with SMTP id jp1mr117161116pbc.54.1351766646026;
        Thu, 01 Nov 2012 03:44:06 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id vw4sm3855414pbc.26.2012.11.01.03.44.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 03:44:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208871>

Introduce a diff.submodule configuration variable corresponding to the
'--submodule' command-line option of 'git diff'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt    |    7 +++++++
 Documentation/diff-options.txt   |    3 ++-
 builtin/diff.c                   |    4 ++++
 cache.h                          |    1 +
 diff.c                           |    5 +++++
 t/t4041-diff-submodule-option.sh |   30 +++++++++++++++++++++++++++++-
 6 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index decd370..89dd634 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -107,6 +107,13 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.submodule::
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
index cf4b216..f4f7e25 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -170,7 +170,8 @@ any of those replacements occurred.
 	the commits in the range like linkgit:git-submodule[1] `summary` does.
 	Omitting the `--submodule` option or specifying `--submodule=short`,
 	uses the 'short' format. This format just shows the names of the commits
-	at the beginning and end of the range.
+	at the beginning and end of the range.  Can be tweaked via the
+	`diff.submodule` configuration variable.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/builtin/diff.c b/builtin/diff.c
index 9650be2..6d00311 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -297,6 +297,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 
+	/* Set SUBMODULE_LOG if diff.submodule config var was set */
+	if (submodule_format_cfg && !strcmp(submodule_format_cfg, "log"))
+		DIFF_OPT_SET(&rev.diffopt, SUBMODULE_LOG);
+
 	if (nongit)
 		die(_("Not a git repository"));
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/cache.h b/cache.h
index a58df84..5fc7ba3 100644
--- a/cache.h
+++ b/cache.h
@@ -1220,6 +1220,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
+extern const char *submodule_format_cfg;
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
diff --git a/diff.c b/diff.c
index 86e5f2a..835eb26 100644
--- a/diff.c
+++ b/diff.c
@@ -29,6 +29,7 @@ static int diff_use_color_default = -1;
 static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+const char *submodule_format_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -168,6 +169,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_stat_graph_width = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.submodule"))
+		return git_config_string(&submodule_format_cfg, var, value);
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
@@ -3656,6 +3659,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!prefixcmp(arg, "--submodule=")) {
 		if (!strcmp(arg + 12, "log"))
 			DIFF_OPT_SET(options, SUBMODULE_LOG);
+		if (!strcmp(arg + 12, "short"))
+			DIFF_OPT_CLR(options, SUBMODULE_LOG);
 	}
 
 	/* misc options */
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 6c01d0c..e401814 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -33,6 +33,7 @@ test_create_repo sm1 &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
+fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
 
 test_expect_success 'added submodule' "
 	git add sm1 &&
@@ -43,6 +44,34 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success 'added submodule, set diff.submodule' "
+	git config diff.submodule log &&
+	git add sm1 &&
+	git diff --cached >actual &&
+	cat >expected <<-EOF &&
+Submodule sm1 0000000...$head1 (new submodule)
+EOF
+	git config --unset diff.submodule &&
+	test_cmp expected actual
+"
+
+test_expect_success '--submodule=short overrides diff.submodule' "
+	git config diff.submodule log &&
+	git add sm1 &&
+	git diff --submodule=short --cached >actual &&
+	cat >expected <<-EOF &&
+diff --git a/sm1 b/sm1
+new file mode 160000
+index 0000000..a2c4dab
+--- /dev/null
++++ b/sm1
+@@ -0,0 +1 @@
++Subproject commit $fullhead1
+EOF
+	git config --unset diff.submodule &&
+	test_cmp expected actual
+"
+
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
@@ -73,7 +102,6 @@ EOF
 	test_cmp expected actual
 "
 
-fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
 fullhead2=$(cd sm1; git rev-list --max-count=1 $head2)
 test_expect_success 'modified submodule(forward) --submodule=short' "
 	git diff --submodule=short >actual &&
-- 
1.7.8.1.362.g5d6df.dirty
