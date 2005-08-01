From: barkalow@iabervon.org
Subject: [PATCH 1/2] Functions for managing the set of packs the library is
 using (whitespace fixed)
Date: Sun, 31 Jul 2005 20:53:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507312053010.23721@iabervon.org>
References: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 02:52:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzOXR-0002AR-70
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 02:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVHAAvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 20:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVHAAvr
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 20:51:47 -0400
Received: from iabervon.org ([66.92.72.58]:23313 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262301AbVHAAut (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 20:50:49 -0400
Received: (qmail 24951 invoked by uid 1000); 31 Jul 2005 20:53:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 20:53:44 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support for reading an uninstalled index, and installing a
pack file that was added while the program was running, as well as
functions for determining where to put the file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 cache.h     |   13 ++++++
 sha1_file.c |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 1 deletions(-)

20fcc8f66a6780cf9bbd2fc2ba3b918c33696a67
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -172,6 +172,8 @@ extern void rollback_index_file(struct c
 extern char *mkpath(const char *fmt, ...);
 extern char *git_path(const char *fmt, ...);
 extern char *sha1_file_name(const unsigned char *sha1);
+extern char *sha1_pack_name(const unsigned char *sha1);
+extern char *sha1_pack_index_name(const unsigned char *sha1);
 
 int safe_create_leading_directories(char *path);
 
@@ -200,6 +202,9 @@ extern int write_sha1_to_fd(int fd, cons
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
 
+extern int has_pack_file(const unsigned char *sha1);
+extern int has_pack_index(const unsigned char *sha1);
+
 /* Convert to/from hex/sha1 representation */
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
@@ -276,6 +281,7 @@ extern struct packed_git {
 	void *pack_base;
 	unsigned int pack_last_used;
 	unsigned int pack_use_cnt;
+	unsigned char sha1[20];
 	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
 } *packed_git;
 
@@ -298,7 +304,14 @@ extern int path_match(const char *path, 
 extern int get_ack(int fd, unsigned char *result_sha1);
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match);
 
+extern struct packed_git *parse_pack_index(unsigned char *sha1);
+
 extern void prepare_packed_git(void);
+extern void install_packed_git(struct packed_git *pack);
+
+extern struct packed_git *find_sha1_pack(const unsigned char *sha1, 
+					 struct packed_git *packs);
+
 extern int use_packed_git(struct packed_git *);
 extern void unuse_packed_git(struct packed_git *);
 extern struct packed_git *add_packed_git(char *, int);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -200,6 +200,56 @@ char *sha1_file_name(const unsigned char
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
@@ -360,6 +410,14 @@ void unuse_packed_git(struct packed_git 
 
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
@@ -387,8 +445,10 @@ int use_packed_git(struct packed_git *p)
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
@@ -426,6 +486,37 @@ struct packed_git *add_packed_git(char *
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
@@ -989,6 +1080,20 @@ static int find_pack_entry(const unsigne
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
@@ -1335,6 +1440,22 @@ int write_sha1_from_fd(const unsigned ch
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
