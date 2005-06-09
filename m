From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-diff-stages command.
Date: Thu, 09 Jun 2005 15:13:13 -0700
Message-ID: <7vekbbb2me.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
	<7vaclzclqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 00:09:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgVDf-0007W8-3c
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 00:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVFIWNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVFIWNv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 18:13:51 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:645 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262487AbVFIWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 18:13:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609221312.DCWH7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 18:13:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vaclzclqd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 09 Jun 2005 13:35:06 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The diff-* brothers acquired a sibling, git-diff-stages.  With
an unmerged index file, you specify two stage numbers and it
shows the differences between them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** ... I think we also can write a simple program that reads an
*** unmerged index file and do the equivalent of these two
*** diff-tree commands.
***
*** Only lightly tested.

 Makefile      |    3 +-
 diff-stages.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ PROG=   git-update-cache git-diff-files 
 	git-http-pull git-ssh-push git-ssh-pull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
 	git-get-tar-commit-id git-mkdelta git-apply git-stripspace \
-	git-cvs2git
+	git-cvs2git git-diff-stages
 
 all: $(PROG)
 
@@ -117,6 +117,7 @@ git-write-blob: write-blob.c
 git-mkdelta: mkdelta.c
 git-stripspace: stripspace.c
 git-cvs2git: cvs2git.c
+git-diff-stages: diff-stages.c
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
diff --git a/diff-stages.c b/diff-stages.c
new file mode 100644
--- /dev/null
+++ b/diff-stages.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2005 Junio C Hamano
+ */
+
+#include "cache.h"
+#include "diff.h"
+
+static int diff_output_format = DIFF_FORMAT_HUMAN;
+static int detect_rename = 0;
+static int diff_setup_opt = 0;
+static int diff_score_opt = 0;
+static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
+static int diff_break_opt = -1;
+static const char *orderfile = NULL;
+
+static char *diff_stages_usage =
+"git-diff-stages [-p] [-r] [-z] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] <stage1> <stage2> [<path>...]";
+
+int main(int ac, const char **av)
+{
+	int stage1, stage2, i;
+
+	read_cache();
+	while (1 < ac && av[1][0] == '-') {
+		const char *arg = av[1];
+		if (!strcmp(arg, "-r"))
+			; /* as usual */
+		else if (!strcmp(arg, "-p"))
+			diff_output_format = DIFF_FORMAT_PATCH;
+		else if (!strncmp(arg, "-B", 2)) {
+			if ((diff_break_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_stages_usage);
+		}
+		else if (!strncmp(arg, "-M", 2)) {
+			detect_rename = DIFF_DETECT_RENAME;
+			if ((diff_score_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_stages_usage);
+		}
+		else if (!strncmp(arg, "-C", 2)) {
+			detect_rename = DIFF_DETECT_COPY;
+			if ((diff_score_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_stages_usage);
+		}
+		else if (!strcmp(arg, "-z"))
+			diff_output_format = DIFF_FORMAT_MACHINE;
+		else if (!strcmp(arg, "-R"))
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
+		else if (!strncmp(arg, "-S", 2))
+			pickaxe = arg + 2;
+		else if (!strncmp(arg, "-O", 2))
+			orderfile = arg + 2;
+		else if (!strcmp(arg, "--pickaxe-all"))
+			pickaxe_opts = DIFF_PICKAXE_ALL;
+		else
+			usage(diff_stages_usage);
+		ac--; av++;
+	}
+
+	if (ac < 3 ||
+	    sscanf(av[1], "%d", &stage1) != 1 ||
+	    ! (0 <= stage1 && stage1 <= 3) ||
+	    sscanf(av[2], "%d", &stage2) != 1 ||
+	    ! (0 <= stage2 && stage2 <= 3))
+		usage(diff_stages_usage);
+
+	av += 3; /* The rest from av[0] are for paths restriction. */
+	diff_setup(diff_setup_opt);
+
+	i = 0;
+	while (i < active_nr) {
+		struct cache_entry *ce, *stages[4] = { NULL, };
+		struct cache_entry *one, *two;
+		const char *name;
+		int len;
+		ce = active_cache[i];
+		len = ce_namelen(ce);
+		name = ce->name;
+		for (;;) {
+			int stage = ce_stage(ce);
+			stages[stage] = ce;
+			if (active_nr <= ++i)
+				break;
+			ce = active_cache[i];
+			if (ce_namelen(ce) != len ||
+			    memcmp(name, ce->name, len))
+				break;
+		}
+		one = stages[stage1];
+		two = stages[stage2];
+		if (!one && !two)
+			continue;
+		if (!one)
+			diff_addremove('+', ntohl(two->ce_mode),
+				       two->sha1, name, NULL);
+		else if (!two)
+			diff_addremove('-', ntohl(one->ce_mode),
+				       one->sha1, name, NULL);
+		else if (memcmp(one->sha1, two->sha1, 20) ||
+			 (one->ce_mode != two->ce_mode))
+			 diff_change(ntohl(one->ce_mode), ntohl(two->ce_mode),
+				     one->sha1, two->sha1, name, NULL);
+	}
+
+	diffcore_std(av,
+		     detect_rename, diff_score_opt,
+		     pickaxe, pickaxe_opts,
+		     diff_break_opt,
+		     orderfile);
+	diff_flush(diff_output_format, 1);
+	return 0;
+}
------------

