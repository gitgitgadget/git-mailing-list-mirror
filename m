From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 11/19] migrate write-tree.c to use the new cache api's
Date: Thu, 21 Apr 2005 11:37:19 -0700
Message-ID: <200504211837.j3LIbJtH027642@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:34:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgUa-000895-Ez
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDUSh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVDUSh5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:37:57 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:49544 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261676AbVDUShU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:37:20 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIbHBd028044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:37:17 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIbJU7027644
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:37:19 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIbJtH027642
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:37:19 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 3a2928786f84d81cfb1a5846cdaf9f3d5403cbcf
parent a94803645fb68119be8835d466585c91e664a173
author Brad Roberts <braddr@puremagic.com> 1114077713 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114077713 -0700

[PATCH] migrate write-tree.c to use the new cache api's

Along the way, altered the write_tree recursion to stay based off of a starting
position rather than moving the array pointer for each recurse step.

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 write-tree.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

Index: write-tree.c
===================================================================
--- a94803645fb68119be8835d466585c91e664a173:1/write-tree.c  (mode:100644 sha1:827809dbddbff6dd8cf842641f6db5ad2f3ae07a)
+++ 8a4556bdf5bc847117c840a8fd7fa42f6efb16e1:1/write-tree.c  (mode:100644 sha1:f1b12cdde1bb446a134a121760007150008b251a)
@@ -29,7 +29,7 @@
 
 #define ORIG_OFFSET (40)	/* Enough space to add the header of "tree <size>\0" */
 
-static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
+static int write_tree(int start_pos, const char *base, int baselen, unsigned char *returnsha1)
 {
 	unsigned char subdir_sha1[20];
 	unsigned long size, offset;
@@ -43,7 +43,7 @@
 
 	nr = 0;
 	do {
-		struct cache_entry *ce = cachep[nr];
+		struct cache_entry *ce = get_cache_entry(start_pos + nr);
 		const char *pathname = ce->name, *filename, *dirname;
 		int pathlen = ce_namelen(ce), entrylen;
 		unsigned char *sha1;
@@ -53,16 +53,13 @@
 		if (baselen >= pathlen || memcmp(base, pathname, baselen))
 			break;
 
-		sha1 = ce->sha1;
-		mode = ntohl(ce->ce_mode);
-
 		/* Do we have _further_ subdirectories? */
 		filename = pathname + baselen;
 		dirname = strchr(filename, '/');
 		if (dirname) {
 			int subdir_written;
 
-			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
+			subdir_written = write_tree(start_pos + nr, pathname, dirname-pathname+1, subdir_sha1);
 			nr += subdir_written;
 
 			/* Now we need to write out the directory entry into this tree.. */
@@ -72,6 +69,9 @@
 			/* ..but the directory entry doesn't count towards the total count */
 			nr--;
 			sha1 = subdir_sha1;
+		} else {
+			sha1 = ce->sha1;
+			mode = ntohl(ce->ce_mode);
 		}
 
 		if (check_valid_sha1(sha1) < 0)
@@ -87,7 +87,7 @@
 		memcpy(buffer + offset, sha1, 20);
 		offset += 20;
 		nr++;
-	} while (nr < maxentries);
+	} while ((start_pos + nr) < get_num_cache_entries());
 
 	i = prepend_integer(buffer, offset - ORIG_OFFSET, ORIG_OFFSET);
 	i -= 5;
@@ -110,7 +110,7 @@
 	/* Verify that the tree is merged */
 	unmerged = 0;
 	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = active_cache[i];
+		struct cache_entry *ce = get_cache_entry(i);
 		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
 			if (++unmerged > 10) {
 				fprintf(stderr, "...\n");
@@ -123,7 +123,7 @@
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
+	if (write_tree(0, "", 0, sha1) != entries)
 		die("write-tree: internal error");
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;

