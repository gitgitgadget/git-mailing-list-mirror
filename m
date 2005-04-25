From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Introduce diff-tree-helper.
Date: Sun, 24 Apr 2005 22:17:29 -0700
Message-ID: <7vll77qvti.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 07:13:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvtt-0004no-Tw
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 07:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVDYFRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 01:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVDYFRw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 01:17:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43656 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262539AbVDYFRb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 01:17:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050425051729.LFJT550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Apr 2005 01:17:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 24 Apr 2005 22:12:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch introduces a new program, diff-tree-helper.  It reads
output from diff-cache and diff-tree, and produces a patch file.
The diff format customization can be done the same way the
show-diff uses; the same external diff interface introduced by
the previous patch to drive diff from show-diff is used so this
is not surprising.

It is used like the following examples:

   $ diff-cache --cached -z <tree> | diff-tree-helper -z -R paths...
   $ diff-tree -r -z <tree1> <tree2> | diff-tree-helper -z paths...

 - As usual, the use of the -z flag is recommended in the script
   to pass NUL-terminated filenames through the pipe between
   commands.

 - The -R flag is used to generate reverse diff.  It does not
   matter for diff-tree case, but it is sometimes useful to get
   a patch in the desired direction out of diff-cache.

 - The paths parameters are used to restrict the paths that
   appears in the output.  Again this is useful to use with
   diff-cache, which, unlike diff-tree, does not take such paths
   restriction parameters.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile           |    6 -
diff-tree-helper.c |  302 +++++++++++++++++++++++++++++++++++++++++++++++++++++
strbuf.c           |   43 +++++++
strbuf.h           |   13 ++
4 files changed, 363 insertions(+), 1 deletion(-)

--- k/Makefile
+++ l/Makefile
@@ -16,7 +16,8 @@ AR=ar
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
-	diff-cache convert-cache http-pull rpush rpull rev-list
+	diff-cache convert-cache http-pull rpush rpull rev-list \
+	diff-tree-helper
 
 all: $(PROG)
 
@@ -27,6 +28,9 @@ LIB_OBJS=read-cache.o sha1_file.o usage.
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
+LIB_H += strbuf.h
+LIB_OBJS += strbuf.o
+
 LIB_H += diff.h
 LIB_OBJS += diff.o
 
--- k/diff-tree-helper.c
+++ l/diff-tree-helper.c
@@ -0,0 +1,302 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "diff.h"
+
+static int matches_pathspec(const char *name, char **spec, int cnt)
+{
+	int i;
+	int namelen = strlen(name);
+	for (i = 0; i < cnt; i++) {
+		int speclen = strlen(spec[i]);
+		if (! strncmp(spec[i], name, speclen) &&
+		    speclen <= namelen &&
+		    (name[speclen] == 0 ||
+		     name[speclen] == '/'))
+			return 1;
+	}
+	return 0;
+}
+
+static int parse_oneside_change(const char *cp, unsigned char *sha1,
+				char *path) {
+	int ch;
+	while ((ch = *cp) && '0' <= ch && ch <= '7')
+		cp++; /* skip mode bits */
+	if (strncmp(cp, "\tblob\t", 6))
+		return -1;
+	cp += 6;
+	if (get_sha1_hex(cp, sha1))
+		return -1;
+	cp += 40;
+	if (*cp++ != '\t')
+		return -1;
+	strcpy(path, cp);
+	return 0;
+}
+
+#define STATUS_CACHED    0 /* cached and sha1 valid */
+#define STATUS_ABSENT    1 /* diff-tree says old removed or new added */
+#define STATUS_UNCACHED  2 /* diff-cache output: read from working tree */
+
+static int parse_diff_tree_output(const char *buf,
+				  unsigned char *old_sha1,
+				  int *old_status,
+				  unsigned char *new_sha1,
+				  int *new_status,
+				  char *path) {
+	const char *cp = buf;
+	int ch;
+	static unsigned char null_sha[20] = { 0, };
+
+	switch (*cp++) {
+	case '+':
+		*old_status = STATUS_ABSENT;
+		*new_status = (memcmp(new_sha1, null_sha, sizeof(null_sha)) ?
+			       STATUS_CACHED : STATUS_UNCACHED);
+		return parse_oneside_change(cp, new_sha1, path);
+	case '-':
+		*new_status = STATUS_ABSENT;
+		*old_status = (memcmp(old_sha1, null_sha, sizeof(null_sha)) ?
+			       STATUS_CACHED : STATUS_UNCACHED);
+		return parse_oneside_change(cp, old_sha1, path);
+	case '*':
+		break;
+	default:
+		return -1;
+	}
+	
+	/* This is for '*' entries */
+	while ((ch = *cp) && ('0' <= ch && ch <= '7'))
+		cp++; /* skip mode bits */
+	if (strncmp(cp, "->", 2))
+		return -1;
+	cp += 2;
+	while ((ch = *cp) && ('0' <= ch && ch <= '7'))
+		cp++; /* skip mode bits */
+	if (strncmp(cp, "\tblob\t", 6))
+		return -1;
+	cp += 6;
+	if (get_sha1_hex(cp, old_sha1))
+		return -1;
+	cp += 40;
+	if (strncmp(cp, "->", 2))
+		return -1;
+	cp += 2;
+	if (get_sha1_hex(cp, new_sha1))
+		return -1;
+	cp += 40;
+	if (*cp++ != '\t')
+		return -1;
+	strcpy(path, cp);
+	*old_status = (memcmp(old_sha1, null_sha, sizeof(null_sha)) ?
+		       STATUS_CACHED : STATUS_UNCACHED);
+	*new_status = (memcmp(new_sha1, null_sha, sizeof(null_sha)) ?
+		       STATUS_CACHED : STATUS_UNCACHED);
+	return 0;
+}
+
+static int sha1err(const char *path, const unsigned char *sha1)
+{
+	return error("diff-tree-helper: unable to read sha1 file of %s (%s)",
+		     path, sha1_to_hex(sha1));
+}
+
+static int fserr(const char *path)
+{
+	return error("diff-tree-helper: unable to read file %s", path);
+}
+
+static char *map_whole_file(const char *path, unsigned long *size) {
+	int fd;
+	struct stat st;
+	void *buf;
+
+	if ((fd = open(path, O_RDONLY)) < 0) {
+		error("diff-tree-helper: unable to read file %s", path);
+		return 0;
+	}
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		error("diff-tree-helper: unable to stat file %s", path);
+		return 0;
+	}
+	*size = st.st_size;
+	buf = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	return buf;
+}
+
+static int show_diff(const unsigned char *old_sha1, int old_status,
+		     const unsigned char *new_sha1, int new_status,
+		     const char *path, int reverse_diff)
+{
+	char other[PATH_MAX];
+	unsigned long size;
+	char type[20];
+	int fd;
+	int reverse;
+	void *blob = 0;
+	const char *fs = 0;
+	int need_unmap = 0;
+	int need_unlink = 0;
+
+
+	switch (old_status) {
+	case STATUS_CACHED:
+		blob = read_sha1_file(old_sha1, type, &size);
+		if (! blob)
+			return sha1err(path, old_sha1);
+			
+		switch (new_status) {
+		case STATUS_CACHED:
+			strcpy(other, ".diff_tree_helper_XXXXXX");
+			fd = mkstemp(other);
+			if (fd < 0)
+				die("unable to create temp-file");
+			if (write(fd, blob, size) != size)
+				die("unable to write temp-file");
+			close(fd);
+			free(blob);
+
+			blob = read_sha1_file(new_sha1, type, &size);
+			if (! blob)
+				return sha1err(path, new_sha1);
+
+			need_unlink = 1;
+			/* new = blob, old = fs */
+			reverse = !reverse_diff;
+			fs = other;
+			break;
+
+		case STATUS_ABSENT:
+		case STATUS_UNCACHED:
+			fs = ((new_status == STATUS_ABSENT) ?
+			      "/dev/null" : path);
+			reverse = reverse_diff;
+			break;
+
+		default:
+ 			reverse = reverse_diff;
+		}
+		break;
+
+	case STATUS_ABSENT:
+		switch (new_status) {
+		case STATUS_CACHED:
+			blob = read_sha1_file(new_sha1, type, &size);
+			if (! blob)
+				return sha1err(path, new_sha1);
+			/* old = fs, new = blob */
+			fs = "/dev/null";
+			reverse = !reverse_diff;
+			break;
+
+		case STATUS_ABSENT:
+			return error("diff-tree-helper: absent from both old and new?");
+		case STATUS_UNCACHED:
+			fs = path;
+			blob = strdup("");
+			size = 0;
+			/* old = blob, new = fs */
+			reverse = reverse_diff;
+			break;
+		default:
+			reverse = reverse_diff;
+		}
+		break;
+
+	case STATUS_UNCACHED:
+		fs = path; /* old = fs, new = blob */
+		reverse = !reverse_diff;
+
+		switch (new_status) {
+		case STATUS_CACHED:
+			blob = read_sha1_file(new_sha1, type, &size);
+			if (! blob)
+				return sha1err(path, new_sha1);
+			break;
+
+		case STATUS_ABSENT:
+			blob = strdup("");
+			size = 0;
+			break;
+
+		case STATUS_UNCACHED:
+			/* old = fs */
+			blob = map_whole_file(path, &size);
+			if (! blob)
+				return fserr(path);
+			need_unmap = 1;
+			break;
+		default:
+			reverse = reverse_diff;
+		}
+		break;
+
+	default:
+		reverse = reverse_diff;
+	}
+	
+	if (fs)
+		show_differences(fs,
+				 path, /* label */
+				 blob,
+				 size,
+				 reverse /* 0: diff blob fs
+					    1: diff fs blob */);
+
+	if (need_unlink)
+		unlink(other);
+	if (need_unmap && blob)
+		munmap(blob, size);
+	else
+		free(blob);
+	return 0;
+}
+
+static const char *diff_tree_helper_usage =
+"diff-tree-helper [-R] [-z] paths...";
+
+int main(int ac, char **av) {
+	struct strbuf sb;
+	int reverse_diff = 0;
+	int line_termination = '\n';
+
+	strbuf_init(&sb);
+
+	while (1 < ac && av[1][0] == '-') {
+		if (av[1][1] == 'R')
+			reverse_diff = 1;
+		else if (av[1][1] == 'z')
+			line_termination = 0;
+		else
+			usage(diff_tree_helper_usage);
+		ac--; av++;
+	}
+	/* the remaining parameters are paths patterns */
+
+	prepare_diff_cmd();
+
+	while (1) {
+		int old_status, new_status;
+		unsigned char old_sha1[20], new_sha1[20];
+		char path[PATH_MAX];
+		read_line(&sb, stdin, line_termination);
+		if (sb.eof)
+			break;
+		if (parse_diff_tree_output(sb.buf,
+					   old_sha1, &old_status,
+					   new_sha1, &new_status,
+					   path)) {
+			fprintf(stderr, "cannot parse %s\n", sb.buf);
+			continue;
+		}
+		if (1 < ac && ! matches_pathspec(path, av+1, ac-1))
+			continue;
+
+		show_diff(old_sha1, old_status,
+			  new_sha1, new_status,
+			  path, reverse_diff);
+	}
+	return 0;
+}
--- k/strbuf.c
+++ l/strbuf.c
@@ -0,0 +1,43 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include "strbuf.h"
+
+void strbuf_init(struct strbuf *sb) {
+	sb->buf = 0;
+	sb->eof = sb->alloc = sb->len = 0;
+}
+
+static void strbuf_begin(struct strbuf *sb) {
+	free(sb->buf);
+	strbuf_init(sb);
+}
+
+static void inline strbuf_add(struct strbuf *sb, int ch) {
+	if (sb->alloc <= sb->len) {
+		sb->alloc = sb->alloc * 3 / 2 + 16;
+		sb->buf = realloc(sb->buf, sb->alloc);
+	}
+	sb->buf[sb->len++] = ch;
+}
+
+static void strbuf_end(struct strbuf *sb) {
+	strbuf_add(sb, 0);
+}
+
+void read_line(struct strbuf *sb, FILE *fp, int term) {
+	int ch;
+	strbuf_begin(sb);
+	if (feof(fp)) {
+		sb->eof = 1;
+		return;
+	}
+	while ((ch = fgetc(fp)) != EOF) {
+		if (ch == term)
+			break;
+		strbuf_add(sb, ch);
+	}
+	if (sb->len == 0)
+		sb->eof = 1;
+	strbuf_end(sb);
+}
+
--- k/strbuf.h
+++ l/strbuf.h
@@ -0,0 +1,13 @@
+#ifndef STRBUF_H
+#define STRBUF_H
+struct strbuf {
+	int alloc;
+	int len;
+	int eof;
+	unsigned char *buf;
+};
+
+extern void strbuf_init(struct strbuf *);
+extern void read_line(struct strbuf *, FILE *, int);
+
+#endif /* STRBUF_H */

