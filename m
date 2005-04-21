From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 17/19] temporarily change add_cache_entry to create an empty cache on demand
Date: Thu, 21 Apr 2005 11:38:51 -0700
Message-ID: <200504211838.j3LIcpuC027819@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgWE-0008OP-A8
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDUSjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVDUSjl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:39:41 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:13705 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261683AbVDUSjC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:39:02 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIcnMs028203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:49 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIcp0O027821
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:51 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIcpuC027819
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:38:51 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 6feaeb314fb1bea393250972b109b7d218cf37d7
parent b965055600b8bf4927ea631446cd6cde714aef95
author Brad Roberts <braddr@puremagic.com> 1114087949 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114087949 -0700

[PATCH] temporarily change add_cache_entry to create an empty cache on demand

read-tree.c expects to be able to add entries into an empty cache in the
non-merging mode.

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 read-cache.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

Index: read-cache.c
===================================================================
--- b965055600b8bf4927ea631446cd6cde714aef95:1/read-cache.c  (mode:100644 sha1:c399f8e497441147afe630ca080558a8c6c79c78)
+++ 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/read-cache.c  (mode:100644 sha1:31e293a3686622c9ec180d41aa37d85ce49325e8)
@@ -32,6 +32,18 @@
 
 static struct cache * cache = NULL;
 
+struct cache * new_cache()
+{
+	return (struct cache*)calloc(1, sizeof(struct cache));
+}
+
+void free_cache()
+{
+	munmap(cache->map.ptr, cache->map.size);
+	free(cache);
+	cache = NULL;
+}
+
 int cache_match_stat(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
@@ -155,6 +167,11 @@
 {
 	int pos;
 
+	/* temporary, read-tree.c expects the cache to always exist, even
+	 * without a read_cache being called */
+	if (!cache)
+		cache = new_cache();
+
 	pos = cache_name_pos(ce->name, htons(ce->ce_flags));
 
 	/* existing match? Just replace it */
@@ -230,7 +247,7 @@
 		return (errno == ENOENT) ? 0 : error("open failed");
 
 	errno = ENOMEM;
-	cache = (struct cache*)malloc(sizeof(struct cache));
+	cache = new_cache();
 	if (!cache)
 		return error("unable to allocate cache");
 
@@ -333,10 +350,3 @@
 	}
 	return ce_flush(&c, newfd);
 }
-
-void free_cache()
-{
-	munmap(cache->map.ptr, cache->map.size);
-	free(cache);
-	cache = NULL;
-}

