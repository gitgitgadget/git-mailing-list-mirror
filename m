X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Add git-count-packs, like git-count-objects.
Date: Sat, 28 Oct 2006 00:00:56 -0400
Message-ID: <20061028040056.GA14191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 04:01:37 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30360>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdfNs-00066l-I5 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 06:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751706AbWJ1EBE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 00:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWJ1EBE
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 00:01:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52714 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1751706AbWJ1EBD
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 00:01:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdfNS-00034d-Vl; Sat, 28 Oct 2006 00:00:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9A3AB20E45B; Sat, 28 Oct 2006 00:00:56 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Now that we are starting to save packs rather than unpacking into
loose objects its nice to have a way to list the number of current
packs and their total size.  This can help the user in deciding
when its time to run `git repack -a -d`.

In the future when we actually start to support historical packs
vs. active packs we probably should be reporting by default on the
number of active packs and ignoring the historical packs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore                        |    1 +
 Documentation/git-count-packs.txt |   29 +++++++++++++++++++++++++++++
 Makefile                          |    1 +
 builtin-count-packs.c             |   29 +++++++++++++++++++++++++++++
 builtin.h                         |    1 +
 git.c                             |    1 +
 6 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index b670877..31be347 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@ git-commit
 git-commit-tree
 git-convert-objects
 git-count-objects
+git-count-packs
 git-cvsexportcommit
 git-cvsimport
 git-cvsserver
diff --git a/Documentation/git-count-packs.txt b/Documentation/git-count-packs.txt
new file mode 100644
index 0000000..1420241
--- /dev/null
+++ b/Documentation/git-count-packs.txt
@@ -0,0 +1,29 @@
+git-count-packs(1)
+====================
+
+NAME
+----
+git-count-packs - Reports on packs
+
+SYNOPSIS
+--------
+'git-count-packs'
+
+DESCRIPTION
+-----------
+This counts the number of pack files and disk space consumed by
+them, to help you decide when it is a good time to repack.
+
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>
+
+Documentation
+--------------
+Documentation by Shawn O. Pearce.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 2d62efb..b7fd558 100644
--- a/Makefile
+++ b/Makefile
@@ -275,6 +275,7 @@ BUILTIN_OBJS = \
 	builtin-check-ref-format.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
+	builtin-count-packs.o \
 	builtin-diff.o \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
diff --git a/builtin-count-packs.c b/builtin-count-packs.c
new file mode 100644
index 0000000..f5a5940
--- /dev/null
+++ b/builtin-count-packs.c
@@ -0,0 +1,29 @@
+/*
+ * Builtin "git count-packs".
+ *
+ * Copyright (c) 2006 Shawn Pearce
+ */
+
+#include "cache.h"
+#include "builtin.h"
+
+static const char count_packs_usage[] = "git-count-packs";
+
+int cmd_count_packs(int ac, const char **av, const char *prefix)
+{
+	struct packed_git *p;
+	unsigned long packs = 0, pack_size = 0;
+
+	if (!ac)
+		usage(count_packs_usage);
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		if (!p->pack_local)
+			continue;
+		packs++;
+		pack_size += p->pack_size / (1024 * 1024);
+	}
+	printf("%lu packs, %lu megabytes\n", packs, pack_size);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 708a2f2..410577e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -22,6 +22,7 @@ extern int cmd_checkout_index(int argc,
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_count_packs(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 6475847..9ad0f01 100644
--- a/git.c
+++ b/git.c
@@ -227,6 +227,7 @@ static void handle_internal_command(int
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "count-packs", cmd_count_packs, RUN_SETUP },
 		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
 		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
-- 
1.4.3.3.g7d63
