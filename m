From: David Greaves <david@dgreaves.com>
Subject: [PATCH 1/1] bugfix for git-checkout-cache --prefix=/symlink/export_dir/ -a
Date: Mon, 23 May 2005 09:49:38 +0100
Message-ID: <E1Da8d0-0002GR-4m@ash.dgreaves.com>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 10:50:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da8c0-0003Vb-Cq
	for gcvg-git@gmane.org; Mon, 23 May 2005 10:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEWItw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEWItw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 04:49:52 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:25323 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261864AbVEWItj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 04:49:39 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 833A7E6DB9; Mon, 23 May 2005 09:48:48 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25992-02; Mon, 23 May 2005 09:48:48 +0100 (BST)
Received: from oak.dgreaves.com (modem-4088.lion.dialup.pol.co.uk [217.135.175.248])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C965CE6DAE; Mon, 23 May 2005 09:48:47 +0100 (BST)
Received: from [10.0.0.90] (helo=ash.dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1Da8d3-0002Lk-GW; Mon, 23 May 2005 09:49:41 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1Da8d0-0002GR-4m; Mon, 23 May 2005 09:49:38 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If there's a prefix then allow symlinks to directories in it.
This fixes a bug where
  git-checkout-cache --prefix=/symlink/export_dir/ -a
otherwise fails.

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit 18006ac69ae9db97b7d96fd0bfb1bdb6893e318d
tree 37580a3d32262d2cee7d28b20474c0f2ceb6faaa
parent 2aef5bbae99aeba3551408eae13faea02bf55b67
author David Greaves <david@dgreaves.com> Mon, 23 May 2005 09:42:04 +0100
committer David Greaves <david@dgreaves.com> Mon, 23 May 2005 09:42:04 +0100

 checkout-cache.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: checkout-cache.c
===================================================================
--- 99282828d5af15b0af0d0eac13a5b1194e88342c/checkout-cache.c  (mode:100644)
+++ 37580a3d32262d2cee7d28b20474c0f2ceb6faaa/checkout-cache.c  (mode:100644)
@@ -37,20 +37,25 @@
 #include "cache.h"
 
 static int force = 0, quiet = 0, not_new = 0, refresh_cache = 0;
+const char *base_dir = "";
 
 static void create_directories(const char *path)
 {
 	int len = strlen(path);
 	char *buf = xmalloc(len + 1);
 	const char *slash = path;
+	int baselen = strlen(base_dir);
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
+		struct stat st;
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
+		if (slash - path <= baselen &&
+		    !stat(buf, &st) && S_ISDIR(st.st_mode))
+			continue; /* allow symlinks only in --prefix */
 		if (mkdir(buf, 0755)) {
 			if (errno == EEXIST) {
-				struct stat st;
 				if (!lstat(buf, &st) && S_ISDIR(st.st_mode))
 					continue; /* ok */
 				if (force && !unlink(buf) && !mkdir(buf, 0755))
@@ -229,7 +234,6 @@
 int main(int argc, char **argv)
 {
 	int i, force_filename = 0;
-	const char *base_dir = "";
 	struct cache_file cache_file;
 	int newfd = -1;
 
