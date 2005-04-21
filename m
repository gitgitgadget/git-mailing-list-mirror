From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 12/19] fix up diff-cache.c to use new cache api's
Date: Thu, 21 Apr 2005 11:37:34 -0700
Message-ID: <200504211837.j3LIbYRQ027685@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgUy-0008Bf-SY
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVDUSiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVDUSiV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:38:21 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:51336 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261675AbVDUShh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:37:37 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIbWD9028057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:37:32 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIbYEn027687
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:37:34 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIbYRQ027685
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:37:34 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 44f1ef88a5d0effdf2337f4c72b88b2bdcd9a54b
parent 8a4556bdf5bc847117c840a8fd7fa42f6efb16e1
author Brad Roberts <braddr@puremagic.com> 1114082996 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114082996 -0700

[PATCH] fix up diff-cache.c to use new cache api's

Along the way, rewrite to use a position index rather than pointer math.

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 diff-cache.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

Index: diff-cache.c
===================================================================
--- 8a4556bdf5bc847117c840a8fd7fa42f6efb16e1:1/diff-cache.c  (mode:100644 sha1:fcbc4900d32f4ca24f67bb8f0fe344c6c5642ac9)
+++ cc414a188c0e8fefa7bea4f969cc7adfe4265d6f:1/diff-cache.c  (mode:100644 sha1:548211944fc00594bfc06b9ab90f0cb476688285)
@@ -4,7 +4,7 @@
 static int recursive = 0;
 static int line_termination = '\n';
 
-static int diff_cache(void *tree, unsigned long size, struct cache_entry **ac, int entries, const char *base);
+static int diff_cache(void *tree, unsigned long size, int pos, const char *base);
 
 static void update_tree_entry(void **bufp, unsigned long *sizep)
 {
@@ -82,10 +82,10 @@
 }
 
 static int compare_tree_entry(const char *path1, unsigned int mode1, const unsigned char *sha1,
-			      struct cache_entry **ac, int *entries, const char *base)
+			      int *pos, const char *base)
 {
 	int baselen = strlen(base);
-	struct cache_entry *ce = *ac;
+	struct cache_entry *ce = get_cache_entry(*pos);
 	const char *path2 = ce->name + baselen;
 	unsigned int mode2 = ntohl(ce->ce_mode);
 	const unsigned char *sha2 = ce->sha1;
@@ -107,7 +107,7 @@
 			memcpy(newbase + baselen + pathlen1, "/", 2);
 			if (!tree || strcmp(type, "tree"))
 				die("unable to read tree object %s", sha1_to_hex(sha1));
-			*entries = diff_cache(tree, size, ac, *entries, newbase);
+			*pos = diff_cache(tree, size, *pos, newbase);
 			free(newbase);
 			free(tree);
 			return -1;
@@ -158,7 +158,7 @@
 	return 0;
 }
 
-static int diff_cache(void *tree, unsigned long size, struct cache_entry **ac, int entries, const char *base)
+static int diff_cache(void *tree, unsigned long size, int pos, const char *base)
 {
 	int baselen = strlen(base);
 
@@ -167,15 +167,16 @@
 		unsigned int mode;
 		const char *path;
 		const unsigned char *sha1;
-		int left;
 
 		/*
 		 * No entries in the cache (with this base)?
 		 * Output the tree contents.
 		 */
-		if (!entries || ce_namelen(ce = *ac) < baselen || memcmp(ce->name, base, baselen)) {
+		if ((pos == get_num_cache_entries()) ||
+		    ce_namelen(ce = get_cache_entry(pos)) < baselen ||
+		    memcmp(ce->name, base, baselen)) {
 			if (!size)
-				return entries;
+				return pos;
 			sha1 = extract(tree, size, &path, &mode);
 			show_file("-", path, mode, sha1, base);
 			update_tree_entry(&tree, &size);
@@ -187,27 +188,20 @@
 		 */
 		if (!size) {
 			show_file("+", ce->name, ntohl(ce->ce_mode), ce->sha1, "");
-			ac++;
-			entries--;
+			pos++;
 			continue;
 		}
 
 		sha1 = extract(tree, size, &path, &mode);
-		left = entries;
-		switch (compare_tree_entry(path, mode, sha1, ac, &left, base)) {
+		switch (compare_tree_entry(path, mode, sha1, &pos, base)) {
 		case -1:
 			update_tree_entry(&tree, &size);
-			if (left < entries) {
-				ac += (entries - left);
-				entries = left;
-			}
 			continue;
 		case 0:
 			update_tree_entry(&tree, &size);
 			/* Fallthrough */
 		case 1:
-			ac++;
-			entries--;
+			pos++;
 			continue;
 		}
 		die("diff-cache: internal error");
@@ -263,5 +257,5 @@
 	if (strcmp(type, "tree"))
 		die("bad tree object %s (%s)", sha1_to_hex(tree_sha1), type);
 
-	return diff_cache(tree, size, active_cache, active_nr, "");
+	return diff_cache(tree, size, 0, "");
 }

