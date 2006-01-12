From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Require packfiles to follow the naming convention (preparation).
Date: Wed, 11 Jan 2006 16:05:19 -0800
Message-ID: <7virsqjoow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpy9-0002Bo-62
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWALAFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWALAFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:25 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38814 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964810AbWALAFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000330.JVUO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:03:30 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14532>



Names of the packfiles will be required to be of the form
"pack-[0-9a-f]{40}.pack".  This commit prepares a switch that I
can toggle to enforce the naming convention, but the switch is
currently toggled off.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Currently in "pu".

 Documentation/git-convert-packs.txt |    2 -
 Documentation/git.txt               |    3 +
 sha1_file.c                         |   51 ++++++++++++++++++++++
 t/t5300-pack-object.sh              |   81 +++++++++++++++++++----------------
 4 files changed, 97 insertions(+), 40 deletions(-)

a8fe7257b8427d31cfcca0aa336335bb43689fc9
diff --git a/Documentation/git-convert-packs.txt b/Documentation/git-convert-packs.txt
index ba02641..ac82033 100644
--- a/Documentation/git-convert-packs.txt
+++ b/Documentation/git-convert-packs.txt
@@ -3,7 +3,7 @@ git-convert-packs(1)
 
 NAME
 ----
-git-convert-packs - Renames packfiles created with pre 0.99.9 GIT
+git-convert-packs - Renames packfiles created with pre 0.99.9 GIT.
 
 
 SYNOPSIS
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 92cfe0e..4ab07a4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -350,6 +350,9 @@ gitlink:git-archimport[1]::
 gitlink:git-convert-objects[1]::
 	Converts old-style git repository.
 
+gitlink:git-convert-packs[1]::
+	Renames packfiles created with pre 0.99.9 GIT.
+
 gitlink:git-cvsimport[1]::
 	Salvage your data out of another SCM people love to hate.
 
diff --git a/sha1_file.c b/sha1_file.c
index 8bebbb2..22d56fc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -346,6 +346,15 @@ static int pack_used_ctr;
 static unsigned long pack_mapped;
 struct packed_git *packed_git;
 
+/*
+ * 0: do not check, do not do anything.
+ * 1: check and warn, but do not reject.
+ * 2: check and reject if pack name is obsolete.
+ */
+#ifndef PACK_NAME_ENFORCEMENT_PHASE
+#define PACK_NAME_ENFORCEMENT_PHASE 0
+#endif
+
 static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 				void **idx_map_)
 {
@@ -357,6 +366,9 @@ static int check_packed_git_idx(const ch
 	int nr, i;
 	int fd;
 	struct stat st;
+#if PACK_NAME_ENFORCEMENT_PHASE
+	unsigned char packname[20];
+#endif
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
@@ -365,6 +377,22 @@ static int check_packed_git_idx(const ch
 		close(fd);
 		return -1;
 	}
+
+#if PACK_NAME_ENFORCEMENT_PHASE
+	/* We require "...../pack-XXXX{40}XXXX.idx" now.
+	 * 5-byte "pack-", 40-byte hex and 4-byte .idx.
+	 */
+	i = strlen(path);
+	if (i < 49 || strcmp(path + i - 4, ".idx") ||
+	    strncmp(path + i - 49, "pack-", 5) ||
+	    get_sha1_hex(path + i - 44, packname))
+#if PACK_NAME_ENFORCEMENT_PHASE == 1
+		fprintf(stderr, "warning: index file name '%s' does not "
+			"match pack-X{40}.idx convention.\n", path);
+#else
+		return error("non index file '%s' ignored", path);
+#endif
+#endif
 	idx_size = st.st_size;
 	idx_map = mmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
@@ -397,7 +425,7 @@ static int check_packed_git_idx(const ch
 		return error("wrong index file size");
 
 	/*
-	 * File checksum.
+	 * File checksum and index name.
 	 */
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, idx_map, idx_size-20);
@@ -406,6 +434,27 @@ static int check_packed_git_idx(const ch
 	if (memcmp(sha1, idx_map + idx_size - 20, 20))
 		return error("index checksum mismatch");
 
+#if PACK_NAME_ENFORCEMENT_PHASE
+	SHA1_Init(&ctx);
+	for (i = 0; i < nr; i++) {
+		unsigned char *ent = (idx_map + 4*256) + i * 24 + 4;
+		SHA1_Update(&ctx, ent, 20);
+	}
+	SHA1_Final(sha1, &ctx);
+	
+	if (memcmp(sha1, packname, 20)) {
+#if PACK_NAME_ENFORCEMENT_PHASE == 1
+		fprintf(stderr, "warning: index name '%s' does not match "
+			"contents of the pack '%s'\n",
+			path, sha1_to_hex(sha1));
+#else
+		return error("index name '%s' does not match "
+			     "contents of the pack '%s'\n",
+			     path, sha1_to_hex(sha1));
+#endif
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index de45ac4..77fd8d7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -10,6 +10,8 @@ test_description='git-pack-object
 
 TRASH=`pwd`
 
+mkdir test-1 test-2
+
 test_expect_success \
     'setup' \
     'rm -f .git/index*
@@ -35,7 +37,7 @@ test_expect_success \
 
 test_expect_success \
     'pack without delta' \
-    'packname_1=$(git-pack-objects --window=0 test-1 <obj-list)'
+    'packname_1=$(git-pack-objects --window=0 test-1/pack <obj-list)'
 
 rm -fr .git2
 mkdir .git2
@@ -45,8 +47,8 @@ test_expect_success \
     "GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     git-unpack-objects -n <test-1-${packname_1}.pack &&
-     git-unpack-objects <test-1-${packname_1}.pack"
+     git-unpack-objects -n <test-1/pack-${packname_1}.pack &&
+     git-unpack-objects <test-1/pack-${packname_1}.pack"
 
 unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
@@ -66,7 +68,8 @@ cd "$TRASH"
 test_expect_success \
     'pack with delta' \
     'pwd &&
-     packname_2=$(git-pack-objects test-2 <obj-list)'
+     packname_2=$(git-pack-objects test-2/pack <obj-list) &&
+     test "$packname_2" = "$packname_1"'
 
 rm -fr .git2
 mkdir .git2
@@ -76,8 +79,8 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     git-unpack-objects -n <test-2-${packname_2}.pack &&
-     git-unpack-objects <test-2-${packname_2}.pack'
+     git-unpack-objects -n <test-2/pack-${packname_2}.pack &&
+     git-unpack-objects <test-2/pack-${packname_2}.pack'
 
 unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
@@ -101,7 +104,8 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
+     cp test-1/pack-${packname_1}.pack test-1/pack-${packname_1}.idx \
+     	.git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
 	 do
@@ -116,8 +120,9 @@ test_expect_success \
     'use packed deltified objects' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     rm -f .git2/objects/pack/test-?.idx &&
-     cp test-2-${packname_2}.pack test-2-${packname_2}.idx .git2/objects/pack && {
+     rm -f .git2/objects/pack/pack-* &&
+     cp test-2/pack-${packname_2}.pack test-2/pack-${packname_2}.idx \
+     	.git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
 	 do
@@ -131,47 +136,47 @@ unset GIT_OBJECT_DIRECTORY
 
 test_expect_success \
     'verify pack' \
-    'git-verify-pack test-1-${packname_1}.idx test-2-${packname_2}.idx'
+    'git-verify-pack test-?/pack-${packname_1}.idx'
 
 test_expect_success \
     'corrupt a pack and see if verify catches' \
-    'cp test-1-${packname_1}.idx test-3.idx &&
-     cp test-2-${packname_2}.pack test-3.pack &&
-     if git-verify-pack test-3.idx
+    'cp test-1/pack-${packname_1}.idx . &&
+     cp test-2/pack-${packname_2}.pack . &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
      : PACK_SIGNATURE &&
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
-     if git-verify-pack test-3.idx
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.pack count=1 bs=1 conv=notrunc seek=2 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
      : PACK_VERSION &&
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
-     if git-verify-pack test-3.idx
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.pack count=1 bs=1 conv=notrunc seek=7 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
      : TYPE/SIZE byte of the first packed object data &&
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
-     if git-verify-pack test-3.idx
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.pack count=1 bs=1 conv=notrunc seek=12 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
      : sum of the index file itself &&
-     l=`wc -c <test-3.idx` &&
+     l=`wc -c <pack-${packname_1}.idx` &&
      l=`expr $l - 20` &&
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
-     if git-verify-pack test-3.pack
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.idx count=20 bs=1 conv=notrunc seek=$l &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
@@ -180,19 +185,19 @@ test_expect_success \
 
 test_expect_success \
     'build pack index for an existing pack' \
-    'cp test-1-${packname_1}.pack test-3.pack &&
-     git-index-pack -o tmp.idx test-3.pack &&
-     cmp tmp.idx test-1-${packname_1}.idx &&
-
-     git-index-pack test-3.pack &&
-     cmp test-3.idx test-1-${packname_1}.idx &&
-
-     cp test-2-${packname_2}.pack test-3.pack &&
-     git-index-pack -o tmp.idx test-2-${packname_2}.pack &&
-     cmp tmp.idx test-2-${packname_2}.idx &&
+    'cp test-1/pack-${packname_1}.pack unknown.pack &&
+     git-index-pack -o tmp.idx unknown.pack &&
+     cmp tmp.idx test-1/pack-${packname_1}.idx &&
+
+     git-index-pack unknown.pack &&
+     cmp unknown.idx test-1/pack-${packname_1}.idx &&
+
+     cp test-2/pack-${packname_2}.pack unknown.pack &&
+     git-index-pack -o tmp.idx unknown.pack &&
+     cmp tmp.idx test-2/pack-${packname_2}.idx &&
 
-     git-index-pack test-3.pack &&
-     cmp test-3.idx test-2-${packname_2}.idx &&
+     git-index-pack unknown.pack &&
+     cmp unknown.idx test-2/pack-${packname_2}.idx &&
 
      :'
 
-- 
1.1.1-g8ecb
