From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Cache of hardlinked blobs
Date: Sat, 16 Apr 2005 00:43:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504160019240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 06:39:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMf5Q-0004sr-8i
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 06:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVDPEmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 00:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVDPEmr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 00:42:47 -0400
Received: from iabervon.org ([66.92.72.58]:53765 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262634AbVDPEml (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 00:42:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMf92-0008QV-00; Sat, 16 Apr 2005 00:43:00 -0400
To: Ingo Molnar <mingo@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wrote a quick and dirty patch to check out blobs into .git/blobs, and
hardlink them into the working directory; if you symlink .git/blobs
together for a number of trees, this should save a lot of space if you
have a lot of working directories. It also seems to speed up and save
space in "git fork" (or whatever it ends up being called) if the symlink
is added to the list of symlinks. It seems effective from trying it with a
git tree. Ingo: do you want to try it with a kernel tree? I think you said
you wanted good performance for that sort of thing.

Patch follows:

Make a cache of expanded blobs, and hardlink against them instead of
creating more files. This is useful if the cache is shared between
different working directories and your editor breaks hard links
appropriately.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: checkout-cache.c
===================================================================
--- e4d994ccc556a50f89297c6dbcf22e484a344cf8/checkout-cache.c  (mode:100664 sha1:431b7032576f40d93a08be801e26f76c168ed57b)
+++ 2ee21d9b73c81d51f6c0e8ff35a92a4f11105fc4/checkout-cache.c  (mode:100664 sha1:9624b3c783c482c9f6da8bf8b2cf45b316107776)
@@ -34,6 +34,8 @@
  */
 #include "cache.h"
 
+#define HARDLINK_CACHE ".git/blobs"
+
 static int force = 0, quiet = 0;
 
 static void create_directories(const char *path)
@@ -64,6 +66,80 @@
 	return fd;
 }
 
+#ifdef HARDLINK_CACHE
+
+/*
+ * NOTE! This returns a statically allocated buffer, so you have to be
+ * careful about using it. Do a "strdup()" if you need to save the
+ * filename.
+ */
+char *sha1_blob_cache_file_name(const unsigned char *sha1)
+{
+	int i;
+	static char *name, *base;
+
+	if (!base) {
+		char *sha1_file_directory = HARDLINK_CACHE;
+		int len = strlen(sha1_file_directory);
+		base = malloc(len + 60);
+		memcpy(base, sha1_file_directory, len);
+		memset(base+len, 0, 60);
+		base[len] = '/';
+		base[len+3] = '/';
+		name = base + len + 1;
+	}
+	for (i = 0; i < 20; i++) {
+		static char hex[] = "0123456789abcdef";
+		unsigned int val = sha1[i];
+		char *pos = name + i*2 + (i > 0);
+		*pos++ = hex[val >> 4];
+		*pos = hex[val & 0xf];
+	}
+	return base;
+}
+
+static int write_entry(struct cache_entry *ce)
+{
+	int fd;
+	void *new;
+	unsigned long size;
+	long wrote;
+	char type[20];
+	char *cache_name;
+	struct stat st;
+
+	cache_name = sha1_blob_cache_file_name(ce->sha1);
+
+	if (stat(cache_name, &st)) {
+		new = read_sha1_file(ce->sha1, type, &size);
+		if (!new || strcmp(type, "blob")) {
+			return error("checkout-cache: unable to read sha1 file of %s (%s)",
+				     ce->name, sha1_to_hex(ce->sha1));
+		}
+		fd = create_file(cache_name, ntohl(ce->ce_mode));
+		if (fd < 0) {
+			free(new);
+			return error("checkout-cache: unable to create %s (%s)",
+				     ce->name, strerror(errno));
+		}
+		wrote = write(fd, new, size);
+		close(fd);
+		free(new);
+		if (wrote != size)
+			return error("checkout-cache: unable to write %s", 
+				     ce->name);
+	}
+	if (link(cache_name, ce->name)) {
+		if (errno == ENOENT) {
+			create_directories(ce->name);
+			link(cache_name, ce->name);
+		}
+	}
+	return 0;
+}
+
+#else
+
 static int write_entry(struct cache_entry *ce)
 {
 	int fd;
@@ -91,6 +167,8 @@
 	return 0;
 }
 
+#endif
+
 static int checkout_entry(struct cache_entry *ce)
 {
 	struct stat st;

