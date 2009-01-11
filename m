From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH 3/3] builtin-ls-tree: enable traversal of submodules
Date: Mon, 12 Jan 2009 00:45:55 +0100
Message-ID: <1231717555-10559-4-git-send-email-hjemli@gmail.com>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
 <1231717555-10559-2-git-send-email-hjemli@gmail.com>
 <1231717555-10559-3-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 01:23:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMAa4-0007Wq-G8
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 01:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbZALAVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbZALAVh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 19:21:37 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:40818 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116AbZALAVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 19:21:36 -0500
Received: from localhost.localdomain (ti0025a380-2268.bb.online.no [80.213.203.224])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id n0BNjuv6029874;
	Mon, 12 Jan 2009 00:46:00 +0100 (MET)
X-Mailer: git-send-email 1.6.1.83.g408d2
In-Reply-To: <1231717555-10559-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105261>

The option '--submodules', which implies '-r', activates the traversal
of all submodules for which the linked commit is reachable.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-ls-tree.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index cb61717..8a1db54 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -23,7 +23,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
-	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] [--submodules] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -63,20 +63,8 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	unsigned long size;
 
 	if (S_ISGITLINK(mode)) {
-		/*
-		 * Maybe we want to have some recursive version here?
-		 *
-		 * Something similar to this incomplete example:
-		 *
-		if (show_subprojects(base, baselen, pathname)) {
-			struct child_process ls_tree;
-
-			ls_tree.dir = base;
-			ls_tree.argv = ls-tree;
-			start_command(&ls_tree);
-		}
-		 *
-		 */
+		if (show_recursive(base, baselen, pathname))
+			retval = READ_TREE_RECURSIVE;
 		type = commit_type;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base, baselen, pathname)) {
@@ -168,6 +156,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 				abbrev = DEFAULT_ABBREV;
 				break;
 			}
+			if (!strcmp(argv[1]+2, "submodules")) {
+				ls_options |= LS_RECURSIVE;
+				traverse_gitlinks = 1;
+				break;
+			}
 			/* otherwise fallthru */
 		default:
 			usage(ls_tree_usage);
-- 
1.6.1.81.g1df1.dirty
