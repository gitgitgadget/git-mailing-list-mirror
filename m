From: Erik van Zijst <erik.van.zijst@gmail.com>
Subject: [PATCH] Configurable diff context in merge-tree command
Date: Mon, 15 Aug 2011 16:17:21 +1000
Message-ID: <CA+69USvBXGoDMp_v2hF6v6QM3-GjF42pFiaBX912txW-e5n7=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 08:17:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsqUK-0003ZF-LG
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 08:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab1HOGRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 02:17:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61490 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1HOGRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 02:17:22 -0400
Received: by ewy4 with SMTP id 4so1752518ewy.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JJ/JLmfTGRXAU0TNoGhWEsHtKV5TyxBhZVByYH6HirM=;
        b=GoMhlQ/3tWr+LuIFVE2g3LTJBz+vfmMiLRKnbHR3F1mccmf6ZS2F0diMyKosOXDBoO
         5sZhp7sHTYtG/I1N2mhZdbDHm3vTGSS53m1oSqfLtCn6hntsvwanYBQL04M5P7WsS+El
         ARdTdxDTgbNk9oqqBuGQggbWt3wLEE6BOanoo=
Received: by 10.14.146.142 with SMTP id r14mr453811eej.228.1313389041392; Sun,
 14 Aug 2011 23:17:21 -0700 (PDT)
Received: by 10.14.99.200 with HTTP; Sun, 14 Aug 2011 23:17:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179359>

Added support for the -U/--unified command line arguments to the
git-merge-tree command to change the number of context lines that
are generated.

Signed-off-by: Erik van Zijst <erik.van.zijst@gmail.com>
---
 Documentation/git-merge-tree.txt |    8 +++++++-
 builtin/merge-tree.c             |   26 +++++++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index c5f84b6..7a0d927 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Show three-way merge without touching index
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' <base-tree> <branch1> <branch2>
+'git merge-tree' [-U<n> | --unified=<n>] <base-tree> <branch1> <branch2>

 DESCRIPTION
 -----------
@@ -24,6 +24,12 @@ merge results outside of the index, and stuff the
results back into the
 index.  For this reason, the output from the command omits
 entries that match the <branch1> tree.

+OPTIONS
+-------
+-U<n>::
+--unified=<n>::
+	Generate diffs with <n> lines of context instead of the usual three.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 897a563..0a5c8c9 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -4,9 +4,15 @@
 #include "blob.h"
 #include "exec_cmd.h"
 #include "merge-file.h"
+#include "parse-options.h"
+
+static const char * const merge_tree_usage[] = {
+	"git merge-tree [options] <base-tree> <branch1> <branch2>",
+	NULL
+};

-static const char merge_tree_usage[] = "git merge-tree <base-tree>
<branch1> <branch2>";
 static int resolve_directories = 1;
+static long ctxlen = 3;

 struct merge_list {
 	struct merge_list *next;
@@ -108,7 +114,7 @@ static void show_diff(struct merge_list *entry)

 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 3;
+	xecfg.ctxlen = ctxlen;
 	ecb.outf = show_outf;
 	ecb.priv = NULL;

@@ -341,13 +347,19 @@ int cmd_merge_tree(int argc, const char **argv,
const char *prefix)
 {
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
+	const struct option opts[] = {
+		OPT_INTEGER('U', "unified", &ctxlen, "number of diff context lines"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, opts, merge_tree_usage, 0);

-	if (argc != 4)
-		usage(merge_tree_usage);
+	if (argc != 3)
+		usage(*merge_tree_usage);

-	buf1 = get_tree_descriptor(t+0, argv[1]);
-	buf2 = get_tree_descriptor(t+1, argv[2]);
-	buf3 = get_tree_descriptor(t+2, argv[3]);
+	buf1 = get_tree_descriptor(t+0, argv[0]);
+	buf2 = get_tree_descriptor(t+1, argv[1]);
+	buf3 = get_tree_descriptor(t+2, argv[2]);
 	merge_trees(t, "");
 	free(buf1);
 	free(buf2);
-- 
1.7.1
