From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Allow symlinks in the leading path in checkout-cache
 --prefix=
Date: Tue, 24 May 2005 01:51:27 -0700
Message-ID: <7vacmlvwfk.fsf_-_@assigned-by-dhcp.cox.net>
References: <E1Da8d0-0002GR-4m@ash.dgreaves.com>
	<Pine.LNX.4.58.0505231145190.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505231208460.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:54:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaVAY-0000GB-8F
	for gcvg-git@gmane.org; Tue, 24 May 2005 10:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVEXIyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 04:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVEXIyQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 04:54:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56796 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261914AbVEXIva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 04:51:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524085127.PJAI12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 04:51:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505231208460.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 12:09:20 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is what Linus wrote, improving what David Greaves
originally submitted.

    Hmm.. Does this alternative work for you instead?
    [ Totally untested, please check for sanity first!! ]
    Btw, I'm not going to apply this, and expect that David or somebody else 
    can validate it and send it back to me as "tested".

I just added a test case and verified the patch works.

Author: David Greaves <david@dgreaves.com>
Author: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

checkout-cache.c                |   28 ++++++-----
t/t2003-checkout-cache-mkdir.sh |   95 ++++++++++++++++++++++++++++++++++++++++
2 files changed, 110 insertions(+), 13 deletions(-)
new file (100755): t/t2003-checkout-cache-mkdir.sh

diff --git a/checkout-cache.c b/checkout-cache.c
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -37,6 +37,8 @@
 #include "cache.h"
 
 static int force = 0, quiet = 0, not_new = 0, refresh_cache = 0;
+static const char *base_dir = "";
+static int base_dir_len = 0;
 
 static void create_directories(const char *path)
 {
@@ -51,10 +53,10 @@ static void create_directories(const cha
 		if (mkdir(buf, 0755)) {
 			if (errno == EEXIST) {
 				struct stat st;
-				if (!lstat(buf, &st) && S_ISDIR(st.st_mode))
-					continue; /* ok */
-				if (force && !unlink(buf) && !mkdir(buf, 0755))
+				if (len > base_dir_len && force && !unlink(buf) && !mkdir(buf, 0755))
 					continue;
+				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
+					continue; /* ok */
 			}
 			die("cannot create directory at %s", buf);
 		}
@@ -163,11 +165,11 @@ static int write_entry(struct cache_entr
 	return 0;
 }
 
-static int checkout_entry(struct cache_entry *ce, const char *base_dir)
+static int checkout_entry(struct cache_entry *ce)
 {
 	struct stat st;
 	static char path[MAXPATHLEN+1];
-	int len = strlen(base_dir);
+	int len = base_dir_len;
 
 	memcpy(path, base_dir, len);
 	strcpy(path + len, ce->name);
@@ -194,7 +196,7 @@ static int checkout_entry(struct cache_e
 	return write_entry(ce, path);
 }
 
-static int checkout_file(const char *name, const char *base_dir)
+static int checkout_file(const char *name)
 {
 	int pos = cache_name_pos(name, strlen(name));
 	if (pos < 0) {
@@ -209,10 +211,10 @@ static int checkout_file(const char *nam
 		}
 		return -1;
 	}
-	return checkout_entry(active_cache[pos], base_dir);
+	return checkout_entry(active_cache[pos]);
 }
 
-static int checkout_all(const char *base_dir)
+static int checkout_all(void)
 {
 	int i;
 
@@ -220,7 +222,7 @@ static int checkout_all(const char *base
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce))
 			continue;
-		if (checkout_entry(ce, base_dir) < 0)
+		if (checkout_entry(ce) < 0)
 			return -1;
 	}
 	return 0;
@@ -229,7 +231,6 @@ static int checkout_all(const char *base
 int main(int argc, char **argv)
 {
 	int i, force_filename = 0;
-	const char *base_dir = "";
 	struct cache_file cache_file;
 	int newfd = -1;
 
@@ -241,7 +242,7 @@ int main(int argc, char **argv)
 		const char *arg = argv[i];
 		if (!force_filename) {
 			if (!strcmp(arg, "-a")) {
-				checkout_all(base_dir);
+				checkout_all();
 				continue;
 			}
 			if (!strcmp(arg, "--")) {
@@ -272,10 +273,11 @@ int main(int argc, char **argv)
 			}
 			if (!memcmp(arg, "--prefix=", 9)) {
 				base_dir = arg+9;
+				base_dir_len = strlen(base_dir);
 				continue;
 			}
 		}
-		if (base_dir[0]) {
+		if (base_dir_len) {
 			/* when --prefix is specified we do not
 			 * want to update cache.
 			 */
@@ -285,7 +287,7 @@ int main(int argc, char **argv)
 			}
 			refresh_cache = 0;
 		}
-		checkout_file(arg, base_dir);
+		checkout_file(arg);
 	}
 
 	if (0 <= newfd &&
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
new file mode 100755
--- /dev/null
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-checkout-cache --prefix test.
+
+This test makes sure that --prefix option works as advertised, and
+also verifies that such leading path may contain symlinks, unlike
+the GIT controlled paths.
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'mkdir path1 &&
+    echo frotz >path0 &&
+    echo rezrov >path1/file1 &&
+    git-update-cache --add path0 path1/file1'
+
+test_expect_success \
+    'have symlink in place where dir is expected.' \
+    'rm -fr path0 path1 &&
+     mkdir path2 &&
+     ln -s path2 path1 &&
+     git-checkout-cache -f -a &&
+     test ! -h path1 && test -d path1 &&
+     test -f path1/file1 && test ! -f path2/file1'
+
+test_expect_success \
+    'use --prefix=path2/' \
+    'rm -fr path0 path1 path2 &&
+     mkdir path2 &&
+     git-checkout-cache --prefix=path2/ -f -a &&
+     test -f path2/path0 &&
+     test -f path2/path1/file1 &&
+     test ! -f path0 &&
+     test ! -f path1/file1'
+
+test_expect_success \
+    'use --prefix=tmp-' \
+    'rm -fr path0 path1 path2 tmp* &&
+     git-checkout-cache --prefix=tmp- -f -a &&
+     test -f tmp-path0 &&
+     test -f tmp-path1/file1 &&
+     test ! -f path0 &&
+     test ! -f path1/file1'
+
+test_expect_success \
+    'use --prefix=tmp- but with a conflicting file and dir' \
+    'rm -fr path0 path1 path2 tmp* &&
+     echo nitfol >tmp-path1 &&
+     mkdir tmp-path0 &&
+     git-checkout-cache --prefix=tmp- -f -a &&
+     test -f tmp-path0 &&
+     test -f tmp-path1/file1 &&
+     test ! -f path0 &&
+     test ! -f path1/file1'
+
+# Linus fix #1
+test_expect_success \
+    'use --prefix=tmp/orary/ where tmp is a symlink' \
+    'rm -fr path0 path1 path2 tmp* &&
+     mkdir tmp1 tmp1/orary &&
+     ln -s tmp1 tmp &&
+     git-checkout-cache --prefix=tmp/orary/ -f -a &&
+     test -d tmp1/orary &&
+     test -f tmp1/orary/path0 &&
+     test -f tmp1/orary/path1/file1 &&
+     test -h tmp'
+
+# Linus fix #2
+test_expect_success \
+    'use --prefix=tmp/orary- where tmp is a symlink' \
+    'rm -fr path0 path1 path2 tmp* &&
+     mkdir tmp1 &&
+     ln -s tmp1 tmp &&
+     git-checkout-cache --prefix=tmp/orary- -f -a &&
+     test -f tmp1/orary-path0 &&
+     test -f tmp1/orary-path1/file1 &&
+     test -h tmp'
+
+# Linus fix #3
+test_expect_success \
+    'use --prefix=tmp- where tmp-path1 is a symlink' \
+    'rm -fr path0 path1 path2 tmp* &&
+     mkdir tmp1 &&
+     ln -s tmp1 tmp-path1 &&
+     git-checkout-cache --prefix=tmp- -f -a &&
+     test -f tmp-path0 &&
+     test ! -h tmp-path1 &&
+     test -d tmp-path1 &&
+     test -f tmp-path1/file1'
+
------------------------------------------------

