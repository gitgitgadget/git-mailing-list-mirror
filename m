From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 04/19] Migrate update-cache.c to use the new cache api's
Date: Thu, 21 Apr 2005 11:35:28 -0700
Message-ID: <200504211835.j3LIZSIP027449@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:32:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgSf-0007qj-Nw
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVDUSf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVDUSf4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:35:56 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:7304 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261644AbVDUSf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:35:29 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIZQ5Y027804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:26 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIZSNX027451
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:28 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIZSIP027449
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:35:28 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 34f7fc89e28a40387e811057065592ed2f0218a2
parent d70686e08f453199e5451b27fc7d0b36b73a5c7f
author Brad Roberts <braddr@puremagic.com> 1114073784 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114073784 -0700

[PATCH] Migrate update-cache.c to use the new cache api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 read-cache.c   |    3 +++
 update-cache.c |   13 +++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: read-cache.c
===================================================================
--- d70686e08f453199e5451b27fc7d0b36b73a5c7f:1/read-cache.c  (mode:100644 sha1:6689df59d5a93e0503d7c80c114efbd16de826f3)
+++ 40bf732f5bcb986943070a2ed6c09a16543d81be:1/read-cache.c  (mode:100644 sha1:8eaa05957a481b09116c37e43e16c5ef4e219a1e)
@@ -122,6 +122,9 @@
 
 void set_cache_entry(struct cache_entry *ce, int pos)
 {
+	/* You can NOT just free active_cache[i] here, since it
+	 * might not be necessarily malloc()ed but can also come
+	 * from mmap(). */
 	active_cache[pos] = ce;
 }
 
Index: update-cache.c
===================================================================
--- d70686e08f453199e5451b27fc7d0b36b73a5c7f:1/update-cache.c  (mode:100644 sha1:585951108c57a64bb774114d289d81fd7fd22768)
+++ 40bf732f5bcb986943070a2ed6c09a16543d81be:1/update-cache.c  (mode:100644 sha1:e741f593eb9c56c596fabed7eb6b79dee2d8cba9)
@@ -204,13 +204,13 @@
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < get_num_cache_entries(); i++) {
 		struct cache_entry *ce, *new;
-		ce = active_cache[i];
+		ce = get_cache_entry(i);
 		if (ce_stage(ce)) {
 			printf("%s: needs merge\n", ce->name);
-			while ((i < active_nr) &&
-			       ! strcmp(active_cache[i]->name, ce->name))
+			while ((i < get_num_cache_entries()) &&
+			       ! strcmp(get_cache_entry(i)->name, ce->name))
 				i++;
 			i--;
 			continue;
@@ -221,10 +221,7 @@
 			printf("%s: needs update\n", ce->name);
 			continue;
 		}
-		/* You can NOT just free active_cache[i] here, since it
-		 * might not be necessarily malloc()ed but can also come
-		 * from mmap(). */
-		active_cache[i] = new;
+		set_cache_entry(new, i);
 	}
 }
 

