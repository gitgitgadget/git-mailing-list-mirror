From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [1/2] Library support for refs/
Date: Sun, 1 May 2005 17:52:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011750050.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505011746230.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:53:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSMNh-00052E-0q
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVEAV6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVEAV5J
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:57:09 -0400
Received: from iabervon.org ([66.92.72.58]:48900 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262718AbVEAVxC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 17:53:02 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSMMy-0002Qy-00; Sun, 1 May 2005 17:52:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0505011746230.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This includes three things: in init, create .git/refs/; a function to read
a refs file; and a function to write a refs file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- bab2f51e8218b023728539c7841ee7613ebd36e8/Makefile  (mode:100644 sha1:a3028efd80a4165ade03158361e0224fb46364f5)
+++ f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/Makefile  (mode:100644 sha1:e43a1db55962c771cc934227213d6520939bd0ce)
@@ -29,9 +29,10 @@
 	install $(PROG) $(SCRIPTS) $(HOME)/bin/
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o refs.o
+
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h refs.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
Index: cache.h
===================================================================
--- bab2f51e8218b023728539c7841ee7613ebd36e8/cache.h  (mode:100644 sha1:af6345820f3f8c533868394059b2d3b189e6b422)
+++ f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/cache.h  (mode:100644 sha1:42a08f57c5b7a7cd013ab3e99f3965014068b787)
@@ -100,6 +100,11 @@
 
 #define get_object_directory() (getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT)
 
+#define REF_ENVIRONMENT "REF_FILE_DIRECTORY"
+#define DEFAULT_REF_ENVIRONMENT ".git/refs"
+
+#define get_refs_directory() (getenv(REF_ENVIRONMENT) ? : DEFAULT_REF_ENVIRONMENT)
+
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define DEFAULT_INDEX_ENVIRONMENT ".git/index"
 
Index: init-db.c
===================================================================
--- bab2f51e8218b023728539c7841ee7613ebd36e8/init-db.c  (mode:100644 sha1:83f95e8b926f4fd28e0db0ccfc4f040d4172ee8a)
+++ f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/init-db.c  (mode:100644 sha1:6bed5a6abdfd7da152ed13b825376c2d2f8820c4)
@@ -38,6 +38,7 @@
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
+	safe_create_dir(get_refs_directory());
 	for (i = 0; i < 256; i++) {
 		sprintf(path+len, "/%02x", i);
 		safe_create_dir(path);
Index: refs.c
===================================================================
--- /dev/null  (tree:bab2f51e8218b023728539c7841ee7613ebd36e8)
+++ f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/refs.c  (mode:100644 sha1:9ba5696c15d8597236e1f5b7a4dbd609045efc81)
@@ -0,0 +1,139 @@
+#include "refs.h"
+#include "cache.h"
+
+#include <errno.h>
+
+static char *split_ref_file_name(const char *dir, const char *name)
+{
+	char *base = get_refs_directory();
+	int baselen = strlen(base);
+	int dirlen = strlen(dir);
+	int namelen = strlen(name);
+	char *ret;
+	if (dir[0] == '.')
+		return NULL;
+	if (strchr(dir, '/'))
+		return NULL;
+	if (strchr(name, '/'))
+		return NULL;
+	ret = xmalloc(baselen + 3 + dirlen + namelen);
+	strcpy(ret, base);
+	ret[baselen] = '/';
+	strcpy(ret + baselen + 1, dir);
+	ret[baselen + 1 + dirlen] = '/';
+	strcpy(ret + baselen + 2 + dirlen, name);
+	ret[baselen + 2 + dirlen + namelen] = '\0';
+	return ret;
+}
+
+static char *ref_file_name(const char *ref)
+{
+	char *base = get_refs_directory();
+	int baselen = strlen(base);
+	int reflen = strlen(ref);
+	char *ret;
+	char *check;
+	if (ref[0] == '.')
+		return NULL;
+	check = strchr(ref, '/');
+	if (!check)
+		return NULL;
+	if (strchr(check + 1, '/'))
+		return NULL;
+	ret = xmalloc(baselen + 2 + reflen);
+	strcpy(ret, base);
+	ret[baselen] = '/';
+	strcpy(ret + baselen + 1, ref);
+	ret[baselen + 1 + reflen] = '\0';
+	return ret;
+}
+
+static int read_ref_file(char *filename, unsigned char *sha1) {
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
+int get_split_ref_sha1(const char *dir, const char *name, unsigned char *sha1)
+{
+	char *filename = split_ref_file_name(dir, name);
+	int retval;
+	if (!filename)
+		return -1;
+	retval = read_ref_file(filename, sha1);
+	free(filename);
+	return retval;
+}
+
+int get_ref_sha1(const char *ref, unsigned char *sha1)
+{
+	char *filename = ref_file_name(ref);
+	int retval;
+	if (!filename)
+		return -1;
+	retval = read_ref_file(filename, sha1);
+	free(filename);
+	return retval;
+}
+
+int write_split_ref_sha1(const char *dir, const char *name,
+			 unsigned char *sha1)
+{
+	char *filename = split_ref_file_name(dir, name);
+	char *hex = sha1_to_hex(sha1);
+	char term = '\n';
+	int fd;
+	if (!filename)
+		return -1;
+	unlink(filename);
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0 && errno == ENOENT) {
+		char *dirname = split_ref_file_name(dir, "");
+		mkdir(dirname, 0755);
+		free(dirname);
+		fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+	if (fd < 0) {
+		error("Couldn't open for writing %s: %s\n", filename,
+		      strerror(errno));
+		free(filename);
+		return -1;
+	}
+	if (write(fd, hex, 40) < 40 ||
+	    write(fd, &term, 1) < 1) {
+		error("Couldn't write %s\n", filename);
+		free(filename);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	return 0;
+	
+}
+
+int split_ref(char **dir, char **name, const char *ref)
+{
+	char *middle = strchr(ref, '/');
+	if (ref[0] == '.')
+		return -1;
+	if (!middle)
+		return -1;
+	if (strchr(middle + 1, '/'))
+		return -1;
+	*dir = xmalloc(middle - ref + 1);
+	*name = strdup(middle + 1);
+	(*dir)[middle - ref] = '\0';
+	memcpy(*dir, ref, middle - ref);
+	return 0;
+}
Index: refs.h
===================================================================
--- /dev/null  (tree:bab2f51e8218b023728539c7841ee7613ebd36e8)
+++ f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/refs.h  (mode:100644 sha1:9ef6ed7563f70273aef6574a01d5626fee28345a)
@@ -0,0 +1,20 @@
+#ifndef REFS_H
+#define REFS_H
+
+/** Reads the refs file specified into sha1 **/
+extern int get_split_ref_sha1(const char *dir, const char *name,
+			      unsigned char *sha1);
+
+/** Reads the refs file specified into sha1 **/
+extern int get_ref_sha1(const char *ref, unsigned char *sha1);
+
+/** Writes sha1 into the refs file specified **/
+extern int write_split_ref_sha1(const char *dir, const char *name, 
+				unsigned char *sha1);
+
+/** Sets dir and name to the directory and name parts of ref, in new
+ * storage. 
+ **/
+extern int split_ref(char **dir, char **name, const char *ref);
+
+#endif /* REFS_H */

