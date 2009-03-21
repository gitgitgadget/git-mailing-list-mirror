From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow setting default diff options via diff.defaultOptions
Date: Sat, 21 Mar 2009 04:15:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkrg1-0006rt-H7
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 04:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbZCUDNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 23:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbZCUDNn
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 23:13:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:50193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752974AbZCUDNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 23:13:42 -0400
Received: (qmail invoked by alias); 21 Mar 2009 03:13:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 21 Mar 2009 04:13:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MFVxg3nhMIcoydGPJPk+OTE3tm9U3t0j0iePTGN
	NTVIFWAuW5nALQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1237600853-22815-1-git-send-email-keith@cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114024>


The idea is from Keith Cascio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I do not particularly like what this patch does, but I like
	the non-intrusiveness and conciseness of it.

 Documentation/config.txt        |    4 ++++
 Documentation/git-diff.txt      |    3 +++
 builtin-diff.c                  |    1 +
 builtin-log.c                   |    4 ++++
 diff.c                          |   25 +++++++++++++++++++++++++
 diff.h                          |    2 ++
 t/t4037-diff-default-options.sh |   19 +++++++++++++++++++
 7 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100755 t/t4037-diff-default-options.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7506755..4913bd6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -625,6 +625,10 @@ diff.autorefreshindex::
 	affects only 'git-diff' Porcelain, and not lower level
 	'diff' commands, such as 'git-diff-files'.
 
+diff.defaultoptions:
+	The value of this option will be prepended to the command line
+	options of the porcelains showing diffs.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index a2f192f..7025717 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -74,6 +74,9 @@ and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:git-rev-parse[1].
 
+Default options can be set via the config variable
+`diff.defaultOptions`.
+
 OPTIONS
 -------
 :git-diff: 1
diff --git a/builtin-diff.c b/builtin-diff.c
index d75d69b..d9a6e7d 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -296,6 +296,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (nongit)
 		die("Not a git repository");
+	parse_default_diff_options(&rev.diffopt);
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/builtin-log.c b/builtin-log.c
index 8af55d2..2a63652 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -243,6 +243,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
+	parse_default_diff_options(&rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -314,6 +315,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
+	parse_default_diff_options(&rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	count = rev.pending.nr;
@@ -381,6 +383,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
 	rev.verbose_header = 1;
+	parse_default_diff_options(&rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	/*
@@ -412,6 +415,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
+	parse_default_diff_options(&rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
diff --git a/diff.c b/diff.c
index 75d9fab..0e1b321 100644
--- a/diff.c
+++ b/diff.c
@@ -2657,6 +2657,31 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	return 1;
 }
 
+static int default_diff_options(const char *key, const char *value, void *cb)
+{
+	if (!strcmp(key, "diff.defaultoptions")) {
+		char **options = cb;
+		free(*options);
+		*options = xstrdup(value);
+	}
+	return 0;
+}
+
+void parse_default_diff_options(struct diff_options *options)
+{
+	char *default_options = NULL;
+	const char **argv;
+	int argc;
+
+	git_config(default_diff_options, &default_options);
+	if (!default_options)
+		return;
+
+	argc = split_cmdline(default_options, &argv);
+	diff_opt_parse(options, argv, argc);
+	free(argv);
+}
+
 static int parse_num(const char **cp_p)
 {
 	unsigned long num, scale;
diff --git a/diff.h b/diff.h
index 6616877..e05e796 100644
--- a/diff.h
+++ b/diff.h
@@ -270,4 +270,6 @@ extern void diff_no_index(struct rev_info *, int, const char **, int, const char
 
 extern int index_differs_from(const char *def, int diff_flags);
 
+extern void parse_default_diff_options(struct diff_options *options);
+
 #endif /* DIFF_H */
diff --git a/t/t4037-diff-default-options.sh b/t/t4037-diff-default-options.sh
new file mode 100755
index 0000000..0284f7b
--- /dev/null
+++ b/t/t4037-diff-default-options.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='default options for diff'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit a &&
+	test_commit b
+'
+
+test_expect_success 'diff.defaultOptions' '
+	git config diff.defaultOptions --raw &&
+	git diff a > output &&
+	grep ^: output &&
+	test 1 = $(wc -l < output)
+'
+
+test_done
-- 
1.6.2.1.493.g67cf3
