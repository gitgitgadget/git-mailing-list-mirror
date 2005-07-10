From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Remove map_sha1_file
Date: Sun, 10 Jul 2005 18:27:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101825420.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0507101811390.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 00:32:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrkLg-0005UB-Iv
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 00:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVGJWbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVGJW3T
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 18:29:19 -0400
Received: from iabervon.org ([66.92.72.58]:53254 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262114AbVGJW3C (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 18:29:02 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrkGM-0006bL-00; Sun, 10 Jul 2005 18:27:02 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0507101811390.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove map_sha1_file(), now unused.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
commit c21a02262f770a25b005378e06354e582aa1bfd8
tree 7ac9fabe666f00f37572e7b349fdb859bf8a6491
parent 264ff9f3dcde5553728b34fa08e04643b2b55946
author Daniel Barkalow <barkalow@iabervon.org> 1121033599 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1121033599 -0400

Index: cache.h
===================================================================
--- 353fe33ae9c7265d7b685bca864d657e3efe2849/cache.h  (mode:100644 sha1:38dac6d6a413f1c788e5331ef4741fc15d72d9bd)
+++ 7ac9fabe666f00f37572e7b349fdb859bf8a6491/cache.h  (mode:100644 sha1:11ba95c8aa9202fa3b1a3cbc07bc976641cd1908)
@@ -167,7 +167,6 @@
 int safe_create_leading_directories(char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
 extern int parse_sha1_header(char *hdr, char *type, unsigned long *sizep);
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
Index: sha1_file.c
===================================================================
--- 353fe33ae9c7265d7b685bca864d657e3efe2849/sha1_file.c  (mode:100644 sha1:08560b2c7a6dff400a46160501c247081f9bb4c7)
+++ 7ac9fabe666f00f37572e7b349fdb859bf8a6491/sha1_file.c  (mode:100644 sha1:e082f2e6cb985caca11979311c291aa51d6c37fd)
@@ -578,8 +578,7 @@
 }
 
 static void *map_sha1_file_internal(const unsigned char *sha1,
-				    unsigned long *size,
-				    int say_error)
+				    unsigned long *size)
 {
 	struct stat st;
 	void *map;
@@ -587,8 +586,6 @@
 	char *filename = find_sha1_file(sha1, &st);
 
 	if (!filename) {
-		if (say_error)
-			error("cannot map sha1 file %s", sha1_to_hex(sha1));
 		return NULL;
 	}
 
@@ -602,8 +599,6 @@
 				break;
 		/* Fallthrough */
 		case 0:
-			if (say_error)
-				perror(filename);
 			return NULL;
 		}
 
@@ -620,11 +615,6 @@
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
-{
-	return map_sha1_file_internal(sha1, size, 1);
-}
-
 int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size)
 {
 	/* Get the data stream */
@@ -1112,7 +1102,7 @@
 	z_stream stream;
 	char hdr[128];
 
-	map = map_sha1_file_internal(sha1, &mapsize, 0);
+	map = map_sha1_file_internal(sha1, &mapsize);
 	if (!map) {
 		struct pack_entry e;
 
@@ -1151,7 +1141,7 @@
 	unsigned long mapsize;
 	void *map, *buf;
 
-	map = map_sha1_file_internal(sha1, &mapsize, 0);
+	map = map_sha1_file_internal(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
 		munmap(map, mapsize);
@@ -1331,7 +1321,7 @@
 	ssize_t size;
 	unsigned long objsize;
 	int posn = 0;
-	char *buf = map_sha1_file_internal(sha1, &objsize, 0);
+	char *buf = map_sha1_file_internal(sha1, &objsize);
 	z_stream stream;
 	if (!buf) {
 		unsigned char *unpacked;
