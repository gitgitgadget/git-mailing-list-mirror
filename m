From: Linus Torvalds <torvalds@osdl.org>
Subject: Start handling references internally as a sorted in-memory list
Date: Mon, 11 Sep 2006 16:37:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 01:37:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMvLY-0005Te-CC
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 01:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWIKXhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWIKXhm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 19:37:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965133AbWIKXhk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 19:37:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8BNbXnW003602
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Sep 2006 16:37:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8BNbWNm000322;
	Mon, 11 Sep 2006 16:37:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
X-Spam-Status: No, hits=-3.515 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26866>


This also adds some very rudimentary support for the notion of packed
refs.  HOWEVER! At this point it isn't used to actually look up a ref
yet, only for listing them (ie "for_each_ref()" and friends see the
packed refs, but none of the other single-ref lookup routines).

Note how we keep two separate lists: one for the loose refs, and one for 
the packed refs we read. That's so that we can easily keep the two apart, 
and read only one set or the other (and still always make sure that the 
loose refs take precedence).

[ From this, it's not actually obvious why we'd keep the two separate 
  lists, but it's important to have the packed refs on their own list 
  later on, when I add support for looking up a single loose one.

  For that case, we will want to read _just_ the packed refs in case the 
  single-ref lookup fails, yet we may end up needing the other list at 
  some point in the future, so keeping them separated is important ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

This passes all the tests, but largely because it doesn't yet actually use 
and test the ref-packing code. The code exists, but it doesn't remove old 
refs yet. It will be easy enough to do with this background code, though: 
I think this is all set up to be reasonably efficient.

And yeah, I know that the "sorting" code is O(n**2) thanks to doing an 
insertion sort into a simple linked list. Tough. I didn't care enough to 
do it well. With "n" usually being a few hundred at most, we really don't 
care, and if we ever do, we _can_ fix it later on to use a heap or 
something.

diff --git a/Makefile b/Makefile
index 7b3114f..5a2e946 100644
--- a/Makefile
+++ b/Makefile
@@ -295,7 +295,8 @@ BUILTIN_OBJS = \
 	builtin-upload-tar.o \
 	builtin-verify-pack.o \
 	builtin-write-tree.o \
-	builtin-zip-tree.o
+	builtin-zip-tree.o \
+	builtin-pack-refs.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
new file mode 100644
index 0000000..0f5d827
--- /dev/null
+++ b/builtin-pack-refs.c
@@ -0,0 +1,41 @@
+#include "cache.h"
+#include "refs.h"
+
+static FILE *refs_file;
+static const char *result_path, *lock_path;
+
+static void remove_lock_file(void)
+{
+	if (lock_path)
+		unlink(lock_path);
+}
+
+static int handle_one_ref(const char *path, const unsigned char *sha1)
+{
+	fprintf(refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	return 0;
+}
+
+int cmd_pack_refs(int argc, const char **argv, const char *prefix)
+{
+	int fd;
+
+	result_path = xstrdup(git_path("packed-refs"));
+	lock_path = xstrdup(mkpath("%s.lock", result_path));
+
+	fd = open(lock_path, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	if (fd < 0)
+		die("unable to create new ref-pack file (%s)", strerror(errno));
+	atexit(remove_lock_file);
+
+	refs_file = fdopen(fd, "w");
+	if (!refs_file)
+		die("unable to create ref-pack file structure (%s)", strerror(errno));
+	for_each_ref(handle_one_ref);
+	fsync(fd);
+	fclose(refs_file);
+	if (rename(lock_path, result_path) < 0)
+		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
+	lock_path = NULL;
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..34ed7b9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -61,5 +61,6 @@ extern int cmd_version(int argc, const c
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index 335f405..63d1ba3 100644
--- a/git.c
+++ b/git.c
@@ -266,6 +266,7 @@ static void handle_internal_command(int 
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
 		{ "verify-pack", cmd_verify_pack },
+		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	};
 	int i;
 
diff --git a/refs.c b/refs.c
index 5e65314..5f80a68 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,145 @@ #include "cache.h"
 
 #include <errno.h>
 
+struct ref_list {
+	struct ref_list *next;
+	unsigned char sha1[20];
+	char name[FLEX_ARRAY];
+};
+
+static const char *parse_ref_line(char *line, unsigned char *sha1)
+{
+	/*
+	 * 42: the answer to everything.
+	 *
+	 * In this case, it happens to be the answer to
+	 *  40 (length of sha1 hex representation)
+	 *  +1 (space in between hex and name)
+	 *  +1 (newline at the end of the line)
+	 */
+	int len = strlen(line) - 42;
+
+	if (len <= 0)
+		return NULL;
+	if (get_sha1_hex(line, sha1) < 0)
+		return NULL;
+	if (!isspace(line[40]))
+		return NULL;
+	line += 41;
+	if (line[len] != '\n')
+		return NULL;
+	line[len] = 0;
+	return line;
+}
+
+static struct ref_list *add_ref(const char *name, const unsigned char *sha1, struct ref_list *list)
+{
+	int len;
+	struct ref_list **p = &list, *entry;
+
+	/* Find the place to insert the ref into.. */
+	while ((entry = *p) != NULL) {
+		int cmp = strcmp(entry->name, name);
+		if (cmp > 0)
+			break;
+
+		/* Same as existing entry? */
+		if (!cmp)
+			return list;
+		p = &entry->next;
+	}
+
+	/* Allocate it and add it in.. */
+	len = strlen(name) + 1;
+	entry = xmalloc(sizeof(struct ref_list) + len);
+	hashcpy(entry->sha1, sha1);
+	memcpy(entry->name, name, len);
+	entry->next = *p;
+	*p = entry;
+	return list;
+}
+
+static struct ref_list *get_packed_refs(void)
+{
+	static int did_refs = 0;
+	static struct ref_list *refs = NULL;
+
+	if (!did_refs) {
+		FILE *f = fopen(git_path("packed-refs"), "r");
+		if (f) {
+			struct ref_list *list = NULL;
+			char refline[PATH_MAX];
+			while (fgets(refline, sizeof(refline), f)) {
+				unsigned char sha1[20];
+				const char *name = parse_ref_line(refline, sha1);
+				if (!name)
+					continue;
+				list = add_ref(name, sha1, list);
+			}
+			fclose(f);
+			refs = list;
+		}
+		did_refs = 1;
+	}
+	return refs;
+}
+
+static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
+{
+	DIR *dir = opendir(git_path("%s", base));
+
+	if (dir) {
+		struct dirent *de;
+		int baselen = strlen(base);
+		char *path = xmalloc(baselen + 257);
+
+		memcpy(path, base, baselen);
+		if (baselen && base[baselen-1] != '/')
+			path[baselen++] = '/';
+
+		while ((de = readdir(dir)) != NULL) {
+			unsigned char sha1[20];
+			struct stat st;
+			int namelen;
+
+			if (de->d_name[0] == '.')
+				continue;
+			namelen = strlen(de->d_name);
+			if (namelen > 255)
+				continue;
+			if (has_extension(de->d_name, ".lock"))
+				continue;
+			memcpy(path + baselen, de->d_name, namelen+1);
+			if (stat(git_path("%s", path), &st) < 0)
+				continue;
+			if (S_ISDIR(st.st_mode)) {
+				list = get_ref_dir(path, list);
+				continue;
+			}
+			if (read_ref(git_path("%s", path), sha1) < 0) {
+				error("%s points nowhere!", path);
+				continue;
+			}
+			list = add_ref(path, sha1, list);
+		}
+		free(path);
+		closedir(dir);
+	}
+	return list;
+}
+
+static struct ref_list *get_loose_refs(void)
+{
+	static int did_refs = 0;
+	static struct ref_list *refs = NULL;
+
+	if (!did_refs) {
+		refs = get_ref_dir("refs", NULL);
+		did_refs = 1;
+	}
+	return refs;
+}
+
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
@@ -121,60 +260,41 @@ int read_ref(const char *filename, unsig
 
 static int do_for_each_ref(const char *base, int (*fn)(const char *path, const unsigned char *sha1), int trim)
 {
-	int retval = 0;
-	DIR *dir = opendir(git_path("%s", base));
-
-	if (dir) {
-		struct dirent *de;
-		int baselen = strlen(base);
-		char *path = xmalloc(baselen + 257);
-
-		if (!strncmp(base, "./", 2)) {
-			base += 2;
-			baselen -= 2;
+	int retval;
+	struct ref_list *packed = get_packed_refs();
+	struct ref_list *loose = get_loose_refs();
+
+	while (packed && loose) {
+		struct ref_list *entry;
+		int cmp = strcmp(packed->name, loose->name);
+		if (!cmp) {
+			packed = packed->next;
+			continue;
 		}
-		memcpy(path, base, baselen);
-		if (baselen && base[baselen-1] != '/')
-			path[baselen++] = '/';
-
-		while ((de = readdir(dir)) != NULL) {
-			unsigned char sha1[20];
-			struct stat st;
-			int namelen;
+		if (cmp > 0) {
+			entry = loose;
+			loose = loose->next;
+		} else {
+			entry = packed;
+			packed = packed->next;
+		}
+		if (strncmp(base, entry->name, trim))
+			continue;
+		retval = fn(entry->name + trim, entry->sha1);
+		if (retval)
+			return retval;
+	}
 
-			if (de->d_name[0] == '.')
-				continue;
-			namelen = strlen(de->d_name);
-			if (namelen > 255)
-				continue;
-			if (has_extension(de->d_name, ".lock"))
-				continue;
-			memcpy(path + baselen, de->d_name, namelen+1);
-			if (stat(git_path("%s", path), &st) < 0)
-				continue;
-			if (S_ISDIR(st.st_mode)) {
-				retval = do_for_each_ref(path, fn, trim);
-				if (retval)
-					break;
-				continue;
-			}
-			if (read_ref(git_path("%s", path), sha1) < 0) {
-				error("%s points nowhere!", path);
-				continue;
-			}
-			if (!has_sha1_file(sha1)) {
-				error("%s does not point to a valid "
-				      "commit object!", path);
-				continue;
-			}
-			retval = fn(path + trim, sha1);
+	packed = packed ? packed : loose;
+	while (packed) {
+		if (!strncmp(base, packed->name, trim)) {
+			retval = fn(packed->name + trim, packed->sha1);
 			if (retval)
-				break;
+				return retval;
 		}
-		free(path);
-		closedir(dir);
+		packed = packed->next;
 	}
-	return retval;
+	return 0;
 }
 
 int head_ref(int (*fn)(const char *path, const unsigned char *sha1))
@@ -187,22 +307,22 @@ int head_ref(int (*fn)(const char *path,
 
 int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
-	return do_for_each_ref("refs", fn, 0);
+	return do_for_each_ref("refs/", fn, 0);
 }
 
 int for_each_tag_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
-	return do_for_each_ref("refs/tags", fn, 10);
+	return do_for_each_ref("refs/tags/", fn, 10);
 }
 
 int for_each_branch_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
-	return do_for_each_ref("refs/heads", fn, 11);
+	return do_for_each_ref("refs/heads/", fn, 11);
 }
 
 int for_each_remote_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
-	return do_for_each_ref("refs/remotes", fn, 13);
+	return do_for_each_ref("refs/remotes/", fn, 13);
 }
 
 int get_ref_sha1(const char *ref, unsigned char *sha1)
