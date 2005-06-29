From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-verify-pack command.
Date: Wed, 29 Jun 2005 02:51:27 -0700
Message-ID: <7vvf3xcwyo.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506282314320.1667@localhost.localdomain>
	<Pine.LNX.4.63.0506290111250.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506282243180.19755@ppc970.osdl.org>
	<Pine.LNX.4.58.0506282252001.14331@ppc970.osdl.org>
	<7v4qbhfxad.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 11:47:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnZ9U-0002ME-0Y
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 11:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVF2Jxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 05:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVF2Jxr
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 05:53:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62925 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262288AbVF2Jv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 05:51:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629095128.FAPO550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 05:51:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4qbhfxad.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 29 Jun 2005 00:16:10 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Given a list of <pack>.idx files, this command validates the
index file and the corresponding .pack file for consistency.

This patch also uses the same validation mechanism in fsck-cache
when the --full flag is used.

During normal operation, sha1_file.c verifies that a given .idx
file matches the .pack file by comparing the SHA1 checksum
stored in .idx file and .pack file as a minimum sanity check.
We may further want to check the pack signature and version when
we map the pack, but that would be a separate patch.

Earlier, errors to map a pack file was not flagged fatal but led
to a random fatal error later.  This version explicitly die()s
when such an error is detected.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This actually covers two of the items I listed in the "Last
*** mile again" message.  I ended up doing the LRU myself.

*** Linus, what would be the practical/recommended/sane limit
*** for mmap regions we would want to use?  Currently I start
*** throwing away mapped packs when the total size of mapped
*** packs exceeds 64MB.

*** Currently, pack-objects/unpack-objects pair is not
*** documented.  Any takers?

*** Oh, again, Linus, what is your preferred way to get a
*** cover-letter material (like this) for a single patch?  I
*** always do a separate cover letter for multi-patch series
*** with [PATCH 0/N], but do you prefer to get [PATCH 0/1] and
*** [PATCH 1/1] for a single patch, or do you prefer to see
*** commentaries after the three-dash line like this message
*** does?

 Documentation/git-verify-pack.txt |   38 +++++++++++++++++++++
 Documentation/git.txt             |    3 ++
 Makefile                          |    5 ++-
 cache.h                           |    4 ++
 fsck-cache.c                      |    5 +++
 pack.h                            |    2 +
 sha1_file.c                       |   66 ++++++++++++++++++++++++++++---------
 t/t5300-pack-object.sh            |   38 +++++++++++++++++++++
 verify-pack.c                     |   26 +++++++++++++++
 verify_pack.c                     |   62 +++++++++++++++++++++++++++++++++++
 10 files changed, 231 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/git-verify-pack.txt
 create mode 100644 verify-pack.c
 create mode 100644 verify_pack.c

8ac4f374a587c58b3d2ecc44220b6b866f769350
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-verify-pack.txt
@@ -0,0 +1,38 @@
+git-verify-pack(1)
+==================
+v0.1, June 2005
+
+NAME
+----
+git-verify-pack - Validate packed GIT archive files.
+
+
+SYNOPSIS
+--------
+'git-verify-pack' <pack>.idx ...
+
+
+DESCRIPTION
+-----------
+Reads given idx file for packed GIT archive created with
+git-pack-objects command and verifies idx file and the
+corresponding pack file.
+
+OPTIONS
+-------
+<pack>.idx ...::
+	The idx files to verify.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by Junio C Hamano
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -110,6 +110,9 @@ link:git-tar-tree.html[git-tar-tree]::
 link:git-unpack-file.html[git-unpack-file]::
 	Creates a temporary file with a blob's contents
 
+link:git-verify-pack.html[git-verify-pack]::
+	Validates packed GIT archive files
+
 The interrogate commands may create files - and you can force them to
 touch the working file set - but in general they don't
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ PROG=   git-update-cache git-diff-files 
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
 	git-get-tar-commit-id git-apply git-stripspace \
 	git-cvs2git git-diff-stages git-rev-parse git-patch-id \
-	git-pack-objects git-unpack-objects
+	git-pack-objects git-unpack-objects git-verify-pack
 
 all: $(PROG)
 
@@ -45,7 +45,7 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o csum-file.o
+	 epoch.o refs.o csum-file.o verify_pack.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h pack.h
 
@@ -124,6 +124,7 @@ git-rev-parse: rev-parse.c
 git-patch-id: patch-id.c
 git-pack-objects: pack-objects.c
 git-unpack-objects: unpack-objects.c
+git-verify-pack: verify-pack.c
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -246,9 +246,13 @@ extern struct packed_git {
 	unsigned int *index_base;
 	void *pack_base;
 	unsigned int pack_last_used;
+	unsigned int pack_use_cnt;
 	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
 } *packed_git;
 extern void prepare_packed_git(void);
+extern int use_packed_git(struct packed_git *);
+extern void unuse_packed_git(struct packed_git *);
+extern struct packed_git *add_packed_git(char *, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 
diff --git a/fsck-cache.c b/fsck-cache.c
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -6,6 +6,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "tag.h"
+#include "pack.h"
 
 #define REACHABLE 0x0001
 
@@ -437,6 +438,10 @@ int main(int argc, char **argv)
 			alt_odb[j].name[-1] = '/';
 		}
 		prepare_packed_git();
+		for (p = packed_git; p; p = p->next)
+			/* verify gives error messages itself */
+			verify_pack(p); 
+
 		for (p = packed_git; p; p = p->next) {
 			int num = num_packed_objects(p);
 			for (i = 0; i < num; i++) {
diff --git a/pack.h b/pack.h
--- a/pack.h
+++ b/pack.h
@@ -27,4 +27,6 @@ struct pack_header {
 	unsigned int hdr_entries;
 };
 
+extern int verify_pack(struct packed_git *);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -302,7 +302,7 @@ static int check_packed_git_idx(const ch
 	index = idx_map;
 
 	/* check index map */
-	if (idx_size < 4*256 + 20)
+	if (idx_size < 4*256 + 20 + 20)
 		return error("index file too small");
 	nr = 0;
 	for (i = 0; i < 256; i++) {
@@ -327,12 +327,29 @@ static int check_packed_git_idx(const ch
 	return 0;
 }
 
-static void unuse_one_packed_git(void)
+static int unuse_one_packed_git(void)
 {
-	/* NOTYET */
+	struct packed_git *p, *lru = NULL;
+
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_use_cnt || !p->pack_base)
+			continue;
+		if (!lru || p->pack_last_used < lru->pack_last_used)
+			lru = p;
+	}
+	if (!lru)
+		return 0;
+	munmap(lru->pack_base, lru->pack_size);
+	lru->pack_base = NULL;
+	return 1;
+}
+
+void unuse_packed_git(struct packed_git *p)
+{
+	p->pack_use_cnt--;
 }
 
-static int use_packed_git(struct packed_git *p)
+int use_packed_git(struct packed_git *p)
 {
 	if (!p->pack_base) {
 		int fd;
@@ -340,28 +357,36 @@ static int use_packed_git(struct packed_
 		void *map;
 
 		pack_mapped += p->pack_size;
-		while (PACK_MAX_SZ < pack_mapped)
-			unuse_one_packed_git();
+		while (PACK_MAX_SZ < pack_mapped && unuse_one_packed_git())
+			; /* nothing */
 		fd = open(p->pack_name, O_RDONLY);
 		if (fd < 0)
-			return -1;
+			die("packfile %s cannot be opened", p->pack_name);
 		if (fstat(fd, &st)) {
 			close(fd);
-			return -1;
+			die("packfile %s cannot be opened", p->pack_name);
 		}
 		if (st.st_size != p->pack_size)
-			return -1;
+			die("packfile %s size mismatch.", p->pack_name);
 		map = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		if (map == MAP_FAILED)
-			return -1;
+			die("packfile %s cannot be mapped.", p->pack_name);
 		p->pack_base = map;
+
+		/* Check if the pack file matches with the index file.
+		 * this is cheap.
+		 */
+		if (memcmp((char*)(p->index_base) + p->index_size - 40,
+			   p->pack_base + p->pack_size - 20, 20))
+			die("packfile %s does not match index.", p->pack_name);
 	}
 	p->pack_last_used = pack_used_ctr++;
+	p->pack_use_cnt++;
 	return 0;
 }
 
-static struct packed_git *add_packed_git(char *path, int path_len)
+struct packed_git *add_packed_git(char *path, int path_len)
 {
 	struct stat st;
 	struct packed_git *p;
@@ -388,6 +413,7 @@ static struct packed_git *add_packed_git
 	p->next = NULL;
 	p->pack_base = NULL;
 	p->pack_last_used = 0;
+	p->pack_use_cnt = 0;
 	return p;
 }
 
@@ -671,6 +697,7 @@ static int packed_object_info(struct pac
 	unsigned long offset, size, left;
 	unsigned char *pack;
 	enum object_type kind;
+	int retval;
 
 	if (use_packed_git(p))
 		die("cannot map packed file");
@@ -681,8 +708,9 @@ static int packed_object_info(struct pac
 
 	switch (kind) {
 	case OBJ_DELTA:
-		return packed_delta_info(pack, size, left, type, sizep);
-		break;
+		retval = packed_delta_info(pack, size, left, type, sizep);
+		unuse_packed_git(p);
+		return retval;
 	case OBJ_COMMIT:
 		strcpy(type, "commit");
 		break;
@@ -699,6 +727,7 @@ static int packed_object_info(struct pac
 		die("corrupted pack file");
 	}
 	*sizep = size;
+	unuse_packed_git(p);
 	return 0;
 }
 
@@ -785,6 +814,7 @@ static void *unpack_entry(struct pack_en
 	unsigned long offset, size, left;
 	unsigned char *pack;
 	enum object_type kind;
+	void *retval;
 
 	if (use_packed_git(p))
 		die("cannot map packed file");
@@ -794,7 +824,9 @@ static void *unpack_entry(struct pack_en
 	left = p->pack_size - offset;
 	switch (kind) {
 	case OBJ_DELTA:
-		return unpack_delta_entry(pack, size, left, type, sizep);
+		retval = unpack_delta_entry(pack, size, left, type, sizep);
+		unuse_packed_git(p);
+		return retval;
 	case OBJ_COMMIT:
 		strcpy(type, "commit");
 		break;
@@ -811,12 +843,14 @@ static void *unpack_entry(struct pack_en
 		die("corrupted pack file");
 	}
 	*sizep = size;
-	return unpack_non_delta_entry(pack, size, left);
+	retval = unpack_non_delta_entry(pack, size, left);
+	unuse_packed_git(p);
+	return retval;
 }
 
 int num_packed_objects(const struct packed_git *p)
 {
-	/* See check_packed_git_idx and pack-objects.c */
+	/* See check_packed_git_idx() */
 	return (p->index_size - 20 - 20 - 4*256) / 24;
 }
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -127,4 +127,42 @@ test_expect_success \
     } >current &&
     diff expect current'
 
+unset GIT_OBJECT_DIRECTORY
+
+test_expect_success \
+    'verify pack' \
+    'git-verify-pack test-1.idx test-2.idx'
+
+test_expect_success \
+    'corrupt a pack and see if verify catches' \
+    'cp test-1.idx test-3.idx &&
+     cp test-2.pack test-3.pack &&
+     if git-verify-pack test-3.idx
+     then false
+     else :;
+     fi &&
+
+     cp test-1.pack test-3.pack &&
+     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
+     if git-verify-pack test-3.idx
+     then false
+     else :;
+     fi &&
+
+     cp test-1.pack test-3.pack &&
+     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
+     if git-verify-pack test-3.idx
+     then false
+     else :;
+     fi &&
+
+     cp test-1.pack test-3.pack &&
+     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
+     if git-verify-pack test-3.idx
+     then false
+     else :;
+     fi &&
+
+     :'
+
 test_done
diff --git a/verify-pack.c b/verify-pack.c
new file mode 100644
--- /dev/null
+++ b/verify-pack.c
@@ -0,0 +1,26 @@
+#include "cache.h"
+#include "pack.h"
+
+static int verify_one_pack(char *arg)
+{
+	struct packed_git *g = add_packed_git(arg, strlen(arg));
+	if (!g)
+		return -1;
+	return verify_pack(g);
+}
+
+int main(int ac, char **av)
+{
+	int errs = 0;
+
+	while (1 < ac) {
+		char path[PATH_MAX];
+		strcpy(path, av[1]);
+		if (verify_one_pack(path))
+			errs++;
+		else
+			printf("%s: OK\n", av[1]);
+		ac--; av++;
+	}
+	return !!errs;
+}
diff --git a/verify_pack.c b/verify_pack.c
new file mode 100644
--- /dev/null
+++ b/verify_pack.c
@@ -0,0 +1,62 @@
+#include "cache.h"
+#include "pack.h"
+
+static int verify_packfile(struct packed_git *p)
+{
+	unsigned long index_size = p->index_size;
+	void *index_base = p->index_base;
+	SHA_CTX ctx;
+	unsigned char sha1[20];
+	unsigned long pack_size = p->pack_size;
+	void *pack_base;
+	struct pack_header *hdr;
+	int nr_objects;
+
+	hdr = p->pack_base;
+	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
+		return error("Packfile signature mismatch", p->pack_name);
+	if (hdr->hdr_version != htonl(PACK_VERSION))
+		return error("Packfile version %d different from ours %d",
+			     ntohl(hdr->hdr_version), PACK_VERSION);
+	nr_objects = ntohl(hdr->hdr_entries);
+	if (num_packed_objects(p) != nr_objects)
+		return error("Packfile claims to have %d objects, "
+			     "while idx size expects %d", nr_objects,
+			     num_packed_objects(p));
+
+	SHA1_Init(&ctx);
+	pack_base = p->pack_base;
+	SHA1_Update(&ctx, pack_base, pack_size - 20);
+	SHA1_Final(sha1, &ctx);
+	if (memcmp(sha1, index_base + index_size - 40, 20))
+		return error("Packfile %s SHA1 mismatch with idx",
+			     p->pack_name);
+	if (memcmp(sha1, pack_base + pack_size - 20, 20))
+		return error("Packfile %s SHA1 mismatch with itself",
+			     p->pack_name);
+	return 0;
+}
+
+
+int verify_pack(struct packed_git *p)
+{
+	unsigned long index_size = p->index_size;
+	void *index_base = p->index_base;
+	SHA_CTX ctx;
+	unsigned char sha1[20];
+	int ret;
+
+	/* Verify SHA1 sum of the index file */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, index_base, index_size - 20);
+	SHA1_Final(sha1, &ctx);
+	if (memcmp(sha1, index_base + index_size - 20, 20))
+		return error("Packfile index for %s SHA1 mismatch",
+			     p->pack_name);
+
+	/* Verify pack file */
+	use_packed_git(p);
+	ret = verify_packfile(p);
+	unuse_packed_git(p);
+	return ret;
+}
------------
