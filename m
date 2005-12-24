From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Require packfiles to follow the naming convention.
Date: Sat, 24 Dec 2005 02:03:32 -0800
Message-ID: <7vfyoiu80b.fsf@assigned-by-dhcp.cox.net>
References: <7vd5jmvnkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 11:03:47 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq6Ff-0008Rf-4a
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 11:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbVLXKDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 05:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbVLXKDe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 05:03:34 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32156 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422648AbVLXKDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 05:03:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224100231.MQTW20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 05:02:31 -0500
To: git@vger.kernel.org
In-Reply-To: <7vd5jmvnkc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 24 Dec 2005 01:42:11 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14013>

Junio C Hamano <junkio@cox.net> writes:

> * require packfiles to follow the naming convention more strictly.
>
>   This rejects a packfile whose name does not begin with
>   "pack-" followed by 40-byte hexadecimal digits.  The core
>   never had such limitation (the only thing it required was
>   that the pack and the idx are named with the same basename
>   with .pack and .idx extention), but the way http-fetch
>   handles packs requires this.
> ...
>   This is probably controversial because it would eventually
>   require users to rename their packs created using pre v0.99.9
>   tools.  There is a small utility program that helps the
>   conversion process, so it may not be that painful.

And this is the patch in question.  When your packs are the ones
produced by pre v0.99.9 tools, you can ask git-convert-packs to
suggest you the "right name" to use.

$ git-convert-packs
warning: index name '.git/objects/pack/pack-a3b60db8bb6dad970f6dcdc03b0addf3988e8556.idx' does not match contents of the pack '83b60db8bb6dad970f6dcdc03b0addf3988e8556'
# Packname does not match contents.
mv '.git/objects/pack/pack-a3b60db8bb6dad970f6dcdc03b0addf3988e8556.pack' '.git/objects/pack/pack-83b60db8bb6dad970f6dcdc03b0addf3988e8556.pack'
mv '.git/objects/pack/pack-a3b60db8bb6dad970f6dcdc03b0addf3988e8556.idx' '.git/objects/pack/pack-83b60db8bb6dad970f6dcdc03b0addf3988e8556.idx'
$ git-convert-packs | sh 
warning: index name '.git/objects/pack/pack-a3b60db8bb6dad970f6dcdc03b0addf3988e8556.idx' does not match contents of the pack '83b60db8bb6dad970f6dcdc03b0addf3988e8556'
$ git-convert-packs
$ exit

Comments?

-- >8 --
Pack files names are required to be "pack-[0-9a-f]{40}.pack",
with corresponding .idx file.  This is not strictly needed at
the core level, but the packed file transfer over HTTP relies on
this format.  With this commit, the core would ignore otherwise
a valid packfile in .git/objects/packs that "git-unpack-objects"
would expand properly, if it does not follow the naming
convention.

The hexadecimal part should be what git-pack-objects computed
when the pack was created originally, and it is the SHA1 sum
over sorted object names (i.e. 20-byte binary SHA1 checksum
each).  However, this condition is checked but not enforced
currently, because git-pack-objects before v0.99.9 computed a
checksum over object names without sorting (i.e. the order
git-rev-list fed the object names), just to make pack names
unlikely to collide.  This made less than ideal use of SHA1 sum
to name packs, which we would want to rectify in the future.

Many packfiles in the wild were created with git before v0.99.9,
so the check would trigger and will give a warning message like
this:

warning: index name '.git/objects/pack/pack-3b60db8....idx' does
not match contents of the pack '83b60db...'

You can rename the existing pack that has this old name
(3b60db8...) to new name (83b60db...) to squelch this warning
message.  For that, a new command git-convert-packs is provided
to produce suitable "mv" command you can paste into your shell.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 .gitignore             |    1 +
 Makefile               |    2 +
 convert-packs.c        |   49 ++++++++++++++++++++++++++++++
 sha1_file.c            |   41 ++++++++++++++++++++++++-
 t/t5300-pack-object.sh |   79 ++++++++++++++++++++++++++----------------------
 5 files changed, 133 insertions(+), 39 deletions(-)
 create mode 100644 convert-packs.c

9c9f23b012e4030f433c7d4260a3fae93c302a0e
diff --git a/.gitignore b/.gitignore
index 6bd508e..d713f62 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,6 +18,7 @@ git-clone-pack
 git-commit
 git-commit-tree
 git-convert-objects
+git-convert-packs
 git-count-objects
 git-cvsexportcommit
 git-cvsimport
diff --git a/Makefile b/Makefile
index 3395a9e..2209f97 100644
--- a/Makefile
+++ b/Makefile
@@ -121,7 +121,7 @@ SIMPLE_PROGRAMS = \
 PROGRAMS = \
 	git-apply$X git-cat-file$X \
 	git-checkout-index$X git-clone-pack$X git-commit-tree$X \
-	git-convert-objects$X git-diff-files$X \
+	git-convert-objects$X git-convert-packs$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-init-db$X \
diff --git a/convert-packs.c b/convert-packs.c
new file mode 100644
index 0000000..13f5502
--- /dev/null
+++ b/convert-packs.c
@@ -0,0 +1,49 @@
+#include "cache.h"
+
+void verify_pack_name(struct packed_git *p)
+{
+	SHA_CTX ctx;
+	unsigned char sha1[20];
+	int i, nr, len;
+	const char *hex;
+
+	nr = num_packed_objects(p);
+
+	SHA1_Init(&ctx);
+	for (i = 0; i < nr; i++) {
+		unsigned char *ent = (((unsigned char *)p->index_base) +
+				      4*256 + i * 24 + 4);
+		SHA1_Update(&ctx, ent, 20);
+	}
+	SHA1_Final(sha1, &ctx);
+	
+	len = strlen(p->pack_name);
+	hex = sha1_to_hex(sha1);
+	/* "pack-X{40}.pack" */
+	if (len < 50 ||
+	    memcmp(p->pack_name + len - 5 - 40, hex, 40)) {
+		char *d = strrchr(p->pack_name, '/');
+		int dlen;
+		
+		if (d)
+			dlen = (d - p->pack_name) + 1;
+		else
+			dlen = 0;
+		printf("# Packname does not match contents.\n");
+		printf("mv '%s' '%.*spack-%s.pack'\n",
+		       p->pack_name, dlen, p->pack_name, hex);
+		printf("mv '%.*sidx' '%.*spack-%s.idx'\n",
+		       len-4, p->pack_name, dlen, p->pack_name, hex);
+	}
+}
+
+int main(int ac, char **av)
+{
+	struct packed_git *p;
+
+	setup_git_directory();
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		verify_pack_name(p);
+	return 0;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 6b7577d..fc24d0e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,6 +323,7 @@ static int check_packed_git_idx(const ch
 {
 	SHA_CTX ctx;
 	unsigned char sha1[20];
+	unsigned char packname[20];
 	void *idx_map;
 	unsigned int *index;
 	unsigned long idx_size;
@@ -337,6 +338,16 @@ static int check_packed_git_idx(const ch
 		close(fd);
 		return -1;
 	}
+
+	/* We require "...../pack-XXXX{40}XXXX.idx" now.
+	 * 5-byte "pack-", 40-byte hex and 4-byte .idx.
+	 */
+	i = strlen(path);
+	if (i < 49 || strcmp(path + i - 4, ".idx") ||
+	    strncmp(path + i - 49, "pack-", 5) ||
+	    get_sha1_hex(path + i - 44, packname))
+		return error("non index file %s ignored", path);
+
 	idx_size = st.st_size;
 	idx_map = mmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
@@ -369,7 +380,7 @@ static int check_packed_git_idx(const ch
 		return error("wrong index file size");
 
 	/*
-	 * File checksum.
+	 * File checksum and index name.
 	 */
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, idx_map, idx_size-20);
@@ -378,6 +389,34 @@ static int check_packed_git_idx(const ch
 	if (memcmp(sha1, idx_map + idx_size - 20, 20))
 		return error("index checksum mismatch");
 
+/*
+ * 0: do not check, do not do anything.
+ * 1: check and warn, but do not reject.
+ * 2: check and reject if pack name is obsolete.
+ */
+#define PACK_NAME_ENFORCEMENT_PHASE 1
+
+#if PACK_NAME_ENFORCEMENT_PHASE != 0
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
index 7dfb1ab..dba8227 100755
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
@@ -131,41 +136,41 @@ unset GIT_OBJECT_DIRECTORY
 
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
 
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
-     if git-verify-pack test-3.idx
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.pack count=1 bs=1 conv=notrunc seek=2 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
-     if git-verify-pack test-3.idx
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.pack count=1 bs=1 conv=notrunc seek=7 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
-     if git-verify-pack test-3.idx
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.pack count=1 bs=1 conv=notrunc seek=12 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
 
-     cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.idx count=1 bs=1 conv=notrunc seek=1200 &&
-     if git-verify-pack test-3.pack
+     cp test-1/pack-${packname_1}.pack . &&
+     dd if=/dev/zero of=pack-${packname_1}.idx count=1 bs=1 conv=notrunc seek=1200 &&
+     if git-verify-pack pack-${packname_1}.idx
      then false
      else :;
      fi &&
@@ -174,19 +179,19 @@ test_expect_success \
 
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
1.0.GIT
