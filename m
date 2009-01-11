From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH 1/3] tree.c: add support for traversal of submodules
Date: Mon, 12 Jan 2009 00:45:53 +0100
Message-ID: <1231717555-10559-2-git-send-email-hjemli@gmail.com>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 02:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMC3v-000384-3t
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZALB4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZALB4b
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:56:31 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:44509 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbZALB4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:56:31 -0500
Received: from localhost.localdomain (ti0025a380-2268.bb.online.no [80.213.203.224])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id n0BNjuv4029874;
	Mon, 12 Jan 2009 00:45:59 +0100 (MET)
X-Mailer: git-send-email 1.6.1.83.g408d2
In-Reply-To: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105275>

If the commit referenced by a gitlink is available in the (possibly
alternate) object database, read_tree_recursive() is now able to descend
into the tree of the linked commit if the flag 'traverse_gitlinks' is
turned on.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 tree.c |   20 +++++++++++++++++---
 tree.h |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 03e782a..1468e10 100644
--- a/tree.c
+++ b/tree.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 
 const char *tree_type = "tree";
+int traverse_gitlinks = 0;
 
 static int read_one_entry_opt(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage, int opt)
 {
@@ -114,16 +115,29 @@ int read_tree_recursive(struct tree *tree,
 		default:
 			return -1;
 		}
-		if (S_ISDIR(entry.mode)) {
+		if (S_ISDIR(entry.mode) || (traverse_gitlinks && S_ISGITLINK(entry.mode))) {
 			int retval;
 			char *newbase;
 			unsigned int pathlen = tree_entry_len(entry.path, entry.sha1);
-
+			struct commit *commit;
+			struct tree *node;
+
+			if (S_ISDIR(entry.mode)) {
+				node = lookup_tree(entry.sha1);
+			} else {
+				commit = lookup_commit_reference_gently(entry.sha1, 1);
+				if (!commit)
+					continue;
+				if (parse_commit(commit))
+					die("parse_commit(%s) failed",
+					    sha1_to_hex(entry.sha1));
+				node = commit->tree;
+			}
 			newbase = xmalloc(baselen + 1 + pathlen);
 			memcpy(newbase, base, baselen);
 			memcpy(newbase + baselen, entry.path, pathlen);
 			newbase[baselen + pathlen] = '/';
-			retval = read_tree_recursive(lookup_tree(entry.sha1),
+			retval = read_tree_recursive(node,
 						     newbase,
 						     baselen + pathlen + 1,
 						     stage, match, fn, context);
diff --git a/tree.h b/tree.h
index 2ff01a4..b6b938f 100644
--- a/tree.h
+++ b/tree.h
@@ -4,6 +4,7 @@
 #include "object.h"
 
 extern const char *tree_type;
+extern int traverse_gitlinks;
 
 struct tree {
 	struct object object;
-- 
1.6.1.81.g1df1.dirty
