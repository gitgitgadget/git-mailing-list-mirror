From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 3/5] Set default diff output format after parsing command
 line
Date: Sat, 24 Jun 2006 00:58:25 +0300
Message-ID: <20060624005825.92b46022.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fttxc-0004P0-I3
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbWFWWRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWFWWQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:16:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:45557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752122AbWFWWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:16:58 -0400
Received: by nf-out-0910.google.com with SMTP id m19so277746nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:16:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XJFKPSUGABMHDkPx7t1Yf9Zk4c7r94izdUxBcDMDUD4UI3Cr+jDEhJu11fJucv1SYcHLaXlXV9xahcs3YaqYgfj0fxvFxU2371By3J0Zek6lw0Uv77slxbRW4qzYKF8dYWoHmppGG2ihoiuQfn93DwVGsFJfz/nEAxuQvSfq09o=
Received: by 10.49.42.5 with SMTP id u5mr2867655nfj;
        Fri, 23 Jun 2006 15:16:58 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id x24sm2835884nfb.2006.06.23.15.16.57;
        Fri, 23 Jun 2006 15:16:57 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624003315.804a1796.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22445>

Move code that sets default output format values after command line
argument parsing.  Only set defaults if output_fmt was not touched by
command line options.

This makes "git diff --raw" output only in raw format instead of -p --raw.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff-files.c  |    4 ++++
 builtin-diff-index.c  |    4 ++++
 builtin-diff-stages.c |    3 +++
 builtin-diff-tree.c   |    3 +++
 builtin-diff.c        |    4 +++-
 builtin-log.c         |    4 +++-
 diff.c                |    1 -
 7 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 42ca07d..4cf2e2f 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -36,6 +36,10 @@ int cmd_diff_files(int argc, const char 
 			usage(diff_files_usage);
 		argv++; argc--;
 	}
+
+	if (!rev.diffopt.output_fmt)
+		rev.diffopt.output_fmt = OUTPUT_FMT_RAW;
+
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * rev.max_count is reasonable (0 <= n <= 3),
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index c42ef9a..8e58308 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -28,6 +28,10 @@ int cmd_diff_index(int argc, const char 
 		else
 			usage(diff_cache_usage);
 	}
+
+	if (!rev.diffopt.output_fmt)
+		rev.diffopt.output_fmt = OUTPUT_FMT_RAW;
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
index 7c157ca..c26a589 100644
--- a/builtin-diff-stages.c
+++ b/builtin-diff-stages.c
@@ -85,6 +85,9 @@ int cmd_diff_stages(int ac, const char *
 		ac--; av++;
 	}
 
+	if (!diff_options.output_fmt)
+		diff_options.output_fmt = OUTPUT_FMT_RAW;
+
 	if (ac < 3 ||
 	    sscanf(av[1], "%d", &stage1) != 1 ||
 	    ! (0 <= stage1 && stage1 <= 3) ||
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 3409a39..29b3fe1 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -84,6 +84,9 @@ int cmd_diff_tree(int argc, const char *
 		usage(diff_tree_usage);
 	}
 
+	if (!opt->diffopt.output_fmt)
+		opt->diffopt.output_fmt = OUTPUT_FMT_RAW;
+
 	/*
 	 * NOTE! We expect "a ^b" to be equal to "a..b", so we
 	 * reverse the order of the objects if the second one
diff --git a/builtin-diff.c b/builtin-diff.c
index 372894a..b6f7727 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -276,9 +276,11 @@ int cmd_diff(int argc, const char **argv
 
 	git_config(git_diff_config);
 	init_revisions(&rev);
-	rev.diffopt.output_fmt = OUTPUT_FMT_PATCH;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (!rev.diffopt.output_fmt)
+		rev.diffopt.output_fmt = OUTPUT_FMT_PATCH;
+
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
diff --git a/builtin-log.c b/builtin-log.c
index e4a6385..e72d7fe 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -178,7 +178,6 @@ int cmd_format_patch(int argc, const cha
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
-	rev.diffopt.output_fmt = OUTPUT_FMT_DIFFSTAT | OUTPUT_FMT_PATCH;
 
 	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
@@ -247,6 +246,9 @@ int cmd_format_patch(int argc, const cha
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
+	if (!rev.diffopt.output_fmt)
+		rev.diffopt.output_fmt = OUTPUT_FMT_DIFFSTAT | OUTPUT_FMT_PATCH;
+
 	if (output_directory) {
 		if (use_stdout)
 			die("standard output, or directory, which one?");
diff --git a/diff.c b/diff.c
index 6eb7db0..45c93c9 100644
--- a/diff.c
+++ b/diff.c
@@ -1354,7 +1354,6 @@ static void run_checkdiff(struct diff_fi
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
-	options->output_fmt = OUTPUT_FMT_RAW;
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
-- 
1.4.1.rc1.gf603-dirty
