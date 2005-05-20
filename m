From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] delta read
Date: Fri, 20 May 2005 16:57:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505201655000.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 22:57:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEY0-0005YT-Ui
	for gcvg-git@gmane.org; Fri, 20 May 2005 22:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVETU5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVETU5n
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 16:57:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14149 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261589AbVETU5d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 16:57:33 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGT001AW3JSRF@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 May 2005 16:57:28 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes the core code aware of delta objects and undeltafy
them as needed.  The convention is to use read_sha1_file() to have
undeltafication done automatically (most users do that already so
this is transparent).

If the delta object itself has to be accessed then it must be done
through map_sha1_file() and unpack_sha1_file().

In that context mktag.c has been switched to read_sha1_file() as there
is no reason to do the full map+unpack manually.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: git/sha1_file.c
===================================================================
--- git.orig/sha1_file.c
+++ git/sha1_file.c
@@ -9,6 +9,7 @@
 #include <stdarg.h>
 #include <limits.h>
 #include "cache.h"
+#include "delta.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -353,6 +354,19 @@
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
 		munmap(map, mapsize);
+		if (buf && !strcmp(type, "delta")) {
+			void *ref = NULL, *delta = buf;
+			unsigned long ref_size, delta_size = *size;
+			buf = NULL;
+			if (delta_size > 20)
+				ref = read_sha1_file(delta, type, &ref_size);
+			if (ref)
+				buf = patch_delta(ref, ref_size,
+						  delta+20, delta_size-20, 
+						  size);
+			free(delta);
+			free(ref);
+		}
 		return buf;
 	}
 	return NULL;
Index: git/mktag.c
===================================================================
--- git.orig/mktag.c
+++ git/mktag.c
@@ -25,20 +25,14 @@
 static int verify_object(unsigned char *sha1, const char *expected_type)
 {
 	int ret = -1;
-	unsigned long mapsize;
-	void *map = map_sha1_file(sha1, &mapsize);
+	char type[100];
+	unsigned long size;
+	void *buffer = read_sha1_file(sha1, type, &size);
 
-	if (map) {
-		char type[100];
-		unsigned long size;
-		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
-
-		if (buffer) {
-			if (!strcmp(type, expected_type))
-				ret = check_sha1_signature(sha1, buffer, size, type);
-			free(buffer);
-		}
-		munmap(map, mapsize);
+	if (buffer) {
+		if (!strcmp(type, expected_type))
+			ret = check_sha1_signature(sha1, buffer, size, type);
+		free(buffer);
 	}
 	return ret;
 }
