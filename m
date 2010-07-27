From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] Allow detached form (e.g. "-S foo" instead of "-Sfoo") for diff options
Date: Tue, 27 Jul 2010 23:21:56 +0200
Message-ID: <1280265719-30968-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 27 23:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrcR-0002qX-V9
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab0G0VXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:23:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42533 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab0G0VXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:23:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6RLKI5B026590
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 23:20:18 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Odrb8-00025h-HW; Tue, 27 Jul 2010 23:22:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Odrb8-00084m-GO; Tue, 27 Jul 2010 23:22:02 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Jul 2010 23:20:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RLKI5B026590
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280870419.48513@nVd/ihogZCr42veF27+LXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152002>

This patch does not handle --stat-name-width and --stat-width, which are
special-cases where IF_LONG_OPT do not apply. They are handled in a
separate patch to ease review.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c                       |   61 +++++++++++++++++++++++++++++++-----------
 diff.h                       |   15 ++++++++++
 t/t4013-diff-various.sh      |    1 +
 t/t4013/diff.log_-S_F_master |    7 +++++
 t/t4202-log.sh               |    5 +++
 5 files changed, 73 insertions(+), 16 deletions(-)
 create mode 100644 t/t4013/diff.log_-S_F_master

diff --git a/diff.c b/diff.c
index 17873f3..41b39be 100644
--- a/diff.c
+++ b/diff.c
@@ -2990,9 +2990,23 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 
 static int diff_scoreopt_parse(const char *opt);
 
-int diff_opt_parse(struct diff_options *options, const char **av, int ac)
+int diff_opt_parse(struct diff_options *options, const char **argv, int ac)
 {
-	const char *arg = av[0];
+	const char *arg = argv[0];
+	const char *optarg;
+	int argcount;
+
+#define IF_SHORT_OPT(optname)			\
+	((!strcmp(arg, "-" #optname)		\
+	  && (argv[1] || (die("Option `" #optname "' requires a value"), 1),	\
+	      optarg   = argv[1],	       		\
+	      argcount = 2,			\
+	      1)) ||				\
+	 (!prefixcmp(arg, "-" #optname)		\
+	  && (optarg = arg + strlen("-" #optname),	\
+	      argcount = 1,			\
+	       1)))
+
 
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
@@ -3149,10 +3163,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else
 			die("bad --word-diff argument: %s", type);
 	}
-	else if (!prefixcmp(arg, "--word-diff-regex=")) {
+	else if (IF_LONG_OPT(word-diff-regex)) {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
-		options->word_regex = arg + 18;
+		options->word_regex = optarg;
+		return argcount;
 	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
@@ -3180,18 +3195,28 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
+	else if (!strcmp(arg, "-l")) {
+		options->rename_limit = strtoul(optarg, NULL, 10);
+		return 2;
+	}
 	else if (!prefixcmp(arg, "-l"))
 		options->rename_limit = strtoul(arg+2, NULL, 10);
-	else if (!prefixcmp(arg, "-S"))
-		options->pickaxe = arg + 2;
+	else if (IF_SHORT_OPT(S)) {
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
+	else if (IF_SHORT_OPT(O)) {
+		options->orderfile = optarg;
+		return argcount;
+	}
+	else if (IF_LONG_OPT(diff-filter)) {
+		options->filter = optarg;
+		return argcount;
+	}
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (!prefixcmp(arg, "--abbrev=")) {
@@ -3201,20 +3226,24 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
-	else if (!prefixcmp(arg, "--src-prefix="))
-		options->a_prefix = arg + 13;
-	else if (!prefixcmp(arg, "--dst-prefix="))
-		options->b_prefix = arg + 13;
+	else if (IF_LONG_OPT(src-prefix)) {
+		options->a_prefix = optarg;
+		return argcount;
+	}
+	else if (IF_LONG_OPT(dst-prefix)) {
+		options->b_prefix = optarg;
+	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-	else if (!prefixcmp(arg, "--output=")) {
-		options->file = fopen(arg + strlen("--output="), "w");
+	else if (IF_LONG_OPT(output)) {
+		options->file = fopen(optarg, "w");
 		if (!options->file)
 			die_errno("Could not open '%s'", arg + strlen("--output="));
 		options->close_file = 1;
+		return argcount;
 	} else
 		return 0;
 	return 1;
diff --git a/diff.h b/diff.h
index 063d10a..ca1a693 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,21 @@ extern void diff_unmerge(struct diff_options *,
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
+/*
+ * Poor man's alternative to parse-option, only meant to be used in
+ * handle_revision_opt and  diff_opt_parse.
+ */
+#define IF_LONG_OPT(optname)					\
+	((!strcmp(arg, "--" #optname)				\
+	  && (argv[1] || (die("Option `" #optname "' requires a value"), 1), \
+	      optarg   = argv[1],	       			\
+	      argcount = 2,					\
+	      1)) ||						\
+	 (!prefixcmp(arg, "--" #optname "=")			\
+	  && (optarg = arg + strlen("--" #optname "="),		\
+	      argcount = 1,					\
+	      1)))
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
