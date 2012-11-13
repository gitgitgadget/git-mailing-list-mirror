From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 2/4] diff: introduce diff.submodule configuration variable
Date: Tue, 13 Nov 2012 21:12:45 +0530
Message-ID: <1352821367-3611-3-git-send-email-artagnon@gmail.com>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIe0-0000rr-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2KMPnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:43:00 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:38905 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab2KMPm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:42:59 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so3254712dak.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8+x8kSI5XC7xnxsQNTJpBTV8Vta/zi9HFuRByakEig4=;
        b=jsOxO7u7L3QfN1iI+xI0Isy13ekHkUkZf8cOXq38J/jjlZdW8OJlhqEn+LiHZEuvkg
         p0HEE39jJbHT1GaLTmnSN3auUHwaKFQHBPkLMgB7Xxa7lJysgBB8vn27zwaAocMpPW5J
         1qwnaLAZg/BtLbwGlHWnl1T9FBknD+J2rntR/rjsWrih5oz+8twHcGNlr+s2hZ7lNHui
         s62kyR9NOKC2N5IIb1XodSFjfomtR7i/BGbOguO2Uraifsd2/SoxLSdKTejvDYpuTAgA
         MCcknsEPaZJpg/y5+EK5HS7MjNjp/zN8olszzSI4BhzINcQT+7C4WIOHXP5a35yK2IVd
         FBFA==
Received: by 10.68.243.72 with SMTP id ww8mr13918263pbc.56.1352821378788;
        Tue, 13 Nov 2012 07:42:58 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id hs2sm3546550pbc.22.2012.11.13.07.42.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 07:42:57 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209622>

Introduce a diff.submodule configuration variable corresponding to the
'--submodule' command-line option of 'git diff'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt    |    7 +++++++
 Documentation/diff-options.txt   |    3 ++-
 diff.c                           |   32 ++++++++++++++++++++++++++++----
 t/t4041-diff-submodule-option.sh |   30 +++++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 6 deletions(-)

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
diff --git a/diff.c b/diff.c
index e89a201..7f2a255 100644
--- a/diff.c
+++ b/diff.c
@@ -123,6 +123,17 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	return ret;
 }
 
+static int parse_submodule_params(struct diff_options *options, const char *value)
+{
+	if (!strcmp(value, "log"))
+		DIFF_OPT_SET(options, SUBMODULE_LOG);
+	else if (!strcmp(value, "short"))
+		DIFF_OPT_CLR(options, SUBMODULE_LOG);
+	else
+		return -1;
+	return 0;
+}
+
 static int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
@@ -178,6 +189,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
 
+	if (!strcmp(var, "diff.submodule")) {
+		if (parse_submodule_params(&default_diff_options, value))
+			warning(_("Unknown value for 'diff.submodule' config variable: '%s'"),
+				value);
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -3475,6 +3493,14 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
+static int parse_submodule_opt(struct diff_options *options, const char *value)
+{
+	if (parse_submodule_params(options, value))
+		die(_("Failed to parse --submodule option parameter: '%s'"),
+			value);
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3655,10 +3681,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		handle_ignore_submodules_arg(options, arg + 20);
 	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
-	else if (!prefixcmp(arg, "--submodule=")) {
-		if (!strcmp(arg + 12, "log"))
-			DIFF_OPT_SET(options, SUBMODULE_LOG);
-	}
+	else if (!prefixcmp(arg, "--submodule="))
+		return parse_submodule_opt(options, arg + 12);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
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
