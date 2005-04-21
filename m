From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 01/19] write_cache api signature change, isolate active_cache and active_nr inside read-cache.c
Date: Thu, 21 Apr 2005 11:34:42 -0700
Message-ID: <200504211834.j3LIYg1j026811@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgRv-0007kE-9E
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVDUSfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVDUSfL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:35:11 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:62599 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261611AbVDUSen (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:34:43 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIYe2F027746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:34:40 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIYghB026815
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:34:42 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIYg1j026811
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:34:42 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree f45fd10b26bf98349b63427805a96bd0551cad74
parent 43fdf65356c50483233cb3d6e391b0849b2a2a50
parent cd1c034369b73da7503da365fa556aab27004814
author Brad Roberts <braddr@puremagic.com> 1114072582 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114072582 -0700

[PATCH] write_cache api signature change, isolate active_cache and active_nr inside read-cache.c


Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h        |    2 +-
 read-cache.c   |    8 ++++----
 read-tree.c    |    2 +-
 update-cache.c |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

Index: cache.h
===================================================================
--- cd1c034369b73da7503da365fa556aab27004814:1/cache.h  (mode:100644 sha1:828d660ab82bb35a1ca632a2ba4620dc483889bd)
+++ 77de9e0b7a81ddc22526c9415f0273171f631d3f:1/cache.h  (mode:100644 sha1:a101870e4a002a2548d88544a77bedad21668203)
@@ -88,7 +88,7 @@
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
-extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+extern int write_cache(int newfd);
 extern int cache_name_pos(const char *name, int namelen);
 extern int add_cache_entry(struct cache_entry *ce, int ok_to_add);
 extern int remove_file_from_cache(char *path);
Index: read-cache.c
===================================================================
--- cd1c034369b73da7503da365fa556aab27004814:1/read-cache.c  (mode:100644 sha1:2f6a4aa18d48865db80459a3459ac4384b0b16c8)
+++ 77de9e0b7a81ddc22526c9415f0273171f631d3f:1/read-cache.c  (mode:100644 sha1:349ebd1f8a0a95bf462bb1dfd3d9dfb50628829c)
@@ -267,7 +267,7 @@
 	return 0;
 }
 
-int write_cache(int newfd, struct cache_entry **cache, int entries)
+int write_cache(int newfd)
 {
 	SHA_CTX c;
 	struct cache_header hdr;
@@ -275,14 +275,14 @@
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(2);
-	hdr.hdr_entries = htonl(entries);
+	hdr.hdr_entries = htonl(active_nr);
 
 	SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = cache[i];
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
 		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
 			return -1;
 	}
Index: read-tree.c
===================================================================
--- cd1c034369b73da7503da365fa556aab27004814:1/read-tree.c  (mode:100644 sha1:620f3f74eb56366fca8be4d28d7b04875c0fa90c)
+++ 77de9e0b7a81ddc22526c9415f0273171f631d3f:1/read-tree.c  (mode:100644 sha1:4ad48f5c409ead69407d2b5feab4466cdcb499f8)
@@ -261,7 +261,7 @@
 			die("just how do you expect me to merge %d trees?", stage-1);
 		}
 	}
-	if (write_cache(newfd, active_cache, active_nr) ||
+	if (write_cache(newfd) ||
 	    rename(".git/index.lock", ".git/index"))
 		die("unable to write new index file");
 	remove_lock = 0;
Index: update-cache.c
===================================================================
--- cd1c034369b73da7503da365fa556aab27004814:1/update-cache.c  (mode:100644 sha1:a09883541c745c76413c62109a80f40df4b7a7fb)
+++ 77de9e0b7a81ddc22526c9415f0273171f631d3f:1/update-cache.c  (mode:100644 sha1:585951108c57a64bb774114d289d81fd7fd22768)
@@ -341,7 +341,7 @@
 		if (add_file_to_cache(path))
 			die("Unable to add %s to database", path);
 	}
-	if (write_cache(newfd, active_cache, active_nr) ||
+	if (write_cache(newfd) ||
 	    rename(".git/index.lock", ".git/index"))
 		die("Unable to write new cachefile");
 

