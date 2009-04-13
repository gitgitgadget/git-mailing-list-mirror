From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add the diff option --no-defaults
Date: Tue, 14 Apr 2009 00:37:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
 <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUlW-0007Qx-CS
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbZDMWfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 18:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZDMWfB
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:35:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:33064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751593AbZDMWfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 18:35:00 -0400
Received: (qmail invoked by alias); 13 Apr 2009 22:34:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 14 Apr 2009 00:34:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rdn1A5AXrcjmqYOAOgh4XLp6Fg1qdUXfC/AHb3Y
	Yk8Ekpx2Ct5+LL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090410080155.GB32195@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116495>


It would be desirable to undo every setting in diff.defaultOptions
individually, but until there are options to reset every command
line option, there is the "--no-defaults" option (which can be
overridden by the "--defaults" option) to ignore the config setting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

On Fri, 10 Apr 2009, Jeff King wrote:

> On Thu, Apr 09, 2009 at 12:43:28PM +0200, Johannes Schindelin wrote:
> 
> > > > Now, it is easy to put a patch on top of my patch to support something 
> > > > like --no-defaults.
> > > 
> > > No, it's not. We went over this in great detail earlier in the thread. 
> > > If you want:
> > > 
> > >   git diff --no-defaults
> > > 
> > > then you basically have to parse twice to avoid the chicken-and-egg
> > > problem.
> > 
> > So what?  We parse the config a gazillion times, and there we have to 
> > access the _disk_.
> 
> But the first parse is only looking for "--no-defaults". So you need to:
> 
>   1. Understand the semantics of the other options to correctly parse
>      around them (i.e., knowing which ones take arguments).
> 
>   2. Parse the arguments without actually respecting most of them, since
>      they will be parsed again later.
> 
> This would actually be pretty easy if we had a declarative structure
> describing each option (like parseopt-ified options do). But the diff
> options are parsed by a big conditional statement.
> 
> Two ways to make it easier would be:
> 
>   1. You could loosen (1) above by assuming that --no-defaults will
>      never appears as the argument to an option, and therefore any time
>      you find it, it should be respected. Thus your first parse is just
>      a simple loop looking for the option.
> 
>   2. You could loosen (2) above by assuming that all options are
>      idempotent. I don't know whether this is the case (I think it
>      isn't for all git options, but a cursory look shows that it may be
>      for diff options).

I go with 1)

 builtin-diff.c                  |    2 +-
 builtin-log.c                   |    8 ++++----
 diff.c                          |   29 ++++++++++++++++++++++-------
 diff.h                          |    2 +-
 t/t4037-diff-default-options.sh |    5 +++++
 5 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index d9a6e7d..8da0052 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -296,7 +296,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (nongit)
 		die("Not a git repository");
-	parse_default_diff_options(&rev.diffopt);
+	argc = parse_default_diff_options(argc, argv, &rev.diffopt);
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/builtin-log.c b/builtin-log.c
index e926774..2f36537 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -243,7 +243,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
-	parse_default_diff_options(&rev.diffopt);
+	argc = parse_default_diff_options(argc, argv, &rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -315,7 +315,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
-	parse_default_diff_options(&rev.diffopt);
+	argc = parse_default_diff_options(argc, argv, &rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	count = rev.pending.nr;
@@ -383,7 +383,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
 	rev.verbose_header = 1;
-	parse_default_diff_options(&rev.diffopt);
+	argc = parse_default_diff_options(argc, argv, &rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	/*
@@ -415,7 +415,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
-	parse_default_diff_options(&rev.diffopt);
+	argc = parse_default_diff_options(argc, argv, &rev.diffopt);
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
diff --git a/diff.c b/diff.c
index 6e76377..903dbb4 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "sigchain.h"
+#include "parse-options.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -2682,19 +2683,33 @@ static int default_diff_options(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-void parse_default_diff_options(struct diff_options *options)
+int parse_default_diff_options(int real_argc, const char **real_argv,
+	struct diff_options *options)
 {
+	int use_defaults = 1;
+	struct option option[] = {
+		OPT_BOOLEAN(0, "defaults", &use_defaults, "use diff defaults"),
+		OPT_END()
+	};
 	char *default_options = NULL;
 	const char **argv;
 	int argc;
 
-	git_config(default_diff_options, &default_options);
-	if (!default_options)
-		return;
+	real_argc = parse_options(real_argc, real_argv, option, NULL,
+		PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+		PARSE_OPT_NO_INTERNAL_HELP);
+
+	if (use_defaults) {
+		git_config(default_diff_options, &default_options);
+		if (!default_options)
+			return real_argc;
+
+		argc = split_cmdline(default_options, &argv);
+		diff_opt_parse(options, argv, argc);
+		free(argv);
+	}
 
-	argc = split_cmdline(default_options, &argv);
-	diff_opt_parse(options, argv, argc);
-	free(argv);
+	return real_argc;
 }
 
 static int parse_num(const char **cp_p)
diff --git a/diff.h b/diff.h
index e05e796..764e2f6 100644
--- a/diff.h
+++ b/diff.h
@@ -270,6 +270,6 @@ extern void diff_no_index(struct rev_info *, int, const char **, int, const char
 
 extern int index_differs_from(const char *def, int diff_flags);
 
-extern void parse_default_diff_options(struct diff_options *options);
+extern int parse_default_diff_options(int argc, const char **argv, struct diff_options *options);
 
 #endif /* DIFF_H */
diff --git a/t/t4037-diff-default-options.sh b/t/t4037-diff-default-options.sh
index 0284f7b..f57d65f 100755
--- a/t/t4037-diff-default-options.sh
+++ b/t/t4037-diff-default-options.sh
@@ -16,4 +16,9 @@ test_expect_success 'diff.defaultOptions' '
 	test 1 = $(wc -l < output)
 '
 
+test_expect_success '--no-defaults' '
+	git diff --no-defaults > output &&
+	! grep ^: output
+'
+
 test_done
-- 
1.6.2.1.613.g25746
