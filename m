From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Expose packed_git and alt_odb.
Date: Tue, 28 Jun 2005 14:56:57 -0700
Message-ID: <7vmzpataae.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<7vslz2x3vg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 00:07:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnODt-0006H7-BQ
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 00:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVF1WA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVF1V7w
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 17:59:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26040 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261436AbVF1V47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 17:56:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628215659.WGDM18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 17:56:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vslz2x3vg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 28 Jun 2005 01:49:39 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The commands git-fsck-cache and probably git-*-pull needs to
have a way to enumerate objects contained in packed GIT archives
and alternate object pools.  This commit exposes the data
structure used to keep track of them from sha1_file.c, and adds
a couple of accessor interface functions for use by the enhanced
git-fsck-cache command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h     |   19 +++++++++++++++++++
 sha1_file.c |   43 ++++++++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 19 deletions(-)

da37711700d11f8c7f44fcb6819c724978c840b7
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -233,4 +233,23 @@ struct checkout {
 
 extern int checkout_entry(struct cache_entry *ce, struct checkout *state);
 
+extern struct alternate_object_database {
+	char *base;
+	char *name;
+} *alt_odb;
+extern void prepare_alt_odb(void);
+
+extern struct packed_git {
+	struct packed_git *next;
+	unsigned long index_size;
+	unsigned long pack_size;
+	unsigned int *index_base;
+	void *pack_base;
+	unsigned int pack_last_used;
+	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
+} *packed_git;
+extern void prepare_packed_git(void);
+extern int num_packed_objects(const struct packed_git *p);
+extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
+
 #endif /* CACHE_H */
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -184,10 +184,7 @@ char *sha1_file_name(const unsigned char
 	return base;
 }
 
-static struct alternate_object_database {
-	char *base;
-	char *name;
-} *alt_odb;
+struct alternate_object_database *alt_odb;
 
 /*
  * Prepare alternate object database registry.
@@ -205,13 +202,15 @@ static struct alternate_object_database 
  * pointed by base fields of the array elements with one xmalloc();
  * the string pool immediately follows the array.
  */
-static void prepare_alt_odb(void)
+void prepare_alt_odb(void)
 {
 	int pass, totlen, i;
 	const char *cp, *last;
 	char *op = NULL;
 	const char *alt = gitenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
 
+	if (alt_odb)
+		return;
 	/* The first pass counts how large an area to allocate to
 	 * hold the entire alt_odb structure, including array of
 	 * structs and path buffers for them.  The second pass fills
@@ -258,8 +257,7 @@ static char *find_sha1_file(const unsign
 
 	if (!stat(name, st))
 		return name;
-	if (!alt_odb)
-		prepare_alt_odb();
+	prepare_alt_odb();
 	for (i = 0; (name = alt_odb[i].name) != NULL; i++) {
 		fill_sha1_path(name, sha1);
 		if (!stat(alt_odb[i].base, st))
@@ -271,15 +269,7 @@ static char *find_sha1_file(const unsign
 #define PACK_MAX_SZ (1<<26)
 static int pack_used_ctr;
 static unsigned long pack_mapped;
-static struct packed_git {
-	struct packed_git *next;
-	unsigned long index_size;
-	unsigned long pack_size;
-	unsigned int *index_base;
-	void *pack_base;
-	unsigned int pack_last_used;
-	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
-} *packed_git;
+struct packed_git *packed_git;
 
 struct pack_entry {
 	unsigned int offset;
@@ -430,7 +420,7 @@ static void prepare_packed_git_one(char 
 	}
 }
 
-static void prepare_packed_git(void)
+void prepare_packed_git(void)
 {
 	int i;
 	static int run_once = 0;
@@ -439,8 +429,7 @@ static void prepare_packed_git(void)
 		return;
 
 	prepare_packed_git_one(get_object_directory());
-	if (!alt_odb)
-		prepare_alt_odb();
+	prepare_alt_odb();
 	for (i = 0; alt_odb[i].base != NULL; i++) {
 		alt_odb[i].name[0] = 0;
 		prepare_packed_git_one(alt_odb[i].base);
@@ -750,6 +739,22 @@ static void *unpack_entry(struct pack_en
 	return unpack_non_delta_entry(pack+5, size, left);
 }
 
+int num_packed_objects(const struct packed_git *p)
+{
+	/* See check_packed_git_idx and pack-objects.c */
+	return (p->index_size - 20 - 20 - 4*256) / 24;
+}
+
+int nth_packed_object_sha1(const struct packed_git *p, int n,
+			   unsigned char* sha1)
+{
+	void *index = p->index_base + 256;
+	if (n < 0 || num_packed_objects(p) <= n)
+		return -1;
+	memcpy(sha1, (index + 24 * n + 4), 20);
+	return 0;
+}
+
 static int find_pack_entry_1(const unsigned char *sha1,
 			     struct pack_entry *e, struct packed_git *p)
 {
------------
