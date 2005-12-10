From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Allow updating the index from a pipe
Date: Sat, 10 Dec 2005 01:57:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512100145500.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 07:56:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekyec-0003UW-72
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 07:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVLJG4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 01:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVLJG4T
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 01:56:19 -0500
Received: from iabervon.org ([66.92.72.58]:33541 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965100AbVLJG4S (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 01:56:18 -0500
Received: (qmail 27112 invoked by uid 1000); 10 Dec 2005 01:57:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2005 01:57:05 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13440>

In order to allow the index to be modified in simple ways without
having a working tree, this adds an option to git-update-index which
updates a single path with a mode of 100644 and reads the content from
stdin. Somebody should probably give the option a better name.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

This is for a git-backed wiki I'm writing, which doesn't want to use a 
working tree when preparing changes, but wants to work entirely with pipes 
and index files.

 Documentation/git-update-index.txt |    7 ++++++
 cache.h                            |    1 +
 sha1_file.c                        |   27 ++++++++++++++++++++++++
 update-index.c                     |   40 +++++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 1 deletions(-)

7883add98deb548c7c10681ae3d71b7a7d949a9a
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e4678cd..d35340a 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=(+|-)x]
 	     [--info-only] [--index-info]
+	     [--name=<file>]
 	     [-z] [--stdin]
 	     [--verbose]
 	     [--] [<file>]\*
@@ -87,6 +88,12 @@ OPTIONS
 	read list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
+--name=<file>:: 
+	Instead of taking a list of paths, only operate on a single
+	path, and get the content from the standard input instead of
+	from the file system.  The mode for the file will be 100644
+	(regular non-executable file).
+
 --verbose::
         Report what is being added and removed from index.
 
diff --git a/cache.h b/cache.h
index 86fc250..1b30f44 100644
--- a/cache.h
+++ b/cache.h
@@ -144,6 +144,7 @@ extern int ce_match_stat(struct cache_en
 extern int ce_modified(struct cache_entry *ce, struct stat *st);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type);
+extern int index_pipe(unsigned char *sha1, int fd, const char *type);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
diff --git a/sha1_file.c b/sha1_file.c
index 111a71d..0073187 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1528,6 +1528,33 @@ int has_sha1_file(const unsigned char *s
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
+int index_pipe(unsigned char *sha1, int fd, const char *type)
+{
+	unsigned long size = 4096;
+	char *buf = malloc(size);
+	int iret, ret;
+	unsigned long off = 0;
+	do {
+		iret = read(fd, buf + off, size - off);
+		if (iret > 0) {
+			off += iret;
+			if (off == size) {
+				size *= 2;
+				buf = realloc(buf, size);
+			}
+		}
+	} while (iret > 0);
+	if (iret < 0) {
+		free(buf);
+		return -1;
+	}
+	if (!type)
+		type = "blob";
+	ret = write_sha1_file(buf, off, type, sha1);
+	free(buf);
+	return ret;
+}
+
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type)
 {
 	unsigned long size = st->st_size;
diff --git a/update-index.c b/update-index.c
index 11b7f6a..f3d79af 100644
--- a/update-index.c
+++ b/update-index.c
@@ -24,6 +24,8 @@ static int info_only;
 static int force_remove;
 static int verbose;
 
+static char *single_name = NULL;
+
 /* Three functions to allow overloaded pointer return; see linux/err.h */
 static inline void *ERR_PTR(long error)
 {
@@ -117,6 +119,33 @@ static int add_file_to_cache(const char 
 	return 0;
 }
 
+
+static int add_stdin_to_cache(const char *path)
+{
+	int size, namelen, option;
+	struct cache_entry *ce;
+	struct stat st;
+
+	namelen = strlen(path);
+	size = cache_entry_size(namelen);
+	ce = xmalloc(size);
+	memset(ce, 0, size);
+	memcpy(ce->name, path, namelen);
+	ce->ce_mode = create_ce_mode(0100644);
+	ce->ce_flags = create_ce_flags(namelen, 0);
+
+	st.st_size = 0;
+	
+	if (index_pipe(ce->sha1, 0, NULL))
+		return -1;
+	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
+	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
+	if (add_cache_entry(ce, option))
+		return error("%s: cannot add to the index - missing --add option?",
+			     path);
+	return 0;
+}
+
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
@@ -396,7 +425,7 @@ static void read_index_info(int line_ter
 }
 
 static const char update_index_usage[] =
-"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--cacheinfo] [--chmod=(+|-)x] [--info-only] [--force-remove] [--stdin] [--index-info] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--cacheinfo] [--chmod=(+|-)x] [--info-only] [--force-remove] [--stdin] [--index-info] [--ignore-missing] [--name=<file>] [-z] [--verbose] [--] <file>...";
 
 int main(int argc, const char **argv)
 {
@@ -464,6 +493,10 @@ int main(int argc, const char **argv)
 					die("git-update-index: %s cannot chmod %s", path, argv[i]);
 				continue;
 			}
+			if (!strncmp(path, "--name=", strlen("--name="))) {
+				single_name = strdup(path + strlen("--name="));
+				continue;
+			}
 			if (!strcmp(path, "--info-only")) {
 				info_only = 1;
 				continue;
@@ -499,6 +532,8 @@ int main(int argc, const char **argv)
 				usage(update_index_usage);
 			die("unknown option %s", path);
 		}
+		if (single_name)
+			die("--name=<file> is incompatible with filenames");
 		update_one(path, prefix, prefix_length);
 	}
 	if (read_from_stdin) {
@@ -511,6 +546,9 @@ int main(int argc, const char **argv)
 			update_one(buf.buf, prefix, prefix_length);
 		}
 	}
+	if (single_name) {
+		add_stdin_to_cache(single_name);
+	}
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_index_file(&cache_file))
-- 
0.99.9.GIT
