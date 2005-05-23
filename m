From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/1] bugfix for git-checkout-cache --prefix=/symlink/export_dir/
 -a
Date: Mon, 23 May 2005 11:45:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231145190.2307@ppc970.osdl.org>
References: <E1Da8d0-0002GR-4m@ash.dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 20:45:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaHsj-0008Hk-TC
	for gcvg-git@gmane.org; Mon, 23 May 2005 20:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVEWSn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 14:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVEWSn5
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 14:43:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:34963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261911AbVEWSnr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 14:43:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NIhhjA007849
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 11:43:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NIhgS0012655;
	Mon, 23 May 2005 11:43:43 -0700
To: David Greaves <david@dgreaves.com>
In-Reply-To: <E1Da8d0-0002GR-4m@ash.dgreaves.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, David Greaves wrote:
>
> If there's a prefix then allow symlinks to directories in it.
> This fixes a bug where
>   git-checkout-cache --prefix=/symlink/export_dir/ -a
> otherwise fails.

Hmm.. Does this alternative work for you instead?

[ Totally untested, please check for sanity first!! ]

		Linus

---
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
