From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Move convert-objects to contrib.
Date: Mon, 24 Sep 2007 20:14:21 -0700
Message-ID: <1190690061-6720-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 05:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia0sh-0003id-I8
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 05:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbXIYDOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 23:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbXIYDOc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 23:14:32 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:58953 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbXIYDOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 23:14:31 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1Ia19G-0000VY-8s; Mon, 24 Sep 2007 20:31:51 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1Ia0sP-0001ke-N2; Mon, 24 Sep 2007 20:14:21 -0700
X-Mailer: git-send-email 1.5.3.2
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59087>


Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 .gitignore                                      |    1 -
 Documentation/cmd-list.perl                     |    1 -
 Documentation/git-convert-objects.txt           |   28 --
 Makefile                                        |    2 +-
 contrib/completion/git-completion.bash          |    1 -
 contrib/convert-objects/convert-objects.c       |  329 +++++++++++++++++++++++
 contrib/convert-objects/git-convert-objects.txt |   28 ++
 convert-objects.c                               |  329 -----------------------
 8 files changed, 358 insertions(+), 361 deletions(-)
 delete mode 100644 Documentation/git-convert-objects.txt
 create mode 100644 contrib/convert-objects/convert-objects.c
 create mode 100644 contrib/convert-objects/git-convert-objects.txt
 delete mode 100644 convert-objects.c

diff --git a/.gitignore b/.gitignore
index 63c918c..e0b91be 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,7 +25,6 @@ git-clone
 git-commit
 git-commit-tree
 git-config
-git-convert-objects
 git-count-objects
 git-cvsexportcommit
 git-cvsimport
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 4ee76ea..1061fd8 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -94,7 +94,6 @@ git-clone                               mainporcelain
 git-commit                              mainporcelain
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
-git-convert-objects                     ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
diff --git a/Documentation/git-convert-objects.txt b/Documentation/git-convert-objects.txt
deleted file mode 100644
index 9718abf..0000000
--- a/Documentation/git-convert-objects.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-git-convert-objects(1)
-======================
-
-NAME
-----
-git-convert-objects - Converts old-style git repository
-
-
-SYNOPSIS
---------
-'git-convert-objects'
-
-DESCRIPTION
------------
-Converts old-style git repository to the latest format
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 0055eef..94b16d0 100644
--- a/Makefile
+++ b/Makefile
@@ -233,7 +233,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
-	git-convert-objects$X git-fetch-pack$X \
+	git-fetch-pack$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-fast-import$X \
 	git-daemon$X \
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cad842a..e760930 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -299,7 +299,6 @@ __git_commands ()
 		check-attr)       : plumbing;;
 		check-ref-format) : plumbing;;
 		commit-tree)      : plumbing;;
-		convert-objects)  : plumbing;;
 		cvsexportcommit)  : export;;
 		cvsimport)        : import;;
 		cvsserver)        : daemon;;
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
new file mode 100644
index 0000000..90e7900
--- /dev/null
+++ b/contrib/convert-objects/convert-objects.c
@@ -0,0 +1,329 @@
+#include "cache.h"
+#include "blob.h"
+#include "commit.h"
+#include "tree.h"
+
+struct entry {
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
+	int converted;
+};
+
+#define MAXOBJECTS (1000000)
+
+static struct entry *convert[MAXOBJECTS];
+static int nr_convert;
+
+static struct entry * convert_entry(unsigned char *sha1);
+
+static struct entry *insert_new(unsigned char *sha1, int pos)
+{
+	struct entry *new = xcalloc(1, sizeof(struct entry));
+	hashcpy(new->old_sha1, sha1);
+	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
+	convert[pos] = new;
+	nr_convert++;
+	if (nr_convert == MAXOBJECTS)
+		die("you're kidding me - hit maximum object limit");
+	return new;
+}
+
+static struct entry *lookup_entry(unsigned char *sha1)
+{
+	int low = 0, high = nr_convert;
+
+	while (low < high) {
+		int next = (low + high) / 2;
+		struct entry *n = convert[next];
+		int cmp = hashcmp(sha1, n->old_sha1);
+		if (!cmp)
+			return n;
+		if (cmp < 0) {
+			high = next;
+			continue;
+		}
+		low = next+1;
+	}
+	return insert_new(sha1, low);
+}
+
+static void convert_binary_sha1(void *buffer)
+{
+	struct entry *entry = convert_entry(buffer);
+	hashcpy(buffer, entry->new_sha1);
+}
+
+static void convert_ascii_sha1(void *buffer)
+{
+	unsigned char sha1[20];
+	struct entry *entry;
+
+	if (get_sha1_hex(buffer, sha1))
+		die("expected sha1, got '%s'", (char*) buffer);
+	entry = convert_entry(sha1);
+	memcpy(buffer, sha1_to_hex(entry->new_sha1), 40);
+}
+
+static unsigned int convert_mode(unsigned int mode)
+{
+	unsigned int newmode;
+
+	newmode = mode & S_IFMT;
+	if (S_ISREG(mode))
+		newmode |= (mode & 0100) ? 0755 : 0644;
+	return newmode;
+}
+
+static int write_subdirectory(void *buffer, unsigned long size, const char *base, int baselen, unsigned char *result_sha1)
+{
+	char *new = xmalloc(size);
+	unsigned long newlen = 0;
+	unsigned long used;
+
+	used = 0;
+	while (size) {
+		int len = 21 + strlen(buffer);
+		char *path = strchr(buffer, ' ');
+		unsigned char *sha1;
+		unsigned int mode;
+		char *slash, *origpath;
+
+		if (!path || strtoul_ui(buffer, 8, &mode))
+			die("bad tree conversion");
+		mode = convert_mode(mode);
+		path++;
+		if (memcmp(path, base, baselen))
+			break;
+		origpath = path;
+		path += baselen;
+		slash = strchr(path, '/');
+		if (!slash) {
+			newlen += sprintf(new + newlen, "%o %s", mode, path);
+			new[newlen++] = '\0';
+			hashcpy((unsigned char*)new + newlen, (unsigned char *) buffer + len - 20);
+			newlen += 20;
+
+			used += len;
+			size -= len;
+			buffer = (char *) buffer + len;
+			continue;
+		}
+
+		newlen += sprintf(new + newlen, "%o %.*s", S_IFDIR, (int)(slash - path), path);
+		new[newlen++] = 0;
+		sha1 = (unsigned char *)(new + newlen);
+		newlen += 20;
+
+		len = write_subdirectory(buffer, size, origpath, slash-origpath+1, sha1);
+
+		used += len;
+		size -= len;
+		buffer = (char *) buffer + len;
+	}
+
+	write_sha1_file(new, newlen, tree_type, result_sha1);
+	free(new);
+	return used;
+}
+
+static void convert_tree(void *buffer, unsigned long size, unsigned char *result_sha1)
+{
+	void *orig_buffer = buffer;
+	unsigned long orig_size = size;
+
+	while (size) {
+		size_t len = 1+strlen(buffer);
+
+		convert_binary_sha1((char *) buffer + len);
+
+		len += 20;
+		if (len > size)
+			die("corrupt tree object");
+		size -= len;
+		buffer = (char *) buffer + len;
+	}
+
+	write_subdirectory(orig_buffer, orig_size, "", 0, result_sha1);
+}
+
+static unsigned long parse_oldstyle_date(const char *buf)
+{
+	char c, *p;
+	char buffer[100];
+	struct tm tm;
+	const char *formats[] = {
+		"%c",
+		"%a %b %d %T",
+		"%Z",
+		"%Y",
+		" %Y",
+		NULL
+	};
+	/* We only ever did two timezones in the bad old format .. */
+	const char *timezones[] = {
+		"PDT", "PST", "CEST", NULL
+	};
+	const char **fmt = formats;
+
+	p = buffer;
+	while (isspace(c = *buf))
+		buf++;
+	while ((c = *buf++) != '\n')
+		*p++ = c;
+	*p++ = 0;
+	buf = buffer;
+	memset(&tm, 0, sizeof(tm));
+	do {
+		const char *next = strptime(buf, *fmt, &tm);
+		if (next) {
+			if (!*next)
+				return mktime(&tm);
+			buf = next;
+		} else {
+			const char **p = timezones;
+			while (isspace(*buf))
+				buf++;
+			while (*p) {
+				if (!memcmp(buf, *p, strlen(*p))) {
+					buf += strlen(*p);
+					break;
+				}
+				p++;
+			}
+		}
+		fmt++;
+	} while (*buf && *fmt);
+	printf("left: %s\n", buf);
+	return mktime(&tm);
+}
+
+static int convert_date_line(char *dst, void **buf, unsigned long *sp)
+{
+	unsigned long size = *sp;
+	char *line = *buf;
+	char *next = strchr(line, '\n');
+	char *date = strchr(line, '>');
+	int len;
+
+	if (!next || !date)
+		die("missing or bad author/committer line %s", line);
+	next++; date += 2;
+
+	*buf = next;
+	*sp = size - (next - line);
+
+	len = date - line;
+	memcpy(dst, line, len);
+	dst += len;
+
+	/* Is it already in new format? */
+	if (isdigit(*date)) {
+		int datelen = next - date;
+		memcpy(dst, date, datelen);
+		return len + datelen;
+	}
+
+	/*
+	 * Hacky hacky: one of the sparse old-style commits does not have
+	 * any date at all, but we can fake it by using the committer date.
+	 */
+	if (*date == '\n' && strchr(next, '>'))
+		date = strchr(next, '>')+2;
+
+	return len + sprintf(dst, "%lu -0700\n", parse_oldstyle_date(date));
+}
+
+static void convert_date(void *buffer, unsigned long size, unsigned char *result_sha1)
+{
+	char *new = xmalloc(size + 100);
+	unsigned long newlen = 0;
+
+	/* "tree <sha1>\n" */
+	memcpy(new + newlen, buffer, 46);
+	newlen += 46;
+	buffer = (char *) buffer + 46;
+	size -= 46;
+
+	/* "parent <sha1>\n" */
+	while (!memcmp(buffer, "parent ", 7)) {
+		memcpy(new + newlen, buffer, 48);
+		newlen += 48;
+		buffer = (char *) buffer + 48;
+		size -= 48;
+	}
+
+	/* "author xyz <xyz> date" */
+	newlen += convert_date_line(new + newlen, &buffer, &size);
+	/* "committer xyz <xyz> date" */
+	newlen += convert_date_line(new + newlen, &buffer, &size);
+
+	/* Rest */
+	memcpy(new + newlen, buffer, size);
+	newlen += size;
+
+	write_sha1_file(new, newlen, commit_type, result_sha1);
+	free(new);
+}
+
+static void convert_commit(void *buffer, unsigned long size, unsigned char *result_sha1)
+{
+	void *orig_buffer = buffer;
+	unsigned long orig_size = size;
+
+	if (memcmp(buffer, "tree ", 5))
+		die("Bad commit '%s'", (char*) buffer);
+	convert_ascii_sha1((char *) buffer + 5);
+	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
+	while (!memcmp(buffer, "parent ", 7)) {
+		convert_ascii_sha1((char *) buffer + 7);
+		buffer = (char *) buffer + 48;
+	}
+	convert_date(orig_buffer, orig_size, result_sha1);
+}
+
+static struct entry * convert_entry(unsigned char *sha1)
+{
+	struct entry *entry = lookup_entry(sha1);
+	enum object_type type;
+	void *buffer, *data;
+	unsigned long size;
+
+	if (entry->converted)
+		return entry;
+	data = read_sha1_file(sha1, &type, &size);
+	if (!data)
+		die("unable to read object %s", sha1_to_hex(sha1));
+
+	buffer = xmalloc(size);
+	memcpy(buffer, data, size);
+
+	if (type == OBJ_BLOB) {
+		write_sha1_file(buffer, size, blob_type, entry->new_sha1);
+	} else if (type == OBJ_TREE)
+		convert_tree(buffer, size, entry->new_sha1);
+	else if (type == OBJ_COMMIT)
+		convert_commit(buffer, size, entry->new_sha1);
+	else
+		die("unknown object type %d in %s", type, sha1_to_hex(sha1));
+	entry->converted = 1;
+	free(buffer);
+	free(data);
+	return entry;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1[20];
+	struct entry *entry;
+
+	setup_git_directory();
+
+	if (argc != 2)
+		usage("git-convert-objects <sha1>");
+	if (get_sha1(argv[1], sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	entry = convert_entry(sha1);
+	printf("new sha1: %s\n", sha1_to_hex(entry->new_sha1));
+	return 0;
+}
diff --git a/contrib/convert-objects/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
new file mode 100644
index 0000000..9718abf
--- /dev/null
+++ b/contrib/convert-objects/git-convert-objects.txt
@@ -0,0 +1,28 @@
+git-convert-objects(1)
+======================
+
+NAME
+----
+git-convert-objects - Converts old-style git repository
+
+
+SYNOPSIS
+--------
+'git-convert-objects'
+
+DESCRIPTION
+-----------
+Converts old-style git repository to the latest format
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/convert-objects.c b/convert-objects.c
deleted file mode 100644
index 90e7900..0000000
--- a/convert-objects.c
+++ /dev/null
@@ -1,329 +0,0 @@
-#include "cache.h"
-#include "blob.h"
-#include "commit.h"
-#include "tree.h"
-
-struct entry {
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
-	int converted;
-};
-
-#define MAXOBJECTS (1000000)
-
-static struct entry *convert[MAXOBJECTS];
-static int nr_convert;
-
-static struct entry * convert_entry(unsigned char *sha1);
-
-static struct entry *insert_new(unsigned char *sha1, int pos)
-{
-	struct entry *new = xcalloc(1, sizeof(struct entry));
-	hashcpy(new->old_sha1, sha1);
-	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
-	convert[pos] = new;
-	nr_convert++;
-	if (nr_convert == MAXOBJECTS)
-		die("you're kidding me - hit maximum object limit");
-	return new;
-}
-
-static struct entry *lookup_entry(unsigned char *sha1)
-{
-	int low = 0, high = nr_convert;
-
-	while (low < high) {
-		int next = (low + high) / 2;
-		struct entry *n = convert[next];
-		int cmp = hashcmp(sha1, n->old_sha1);
-		if (!cmp)
-			return n;
-		if (cmp < 0) {
-			high = next;
-			continue;
-		}
-		low = next+1;
-	}
-	return insert_new(sha1, low);
-}
-
-static void convert_binary_sha1(void *buffer)
-{
-	struct entry *entry = convert_entry(buffer);
-	hashcpy(buffer, entry->new_sha1);
-}
-
-static void convert_ascii_sha1(void *buffer)
-{
-	unsigned char sha1[20];
-	struct entry *entry;
-
-	if (get_sha1_hex(buffer, sha1))
-		die("expected sha1, got '%s'", (char*) buffer);
-	entry = convert_entry(sha1);
-	memcpy(buffer, sha1_to_hex(entry->new_sha1), 40);
-}
-
-static unsigned int convert_mode(unsigned int mode)
-{
-	unsigned int newmode;
-
-	newmode = mode & S_IFMT;
-	if (S_ISREG(mode))
-		newmode |= (mode & 0100) ? 0755 : 0644;
-	return newmode;
-}
-
-static int write_subdirectory(void *buffer, unsigned long size, const char *base, int baselen, unsigned char *result_sha1)
-{
-	char *new = xmalloc(size);
-	unsigned long newlen = 0;
-	unsigned long used;
-
-	used = 0;
-	while (size) {
-		int len = 21 + strlen(buffer);
-		char *path = strchr(buffer, ' ');
-		unsigned char *sha1;
-		unsigned int mode;
-		char *slash, *origpath;
-
-		if (!path || strtoul_ui(buffer, 8, &mode))
-			die("bad tree conversion");
-		mode = convert_mode(mode);
-		path++;
-		if (memcmp(path, base, baselen))
-			break;
-		origpath = path;
-		path += baselen;
-		slash = strchr(path, '/');
-		if (!slash) {
-			newlen += sprintf(new + newlen, "%o %s", mode, path);
-			new[newlen++] = '\0';
-			hashcpy((unsigned char*)new + newlen, (unsigned char *) buffer + len - 20);
-			newlen += 20;
-
-			used += len;
-			size -= len;
-			buffer = (char *) buffer + len;
-			continue;
-		}
-
-		newlen += sprintf(new + newlen, "%o %.*s", S_IFDIR, (int)(slash - path), path);
-		new[newlen++] = 0;
-		sha1 = (unsigned char *)(new + newlen);
-		newlen += 20;
-
-		len = write_subdirectory(buffer, size, origpath, slash-origpath+1, sha1);
-
-		used += len;
-		size -= len;
-		buffer = (char *) buffer + len;
-	}
-
-	write_sha1_file(new, newlen, tree_type, result_sha1);
-	free(new);
-	return used;
-}
-
-static void convert_tree(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	void *orig_buffer = buffer;
-	unsigned long orig_size = size;
-
-	while (size) {
-		size_t len = 1+strlen(buffer);
-
-		convert_binary_sha1((char *) buffer + len);
-
-		len += 20;
-		if (len > size)
-			die("corrupt tree object");
-		size -= len;
-		buffer = (char *) buffer + len;
-	}
-
-	write_subdirectory(orig_buffer, orig_size, "", 0, result_sha1);
-}
-
-static unsigned long parse_oldstyle_date(const char *buf)
-{
-	char c, *p;
-	char buffer[100];
-	struct tm tm;
-	const char *formats[] = {
-		"%c",
-		"%a %b %d %T",
-		"%Z",
-		"%Y",
-		" %Y",
-		NULL
-	};
-	/* We only ever did two timezones in the bad old format .. */
-	const char *timezones[] = {
-		"PDT", "PST", "CEST", NULL
-	};
-	const char **fmt = formats;
-
-	p = buffer;
-	while (isspace(c = *buf))
-		buf++;
-	while ((c = *buf++) != '\n')
-		*p++ = c;
-	*p++ = 0;
-	buf = buffer;
-	memset(&tm, 0, sizeof(tm));
-	do {
-		const char *next = strptime(buf, *fmt, &tm);
-		if (next) {
-			if (!*next)
-				return mktime(&tm);
-			buf = next;
-		} else {
-			const char **p = timezones;
-			while (isspace(*buf))
-				buf++;
-			while (*p) {
-				if (!memcmp(buf, *p, strlen(*p))) {
-					buf += strlen(*p);
-					break;
-				}
-				p++;
-			}
-		}
-		fmt++;
-	} while (*buf && *fmt);
-	printf("left: %s\n", buf);
-	return mktime(&tm);
-}
-
-static int convert_date_line(char *dst, void **buf, unsigned long *sp)
-{
-	unsigned long size = *sp;
-	char *line = *buf;
-	char *next = strchr(line, '\n');
-	char *date = strchr(line, '>');
-	int len;
-
-	if (!next || !date)
-		die("missing or bad author/committer line %s", line);
-	next++; date += 2;
-
-	*buf = next;
-	*sp = size - (next - line);
-
-	len = date - line;
-	memcpy(dst, line, len);
-	dst += len;
-
-	/* Is it already in new format? */
-	if (isdigit(*date)) {
-		int datelen = next - date;
-		memcpy(dst, date, datelen);
-		return len + datelen;
-	}
-
-	/*
-	 * Hacky hacky: one of the sparse old-style commits does not have
-	 * any date at all, but we can fake it by using the committer date.
-	 */
-	if (*date == '\n' && strchr(next, '>'))
-		date = strchr(next, '>')+2;
-
-	return len + sprintf(dst, "%lu -0700\n", parse_oldstyle_date(date));
-}
-
-static void convert_date(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	char *new = xmalloc(size + 100);
-	unsigned long newlen = 0;
-
-	/* "tree <sha1>\n" */
-	memcpy(new + newlen, buffer, 46);
-	newlen += 46;
-	buffer = (char *) buffer + 46;
-	size -= 46;
-
-	/* "parent <sha1>\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
-		memcpy(new + newlen, buffer, 48);
-		newlen += 48;
-		buffer = (char *) buffer + 48;
-		size -= 48;
-	}
-
-	/* "author xyz <xyz> date" */
-	newlen += convert_date_line(new + newlen, &buffer, &size);
-	/* "committer xyz <xyz> date" */
-	newlen += convert_date_line(new + newlen, &buffer, &size);
-
-	/* Rest */
-	memcpy(new + newlen, buffer, size);
-	newlen += size;
-
-	write_sha1_file(new, newlen, commit_type, result_sha1);
-	free(new);
-}
-
-static void convert_commit(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	void *orig_buffer = buffer;
-	unsigned long orig_size = size;
-
-	if (memcmp(buffer, "tree ", 5))
-		die("Bad commit '%s'", (char*) buffer);
-	convert_ascii_sha1((char *) buffer + 5);
-	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
-		convert_ascii_sha1((char *) buffer + 7);
-		buffer = (char *) buffer + 48;
-	}
-	convert_date(orig_buffer, orig_size, result_sha1);
-}
-
-static struct entry * convert_entry(unsigned char *sha1)
-{
-	struct entry *entry = lookup_entry(sha1);
-	enum object_type type;
-	void *buffer, *data;
-	unsigned long size;
-
-	if (entry->converted)
-		return entry;
-	data = read_sha1_file(sha1, &type, &size);
-	if (!data)
-		die("unable to read object %s", sha1_to_hex(sha1));
-
-	buffer = xmalloc(size);
-	memcpy(buffer, data, size);
-
-	if (type == OBJ_BLOB) {
-		write_sha1_file(buffer, size, blob_type, entry->new_sha1);
-	} else if (type == OBJ_TREE)
-		convert_tree(buffer, size, entry->new_sha1);
-	else if (type == OBJ_COMMIT)
-		convert_commit(buffer, size, entry->new_sha1);
-	else
-		die("unknown object type %d in %s", type, sha1_to_hex(sha1));
-	entry->converted = 1;
-	free(buffer);
-	free(data);
-	return entry;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned char sha1[20];
-	struct entry *entry;
-
-	setup_git_directory();
-
-	if (argc != 2)
-		usage("git-convert-objects <sha1>");
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	entry = convert_entry(sha1);
-	printf("new sha1: %s\n", sha1_to_hex(entry->new_sha1));
-	return 0;
-}
-- 
1.5.3.2
