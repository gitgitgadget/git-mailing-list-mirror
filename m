From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Sun, 11 Nov 2012 22:29:05 +0530
Message-ID: <1352653146-3932-3-git-send-email-artagnon@gmail.com>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:59:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXasf-00055R-T7
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2KKQ7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:59:21 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59164 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab2KKQ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:59:20 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2391580dak.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xxhHkYO12NDVw7cxoReCc0/EwLOUUtCxpcoJm1yWnmg=;
        b=S9svl1yMCivc8WYS/VbBChf/CiWRykqZitDRLGEdtuEhElKNZcJ63YoZf5o6o6RhLM
         SBY8mTfdxw0MIWZ2rxEHvwY5KqiRqpevg1gRFdhZ8YqUkpJAKnAjGhWxrxU8h3NPwxyl
         X2eqAol9YNYoMZbav0mEAsFgE2YQtVEBjBEYzcWA0klAG6Vq4Ea6OlH52mb/Ys66Az6x
         UysPcGEzZlF0U9/iYLXl4cneV5dnmOe+eEe6A7WY3pDEek789sZ2+Bd4BQGjN4JTgAC8
         nY0eyiQK2EWX0tUlwc2F80a/4DS/WPOj34RgtlBrAvPjXlgoUyfsUqEfoi8Kz+2tJ1OE
         AS2Q==
Received: by 10.66.78.169 with SMTP id c9mr48378826pax.30.1352653160293;
        Sun, 11 Nov 2012 08:59:20 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id s1sm2824079paz.0.2012.11.11.08.59.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 08:59:19 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209411>

Introduce a diff.submodule configuration variable corresponding to the
'--submodule' command-line option of 'git diff'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt    |    7 ++++++
 Documentation/diff-options.txt   |    3 +-
 cache.h                          |    1 +
 diff.c                           |   40 ++++++++++++++++++++++++++++++++++---
 t/t4041-diff-submodule-option.sh |   30 +++++++++++++++++++++++++++-
 5 files changed, 75 insertions(+), 6 deletions(-)

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
diff --git a/cache.h b/cache.h
index dbd8018..4d9dbc7 100644
--- a/cache.h
+++ b/cache.h
@@ -1221,6 +1221,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
+extern const char *submodule_format_cfg;
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
diff --git a/diff.c b/diff.c
index e89a201..b486070 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@ static int diff_use_color_default = -1;
 static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+const char *submodule_format_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -123,6 +124,20 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	return ret;
 }
 
+static int parse_submodule_params(struct diff_options *options, const char *value,
+				struct strbuf *errmsg)
+{
+	if (!strcmp(value, "log"))
+		DIFF_OPT_SET(options, SUBMODULE_LOG);
+	else if (!strcmp(value, "short"))
+		DIFF_OPT_CLR(options, SUBMODULE_LOG);
+	else {
+		strbuf_addf(errmsg, _("'%s'"), value);
+		return 1;
+	}
+	return 0;
+}
+
 static int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
@@ -223,6 +238,15 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.submodule")) {
+		struct strbuf errmsg = STRBUF_INIT;
+		if (parse_submodule_params(&default_diff_options, value, &errmsg))
+			warning(_("Unknown value for 'diff.submodule' config variable: %s"),
+				errmsg.buf);
+		strbuf_release(&errmsg);
+		return 0;
+	}
+
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
@@ -3475,6 +3499,16 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
+static int parse_submodule_opt(struct diff_options *options, const char *params)
+{
+	struct strbuf errmsg = STRBUF_INIT;
+	if (parse_submodule_params(options, params, &errmsg))
+		die(_("Failed to parse --submodule option parameter: %s"),
+			errmsg.buf);
+	strbuf_release(&errmsg);
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3655,10 +3689,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
