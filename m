From: =?ISO-8859-1?Q?Robert_S=FCtterlin?= <robert@mpe.mpg.de>
Subject: [PATCH]: first take at cleanup of #include, xmalloc / xrealloc, git status report usage.
Date: Fri, 29 Apr 2005 15:19:06 +0200
Message-ID: <bfbb1f23220e1918afe70d4cf3de24f5@mpe.mpg.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Apr 29 15:48:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRVlI-0001TW-T4
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 15:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVD2N34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 09:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVD2N3p
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 09:29:45 -0400
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:22020 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id S262583AbVD2NTj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 09:19:39 -0400
Received: from [130.183.136.84] (robert3.mpe-garching.mpg.de [130.183.136.84])
	by mpehp1.mpe-garching.mpg.de (8.9.3 (PHNE_25183+JAGae58098)/8.9.3) with ESMTP id PAA15754
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 15:19:37 +0200 (METDST)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.622)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a rather large monolithic or rather dualithic patch that tries 
to clean up #include usage in cache.h.

IMHO including headers that include headers that include headers ... 
are we there, yet? is a BAD(tm) thing.  So I removed every #include 
from cache.h that was not necessary to define the contents of cache.h 
itself.  Then I entered only the required headers to each sourcefile.  
This will help in identifying which subsystems don't use the libgit 
infrastructure, or which functionality needs to be added to libgit.

Also I added two report functions to usage (warning and message), 
trtied to remove xmalloc and xrealloc whereever simply dying was IMHO 
wrong, added more diagnostic output and return value chacking to some 
files.

This is the beginning of a cleanup of git code.  I feel that (except 
maybe for diff / merge) git has stabilised enough to start the 
refactoring / renaming / api cleanup stuff.

I also strongly believe that we should design a new internal memory 
buffer.  The usage of malloc / realloc in git is not good at all.  
Everybody and her dog seems to know how to best handle malloc, so there 
is a lot of code repetition and bad (i.e. no) api all over the place.  
A new internal buffer concept would of course mean, that all of the 
algorithms must be rewritten, but as Linus always says: "that is just 
coding."  Some not-so-core components already use strbuf --- which I do 
not like that much really --- still I'd call this a beginning.

Feel free to neglect any of my changes.

signed-off-by: Robert Suetterlin <robert@mpe.mpg.de>

intermediate commit before cg-update continuing work to clean up 
#include, malloc / realloc and diagnostics messages.

---
commit f03e0239ea6ae31d8f89a4a7965ed90832770c5b
tree 86241f0cd550785e3cba0a235f7e423d0503be93
parent 49612c471eebd26efe926a71752e254c1cdc382d
author Robert Suetterlin <krs@robert3.mpe-garching.mpg.de> 1114763833 
+0200
committer Robert Suetterlin <krs@robert3.mpe-garching.mpg.de> 
1114763833 +0200

Index: Makefile
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/Makefile  (mode:100644 
sha1:d73bea1cbb9451a89b03d6066bf2ed7fec32fd31)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/Makefile  (mode:100644 
sha1:3c461e439a8731b688533dccbc5dafa1471a5b3b)
@@ -73,7 +73,7 @@
  	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
  else
  	SHA1_HEADER=<openssl/sha.h>
-	LIBS += -lssl
+	LIBS += -lcrypto
  endif
  endif

Index: blob.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/blob.c  (mode:100644 
sha1:3d99b93f020d84c5410c2b1056f2d7446b647d1e)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/blob.c  (mode:100644 
sha1:037e7ebcf786efee5741398afa2144d6d168e9f3)
@@ -1,20 +1,27 @@
-#include "blob.h"
-#include "cache.h"
  #include <stdlib.h>
+#include <string.h>
+
+#include "cache.h"
+
+#include "blob.h"

  const char *blob_type = "blob";

  struct blob *lookup_blob(unsigned char *sha1)
  {
  	struct object *obj = lookup_object(sha1);
-	if (!obj) {
-		struct blob *ret = xmalloc(sizeof(struct blob));
+	if (NULL == obj) {
+		struct blob *ret = malloc(sizeof(struct blob));
+		if (NULL == ret) {
+			error("Could not malloc(sizeof(struct blob))");
+			return NULL;
+		}
  		memset(ret, 0, sizeof(struct blob));
  		created_object(sha1, &ret->object);
  		ret->object.type = blob_type;
  		return ret;
  	}
-	if (obj->parsed && obj->type != blob_type) {
+	if (obj->type != blob_type) {
  		error("Object %s is a %s, not a blob",
  		      sha1_to_hex(sha1), obj->type);
  		return NULL;
Index: cache.h
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cache.h  (mode:100644 
sha1:1052e17da7093024d34be3c939ab768e20cfa2a3)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/cache.h  (mode:100644 
sha1:036d6b6897ef119b4de051d957b5886680bfffe3)
@@ -1,19 +1,21 @@
  #ifndef CACHE_H
  #define CACHE_H

-#include <unistd.h>
-#include <stdio.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/param.h>
  #include <sys/stat.h>
+
+#include <netinet/in.h>
+
+//#include <errno.h>
  #include <fcntl.h>
+#include <stdarg.h>
  #include <stddef.h>
  #include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
+//#include <stdio.h>
+//#include <string.h>
  #include <unistd.h>
-#include <errno.h>
-#include <sys/mman.h>
-#include <sys/param.h>
-#include <netinet/in.h>

  #include SHA1_HEADER
  #include <zlib.h>
@@ -25,6 +27,7 @@
  /*
   * Basic data structures for the directory cache
   *
+ * FIX this:  The Note below is outdated.
   * NOTE NOTE NOTE! This is all in the native CPU byte format. It's
   * not even trying to be portable. It's trying to be efficient. It's
   * just a cache, after all.
@@ -145,6 +148,8 @@
  extern void usage(const char *err);
  extern void die(const char *err, ...);
  extern int error(const char *err, ...);
+extern void warning(const char *err, ...);
+extern void message(const char *msg, ...);

  extern int cache_name_compare(const char *name1, int len1, const char 
*name2, int len2);

Index: cat-file.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cat-file.c  (mode:100644 
sha1:3c47d79a16305d326a65768fe9f37ee25928510b)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/cat-file.c  (mode:100644 
sha1:568cfbc266416f8afa88995a90a3d17132e8db8b)
@@ -3,6 +3,9 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <errno.h>
+#include <string.h>
+
  #include "cache.h"

  int main(int argc, char **argv)
Index: check-files.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/check-files.c  
(mode:100644 sha1:7d16691aa9d51b5b4670d5837b3527ee7c7da79c)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/check-files.c  
(mode:100644 sha1:438fa7fc084b94a5fe6dd0a4200b69d1ef147b75)
@@ -6,6 +6,9 @@
   *
   * Copyright (C) 2005 Linus Torvalds
   */
+#include <errno.h>
+#include <string.h>
+
  #include "cache.h"

  static void check_file(const char *path)
Index: checkout-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/checkout-cache.c  
(mode:100644 sha1:b5ca20e8d0e25a688bcca3f0be39e9493dc947ce)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/checkout-cache.c  
(mode:100644 sha1:c6576f35685a0a83627af2fa5edba742a103c2ad)
@@ -32,34 +32,42 @@
   * of "-a" causing problems (not possible in the above example,
   * but get used to it in scripting!).
   */
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <errno.h>
+#include <string.h>
+
  #include "cache.h"

  static int force = 0, quiet = 0, not_new = 0;

-static void create_directories(const char *path)
+static int
+create_directories(const char *path)
  {
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
+	char *buf = (char *)path;
+	char *slash = buf;

  	while ((slash = strchr(slash+1, '/')) != NULL) {
-		len = slash - path;
-		memcpy(buf, path, len);
-		buf[len] = 0;
-		mkdir(buf, 0755);
+		*slash = '\0';
+		if (0 != mkdir(buf, 0755))
+			return error("Unable to mkdir(``%s'', 0755)", buf);
+		*slash = '/';
  	}
-	free(buf);
+
+	return 0;
  }

-static int create_file(const char *path, unsigned int mode)
+static int
+create_file(const char *path, unsigned int mode)
  {
  	int fd;

  	mode = (mode & 0100) ? 0777 : 0666;
  	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
  	if (fd < 0) {
-		if (errno == ENOENT) {
-			create_directories(path);
+		if (ENOENT == errno) {
+			if (0 != create_directories(path)) return -1;
  			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
  		}
  	}
@@ -110,7 +118,7 @@
  			return 0;
  		if (!force) {
  			if (!quiet)
-				fprintf(stderr, "checkout-cache: %s already exists\n", path);
+				message("checkout-cache: %s already exists\n", path);
  			return 0;
  		}

@@ -132,8 +140,7 @@
  	if (pos < 0) {
  		if (!quiet) {
  			pos = -pos - 1;
-			fprintf(stderr,
-				"checkout-cache: %s is %s.\n",
+			message("checkout-cache: %s is %s.\n",
  				name,
  				(pos < active_nr &&
  				 !strcmp(active_cache[pos]->name, name)) ?
Index: commit-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/commit-tree.c  
(mode:100644 sha1:23de13361944ad7ba7c5320cf7cdd04e81842c60)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/commit-tree.c  
(mode:100644 sha1:e396ca80f6a87c09130b19fc5452605ac7d83861)
@@ -3,13 +3,13 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
-#include "cache.h"
-
+#include <ctype.h>
  #include <pwd.h>
  #include <time.h>
+#include <stdio.h>
  #include <string.h>
-#include <ctype.h>
-#include <time.h>
+
+#include "cache.h"

  #define BLOCKING (1ul << 14)

Index: convert-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/convert-cache.c  
(mode:100644 sha1:631d1aa910e7328c99642495f93908c749074f91)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/convert-cache.c  
(mode:100644 sha1:e50248857b1b707a771a42fe4ce7f7dcc5fdc79f)
@@ -1,6 +1,9 @@
  #define _XOPEN_SOURCE /* glibc2 needs this */
-#include <time.h>
  #include <ctype.h>
+#include <time.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  struct entry {
Index: diff-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/diff-cache.c  (mode:100644 
sha1:49f815cf732a32c87d965f22b00850643e7aab77)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/diff-cache.c  (mode:100644 
sha1:1177977fba4d3d2fcd3cd6ec72451abb84d414a1)
@@ -1,3 +1,6 @@
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
  #include "diff.h"

Index: diff-tree-helper.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/diff-tree-helper.c  
(mode:100644 sha1:f3efc8a6f2d21c33bd6096dae3150df61800b015)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/diff-tree-helper.c  
(mode:100644 sha1:4071871b6d3416d02d6203c47950d482d79c78f4)
@@ -1,6 +1,9 @@
  /*
   * Copyright (C) 2005 Junio C Hamano
   */
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
  #include "strbuf.h"
  #include "diff.h"
Index: diff-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/diff-tree.c  (mode:100644 
sha1:5a1ad34652fcda63a37c3aeb55c0231f1be69bdd)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/diff-tree.c  (mode:100644 
sha1:ac026816c32cb44d43025236409655f97197aff2)
@@ -1,3 +1,6 @@
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
  #include "diff.h"

Index: diff.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/diff.c  (mode:100644 
sha1:4cc41f097dfe1ade230d2d6e438b0249dfbc1a76)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/diff.c  (mode:100644 
sha1:0326f0488d2c037f238f9012d8a007473b13b968)
@@ -3,6 +3,11 @@
   */
  #include <sys/types.h>
  #include <sys/wait.h>
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
  #include "diff.h"

Index: fsck-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/fsck-cache.c  (mode:100644 
sha1:f9b1431dd8f4f3b426a7e410de952277aaa11401)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/fsck-cache.c  (mode:100644 
sha1:265319c97cc68313e3e62d304c38d074dc22abdb)
@@ -1,11 +1,13 @@
-#include "cache.h"
-
  #include <sys/types.h>
+
  #include <dirent.h>
+#include <stdio.h>
+#include <string.h>

  #include "commit.h"
  #include "tree.h"
  #include "blob.h"
+#include "cache.h"

  #define REACHABLE 0x0001

@@ -44,7 +46,7 @@
  	if (parse_tree(item))
  		return -1;
  	if (item->has_full_path) {
-		fprintf(stderr, "warning: fsck-cache: tree %s "
+		warning("fsck-cache: tree %s "
  			"has full pathnames in it\n", sha1_to_hex(sha1));
  	}
  	return 0;
@@ -182,7 +184,7 @@
  			if (!fsck_name(name))
  				continue;
  		}
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
+		error("bad sha1 file: %s/%s\n", path, de->d_name);
  	}
  	closedir(dir);
  	return 0;
@@ -238,10 +240,10 @@

  	if (!heads) {
  		if (show_unreachable) {
-			fprintf(stderr, "unable to do reachability without a head\n");
+			message("unable to do reachability without a head\n");
  			show_unreachable = 0;
  		}
-		fprintf(stderr, "expect dangling commits - potential heads - due to 
lack of head information\n");
+		message("expect dangling commits - potential heads - due to lack of 
head information\n");
  	}

  	check_connectivity();
Index: git-export.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/git-export.c  (mode:100644 
sha1:9c867a285b7753859bb2cdcdb2615b386847db70)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/git-export.c  (mode:100644 
sha1:c141f559b9f3e4812bd5a3f3f06df6e246f58142)
@@ -1,3 +1,6 @@
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
  #include "commit.h"

Index: git-mktag.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/git-mktag.c  (mode:100644 
sha1:5d2830dc2bdfa2e76afc3fd4687db8faffaefba2)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/git-mktag.c  (mode:100644 
sha1:ae0d0c560a6da9ace877b25e7691745d660a9e3a)
@@ -1,3 +1,6 @@
+#include <string.h>
+#include <stdio.h>
+
  #include "cache.h"

  /*
Index: init-db.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/init-db.c  (mode:100644 
sha1:83f95e8b926f4fd28e0db0ccfc4f040d4172ee8a)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/init-db.c  (mode:100644 
sha1:e4ce5acea8efb8488a2557d022ca9673a6d5170a)
@@ -3,13 +3,17 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  void safe_create_dir(char *dir)
  {
  	if (mkdir(dir, 0755) < 0) {
  		if (errno != EEXIST) {
-			perror(dir);
+			error("%s: %s", dir, strerror(errno));
  			exit(1);
  		}
  	}
@@ -31,7 +35,7 @@
  	sha1_dir = getenv(DB_ENVIRONMENT);
  	if (!sha1_dir) {
  		sha1_dir = DEFAULT_DB_ENVIRONMENT;
-		fprintf(stderr, "defaulting to local storage area\n");
+		error("defaulting to local storage area");
  	}
  	len = strlen(sha1_dir);
  	path = xmalloc(len + 40);
Index: ls-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/ls-tree.c  (mode:100644 
sha1:60c169000bfaf7aa21406861e82140449f9a07ea)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/ls-tree.c  (mode:100644 
sha1:94e3780d30bbdbb33693d2d767e81b26c83bd612)
@@ -3,6 +3,9 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  int line_termination = '\n';
Index: merge-base.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/merge-base.c  (mode:100644 
sha1:2c40881302e586366f03ae6ac6e7c0035847e2f0)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/merge-base.c  (mode:100644 
sha1:ec9162900c34f45b2c736436554481d380ec0778)
@@ -1,4 +1,6 @@
  #include <stdlib.h>
+#include <stdio.h>
+
  #include "cache.h"
  #include "commit.h"

Index: merge-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/merge-cache.c  
(mode:100644 sha1:4902749fbb4230f218a350efa0ff786ded40337a)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/merge-cache.c  
(mode:100644 sha1:8c944f383e699677e92d945d61e85ebf1a125321)
@@ -1,6 +1,9 @@
  #include <sys/types.h>
  #include <sys/wait.h>

+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  static const char *pgm = NULL;
Index: read-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/read-cache.c  (mode:100644 
sha1:2112168477b8cc87970a94c584104d888ad0c067)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/read-cache.c  (mode:100644 
sha1:2c2f85a3cdad584eddfa2a1db23d122630f14a75)
@@ -3,7 +3,9 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
-#include <stdarg.h>
+#include <errno.h>
+#include <string.h>
+
  #include "cache.h"

  struct cache_entry **active_cache = NULL;
Index: read-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/read-tree.c  (mode:100644 
sha1:1ad7ffc555b635fe57fa7834b12d71ff576be065)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/read-tree.c  (mode:100644 
sha1:8b2de2a750328f82759c23c6ec35e35cfac42689)
@@ -3,6 +3,9 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  static int stage = 0;
Index: rev-list.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/rev-list.c  (mode:100644 
sha1:77bfc29db1aad08ba9d7d87ce08d33d4a88e74e3)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/rev-list.c  (mode:100644 
sha1:7cd56acf83c17e752f2cabd06efc4acc2f0b10ea)
@@ -1,3 +1,4 @@
+#include <stdio.h>
  #include "cache.h"
  #include "commit.h"

Index: rev-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/rev-tree.c  (mode:100644 
sha1:94d500ec091e8c1ac0bd4c68a7e39fd5213a79eb)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/rev-tree.c  (mode:100644 
sha1:4a4d7c6b4baf8119c3f475eeb4c0302a978ff63c)
@@ -1,7 +1,10 @@
  #define _XOPEN_SOURCE /* glibc2 needs this */
  #define _BSD_SOURCE /* for tm.tm_gmtoff */
-#include <time.h>
+
  #include <ctype.h>
+#include <stdio.h>
+#include <string.h>
+#include <time.h>

  #include "cache.h"
  #include "commit.h"
Index: rpush.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/rpush.c  (mode:100644 
sha1:0293a1a46311d7e20b13177143741ab9d6d0d201)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/rpush.c  (mode:100644 
sha1:83b197668b1b61ccbe73aa88084adcf8ee1e807e)
@@ -1,7 +1,10 @@
-#include "cache.h"
-#include "rsh.h"
+#include <sys/types.h>
  #include <sys/socket.h>
  #include <errno.h>
+#include <string.h>
+
+#include "cache.h"
+#include "rsh.h"

  void service(int fd_in, int fd_out) {
  	ssize_t size;
@@ -14,10 +17,10 @@
  		do {
  			size = read(fd_in, sha1 + posn, 20 - posn);
  			if (size < 0) {
-				perror("rpush: read ");
+				error("rpush: read %s", strerror(errno));
  				return;
  			}
-			if (!size)
+			if (0 == size)
  				return;
  			posn += size;
  		} while (posn < 20);
@@ -26,7 +29,7 @@

  		buf = map_sha1_file(sha1, &objsize);
  		if (!buf) {
-			fprintf(stderr, "rpush: could not find %s\n",
+			error("rpush: could not find %s\n",
  				sha1_to_hex(sha1));
  			return;
  		}
@@ -34,10 +37,11 @@
  		do {
  			size = write(fd_out, buf + posn, objsize - posn);
  			if (size <= 0) {
-				if (!size) {
-					fprintf(stderr, "rpush: write closed");
+				if (0 == size) {
+					error("rpush: write closed");
  				} else {
-					perror("rpush: write ");
+					error("rpush: write %s",
+					     strerror(errno));
  				}
  				return;
  			}
Index: rsh.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/rsh.c  (mode:100644 
sha1:af2f47b174e3895e6c02c4cd8f16a89e3bacbbbb)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/rsh.c  (mode:100644 
sha1:c1c1b2653460588cb1c76fffc68dce002ae3b6f9)
@@ -1,10 +1,12 @@
-#include "rsh.h"
-
-#include <string.h>
  #include <sys/types.h>
  #include <sys/socket.h>

+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
+
+#include "rsh.h"

  #define COMMAND_SIZE 4096

Index: sha1_file.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/sha1_file.c  (mode:100644 
sha1:2bc1590efa688e7a4d7b3a89d3bffb1482e7302a)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/sha1_file.c  (mode:100644 
sha1:7b25a17e78fd114f0436bc48f4b52d3852266153)
@@ -6,7 +6,16 @@
   * This handles basic git sha1 object files - packing, unpacking,
   * creation etc.
   */
-#include <stdarg.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+
+#include <errno.h>
+#include <fcntl.h>
+//#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
  #include "cache.h"

  const char *sha1_file_directory = NULL;
@@ -64,6 +73,7 @@
   * NOTE! This returns a statically allocated buffer, so you have to be
   * careful about using it. Do a "strdup()" if you need to save the
   * filename.
+ * NOTE! This is not thread safe.
   */
  char *sha1_file_name(const unsigned char *sha1)
  {
@@ -71,7 +81,7 @@
  	static char *name, *base;

  	if (!base) {
-		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : 
DEFAULT_DB_ENVIRONMENT;
+		char *sha1_file_directory = get_object_directory();
  		int len = strlen(sha1_file_directory);
  		base = xmalloc(len + 60);
  		memcpy(base, sha1_file_directory, len);
@@ -109,22 +119,27 @@
  	struct stat st;
  	void *map;
  	int fd;
+	mode_t mode = O_RDONLY | sha1_file_open_flag;

-	fd = open(filename, O_RDONLY | sha1_file_open_flag);
+	fd = open(filename, mode);
  	if (fd < 0) {
-		/* See if it works without O_NOATIME */
+		/* See if it works without special flags */
  		switch (sha1_file_open_flag) {
  		default:
-			fd = open(filename, O_RDONLY);
+			mode = O_RDONLY;
+			fd = open(filename, mode);
  			if (fd >= 0)
  				break;
-		/* Fallthrough */
+			/* FALLTHROUGH */
  		case 0:
-			perror(filename);
+			error("Unable to open(%s, %o): %s", filename, mode,
+			     strerror(errno));
  			return NULL;
  		}

-		/* If it failed once, it will probably fail again. Stop using 
O_NOATIME */
+		/*
+		 * If it failed once, it will probably fail again.
+		 *  Stop using O_NOATIME */
  		sha1_file_open_flag = 0;
  	}
  	if (fstat(fd, &st) < 0) {
@@ -144,7 +159,7 @@
  	int ret, bytes;
  	z_stream stream;
  	char buffer[8192];
-	char *buf;
+	char *buf = NULL;

  	/* Get the data stream */
  	memset(&stream, 0, sizeof(stream));
@@ -154,23 +169,38 @@
  	stream.avail_out = sizeof(buffer);

  	inflateInit(&stream);
-	ret = inflate(&stream, 0);
-	if (ret < Z_OK)
-		return NULL;
-	if (sscanf(buffer, "%10s %lu", type, size) != 2)
-		return NULL;
+	ret = inflate(&stream, Z_SYNC_FLUSH);
+	if (ret < Z_OK) {
+		error("Error during initial inflate.");
+		goto end;
+	}
+	if (sscanf(buffer, "%10s %lu", type, size) != 2) {
+		error("Malformed object.");
+		goto end;
+	}

  	bytes = strlen(buffer) + 1;
-	buf = xmalloc(*size);
+	buf = malloc(*size);
+	if (NULL == buf) {
+		error("Unable to malloc(%d): %s", *size, strerror(errno));
+		goto end;
+	}

  	memcpy(buf, buffer + bytes, stream.total_out - bytes);
  	bytes = stream.total_out - bytes;
-	if (bytes < *size && ret == Z_OK) {
+	if (bytes < *size && Z_OK == ret) {
  		stream.next_out = buf + bytes;
  		stream.avail_out = *size - bytes;
-		while (inflate(&stream, Z_FINISH) == Z_OK)
+		while (Z_OK == (ret = inflate(&stream, Z_FINISH)))
  			/* nothing */;
  	}
+
+	if (Z_STREAM_END != ret) {
+		free(buf);
+		buf = NULL;
+		error("Error during inflate.");
+	}
+end:
  	inflateEnd(&stream);
  	return buf;
  }
@@ -231,8 +261,8 @@

  int write_sha1_file(char *buf, unsigned long len, const char *type, 
unsigned char *returnsha1)
  {
-	int size;
-	char *compressed;
+	int size, ret;
+	char *compressed = NULL;
  	z_stream stream;
  	unsigned char sha1[20];
  	SHA_CTX c;
@@ -249,14 +279,16 @@
  	SHA1_Update(&c, buf, len);
  	SHA1_Final(sha1, &c);

-	if (returnsha1)
+	if (NULL != returnsha1)
  		memcpy(returnsha1, sha1, 20);

  	filename = sha1_file_name(sha1);
  	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
  	if (fd < 0) {
-		if (errno != EEXIST)
-			return -1;
+		if (EEXIST != errno)
+			return error(
+"Cannot open(%s, O_WRONLY | O_CREAT | O_EXCL, 0666):\n%s",
+				    filename, strerror(errno));

  		/*
  		 * We might do collision checking here, but we'd need to
@@ -267,9 +299,17 @@

  	/* Set it up */
  	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, Z_BEST_COMPRESSION);
+	if(Z_OK != deflateInit(&stream, Z_BEST_COMPRESSION)) {
+		unlink(filename);
+		ret = error("deflateInit(&stream, Z_BEST_COMPRESSION) failed");
+		goto end;
+        }
  	size = deflateBound(&stream, len+hdrlen);
-	compressed = xmalloc(size);
+	compressed = malloc(size);
+	if (NULL == compressed) {
+		ret = error("Unable to malloc(%d):%s", size, strerror(errno));
+		goto end;
+	}

  	/* Compress it */
  	stream.next_out = compressed;
@@ -278,23 +318,39 @@
  	/* First header.. */
  	stream.next_in = hdr;
  	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
+	while (Z_OK == (ret = deflate(&stream, Z_NO_FLUSH)))
  		/* nothing */
+	if (Z_STREAM_END != ret) {
+		ret = error("Error deflating header");
+		goto end;
+	}

  	/* Then the data itself.. */
  	stream.next_in = buf;
  	stream.avail_in = len;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
+	while (Z_OK == (ret = deflate(&stream, Z_FINISH)))
  		/* nothing */;
-	deflateEnd(&stream);
-	size = stream.total_out;
+	if (Z_STREAM_END != ret) {
+		ret = error("Error deflating data");
+		goto end;
+	}

-	if (write(fd, compressed, size) != size)
-		die("unable to write file");
+	size = write(fd, compressed, stream.total_out);
+	ret = 0;
+	if (stream.total_out != size) {
+		if (0 > size)
+			ret = error("Error writing to %s:%s", filename,
+				   strerror(errno));
+		else
+			ret = error("Unexpected short write to %s", filename);
+	}
+end:
  	free(compressed);
+	deflateEnd(&stream);
  	close(fd);
+	if (0 != ret) unlink(filename);
  		
-	return 0;
+	return ret;
  }

  static inline int collision_check(char *filename, void *buf, unsigned 
int size)
@@ -354,7 +410,6 @@
  int write_sha1_from_fd(const unsigned char *sha1, int fd)
  {
  	char *filename = sha1_file_name(sha1);
-
  	int local;
  	z_stream stream;
  	unsigned char real_sha1[20];
@@ -366,7 +421,9 @@
  	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);

  	if (local < 0)
-		return error("Couldn't open %s\n", filename);
+		return error(
+"Error open(%s, O_WRONLY | O_CREAT | O_EXCL, 0666):\n%s",
+			    filename, strerror(errno));

  	memset(&stream, 0, sizeof(stream));

@@ -377,13 +434,12 @@
  	do {
  		ssize_t size;
  		size = read(fd, buf, 4096);
-		if (size <= 0) {
+		if (0 >= size) {
  			close(local);
  			unlink(filename);
-			if (!size)
-				return error("Connection closed?");
-			perror("Reading from connection");
-			return -1;
+			if (0 == size) return error("Connection closed?");
+			return error("Reading from connection: %s",
+				    strerror(errno));
  		}
  		write(local, buf, size);
  		stream.avail_in = size;
Index: show-diff.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/show-diff.c  (mode:100644 
sha1:b13dbabcbd48b509d71bf36ff75ee569005e0d83)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/show-diff.c  (mode:100644 
sha1:9c44d7b5e0c62f54cf59b50565837bc04e20a9e6)
@@ -3,6 +3,10 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"
  #include "diff.h"

@@ -88,7 +92,7 @@
  	 * Otherwise argv[1] .. argv[argc-1] have the explicit paths.
  	 */
  	if (entries < 0) {
-		perror("read_cache");
+		error("read_cache: %s", strerror(errno));
  		exit(1);
  	}

@@ -113,7 +117,7 @@

  		if (stat(ce->name, &st) < 0) {
  			if (errno != ENOENT) {
-				perror(ce->name);
+				error("%s: %s", ce->name, strerror(errno));
  				continue;
  			}	
  			if (silent)
Index: show-files.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/show-files.c  (mode:100644 
sha1:dd9ea231ef0e5af1d55f16add1d2f265a9bcc904)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/show-files.c  (mode:100644 
sha1:12771b89e32c841dc2227fe624ab0ad1d623ef77)
@@ -6,6 +6,8 @@
   * Copyright (C) Linus Torvalds, 2005
   */
  #include <dirent.h>
+#include <string.h>
+#include <stdio.h>

  #include "cache.h"

Index: tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/tree.c  (mode:100644 
sha1:7c55bb9bfa1565dc9df5cab31207a02004d7fe10)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/tree.c  (mode:100644 
sha1:9db7f13cda9e5adac67e5c258574adedc0e16e42)
@@ -1,7 +1,10 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "tree.h"
  #include "blob.h"
  #include "cache.h"
-#include <stdlib.h>

  const char *tree_type = "tree";

Index: unpack-file.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/unpack-file.c  
(mode:100644 sha1:6ff3d51c182627f42b104932ecea9b95d6225a5d)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/unpack-file.c  
(mode:100644 sha1:07f4d576b81d1abd0c906b68cc93c733cc84ccf6)
@@ -1,3 +1,6 @@
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  static char *create_temp_file(unsigned char *sha1)
Index: update-cache.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/update-cache.c  
(mode:100644 sha1:30ab8972bd0d49fa0ae3fef33f68618c8b042acf)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/update-cache.c  
(mode:100644 sha1:99b08762af96b0dd457abdf45b37b723a703b4af)
@@ -3,7 +3,11 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <errno.h>
  #include <signal.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  /*
Index: usage.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/usage.c  (mode:100644 
sha1:e774d2ef32726af0707d817cdb63fc8751ddc9d8)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/usage.c  (mode:100644 
sha1:58285fca616c970e2e76d4251197b5ee0e0baa3e)
@@ -4,6 +4,7 @@
   * Copyright (C) Linus Torvalds, 2005
   */
  #include <stdarg.h>
+#include <stdio.h>
  #include "cache.h"

  static void report(const char *prefix, const char *err, va_list params)
@@ -37,4 +38,28 @@
  	report("error: ", err, params);
  	va_end(params);
  	return -1;
+}
+
+void
+warning(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	report("warning: ", err, params);
+	va_end(params);
+
+	return;
+}
+
+void
+message(const char *msg, ...)
+{
+	va_list params;
+
+	va_start(params, msg);
+	report("", msg, params);
+	va_end(params);
+
+	return;
  }
Index: write-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/write-tree.c  (mode:100644 
sha1:168352853d37bdca71d68ad8312b87b84477dea1)
+++ 86241f0cd550785e3cba0a235f7e423d0503be93/write-tree.c  (mode:100644 
sha1:9349a974498bc9a52810d5c5203c0f27952ff14b)
@@ -3,6 +3,10 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
  #include "cache.h"

  static int check_valid_sha1(unsigned char *sha1)
@@ -12,8 +16,8 @@

  	/* If we were anal, we'd check that the sha1 of the contents actually 
matches */
  	ret = access(filename, R_OK);
-	if (ret)
-		perror(filename);
+	if (0 != ret)
+		error("access(%s, R_OK): %s", filename, strerror(errno));
  	return ret;
  }

@@ -97,10 +101,10 @@
  		struct cache_entry *ce = active_cache[i];
  		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
  			if (++unmerged > 10) {
-				fprintf(stderr, "...\n");
+				message("...");
  				break;
  			}
-			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, 
sha1_to_hex(ce->sha1));
+			message("%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
  		}
  	}
  	if (unmerged)



!-------------------------------------------------------------flip-


Added two report functions (warning, message) to usage.c.
Tried to correct all usages of xmalloc, xrealloc where simple dying
was not an option IMHO.

---
commit c0dc464ff1c7c28e263fbccafa3e7965417b002b
tree 8d544bed2cad3eb71e31dfee64544972beb49f3a
parent f03e0239ea6ae31d8f89a4a7965ed90832770c5b
author Robert Suetterlin <krs@robert3.mpe-garching.mpg.de> 1114778282 
+0200
committer Robert Suetterlin <krs@robert3.mpe-garching.mpg.de> 
1114778282 +0200

Index: Makefile
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/Makefile  (mode:100644 
sha1:3c461e439a8731b688533dccbc5dafa1471a5b3b)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/Makefile  (mode:100644 
sha1:6133db7c39995dee2dc4f4f1bfef88bc12b8f0c6)
@@ -21,7 +21,7 @@

  # DEFINES += -DNSEC

-CFLAGS=-g -O2 -Wall
+CFLAGS=-g -O -pipe -Wall -Werror
  CFLAGS+=$(DEFINES)

  # Should be changed to /usr/local
Index: cache.h
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/cache.h  (mode:100644 
sha1:036d6b6897ef119b4de051d957b5886680bfffe3)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/cache.h  (mode:100644 
sha1:5651f0b8e3181f9369467ee7c9203ce513c8cd79)
@@ -1,24 +1,11 @@
  #ifndef CACHE_H
  #define CACHE_H

-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/param.h>
-#include <sys/stat.h>
-
-#include <netinet/in.h>
-
-//#include <errno.h>
-#include <fcntl.h>
-#include <stdarg.h>
-#include <stddef.h>
-#include <stdlib.h>
-//#include <stdio.h>
-//#include <string.h>
-#include <unistd.h>
-
-#include SHA1_HEADER
-#include <zlib.h>
+//FIX: these two includes are either unnecesary, or like stddef
+// should be #included in the files that use the feature supplied
+// by the header file.
+#include <stddef.h> /* defines offsetof(), used in cache_entry_size()  
*/
+#include <stdlib.h> /* needed by inline functions xmalloc and xrealloc 
*/

  #if ZLIB_VERNUM < 0x1200
  #define deflateBound(c,s) ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) 
+ 11)
Index: cat-file.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/cat-file.c  (mode:100644 
sha1:568cfbc266416f8afa88995a90a3d17132e8db8b)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/cat-file.c  (mode:100644 
sha1:b3edf2adc27e49d84cd1ca7a6d550d5b17d6b3e7)
@@ -5,6 +5,7 @@
   */
  #include <errno.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

Index: check-files.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/check-files.c  
(mode:100644 sha1:438fa7fc084b94a5fe6dd0a4200b69d1ef147b75)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/check-files.c  
(mode:100644 sha1:cc336ff2fe90fc381de0d5b1eeccf9d8d9c41dec)
@@ -6,7 +6,10 @@
   *
   * Copyright (C) 2005 Linus Torvalds
   */
+#include <sys/stat.h>
+
  #include <errno.h>
+#include <fcntl.h>
  #include <string.h>

  #include "cache.h"
Index: checkout-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/checkout-cache.c  
(mode:100644 sha1:c6576f35685a0a83627af2fa5edba742a103c2ad)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/checkout-cache.c  
(mode:100644 sha1:fd42b25c405c124d2c44a72de32061bf3fecbbd0)
@@ -32,11 +32,14 @@
   * of "-a" causing problems (not possible in the above example,
   * but get used to it in scripting!).
   */
+#include <sys/param.h>
  #include <sys/types.h>
  #include <sys/stat.h>

  #include <errno.h>
+#include <fcntl.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

Index: commit-tree.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/commit-tree.c  
(mode:100644 sha1:e396ca80f6a87c09130b19fc5452605ac7d83861)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/commit-tree.c  
(mode:100644 sha1:c4c20dfd1129e13171af325ac1a076926aa45370)
@@ -6,8 +6,10 @@
  #include <ctype.h>
  #include <pwd.h>
  #include <time.h>
-#include <stdio.h>
+#include <stdarg.h> /* add_buffer */
+#include <stdio.h> /* add_buffer, parse_rfc2822_date, main */
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

@@ -273,7 +275,7 @@
  		parents++;
  	}
  	if (!parents)
-		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
+		message("Committing initial tree %s\n", argv[1]);
  	pw = getpwuid(getuid());
  	if (!pw)
  		die("You don't exist. Go away!");
Index: convert-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/convert-cache.c  
(mode:100644 sha1:e50248857b1b707a771a42fe4ce7f7dcc5fdc79f)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/convert-cache.c  
(mode:100644 sha1:be0bbb67d15a825568eee3fca38d68780bfa6f5c)
@@ -1,4 +1,6 @@
  #define _XOPEN_SOURCE /* glibc2 needs this */
+#include <sys/stat.h>
+
  #include <ctype.h>
  #include <time.h>
  #include <stdio.h>
Index: diff-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/diff-cache.c  (mode:100644 
sha1:1177977fba4d3d2fcd3cd6ec72451abb84d414a1)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/diff-cache.c  (mode:100644 
sha1:d821c62811c2c968ec81f0eba6794bfcab5ed8f0)
@@ -1,3 +1,5 @@
+#include <sys/stat.h>
+
  #include <stdio.h>
  #include <string.h>

Index: diff-tree-helper.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/diff-tree-helper.c  
(mode:100644 sha1:4071871b6d3416d02d6203c47950d482d79c78f4)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/diff-tree-helper.c  
(mode:100644 sha1:d86042af7ad940ae20e3d24af2d688dde294a3a3)
@@ -1,6 +1,8 @@
  /*
   * Copyright (C) 2005 Junio C Hamano
   */
+#include <sys/param.h>
+
  #include <stdio.h>
  #include <string.h>

Index: diff-tree.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/diff-tree.c  (mode:100644 
sha1:ac026816c32cb44d43025236409655f97197aff2)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/diff-tree.c  (mode:100644 
sha1:4236f5baa23d158064544373d0d44984053899f5)
@@ -1,3 +1,5 @@
+#include <sys/stat.h>
+
  #include <stdio.h>
  #include <string.h>

Index: diff.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/diff.c  (mode:100644 
sha1:0326f0488d2c037f238f9012d8a007473b13b968)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/diff.c  (mode:100644 
sha1:e6680ebb5ea4f6451f4dcd6ce8edadb768b96c0a)
@@ -2,11 +2,14 @@
   * Copyright (C) 2005 Junio C Hamano
   */
  #include <sys/types.h>
+#include <sys/param.h>
+#include <sys/stat.h>
  #include <sys/wait.h>

  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"
  #include "diff.h"
Index: fsck-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/fsck-cache.c  (mode:100644 
sha1:265319c97cc68313e3e62d304c38d074dc22abdb)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/fsck-cache.c  (mode:100644 
sha1:7a16928924425b142d5350375e1c949bfee0066e)
@@ -1,4 +1,5 @@
  #include <sys/types.h>
+#include <sys/mman.h> /* needed to munmap a map returned by 
map_sha1_file */

  #include <dirent.h>
  #include <stdio.h>
@@ -135,6 +136,7 @@
  	return 0;
  }

+// FIX: uses map_sha1_file and unpack_sha1_file, never frees buffer
  static int fsck_name(char *hex)
  {
  	unsigned char sha1[20];
Index: git-mktag.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/git-mktag.c  (mode:100644 
sha1:ae0d0c560a6da9ace877b25e7691745d660a9e3a)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/git-mktag.c  (mode:100644 
sha1:72e1eb38fb562c0275b4903dcc23e05f14f1532c)
@@ -1,3 +1,6 @@
+#include <sys/types.h> /* only needed for mman.h */
+#include <sys/mman.h> /*only needed for munmap */
+
  #include <string.h>
  #include <stdio.h>

@@ -25,6 +28,7 @@
  /*
   * We refuse to tag something we can't verify. Just because.
   */
+// FIX: uses map_sha1_file and unpack_sha1_file
  static int verify_object(unsigned char *sha1, const char 
*expected_type)
  {
  	int ret = -1;
@@ -115,7 +119,7 @@
  		usage("cat <signaturefile> | git-mktag");

  	// Read the signature
-	size = read(0, buffer, MAXSIZE);
+	size = fread(buffer, MAXSIZE, 1, stdin);

  	// Verify it for some basic sanity: it needs to start with "object 
<sha1>\ntag "
  	if (verify_tag(buffer, size) < 0)
Index: http-pull.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/http-pull.c  (mode:100644 
sha1:192dcc370dee47c52c72915394bb6f2a79f64e12)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/http-pull.c  (mode:100644 
sha1:fba8940c5435eb05e1093172b7ebb20e1795761b)
@@ -1,14 +1,17 @@
+#include <errno.h>
  #include <fcntl.h>
-#include <unistd.h>
-#include <string.h>
  #include <stdlib.h>
-#include "cache.h"
-#include "commit.h"
-#include <errno.h>
  #include <stdio.h>
+#include <string.h>
+#include <unistd.h>

  #include <curl/curl.h>
  #include <curl/easy.h>
+#include SHA1_HEADER
+#include <zlib.h>
+
+#include "cache.h"
+#include "commit.h"

  static CURL *curl;

@@ -93,7 +96,7 @@
  	close(local);
  	inflateEnd(&stream);
  	SHA1_Final(real_sha1, &c);
-	if (zret != Z_STREAM_END) {
+	if (Z_STREAM_END != zret) {
  		unlink(filename);
  		return error("File %s (%s) corrupt\n", hex, url);
  	}
Index: init-db.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/init-db.c  (mode:100644 
sha1:e4ce5acea8efb8488a2557d022ca9673a6d5170a)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/init-db.c  (mode:100644 
sha1:aba6b2630dfac2f8a3d58db776fe7c1c0535dd3a)
@@ -3,6 +3,8 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/stat.h>
+
  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
Index: ls-tree.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/ls-tree.c  (mode:100644 
sha1:94e3780d30bbdbb33693d2d767e81b26c83bd612)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/ls-tree.c  (mode:100644 
sha1:ea2c7ce121d203711e54efb3bd41788c60c7f3ef)
@@ -3,6 +3,8 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/stat.h>
+
  #include <stdio.h>
  #include <string.h>

Index: merge-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/merge-cache.c  
(mode:100644 sha1:8c944f383e699677e92d945d61e85ebf1a125321)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/merge-cache.c  
(mode:100644 sha1:281ae0ab5da499a68f5072e197f2d38980b87b8a)
@@ -1,8 +1,10 @@
  #include <sys/types.h>
+#include <sys/stat.h>
  #include <sys/wait.h>

  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

Index: read-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/read-cache.c  (mode:100644 
sha1:2c2f85a3cdad584eddfa2a1db23d122630f14a75)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/read-cache.c  (mode:100644 
sha1:0e99d46b859a13b9aaceb497488e6255a883663b)
@@ -3,9 +3,16 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+
  #include <errno.h>
+#include <fcntl.h>
  #include <string.h>
+#include <unistd.h>

+#include SHA1_HEADER
  #include "cache.h"

  struct cache_entry **active_cache = NULL;
Index: read-tree.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/read-tree.c  (mode:100644 
sha1:8b2de2a750328f82759c23c6ec35e35cfac42689)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/read-tree.c  (mode:100644 
sha1:d3dbbd2bc1f85554b6ea96edf7e7ffee73afd79e)
@@ -3,8 +3,12 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/param.h>
+
+#include <fcntl.h>
  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

Index: rpush.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/rpush.c  (mode:100644 
sha1:83b197668b1b61ccbe73aa88084adcf8ee1e807e)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/rpush.c  (mode:100644 
sha1:bb67e578915c571523d49d2b7ae6344ee45b2853)
@@ -1,7 +1,9 @@
  #include <sys/types.h>
  #include <sys/socket.h>
+
  #include <errno.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"
  #include "rsh.h"
Index: rsh.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/rsh.c  (mode:100644 
sha1:c1c1b2653460588cb1c76fffc68dce002ae3b6f9)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/rsh.c  (mode:100644 
sha1:85f508a6ae6f9dfcc215a8468bc2cb337cf94c4f)
@@ -3,6 +3,7 @@

  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

Index: sha1_file.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/sha1_file.c  (mode:100644 
sha1:7b25a17e78fd114f0436bc48f4b52d3852266153)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/sha1_file.c  (mode:100644 
sha1:0f07a82f7ab5a6bc89dec0d912cf5ce2d7fff64a)
@@ -7,15 +7,19 @@
   * creation etc.
   */
  #include <sys/types.h>
-#include <sys/uio.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+//#include <sys/uio.h>

  #include <errno.h>
  #include <fcntl.h>
-//#include <stdarg.h>
  #include <stdio.h>
  #include <string.h>
  #include <unistd.h>

+#include SHA1_HEADER
+#include <zlib.h>
+
  #include "cache.h"

  const char *sha1_file_directory = NULL;
@@ -319,9 +323,9 @@
  	stream.next_in = hdr;
  	stream.avail_in = hdrlen;
  	while (Z_OK == (ret = deflate(&stream, Z_NO_FLUSH)))
-		/* nothing */
-	if (Z_STREAM_END != ret) {
-		ret = error("Error deflating header");
+		/* nothing */;
+	if (Z_STREAM_ERROR == ret) {
+		ret = error("deflate(header): inconsistent stream state.");
  		goto end;
  	}

@@ -457,7 +461,7 @@

  	close(local);
  	SHA1_Final(real_sha1, &c);
-	if (ret != Z_STREAM_END) {
+	if (Z_STREAM_END != ret) {
  		unlink(filename);
  		return error("File %s corrupted", sha1_to_hex(sha1));
  	}
Index: show-diff.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/show-diff.c  (mode:100644 
sha1:9c44d7b5e0c62f54cf59b50565837bc04e20a9e6)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/show-diff.c  (mode:100644 
sha1:187cadd510e86018493061addd72465d9c920caa)
@@ -3,6 +3,8 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/stat.h>
+
  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
Index: show-files.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/show-files.c  (mode:100644 
sha1:12771b89e32c841dc2227fe624ab0ad1d623ef77)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/show-files.c  (mode:100644 
sha1:c54ffdd14b1815381d1957cab9ce0499c9739691)
@@ -5,6 +5,9 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/param.h>
+#include <sys/stat.h>
+
  #include <dirent.h>
  #include <string.h>
  #include <stdio.h>
Index: tree.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/tree.c  (mode:100644 
sha1:9db7f13cda9e5adac67e5c258574adedc0e16e42)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/tree.c  (mode:100644 
sha1:f9762bf82e528ad3842c8ada4d8ccaf5acce96c3)
@@ -1,3 +1,5 @@
+#include <sys/stat.h>
+
  #include <stdlib.h>
  #include <stdio.h>
  #include <string.h>
Index: unpack-file.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/unpack-file.c  
(mode:100644 sha1:07f4d576b81d1abd0c906b68cc93c733cc84ccf6)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/unpack-file.c  
(mode:100644 sha1:5a867509ba1f7276cdeec6ff46fd6fd0f89c80c8)
@@ -1,5 +1,6 @@
  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"

Index: update-cache.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/update-cache.c  
(mode:100644 sha1:99b08762af96b0dd457abdf45b37b723a703b4af)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/update-cache.c  
(mode:100644 sha1:78d4ba3fbbf548b85935a6fb83f445dcb5eec3c0)
@@ -3,10 +3,20 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/types.h> /* FIX: used in index_fd, should be part of 
sha1_file */
+#include <sys/mman.h> /* FIX: used in index_fd, should be part of 
sha1_file */
+#include <sys/param.h> /* only used in main for MAXPATHLEN */
+#include <sys/stat.h>
+
  #include <errno.h>
+#include <fcntl.h>
  #include <signal.h>
  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>
+
+#include SHA1_HEADER /* FIX: used in index_fd, should be part of 
sha1_file */
+#include <zlib.h> /* FIX: used in index_fd, should be part of 
sha1_file */

  #include "cache.h"

@@ -79,7 +89,7 @@
  	stream.next_in = in;
  	stream.avail_in = size;
  	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/*nothing */;
+		/* nothing */;

  	deflateEnd(&stream);
  	
@@ -115,7 +125,7 @@

  	fd = open(path, O_RDONLY);
  	if (fd < 0) {
-		if (errno == ENOENT) {
+		if (ENOENT == errno) {
  			if (allow_remove)
  				return remove_file_from_cache(path);
  		}
@@ -123,7 +133,7 @@
  	}
  	if (fstat(fd, &st) < 0) {
  		close(fd);
-		return -1;
+		return error("fstat(\"%s\"): %s", path, strerror(errno));
  	}
  	if (S_ISDIR(st.st_mode)) {
  		fprintf(stderr, "'%s' is a directory, ignoring\n", path);
Index: write-tree.c
===================================================================
--- 86241f0cd550785e3cba0a235f7e423d0503be93/write-tree.c  (mode:100644 
sha1:9349a974498bc9a52810d5c5203c0f27952ff14b)
+++ 8d544bed2cad3eb71e31dfee64544972beb49f3a/write-tree.c  (mode:100644 
sha1:1f32b3ab5b482b68934e1d8373b253750962a027)
@@ -3,9 +3,12 @@
   *
   * Copyright (C) Linus Torvalds, 2005
   */
+#include <sys/stat.h>
+
  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
+#include <unistd.h>

  #include "cache.h"




!-------------------------------------------------------------flip-


