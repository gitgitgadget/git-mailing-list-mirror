From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4 v2] Allow detached form (e.g. "-S foo" instead of "-Sfoo") for diff options
Date: Wed, 28 Jul 2010 11:40:59 +0200
Message-ID: <1280310062-16793-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 11:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3Bw-0007Gu-Qn
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0G1Joo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:44:44 -0400
Received: from imag.imag.fr ([129.88.30.1]:57503 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab0G1Jon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:44:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6S9f45j019842
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 11:41:04 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38K-0000KP-Mu; Wed, 28 Jul 2010 11:41:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38K-0004NR-Kn; Wed, 28 Jul 2010 11:41:04 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <vpqr5ioukca.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Jul 2010 11:41:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152063>

This patch does not handle --stat-name-width and --stat-width, which are
special-cases where diff_long_opt do not apply. They are handled in a
separate patch to ease review.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c                       |   86 ++++++++++++++++++++++++++++++++++--------
 diff.h                       |    7 +++
 t/t4013-diff-various.sh      |    1 +
 t/t4013/diff.log_-S_F_master |    7 +++
 t/t4202-log.sh               |    5 ++
 5 files changed, 90 insertions(+), 16 deletions(-)
 create mode 100644 t/t4013/diff.log_-S_F_master

diff --git a/diff.c b/diff.c
index 17873f3..1868b3e 100644
--- a/diff.c
+++ b/diff.c
@@ -2990,9 +2990,50 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 
 static int diff_scoreopt_parse(const char *opt);
 
+static inline int short_opt(char opt, const char **argv,
+			    const char **optarg)
+{
+	const char *arg = argv[0];
+	if (arg[0] != '-' || arg[1] != opt)
+		return 0;
+	if (arg[2] != '\0') {
+		*optarg = arg + strlen("-c");
+		return 1;
+	}
+	if (!argv[1])
+		die("Option '%c' requires a value", opt);
+	*optarg = argv[1];
+	return 2;
+}
+
+int diff_long_opt(const char *opt, const char **argv,
+		  const char **optarg)
+{
+	const char *arg = argv[0];
+	if (arg[0] != '-' || arg[1] != '-')
+		return 0;
+	arg += strlen("--");
+	if (prefixcmp(arg, opt))
+		return 0;
+	arg += strlen(opt);
+	if (*arg == '=') { /* Sticky form: --option=value */
+		*optarg = arg + 1;
+		return 1;
+	}
+	if (*arg != '\0')
+		return 0;
+	/* detached form: --option value */
+	if (!argv[1])
+		die("Option '--%s' requires a value", opt);
+	*optarg = argv[1];
+	return 2;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
+	const char *optarg;
+	int argcount;
 
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
@@ -3149,10 +3190,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else
 			die("bad --word-diff argument: %s", type);
 	}
-	else if (!prefixcmp(arg, "--word-diff-regex=")) {
+	else if ((argcount = diff_long_opt("word-diff-regex", av, &optarg))) {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
-		options->word_regex = arg + 18;
+		options->word_regex = optarg;
+		return argcount;
 	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
@@ -3180,18 +3222,26 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
-	else if (!prefixcmp(arg, "-l"))
-		options->rename_limit = strtoul(arg+2, NULL, 10);
-	else if (!prefixcmp(arg, "-S"))
-		options->pickaxe = arg + 2;
+	else if ((argcount = short_opt('l', av, &optarg))) {
+		options->rename_limit = strtoul(optarg, NULL, 10);
+		return argcount;
+	}
+	else if ((argcount = short_opt('S', av, &optarg))) {
+		options->pickaxe = optarg;
+		return argcount;
+	}
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts = DIFF_PICKAXE_ALL;
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
-	else if (!prefixcmp(arg, "-O"))
-		options->orderfile = arg + 2;
-	else if (!prefixcmp(arg, "--diff-filter="))
-		options->filter = arg + 14;
+	else if ((argcount = short_opt('O', av, &optarg))) {
+		options->orderfile = optarg;
+		return argcount;
+	}
+	else if ((argcount = diff_long_opt("diff-filter", av, &optarg))) {
+		options->filter = optarg;
+		return argcount;
+	}
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (!prefixcmp(arg, "--abbrev=")) {
@@ -3201,20 +3251,24 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
-	else if (!prefixcmp(arg, "--src-prefix="))
-		options->a_prefix = arg + 13;
-	else if (!prefixcmp(arg, "--dst-prefix="))
-		options->b_prefix = arg + 13;
+	else if ((argcount = diff_long_opt("src-prefix", av, &optarg))) {
+		options->a_prefix = optarg;
+		return argcount;
+	}
+	else if ((argcount = diff_long_opt("dst-prefix", av, &optarg))) {
+		options->b_prefix = optarg;
+	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-	else if (!prefixcmp(arg, "--output=")) {
-		options->file = fopen(arg + strlen("--output="), "w");
+	else if ((argcount = diff_long_opt("output", av, &optarg))) {
+		options->file = fopen(optarg, "w");
 		if (!options->file)
 			die_errno("Could not open '%s'", arg + strlen("--output="));
 		options->close_file = 1;
+		return argcount;
 	} else
 		return 0;
 	return 1;
diff --git a/diff.h b/diff.h
index 063d10a..3b11732 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,13 @@ extern void diff_unmerge(struct diff_options *,
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
+/*
+ * Poor man's alternative to parse-option, to allow both sticky form
+ * (--option=value) and detached form (--option value).
+ */
+extern int diff_long_opt(const char *opt, const char **argv,
+			 const char **optarg);
+
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
 extern int diff_use_color_default;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dae6358..8036e00 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -208,6 +208,7 @@ log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
 log -SF master
+log -S F master
 log -SF -p master
 log --decorate --all
 log --decorate=full --all
diff --git a/t/t4013/diff.log_-S_F_master b/t/t4013/diff.log_-S_F_master
new file mode 100644
index 0000000..978d2b4
--- /dev/null
+++ b/t/t4013/diff.log_-S_F_master
@@ -0,0 +1,7 @@
+$ git log -S F master
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+$
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2230e60..3352935 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -101,11 +101,16 @@ test_expect_success 'oneline' '
 test_expect_success 'diff-filter=A' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=A HEAD) &&
+	actual_detached=$(git log --pretty="format:%s" --diff-filter A HEAD) &&
 	expect=$(echo fifth ; echo fourth ; echo third ; echo initial) &&
 	test "$actual" = "$expect" || {
 		echo Oops
 		echo "Actual: $actual"
 		false
+	} &&
+	test "$actual" = "$actual_detached" || {
+		echo Oops. Detached form broken
+		echo "Actual_detached: $actual_detached"
 	}
 
 '
-- 
1.7.2.25.g9ebe3
