From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Use setenv(), fix warnings
Date: Sun, 26 Feb 2006 17:13:46 +0200
Message-ID: <20060226171346.33ad3e47.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 16:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDNZe-00033p-Ch
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 16:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWBZPMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 10:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWBZPMS
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 10:12:18 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:51595 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751212AbWBZPMS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 10:12:18 -0500
Received: by wproxy.gmail.com with SMTP id 71so650812wra
        for <git@vger.kernel.org>; Sun, 26 Feb 2006 07:12:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YCNIEfJbdNwnY5AotUdO4X6jBQZHMgPqtEX9ccxtxlueLVaBi5yXC0+n6IX2kw0DizeqbFNTmUsjtwKnUMzJ8n30s4CU2noOZMlXO2P29mKUbEl1fcF9OEmDVzbdOEcT/j/L1mkV0ayhIe4UReGtLxrdufg2uUTAnQ96hAJcOco=
Received: by 10.64.96.20 with SMTP id t20mr32813qbb;
        Sun, 26 Feb 2006 07:12:17 -0800 (PST)
Received: from garlic.home.net ( [82.128.228.98])
        by mx.gmail.com with ESMTP id e10sm2430222qbe.2006.02.26.07.12.15;
        Sun, 26 Feb 2006 07:12:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16782>


  - Use setenv() instead of putenv()
  - Fix -Wundef -Wold-style-definition warnings
  - Make pll_free() static

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 cache.h          |    2 +-
 exec_cmd.c       |    2 +-
 fetch-pack.c     |    2 +-
 fsck-objects.c   |    4 ++--
 pack-objects.c   |    2 +-
 pack-redundant.c |    4 ++--
 path.c           |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

4001390d41ffd2c816cead47c256e598bedff452
diff --git a/cache.h b/cache.h
index 5020f07..58eec00 100644
--- a/cache.h
+++ b/cache.h
@@ -10,7 +10,7 @@
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-#if defined(DT_UNKNOWN) && !NO_D_TYPE_IN_DIRENT
+#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
 #undef DT_UNKNOWN
diff --git a/exec_cmd.c b/exec_cmd.c
index 55af33b..b5e59a9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -13,7 +13,7 @@ void git_set_exec_path(const char *exec_
 
 
 /* Returns the highest-priority, location to look for git programs. */
-const char *git_exec_path()
+const char *git_exec_path(void)
 {
 	const char *env;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 09738fe..535de10 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -82,7 +82,7 @@ static void mark_common(struct commit *c
   Get the next rev to send, ignoring the common.
 */
 
-static const unsigned char* get_rev()
+static const unsigned char* get_rev(void)
 {
 	struct commit *commit = NULL;
 
diff --git a/fsck-objects.c b/fsck-objects.c
index 6439d55..f9c69f5 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -20,7 +20,7 @@ static int check_strict = 0;
 static int keep_cache_objects = 0; 
 static unsigned char head_sha1[20];
 
-#if NO_D_INO_IN_DIRENT
+#ifdef NO_D_INO_IN_DIRENT
 #define SORT_DIRENT 0
 #define DIRENT_SORT_HINT(de) 0
 #else
@@ -483,7 +483,7 @@ int main(int argc, char **argv)
 	if (standalone && check_full)
 		die("Only one of --standalone or --full can be used.");
 	if (standalone)
-		putenv("GIT_ALTERNATE_OBJECT_DIRECTORIES=");
+		setenv("GIT_ALTERNATE_OBJECT_DIRECTORIES", "", 1);
 
 	fsck_head_link();
 	fsck_object_dir(get_object_directory());
diff --git a/pack-objects.c b/pack-objects.c
index 0287449..21ee572 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -768,7 +768,7 @@ static int sha1_sort(const struct object
 	return memcmp(a->sha1, b->sha1, 20);
 }
 
-static struct object_entry **create_final_object_list()
+static struct object_entry **create_final_object_list(void)
 {
 	struct object_entry **list;
 	int i, j;
diff --git a/pack-redundant.c b/pack-redundant.c
index 1869b38..cd81f5a 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -45,7 +45,7 @@ static inline void llist_item_put(struct
 	free_nodes = item;
 }
 
-static inline struct llist_item *llist_item_get()
+static inline struct llist_item *llist_item_get(void)
 {
 	struct llist_item *new;
 	if ( free_nodes ) {
@@ -275,7 +275,7 @@ static void cmp_two_packs(struct pack_li
 	}
 }
 
-void pll_free(struct pll *l)
+static void pll_free(struct pll *l)
 {
 	struct pll *old;
 	struct pack_list *opl;
diff --git a/path.c b/path.c
index 334b2bd..6500a40 100644
--- a/path.c
+++ b/path.c
@@ -243,7 +243,7 @@ char *enter_repo(char *path, int strict)
 
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_symref("HEAD") == 0) {
-		putenv("GIT_DIR=.");
+		setenv("GIT_DIR", ".", 1);
 		check_repository_format();
 		return path;
 	}
-- 
1.2.1
