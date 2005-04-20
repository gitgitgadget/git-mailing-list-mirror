From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 1/3] add GIT_CACHE_DIRECTORY support
Date: Tue, 19 Apr 2005 21:32:06 -0700
Message-ID: <mailbox-1370-1113971526-293449@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:28:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6p7-0007Xk-Kr
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDTEce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDTEce
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:32:34 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:22927 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261357AbVDTEcJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 00:32:09 -0400
Received: (qmail 1379 invoked by uid 5006); 19 Apr 2005 21:32:08 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-1370-1113971526-282751@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 cache.h        |    3 +++
 init-db.c      |    9 +++++++--
 read-cache.c   |   15 +++++++++++++--
 read-tree.c    |   35 ++++++++++++++++++++++++++---------
 update-cache.c |   33 ++++++++++++++++++++++++---------
 5 files changed, 73 insertions(+), 22 deletions(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>

This patch introduces the GIT_CACHE_DIRECTORY to the C plumbing.
Without this patch, the index file and its lock are always placed
in './.git'.  Scripts wishing to run these commands from a different 
working directory can use this support to override the cache directory.

This require my latest init-db cleanups be applied first, otherwise
you will get a rejection in init-db.c.

cache.h: 5948db759b3f6fb5ade3b027f202330f71a8cb6a
--- a/cache.h
+++ b/cache.h
@@ -81,6 +81,9 @@ const char *sha1_file_directory;
 struct cache_entry **active_cache;
 unsigned int active_nr, active_alloc;
 
+#define GIT_CACHE_ENVIRONMENT "GIT_CACHE_DIRECTORY"
+#define DEFAULT_GIT_CACHE_ENVIRONMENT ".git"
+
 #define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
 
init-db.c: 14beb35657de229a61673198bfc4e009daafca15
--- a/init-db.c
+++ b/init-db.c
@@ -23,10 +23,15 @@ void safe_create_dir(char *dir)
  */
 int main(int argc, char **argv)
 {
-	char *sha1_dir, *path;
+	char *sha1_dir, *path, *git_dir;
 	int len, i;
 
-	safe_create_dir(".git");
+	git_dir = getenv(GIT_CACHE_ENVIRONMENT);
+	if (!git_dir) {
+		git_dir = DEFAULT_GIT_CACHE_ENVIRONMENT;
+		fprintf(stderr, "defaulting to local cache area\n");
+	}	
+	safe_create_dir(git_dir);
 
 	sha1_dir = getenv(DB_ENVIRONMENT);
 	if (!sha1_dir) {
read-cache.c: edaadf3e1c0714735ca8d80301dd644aa0f9cd2a
--- a/read-cache.c
+++ b/read-cache.c
@@ -174,22 +174,33 @@ static int verify_hdr(struct cache_heade
 
 int read_cache(void)
 {
-	int fd, i;
+	int fd, i, len;
 	struct stat st;
 	unsigned long size, offset;
 	void *map;
 	struct cache_header *hdr;
+	char *index_path, *index_file;
 
 	errno = EBUSY;
 	if (active_cache)
 		return error("more than one cachefile");
 	errno = ENOENT;
+
 	sha1_file_directory = getenv(DB_ENVIRONMENT);
 	if (!sha1_file_directory)
 		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
 	if (access(sha1_file_directory, X_OK) < 0)
 		return error("no access to SHA1 file directory");
-	fd = open(".git/index", O_RDONLY);
+
+	index_path = getenv(GIT_CACHE_ENVIRONMENT);
+	if (!index_path)
+		index_path = DEFAULT_GIT_CACHE_ENVIRONMENT;
+	len = strlen(index_path);
+	index_file = malloc(len + 7);
+	if (!index_file) error("out of memory");
+	sprintf(index_file, "%s/index", index_path);
+
+	fd = open(index_file, O_RDONLY);
 	if (fd < 0)
 		return (errno == ENOENT) ? 0 : error("open failed");
 
read-tree.c: 9bcba2d567e1c86ae967d383cc081e6947d00a13
--- a/read-tree.c
+++ b/read-tree.c
@@ -65,12 +65,12 @@ static int read_tree(unsigned char *sha1
 	return 0;
 }
 
-static int remove_lock = 0;
+static char *index_lock = NULL;
 
 static void remove_lock_file(void)
 {
-	if (remove_lock)
-		unlink(".git/index.lock");
+	if (index_lock)
+		unlink(index_lock);
 }
 
 static int path_matches(struct cache_entry *a, struct cache_entry *b)
@@ -205,14 +205,27 @@ static void merge_stat_info(struct cache
 
 int main(int argc, char **argv)
 {
-	int i, newfd, merge;
+	int i, newfd, len, merge;
 	unsigned char sha1[20];
-
-	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
+ 	char *index_file, *index_path;
+  
+ 	index_path = getenv(GIT_CACHE_ENVIRONMENT);
+ 	if (!index_path)
+ 		index_path = DEFAULT_GIT_CACHE_ENVIRONMENT;
+ 
+ 	len = strlen(index_path);
+ 	index_file = malloc(len + 7);
+ 	if (!index_file) error("out of memory");
+ 	sprintf(index_file, "%s/index", index_path);
+ 
+ 	index_lock = malloc(len + 12);
+ 	if (!index_lock) error("out of memory");
+ 	sprintf(index_lock, "%s/index.lock", index_path);
+ 
+ 	newfd = open(index_lock, O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
 		die("unable to create new cachefile");
 	atexit(remove_lock_file);
-	remove_lock = 1;
 
 	merge = 0;
 	for (i = 1; i < argc; i++) {
@@ -253,8 +266,12 @@ int main(int argc, char **argv)
 		}
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    rename(".git/index.lock", ".git/index"))
+	    rename(index_lock, index_file))
 		die("unable to write new index file");
-	remove_lock = 0;
+
+	free(index_file);
+	free(index_lock);
+	index_lock = NULL;
+
 	return 0;
 }
update-cache.c: 0d16b36d7d074e9f0a2811a40e16e9823a628ec9
--- a/update-cache.c
+++ b/update-cache.c
@@ -270,25 +270,37 @@ static int add_cacheinfo(char *arg1, cha
 	return add_cache_entry(ce, allow_add);
 }
 
-static int remove_lock = 0;
+static char *index_lock = NULL;
 
 static void remove_lock_file(void)
 {
-	if (remove_lock)
-		unlink(".git/index.lock");
+	if (index_lock)
+		unlink(index_lock);
 }
 
 int main(int argc, char **argv)
 {
-	int i, newfd, entries;
+	int i, newfd, entries, len;
 	int allow_options = 1;
+	char *index_file, *index_path;
 
-	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
+	index_path = getenv(GIT_CACHE_ENVIRONMENT);
+	if (!index_path)
+		index_path = DEFAULT_GIT_CACHE_ENVIRONMENT;
+
+	len = strlen(index_path);
+	index_file = malloc(len + 7);
+	if (!index_file) error("out of memory");
+	sprintf(index_file, "%s/index", index_path);
+
+	index_lock = malloc(len + 12);
+	if (!index_lock) error("out of memory");
+	sprintf(index_lock, "%s/index.lock", index_path);
+
+	newfd = open(index_lock, O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
 		die("unable to create new cachefile");
-
 	atexit(remove_lock_file);
-	remove_lock = 1;
 
 	entries = read_cache();
 	if (entries < 0)
@@ -330,9 +342,12 @@ int main(int argc, char **argv)
 			die("Unable to add %s to database", path);
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    rename(".git/index.lock", ".git/index"))
+	    rename(index_lock, index_file))
 		die("Unable to write new cachefile");
 
-	remove_lock = 0;
+	free(index_file);
+	free(index_lock);
+	index_lock = NULL;
+
 	return 0;
 }
