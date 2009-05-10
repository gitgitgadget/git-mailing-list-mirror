From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] build-in git-mktree
Date: Sun, 10 May 2009 11:49:46 -0700
Message-ID: <1241981391-19639-2-git-send-email-gitster@pobox.com>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6O-0004rg-RH
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622AbZEJSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754898AbZEJSt5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:49:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbZEJSt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:49:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 513661616B
	for <git@vger.kernel.org>; Sun, 10 May 2009 14:49:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BED6516169 for
 <git@vger.kernel.org>; Sun, 10 May 2009 14:49:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <1241981391-19639-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5AF58DA8-3D93-11DE-97C7-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118735>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                     |    2 +-
 mktree.c => builtin-mktree.c |   18 +++++++-----------
 builtin.h                    |    1 +
 git.c                        |    1 +
 4 files changed, 10 insertions(+), 12 deletions(-)
 rename mktree.c => builtin-mktree.c (91%)

diff --git a/Makefile b/Makefile
index 6e21643..9d9f0da 100644
--- a/Makefile
+++ b/Makefile
@@ -332,7 +332,6 @@ PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-merge-tree$X
 PROGRAMS += git-mktag$X
-PROGRAMS += git-mktree$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
 PROGRAMS += git-shell$X
@@ -586,6 +585,7 @@ BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
+BUILTIN_OBJS += builtin-mktree.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
diff --git a/mktree.c b/builtin-mktree.c
similarity index 91%
rename from mktree.c
rename to builtin-mktree.c
index 137a095..3d05427 100644
--- a/mktree.c
+++ b/builtin-mktree.c
@@ -1,12 +1,11 @@
 /*
  * GIT - the stupid content tracker
  *
- * Copyright (c) Junio C Hamano, 2006
+ * Copyright (c) Junio C Hamano, 2006, 2009
  */
-#include "cache.h"
+#include "builtin.h"
 #include "quote.h"
 #include "tree.h"
-#include "exec_cmd.h"
 
 static struct treeent {
 	unsigned mode;
@@ -64,19 +63,15 @@ static void write_tree(unsigned char *sha1)
 
 static const char mktree_usage[] = "git mktree [-z]";
 
-int main(int ac, char **av)
+int cmd_mktree(int ac, const char **av, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf p_uq = STRBUF_INIT;
 	unsigned char sha1[20];
 	int line_termination = '\n';
 
-	git_extract_argv0_path(av[0]);
-
-	setup_git_directory();
-
 	while ((1 < ac) && av[1][0] == '-') {
-		char *arg = av[1];
+		const char *arg = av[1];
 		if (!strcmp("-z", arg))
 			line_termination = 0;
 		else
@@ -92,8 +87,9 @@ int main(int ac, char **av)
 		char *path;
 
 		ptr = sb.buf;
-		/* Input is non-recursive ls-tree output format
-		 * mode SP type SP sha1 TAB name
+		/*
+		 * Read non-recursive ls-tree output format:
+		 *     mode SP type SP sha1 TAB name
 		 */
 		mode = strtoul(ptr, &ntr, 8);
 		if (ptr == ntr || !ntr || *ntr != ' ')
diff --git a/builtin.h b/builtin.h
index 425ff8e..20427d2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -72,6 +72,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 5a00726..7d7f949 100644
--- a/git.c
+++ b/git.c
@@ -327,6 +327,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "mktree", cmd_mktree, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-- 
1.6.3.9.g6345d
