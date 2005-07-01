From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] verify-pack updates.
Date: Thu, 30 Jun 2005 17:15:39 -0700
Message-ID: <7vr7ejz8ic.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 02:10:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do96c-0006Gf-Iw
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 02:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbVGAARZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVGAARY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 20:17:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59853 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263132AbVGAAPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 20:15:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701001538.SSBP1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 20:15:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nico pointed out that having verify_pack.c and verify-pack.c was
confusing.  Rename verify_pack.c to pack-check.c as suggested,
and enhances the verification done quite a bit.

 - Built-in sha1_file unpacking knows that a base object of a
   deltified object _must_ be in the same pack, and takes
   advantage of that fact.

 - Earlier verify-pack command only checked the SHA1 sum for the
   entire pack file and did not look into its contents.  It now
   checks everything idx file claims to have unpacks correctly.

 - It now has a hook to give more detailed information for
   objects contained in the pack under -v flag.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** I used "git format-patch -M20" to generate diff to show this
*** commit as a rename/copy patch.  Let's see if git-apply can
*** still grok it ;-).

 Makefile      |    2 +-
 cache.h       |    9 ++++++++
 fsck-cache.c  |    2 +-
 pack-check.c  |   68 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 pack.h        |    2 +-
 sha1_file.c   |   66 +++++++++++++++++++++++++++++++++++++------------------
 verify-pack.c |   51 ++++++++++++++++++++++++++++++++++---------
 7 files changed, 156 insertions(+), 44 deletions(-)
 rename verify_pack.c => pack-check.c (25%)

cf43fb6e9fec205d4786a284e1656b3612c28a77
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -46,7 +46,7 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o csum-file.o verify_pack.o pkt-line.o
+	 epoch.o refs.o csum-file.o pack-check.o pkt-line.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h \
 	pack.h pkt-line.h
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -251,11 +251,20 @@ extern struct packed_git {
 	unsigned int pack_use_cnt;
 	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
 } *packed_git;
+
+struct pack_entry {
+	unsigned int offset;
+	unsigned char sha1[20];
+	struct packed_git *p;
+};
+
 extern void prepare_packed_git(void);
 extern int use_packed_git(struct packed_git *);
 extern void unuse_packed_git(struct packed_git *);
 extern struct packed_git *add_packed_git(char *, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
+extern int find_pack_entry_one(const unsigned char *, struct pack_entry *, struct packed_git *);
+extern void *unpack_entry_gently(struct pack_entry *, char *, unsigned long *);
 
 #endif /* CACHE_H */
diff --git a/fsck-cache.c b/fsck-cache.c
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -440,7 +440,7 @@ int main(int argc, char **argv)
 		prepare_packed_git();
 		for (p = packed_git; p; p = p->next)
 			/* verify gives error messages itself */
-			verify_pack(p); 
+			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
 			int num = num_packed_objects(p);
diff --git a/verify_pack.c b/pack-check.c
similarity index 25%
rename from verify_pack.c
rename to pack-check.c
--- a/verify_pack.c
+++ b/pack-check.c
@@ -10,8 +10,9 @@ static int verify_packfile(struct packed
 	unsigned long pack_size = p->pack_size;
 	void *pack_base;
 	struct pack_header *hdr;
-	int nr_objects;
+	int nr_objects, err, i;
 
+	/* Header consistency check */
 	hdr = p->pack_base;
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		return error("Packfile signature mismatch", p->pack_name);
@@ -34,11 +35,47 @@ static int verify_packfile(struct packed
 	if (memcmp(sha1, pack_base + pack_size - 20, 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
-	return 0;
+
+	/* Make sure everything reachable from idx is valid.  Since we
+	 * have verified that nr_objects matches between idx and pack,
+	 * we do not do scan-streaming check on the pack file.
+	 */
+	for (i = err = 0; i < nr_objects; i++) {
+		unsigned char sha1[20];
+		struct pack_entry e;
+		void *data;
+		char type[20];
+		unsigned long size;
+
+		if (nth_packed_object_sha1(p, i, sha1))
+			die("internal error pack-check nth-packed-object");
+		if (!find_pack_entry_one(sha1, &e, p))
+			die("internal error pack-check find-pack-entry-one");
+		data = unpack_entry_gently(&e, type, &size);
+		if (!data) {
+			err = error("cannot unpack %s from %s",
+				    sha1_to_hex(sha1), p->pack_name);
+			continue;
+		}
+		if (check_sha1_signature(sha1, data, size, type)) {
+			err = error("cannot packed %s from %s corrupt",
+				    sha1_to_hex(sha1), p->pack_name);
+			free(data);
+			continue;
+		}
+		free(data);
+	}
+
+	return err;
 }
 
 
-int verify_pack(struct packed_git *p)
+static void show_pack_info(struct packed_git *p)
+{
+	/* Next round */
+}
+
+int verify_pack(struct packed_git *p, int verbose)
 {
 	unsigned long index_size = p->index_size;
 	void *index_base = p->index_base;
@@ -46,17 +83,30 @@ int verify_pack(struct packed_git *p)
 	unsigned char sha1[20];
 	int ret;
 
+	ret = 0;
 	/* Verify SHA1 sum of the index file */
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, index_size - 20);
 	SHA1_Final(sha1, &ctx);
 	if (memcmp(sha1, index_base + index_size - 20, 20))
-		return error("Packfile index for %s SHA1 mismatch",
-			     p->pack_name);
+		ret = error("Packfile index for %s SHA1 mismatch",
+			    p->pack_name);
+
+	if (!ret) {
+		/* Verify pack file */
+		use_packed_git(p);
+		ret = verify_packfile(p);
+		unuse_packed_git(p);
+	}
+
+	if (verbose) {
+		if (ret)
+			printf("%s: bad\n", p->pack_name);
+		else {
+			show_pack_info(p);
+			printf("%s: ok\n", p->pack_name);
+		}
+	}
 
-	/* Verify pack file */
-	use_packed_git(p);
-	ret = verify_packfile(p);
-	unuse_packed_git(p);
 	return ret;
 }
diff --git a/pack.h b/pack.h
--- a/pack.h
+++ b/pack.h
@@ -27,6 +27,6 @@ struct pack_header {
 	unsigned int hdr_entries;
 };
 
-extern int verify_pack(struct packed_git *);
+extern int verify_pack(struct packed_git *, int);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -272,12 +272,6 @@ static int pack_used_ctr;
 static unsigned long pack_mapped;
 struct packed_git *packed_git;
 
-struct pack_entry {
-	unsigned int offset;
-	unsigned char sha1[20];
-	struct packed_git *p;
-};
-
 static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 				void **idx_map_)
 {
@@ -618,22 +612,34 @@ void * unpack_sha1_file(void *map, unsig
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
+/* forward declaration for a mutually recursive function */
+static int packed_object_info(struct pack_entry *entry,
+			      char *type, unsigned long *sizep);
+
 static int packed_delta_info(unsigned char *base_sha1,
 			     unsigned long delta_size,
 			     unsigned long left,
 			     char *type,
-			     unsigned long *sizep)
+			     unsigned long *sizep,
+			     struct packed_git *p)
 {
+	struct pack_entry base_ent;
+
 	if (left < 20)
 		die("truncated pack file");
 
+	/* The base entry _must_ be in the same pack */
+	if (!find_pack_entry_one(base_sha1, &base_ent, p))
+		die("failed to find delta-pack base object %s",
+		    sha1_to_hex(base_sha1));
+
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
 	 * inflate() calls.
 	 */
 
-	if (sha1_object_info(base_sha1, type, NULL))
+	if (packed_object_info(&base_ent, type, NULL))
 		die("cannot get info for delta-pack base");
 
 	if (sizep) {
@@ -716,7 +722,7 @@ static int packed_object_info(struct pac
 
 	switch (kind) {
 	case OBJ_DELTA:
-		retval = packed_delta_info(pack, size, left, type, sizep);
+		retval = packed_delta_info(pack, size, left, type, sizep, p);
 		unuse_packed_git(p);
 		return retval;
 	case OBJ_COMMIT:
@@ -747,8 +753,10 @@ static void *unpack_delta_entry(unsigned
 				unsigned long delta_size,
 				unsigned long left,
 				char *type,
-				unsigned long *sizep)
+				unsigned long *sizep,
+				struct packed_git *p)
 {
+	struct pack_entry base_ent;
 	void *data, *delta_data, *result, *base;
 	unsigned long data_size, result_size, base_size;
 	z_stream stream;
@@ -773,8 +781,11 @@ static void *unpack_delta_entry(unsigned
 	if ((st != Z_STREAM_END) || stream.total_out != delta_size)
 		die("delta data unpack failed");
 
-	/* This may recursively unpack the base, which is what we want */
-	base = read_sha1_file(base_sha1, type, &base_size);
+	/* The base entry _must_ be in the same pack */
+	if (!find_pack_entry_one(base_sha1, &base_ent, p))
+		die("failed to find delta-pack base object %s",
+		    sha1_to_hex(base_sha1));
+	base = unpack_entry_gently(&base_ent, type, &base_size);
 	if (!base)
 		die("failed to read delta-pack base object %s",
 		    sha1_to_hex(base_sha1));
@@ -820,21 +831,33 @@ static void *unpack_entry(struct pack_en
 			  char *type, unsigned long *sizep)
 {
 	struct packed_git *p = entry->p;
-	unsigned long offset, size, left;
-	unsigned char *pack;
-	enum object_type kind;
 	void *retval;
 
 	if (use_packed_git(p))
 		die("cannot map packed file");
+	retval = unpack_entry_gently(entry, type, sizep);
+	unuse_packed_git(p);
+	if (!retval)
+		die("corrupted pack file");
+	return retval;
+}
+
+/* The caller is responsible for use_packed_git()/unuse_packed_git() pair */
+void *unpack_entry_gently(struct pack_entry *entry,
+			  char *type, unsigned long *sizep)
+{
+	struct packed_git *p = entry->p;
+	unsigned long offset, size, left;
+	unsigned char *pack;
+	enum object_type kind;
+	void *retval;
 
 	offset = unpack_object_header(p, entry->offset, &kind, &size);
 	pack = p->pack_base + offset;
 	left = p->pack_size - offset;
 	switch (kind) {
 	case OBJ_DELTA:
-		retval = unpack_delta_entry(pack, size, left, type, sizep);
-		unuse_packed_git(p);
+		retval = unpack_delta_entry(pack, size, left, type, sizep, p);
 		return retval;
 	case OBJ_COMMIT:
 		strcpy(type, "commit");
@@ -849,11 +872,10 @@ static void *unpack_entry(struct pack_en
 		strcpy(type, "tag");
 		break;
 	default:
-		die("corrupted pack file");
+		return NULL;
 	}
 	*sizep = size;
 	retval = unpack_non_delta_entry(pack, size, left);
-	unuse_packed_git(p);
 	return retval;
 }
 
@@ -873,8 +895,8 @@ int nth_packed_object_sha1(const struct 
 	return 0;
 }
 
-static int find_pack_entry_1(const unsigned char *sha1,
-			     struct pack_entry *e, struct packed_git *p)
+int find_pack_entry_one(const unsigned char *sha1,
+			struct pack_entry *e, struct packed_git *p)
 {
 	int *level1_ofs = p->index_base;
 	int hi = ntohl(level1_ofs[*sha1]);
@@ -904,7 +926,7 @@ static int find_pack_entry(const unsigne
 	prepare_packed_git();
 
 	for (p = packed_git; p; p = p->next) {
-		if (find_pack_entry_1(sha1, e, p))
+		if (find_pack_entry_one(sha1, e, p))
 			return 1;
 	}
 	return 0;
diff --git a/verify-pack.c b/verify-pack.c
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -1,25 +1,56 @@
 #include "cache.h"
 #include "pack.h"
 
-static int verify_one_pack(char *arg)
+static int verify_one_pack(char *arg, int verbose)
 {
-	struct packed_git *g = add_packed_git(arg, strlen(arg));
-	if (!g)
-		return -1;
-	return verify_pack(g);
+	int len = strlen(arg);
+	struct packed_git *g;
+	
+	while (1) {
+		/* Should name foo.idx, but foo.pack may be named;
+		 * convert it to foo.idx
+		 */
+		if (!strcmp(arg + len - 5, ".pack")) {
+			strcpy(arg + len - 5, ".idx");
+			len--;
+		}
+		/* Should name foo.idx now */
+		if ((g = add_packed_git(arg, len)))
+			break;
+		/* No?  did you name just foo? */
+		strcpy(arg + len, ".idx");
+		len += 4;
+		if ((g = add_packed_git(arg, len)))
+			break;
+		return error("packfile %s not found.", arg);
+	}
+	return verify_pack(g, verbose);
 }
 
+static const char *verify_pack_usage = "git-verify-pack [-v] <pack>...";
+
 int main(int ac, char **av)
 {
 	int errs = 0;
+	int verbose = 0;
+	int no_more_options = 0;
 
 	while (1 < ac) {
 		char path[PATH_MAX];
-		strcpy(path, av[1]);
-		if (verify_one_pack(path))
-			errs++;
-		else
-			printf("%s: OK\n", av[1]);
+
+		if (!no_more_options && av[1][0] == '-') {
+			if (!strcmp("-v", av[1]))
+				verbose = 1;
+			else if (!strcmp("--", av[1]))
+				no_more_options = 1;
+			else
+				usage(verify_pack_usage);
+		}
+		else {
+			strcpy(path, av[1]);
+			if (verify_one_pack(path, verbose))
+				errs++;
+		}
 		ac--; av++;
 	}
 	return !!errs;
------------
