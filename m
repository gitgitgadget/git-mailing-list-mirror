From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Operations on refs
Date: Mon, 6 Jun 2005 16:31:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506061627530.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:34:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfOIZ-0002Ec-1I
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 22:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVFFUgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVFFUfk
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 16:35:40 -0400
Received: from iabervon.org ([66.92.72.58]:55556 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261674AbVFFUcu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 16:32:50 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfOFt-0006YN-00; Mon, 6 Jun 2005 16:31:29 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds code to read a hash out of a specified file under
{GIT_DIR}/refs/, and to write such files atomically and optionally with an
compare and lock.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- 2dde8ae2d3300fb95e35facac622b9b54990624e/Makefile  (mode:100644 sha1:a5e7552e10bf50888814d43b1ba1a7276d130ca6)
+++ 9138b84eb683fc23a285445f7d7fc5a836ba01cb/Makefile  (mode:100644 sha1:c6e2eae2e68a47cdb88d2b1b7fec2c4cc230d506)
@@ -40,7 +40,7 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o
+	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o refs.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h
 
Index: cache.h
===================================================================
--- 2dde8ae2d3300fb95e35facac622b9b54990624e/cache.h  (mode:100644 sha1:481f7c787040aadbbea877adbb3b9a4fd5f9b9d0)
+++ 9138b84eb683fc23a285445f7d7fc5a836ba01cb/cache.h  (mode:100644 sha1:d2dbb0088b2a540972cd3c896d76b6c8dc1844ab)
@@ -110,6 +110,7 @@
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 
 extern char *get_object_directory(void);
+extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
Index: refs.c
===================================================================
--- /dev/null  (tree:2dde8ae2d3300fb95e35facac622b9b54990624e)
+++ 9138b84eb683fc23a285445f7d7fc5a836ba01cb/refs.c  (mode:100644 sha1:9973d1fc21e9d14f4cf1d30cb59f55cdfd7fc1e7)
@@ -0,0 +1,173 @@
+#include "refs.h"
+#include "cache.h"
+
+#include <errno.h>
+
+static char *ref_file_name(const char *ref)
+{
+	char *base = get_refs_directory();
+	int baselen = strlen(base);
+	int reflen = strlen(ref);
+	char *ret = xmalloc(baselen + 2 + reflen);
+	sprintf(ret, "%s/%s", base, ref);
+	return ret;
+}
+
+static char *ref_lock_file_name(const char *ref)
+{
+	char *base = get_refs_directory();
+	int baselen = strlen(base);
+	int reflen = strlen(ref);
+	char *ret = xmalloc(baselen + 7 + reflen);
+	sprintf(ret, "%s/%s.lock", base, ref);
+	return ret;
+}
+
+static int read_ref_file(const char *filename, unsigned char *sha1) {
+	int fd = open(filename, O_RDONLY);
+	char hex[41];
+	if (fd < 0) {
+		return error("Couldn't open %s\n", filename);
+	}
+	if ((read(fd, hex, 41) < 41) ||
+	    (hex[40] != '\n') ||
+	    get_sha1_hex(hex, sha1)) {
+		error("Couldn't read a hash from %s\n", filename);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	return 0;
+}
+
+int get_ref_sha1(const char *ref, unsigned char *sha1)
+{
+	char *filename;
+	int retval;
+	if (check_ref_format(ref))
+		return -1;
+	filename = ref_file_name(ref);
+	retval = read_ref_file(filename, sha1);
+	free(filename);
+	return retval;
+}
+
+static int lock_ref_file(const char *filename, const char *lock_filename,
+			 const unsigned char *old_sha1)
+{
+	int fd = open(lock_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	unsigned char current_sha1[20];
+	int retval;
+	if (fd < 0) {
+		return error("Couldn't open lock file for %s: %s",
+			     filename, strerror(errno));
+	}
+	retval = read_ref_file(filename, current_sha1);
+	if (old_sha1) {
+		if (retval) {
+			close(fd);
+			unlink(lock_filename);
+			return error("Could not read the current value of %s",
+				     filename);
+		}
+		if (memcmp(current_sha1, old_sha1, 20)) {
+			close(fd);
+			unlink(lock_filename);
+			error("The current value of %s is %s",
+			      filename, sha1_to_hex(current_sha1));
+			return error("Expected %s",
+				     sha1_to_hex(old_sha1));
+		}
+	} else {
+		if (!retval) {
+			close(fd);
+			unlink(lock_filename);
+			return error("Unexpectedly found a value of %s for %s",
+				     sha1_to_hex(current_sha1), filename);
+		}
+	}
+	return fd;
+}
+
+int lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
+{
+	char *filename;
+	char *lock_filename;
+	int retval;
+	if (check_ref_format(ref))
+		return -1;
+	filename = ref_file_name(ref);
+	lock_filename = ref_lock_file_name(ref);
+	retval = lock_ref_file(filename, lock_filename, old_sha1);
+	free(filename);
+	free(lock_filename);
+	return retval;
+}
+
+static int write_ref_file(const char *filename,
+			  const char *lock_filename, int fd,
+			  const unsigned char *sha1)
+{
+	char *hex = sha1_to_hex(sha1);
+	char term = '\n';
+	if (write(fd, hex, 40) < 40 ||
+	    write(fd, &term, 1) < 1) {
+		error("Couldn't write %s\n", filename);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	rename(lock_filename, filename);
+	return 0;
+}
+
+int write_ref_sha1(const char *ref, int fd, const unsigned char *sha1)
+{
+	char *filename;
+	char *lock_filename;
+	int retval;
+	if (fd < 0)
+		return -1;
+	if (check_ref_format(ref))
+		return -1;
+	filename = ref_file_name(ref);
+	lock_filename = ref_lock_file_name(ref);
+	retval = write_ref_file(filename, lock_filename, fd, sha1);
+	free(filename);
+	free(lock_filename);
+	return retval;
+}
+
+int check_ref_format(const char *ref)
+{
+	char *middle;
+	if (ref[0] == '.' || ref[0] == '/')
+		return -1;
+	middle = strchr(ref, '/');
+	if (!middle || !middle[1])
+		return -1;
+	if (strchr(middle + 1, '/'))
+		return -1;
+	return 0;
+}
+
+int write_ref_sha1_unlocked(const char *ref, const unsigned char *sha1)
+{
+	char *filename;
+	char *lock_filename;
+	int fd;
+	int retval;
+	if (check_ref_format(ref))
+		return -1;
+	filename = ref_file_name(ref);
+	lock_filename = ref_lock_file_name(ref);
+	fd = open(lock_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		error("Writing %s", lock_filename);
+		perror("Open");
+	}
+	retval = write_ref_file(filename, lock_filename, fd, sha1);
+	free(filename);
+	free(lock_filename);
+	return retval;
+}
Index: refs.h
===================================================================
--- /dev/null  (tree:2dde8ae2d3300fb95e35facac622b9b54990624e)
+++ 9138b84eb683fc23a285445f7d7fc5a836ba01cb/refs.h  (mode:100644 sha1:60cf48086f61c9206a343425ba9fdae3dce62937)
@@ -0,0 +1,21 @@
+#ifndef REFS_H
+#define REFS_H
+
+/** Reads the refs file specified into sha1 **/
+extern int get_ref_sha1(const char *ref, unsigned char *sha1);
+
+/** Locks ref and returns the fd to give to write_ref_sha1() if the ref
+ * has the given value currently; otherwise, returns -1.
+ **/
+extern int lock_ref_sha1(const char *ref, const unsigned char *old_sha1);
+
+/** Writes sha1 into the refs file specified, locked with the given fd. **/
+extern int write_ref_sha1(const char *ref, int fd, const unsigned char *sha1);
+
+/** Writes sha1 into the refs file specified. **/
+extern int write_ref_sha1_unlocked(const char *ref, const unsigned char *sha1);
+
+/** Returns 0 if target has the right format for a ref. **/
+extern int check_ref_format(const char *target);
+
+#endif /* REFS_H */
Index: sha1_file.c
===================================================================
--- 2dde8ae2d3300fb95e35facac622b9b54990624e/sha1_file.c  (mode:100644 sha1:a2ba4c81dba1b55b119d9ec3c42a7e4ce4ca1df5)
+++ 9138b84eb683fc23a285445f7d7fc5a836ba01cb/sha1_file.c  (mode:100644 sha1:7cfd43c51ba20ee85fe6056c67bbc88cc90dad81)
@@ -58,7 +58,7 @@
 	return get_sha1_hex(buffer, result);
 }
 
-static char *git_dir, *git_object_dir, *git_index_file;
+static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir;
 static void setup_git_env(void)
 {
 	git_dir = gitenv(GIT_DIR_ENVIRONMENT);
@@ -69,6 +69,8 @@
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
+	git_refs_dir = xmalloc(strlen(git_dir) + 6);
+	sprintf(git_refs_dir, "%s/refs", git_dir);
 	git_index_file = gitenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
@@ -83,6 +85,13 @@
 	return git_object_dir;
 }
 
+char *get_refs_directory(void)
+{
+	if (!git_refs_dir)
+		setup_git_env();
+	return git_refs_dir;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)

