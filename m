From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Management of packs not yet installed
Date: Sun, 10 Jul 2005 15:55:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101553270.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 10 21:59:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrhxL-0008BR-0s
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 21:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVGJT6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVGJT6p
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 15:58:45 -0400
Received: from iabervon.org ([66.92.72.58]:44548 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262094AbVGJT5T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 15:57:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Drhta-0007Dr-00; Sun, 10 Jul 2005 15:55:22 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Support for parsing index files without pack files, installing pack
files while running, and checking what pack files are available.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
commit b686d7a0377c24e05dbed0dafe909dda6c3dfb48
tree ce285b1a0adb4f8d415f72668a77bc1f1f92e1e1
parent 167a4a3308f4a1606e268c2204c98d6999046ae0
author Daniel Barkalow <barkalow@iabervon.org> 1121024924 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1121024924 -0400

Index: cache.h
===================================================================
--- dbae854c7c91182c8a124d0b85d802945d1c6223/cache.h  (mode:100644 sha1:84d43d366c6145a30865aa65d92ada88ab95bb9f)
+++ ce285b1a0adb4f8d415f72668a77bc1f1f92e1e1/cache.h  (mode:100644 sha1:719a77dfabb24e58abd21b7f3a4b846a114e000a)
@@ -161,6 +161,8 @@
 extern char *mkpath(const char *fmt, ...);
 extern char *git_path(const char *fmt, ...);
 extern char *sha1_file_name(const unsigned char *sha1);
+extern char *sha1_pack_name(const unsigned char *sha1);
+extern char *sha1_pack_index_name(const unsigned char *sha1);
 
 int safe_create_leading_directories(char *path);
 
@@ -189,6 +191,9 @@
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
 
+extern int has_pack_file(const unsigned char *sha1);
+extern int has_pack_index(const unsigned char *sha1);
+
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
@@ -260,6 +265,7 @@
 	void *pack_base;
 	unsigned int pack_last_used;
 	unsigned int pack_use_cnt;
+	unsigned char sha1[20];
 	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
 } *packed_git;
 
@@ -274,7 +280,14 @@
 extern int path_match(const char *path, int nr, char **match);
 extern int get_ack(int fd, unsigned char *result_sha1);
 
+extern struct packed_git *parse_pack_index(unsigned char *sha1);
+
 extern void prepare_packed_git(void);
+extern void install_packed_git(struct packed_git *pack);
+
+struct packed_git *find_sha1_pack(const unsigned char *sha1, 
+				  struct packed_git *packs);
+
 extern int use_packed_git(struct packed_git *);
 extern void unuse_packed_git(struct packed_git *);
 extern struct packed_git *add_packed_git(char *, int);
Index: sha1_file.c
===================================================================
--- dbae854c7c91182c8a124d0b85d802945d1c6223/sha1_file.c  (mode:100644 sha1:b2914dd2ea629ae974fd4b4c272e77cb04e5c0e0)
+++ ce285b1a0adb4f8d415f72668a77bc1f1f92e1e1/sha1_file.c  (mode:100644 sha1:27136fdba0fbf2dd943f2634cb49660cdbf95ec4)
@@ -200,6 +200,56 @@
 	return base;
 }
 
+char *sha1_pack_name(const unsigned char *sha1)
+{
+	static const char hex[] = "0123456789abcdef";
+	static char *name, *base, *buf;
+	int i;
+
+	if (!base) {
+		const char *sha1_file_directory = get_object_directory();
+		int len = strlen(sha1_file_directory);
+		base = xmalloc(len + 60);
+		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
+		name = base + len + 11;
+	}
+
+	buf = name;
+
+	for (i = 0; i < 20; i++) {
+		unsigned int val = *sha1++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	
+	return base;
+}
+
+char *sha1_pack_index_name(const unsigned char *sha1)
+{
+	static const char hex[] = "0123456789abcdef";
+	static char *name, *base, *buf;
+	int i;
+
+	if (!base) {
+		const char *sha1_file_directory = get_object_directory();
+		int len = strlen(sha1_file_directory);
+		base = xmalloc(len + 60);
+		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.idx", sha1_file_directory);
+		name = base + len + 11;
+	}
+
+	buf = name;
+
+	for (i = 0; i < 20; i++) {
+		unsigned int val = *sha1++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	
+	return base;
+}
+
 struct alternate_object_database *alt_odb;
 
 /*
@@ -360,6 +410,14 @@
 
 int use_packed_git(struct packed_git *p)
 {
+	if (!p->pack_size) {
+		struct stat st;
+		// We created the struct before we had the pack
+		stat(p->pack_name, &st);
+		if (!S_ISREG(st.st_mode))
+			die("packfile %s not a regular file", p->pack_name);
+		p->pack_size = st.st_size;
+	}
 	if (!p->pack_base) {
 		int fd;
 		struct stat st;
@@ -387,8 +445,10 @@
 		 * this is cheap.
 		 */
 		if (memcmp((char*)(p->index_base) + p->index_size - 40,
-			   p->pack_base + p->pack_size - 20, 20))
+			   p->pack_base + p->pack_size - 20, 20)) {
+			      
 			die("packfile %s does not match index.", p->pack_name);
+		}
 	}
 	p->pack_last_used = pack_used_ctr++;
 	p->pack_use_cnt++;
@@ -426,6 +486,37 @@
 	return p;
 }
 
+struct packed_git *parse_pack_index(unsigned char *sha1)
+{
+	struct packed_git *p;
+	unsigned long idx_size;
+	void *idx_map;
+	char *path = sha1_pack_index_name(sha1);
+
+	if (check_packed_git_idx(path, &idx_size, &idx_map))
+		return NULL;
+
+	path = sha1_pack_name(sha1);
+
+	p = xmalloc(sizeof(*p) + strlen(path) + 2);
+	strcpy(p->pack_name, path);
+	p->index_size = idx_size;
+	p->pack_size = 0;
+	p->index_base = idx_map;
+	p->next = NULL;
+	p->pack_base = NULL;
+	p->pack_last_used = 0;
+	p->pack_use_cnt = 0;
+	memcpy(p->sha1, sha1, 20);
+	return p;
+}
+
+void install_packed_git(struct packed_git *pack)
+{
+	pack->next = packed_git;
+	packed_git = pack;
+}
+
 static void prepare_packed_git_one(char *objdir)
 {
 	char path[PATH_MAX];
@@ -999,6 +1090,20 @@
 	return 0;
 }
 
+struct packed_git *find_sha1_pack(const unsigned char *sha1, 
+				  struct packed_git *packs)
+{
+	struct packed_git *p;
+	struct pack_entry e;
+
+	for (p = packs; p; p = p->next) {
+		if (find_pack_entry_one(sha1, &e, p))
+			return p;
+	}
+	return NULL;
+	
+}
+
 int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
 {
 	int status;
@@ -1283,6 +1388,22 @@
 	return 0;
 }
 
+int has_pack_index(const unsigned char *sha1)
+{
+	struct stat st;
+	if (stat(sha1_pack_index_name(sha1), &st))
+		return 0;
+	return 1;
+}
+
+int has_pack_file(const unsigned char *sha1)
+{
+	struct stat st;
+	if (stat(sha1_pack_name(sha1), &st))
+		return 0;
+	return 1;
+}
+
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
