From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 16/19] change all call sites that use the return value of read_cache to get the # of cache entries.
Date: Thu, 21 Apr 2005 11:38:36 -0700
Message-ID: <200504211838.j3LIcahX027805@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:35:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgW1-0008M4-7v
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVDUSj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVDUSj3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:39:29 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:7305 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261681AbVDUSir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:38:47 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIcYoJ028175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:34 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIcaqW027807
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:36 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIcahX027805
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:38:36 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 6bce19032505c2939bf74eeca5e51aeefa4e1600
parent f07f7073f45a7f81e5b6cf26f5181e14fd051d81
author Brad Roberts <braddr@puremagic.com> 1114086602 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114086602 -0700

[PATCH] change all call sites that use the return value of read_cache to get the # of cache entries.

This patch somewhat breaks error handling for those call sites.  I'll fix
that in the next few patches.

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 show-diff.c    |   13 ++++++++-----
 update-cache.c |    3 ++-
 write-tree.c   |    4 +++-
 3 files changed, 13 insertions(+), 7 deletions(-)

Index: show-diff.c
===================================================================
--- f07f7073f45a7f81e5b6cf26f5181e14fd051d81:1/show-diff.c  (mode:100644 sha1:e2642b65805b3e52a16c6309b44a92c2a2bd13c3)
+++ b965055600b8bf4927ea631446cd6cde714aef95:1/show-diff.c  (mode:100644 sha1:6e04e9182667cbb79afa4c878a31b685fdea3229)
@@ -126,10 +126,17 @@
 	int silent_on_nonexisting_files = 0;
 	int machine_readable = 0;
 	int reverse = 0;
-	int entries = read_cache();
+	int entries;
 	int matched = 0;
 	int i;
 
+	read_cache();
+	entries = get_num_cache_entries();
+	if (entries < 0) {
+		perror("read_cache");
+		exit(1);
+	}
+
 	while (1 < argc && argv[1][0] == '-') {
 		if  (!strcmp(argv[1], "-R"))
 			reverse = 1;
@@ -147,10 +154,6 @@
 	/* At this point, if argc == 1, then we are doing everything.
 	 * Otherwise argv[1] .. argv[argc-1] have the explicit paths.
 	 */
-	if (entries < 0) {
-		perror("read_cache");
-		exit(1);
-	}
 	prepare_diff_cmd();
 	for (i = 0; i < entries; i++) {
 		struct stat st;
Index: update-cache.c
===================================================================
--- f07f7073f45a7f81e5b6cf26f5181e14fd051d81:1/update-cache.c  (mode:100644 sha1:e741f593eb9c56c596fabed7eb6b79dee2d8cba9)
+++ b965055600b8bf4927ea631446cd6cde714aef95:1/update-cache.c  (mode:100644 sha1:8328975cb726f5e06a413a9f0099bfa2f81d3381)
@@ -299,7 +299,8 @@
 	atexit(remove_lock_file);
 	remove_lock = 1;
 
-	entries = read_cache();
+	read_cache();
+	entries = get_num_cache_entries();
 	if (entries < 0)
 		die("cache corrupted");
 
Index: write-tree.c
===================================================================
--- f07f7073f45a7f81e5b6cf26f5181e14fd051d81:1/write-tree.c  (mode:100644 sha1:f1b12cdde1bb446a134a121760007150008b251a)
+++ b965055600b8bf4927ea631446cd6cde714aef95:1/write-tree.c  (mode:100644 sha1:92e707fd4780805da160ce6fa282e75111ea67b9)
@@ -101,9 +101,11 @@
 int main(int argc, char **argv)
 {
 	int i, unmerged;
-	int entries = read_cache();
+	int entries;
 	unsigned char sha1[20];
 
+	read_cache();
+	entries = get_num_cache_entries();
 	if (entries <= 0)
 		die("write-tree: no cache contents to write");
 

