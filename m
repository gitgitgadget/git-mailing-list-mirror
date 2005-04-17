From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 11:35:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171131230.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:32:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBkG-0004AJ-TL
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDQPfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDQPfW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:35:22 -0400
Received: from iabervon.org ([66.92.72.58]:11012 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261332AbVDQPfB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:35:01 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNBnr-0006bj-00; Sun, 17 Apr 2005 11:35:19 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds an option (compile time, defined in the Makefile) to have a
cache of extracted blobs so that different working directories can
hardlink against them instead of creating new files for every
checkout. You should only use this if you're sure the programs you use
break links on modification and you care about storing many large working
directories with few changes at the same time.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/Makefile  (mode:100644 sha1:940ef8578cf469354002cd8feaec25d907015267)
+++ 08f7700831e056ad710af69f91e3a8a705b6b2b1/Makefile  (mode:100644 sha1:a60fa46404c0487158d232bd021e4798bc8df8de)
@@ -2,6 +2,9 @@
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # enough guarantees about no collisions between objects ever hapenning.
 #
+# -DUSE_HARDLINK_CACHE if you want a cache of files to be hardlinked
+# to for unmodified checked out files.
+#
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
Index: checkout-cache.c
===================================================================
--- 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/checkout-cache.c  (mode:100644 sha1:5d3028df0a45329e45fff2006719c9267adeb946)
+++ 08f7700831e056ad710af69f91e3a8a705b6b2b1/checkout-cache.c  (mode:100644 sha1:338588259e17dd235fdc7db759d770004a760e15)
@@ -34,6 +34,10 @@
  */
 #include "cache.h"
 
+#ifdef USE_HARDLINK_CACHE
+#define HARDLINK_CACHE ".git/blobs"
+#endif /* USE_HARDLINK_CACHE */
+
 static int force = 0, quiet = 0;
 
 static void create_directories(const char *path)
@@ -67,6 +71,80 @@
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
@@ -94,6 +172,8 @@
 	return 0;
 }
 
+#endif
+
 static int checkout_entry(struct cache_entry *ce)
 {
 	struct stat st;

