From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 4/7] Set default diff output format after parsing command
 line
Date: Sat, 24 Jun 2006 20:24:14 +0300
Message-ID: <20060624202414.d03cec6e.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxm-0001XZ-KH
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWFXRa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWFXRa0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:12043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750957AbWFXRaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:25 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402611nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=I7PYXKBfZ84sQHlglH0GZGwJbZVKxRZSKTYi/FAoMYFeUSXbZwVq80kghDfl0KpqupqODNlBlKl4109j2Vl10NXzSm6+5jhK1ijjBjCEaJA97ANGr/JNC74g9EhRzuuRmfKyEYAOfYJMb42oqMmdW8vfsVWdt4/XCl75Pf9LWZ4=
Received: by 10.49.4.17 with SMTP id g17mr3526359nfi;
        Sat, 24 Jun 2006 10:30:24 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id p72sm2585827nfc.2006.06.24.10.30.23;
        Sat, 24 Jun 2006 10:30:23 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22527>

Initialize output_format to 0 instead of DIFF_FORMAT_RAW so that we can see
later if any command line options changed it.  Default value is set only if
output format was not specified.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff-files.c  |    3 +++
 builtin-diff-index.c  |    3 +++
 builtin-diff-stages.c |    3 +++
 builtin-diff-tree.c   |    3 +++
 builtin-diff.c        |    4 +++-
 builtin-log.c         |    4 +++-
 diff.c                |    1 -
 7 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5afc1d7..a655eea 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -36,6 +36,9 @@ int cmd_diff_files(int argc, const char 
 			usage(diff_files_usage);
 		argv++; argc--;
 	}
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * rev.max_count is reasonable (0 <= n <= 3),
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index c42ef9a..b37c9e8 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -28,6 +28,9 @@ int cmd_diff_index(int argc, const char 
 		else
 			usage(diff_cache_usage);
 	}
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
index 7c157ca..30931fe 100644
--- a/builtin-diff-stages.c
+++ b/builtin-diff-stages.c
@@ -85,6 +85,9 @@ int cmd_diff_stages(int ac, const char *
 		ac--; av++;
 	}
 
+	if (!diff_options.output_format)
+		diff_options.output_format = DIFF_FORMAT_RAW;
+
 	if (ac < 3 ||
 	    sscanf(av[1], "%d", &stage1) != 1 ||
 	    ! (0 <= stage1 && stage1 <= 3) ||
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 3409a39..ae1cde9 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -84,6 +84,9 @@ int cmd_diff_tree(int argc, const char *
 		usage(diff_tree_usage);
 	}
 
+	if (!opt->diffopt.output_format)
+		opt->diffopt.output_format = DIFF_FORMAT_RAW;
+
 	/*
 	 * NOTE! We expect "a ^b" to be equal to "a..b", so we
 	 * reverse the order of the objects if the second one
diff --git a/builtin-diff.c b/builtin-diff.c
index 91235a1..47e0a37 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -252,9 +252,11 @@ int cmd_diff(int argc, const char **argv
 
 	git_config(git_diff_config);
 	init_revisions(&rev);
-	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
diff --git a/builtin-log.c b/builtin-log.c
index 5c656bc..65f9527 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -178,7 +178,6 @@ int cmd_format_patch(int argc, const cha
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
-	rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 
 	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
@@ -247,6 +246,9 @@ int cmd_format_patch(int argc, const cha
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
+
 	if (output_directory) {
 		if (use_stdout)
 			die("standard output, or directory, which one?");
diff --git a/diff.c b/diff.c
index 6e5ae77..6be31e7 100644
--- a/diff.c
+++ b/diff.c
@@ -1355,7 +1355,6 @@ static void run_checkdiff(struct diff_fi
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
-	options->output_format = DIFF_FORMAT_RAW;
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
-- 
1.4.1.rc1.g8637
