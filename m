From: Jon Seymour <jon.seymour@gmail.com>
Subject: [resend#2] [PATCH] Add -i option to cat-file to allow operation on displaced git object files
Date: Sun, 24 Apr 2005 04:27:01 +1000
Message-ID: <20050423192032.27808.qmail@blackcubes.dyndns.org>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 23 21:16:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQ72-0007Zm-9Z
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVDWTU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVDWTU7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:20:59 -0400
Received: from 203-206-251-226.dyn.iinet.net.au ([203.206.251.226]:20354 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261720AbVDWTUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 15:20:36 -0400
Received: (qmail 27809 invoked by uid 0); 23 Apr 2005 19:20:32 -0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add -i option to cat-file to allow operation on displaced git object files

For the purposes of merging the contents of remote git object repositories at the filesystem level, it would
be helpful to be able to verify the integrity of a remote git object file before it is actually
copied into the local repository.

To enable this, the option syntax for the usage of the cat-file tool is extended with a -i option, per the
modified usage string quoted below:

    usage: cat-file [-t | tagname] <sha1> [ -i displaced-git-object-file ]

If the -i option is specified, cat-file uses the filename specified on the command line rather than the derived
filename to locate and process the git object file implied by the sha1 argument.

In addition, the -i option forces cat-file to check the SHA1 signature of the specified input file against
the SHA1 signature specified on the command line and report an error if there is a mismatch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Apologies for the repeated attempts to mail this patch. I'll use qmail in future!

---
Index: cache.h
=================================--- e6d3a81c30ad237102e2ca82f3dfc57d0b9f0ddf/cache.h  (mode:100644 sha1:bf30ac4741d2eeeb483079f566182505898082f3)
+++ 1b503f0571727a865b413e28641d2be09c8c3304/cache.h  (mode:100644 sha1:56eacfa0ab43c93a838efedca429e865c95f16bc)
@@ -121,8 +121,9 @@
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
+extern void * read_displaced_sha1_file(char *type, unsigned long *size, const char *filename);
 extern int write_sha1_file(char *buf, unsigned len, unsigned char *return_sha1);
-extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
+extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage);
Index: cat-file.c
=================================--- e6d3a81c30ad237102e2ca82f3dfc57d0b9f0ddf/cat-file.c  (mode:100644 sha1:3c47d79a16305d326a65768fe9f37ee25928510b)
+++ 1b503f0571727a865b413e28641d2be09c8c3304/cat-file.c  (mode:100644 sha1:c88df7287b6ce7d6d33d016ffb524cc5a793cad2)
@@ -5,16 +5,32 @@
  */
 #include "cache.h"
 
+static char _usage[]"cat-file [-t | tagname] <sha1> [ -i displaced-git-object-file ]";
+
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 	char type[20];
-	void *buf;
+	void *buf NULL;
 	unsigned long size;
 
-	if (argc ! || get_sha1_hex(argv[2], sha1))
-		usage("cat-file [-t | tagname] <sha1>");
-	buf read_sha1_file(sha1, type, &size);
+	if (argc < 3 || get_sha1_hex(argv[2], sha1))
+		usage(_usage);
+
+        if (argc = 3) {
+	    buf read_sha1_file(sha1, type, &size);
+        } else if (argc = 5 && !strcmp(argv[3], "-i")) {
+            buf read_displaced_sha1_file(type, &size, argv[4]);
+            if (!buf) 
+                    die("bad file: %s", argv[4]);
+	    
+            if (check_sha1_signature(sha1, buf, size, type) < 0)
+                    die("signature mismatch for %s", argv[4]);
+
+        } else {
+	    usage(_usage);
+        }
+
 	if (!buf)
 		die("cat-file %s: bad file", argv[2]);
 	if (!strcmp("-t", argv[1])) {
Index: sha1_file.c
=================================--- e6d3a81c30ad237102e2ca82f3dfc57d0b9f0ddf/sha1_file.c  (mode:100644 sha1:6f7228e106d4e24b18f8416cc6adc2a6fd303eb7)
+++ 1b503f0571727a865b413e28641d2be09c8c3304/sha1_file.c  (mode:100644 sha1:25e2e8b22cf9590a6df05f234ce88db8c2cd1030)
@@ -80,7 +80,7 @@
 	return base;
 }
 
-int check_sha1_signature(unsigned char *sha1, void *map, unsigned long size, const char *type)
+int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	char header[100];
 	unsigned char real_sha1[20];
@@ -93,13 +93,12 @@
 	return memcmp(sha1, real_sha1, 20) ? -1 : 0;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+static void *map_file(const char *filename, unsigned long *size)
 {
-	char *filename sha1_file_name(sha1);
-	int fd open(filename, O_RDONLY);
 	struct stat st;
 	void *map;
 
+	int fd open(filename, O_RDONLY);
 	if (fd < 0) {
 		perror(filename);
 		return NULL;
@@ -116,6 +115,12 @@
 	return map;
 }
 
+void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+{
+        char *filename sha1_file_name(sha1);
+        return map_file(filename, size);
+}
+
 void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size)
 {
 	int ret, bytes;
@@ -166,6 +171,20 @@
 	return NULL;
 }
 
+void * read_displaced_sha1_file(char *type, unsigned long *size, const char *filename)
+{
+	unsigned long mapsize;
+	void *map, *buf;
+
+	map map_file(filename, &mapsize);
+	if (map) {
+		buf unpack_sha1_file(map, mapsize, type, size);
+		munmap(map, mapsize);
+		return buf;
+	}
+	return NULL;
+}
+
 void *read_tree_with_tree_or_commit_sha1(const unsigned char *sha1,
 					 unsigned long *size,
 					 unsigned char *tree_sha1_return)
