From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 5/7] Further strbuf re-engineering.
Date: Thu,  6 Sep 2007 13:20:09 +0200
Message-ID: <11890776112309-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
 <11890776111843-git-send-email-madcoder@debian.org>
 <11890776112292-git-send-email-madcoder@debian.org>
 <11890776111670-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPn-0008PZ-MD
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXIFLU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXIFLU2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:28 -0400
Received: from pan.madism.org ([88.191.52.104]:52613 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbXIFLUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:15 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6E1C51E405;
	Thu,  6 Sep 2007 13:20:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E0FA31A3C1; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11890776111670-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57869>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c       |   30 +++++++-----------------
 builtin-blame.c       |   35 +++++++++------------------
 builtin-commit-tree.c |   60 +++++++++++-------------------------------------
 diff.c                |   27 +++++++--------------
 4 files changed, 44 insertions(+), 108 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 25b1447..d70c6cf 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
+#include "strbuf.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -181,34 +182,21 @@ static void say_patch_name(FILE *output, const char *pre, struct patch *patch, c
 
 static void *read_patch_file(int fd, unsigned long *sizep)
 {
-	unsigned long size = 0, alloc = CHUNKSIZE;
-	void *buffer = xmalloc(alloc);
+	struct strbuf buf;
 
-	for (;;) {
-		ssize_t nr = alloc - size;
-		if (nr < 1024) {
-			alloc += CHUNKSIZE;
-			buffer = xrealloc(buffer, alloc);
-			nr = alloc - size;
-		}
-		nr = xread(fd, (char *) buffer + size, nr);
-		if (!nr)
-			break;
-		if (nr < 0)
-			die("git-apply: read returned %s", strerror(errno));
-		size += nr;
-	}
-	*sizep = size;
+        strbuf_init(&buf);
+	if (strbuf_read(&buf, fd) < 0)
+		die("git-apply: read returned %s", strerror(errno));
+	*sizep = buf.len;
 
 	/*
 	 * Make sure that we have some slop in the buffer
 	 * so that we can do speculative "memcmp" etc, and
 	 * see to it that it is NUL-filled.
 	 */
-	if (alloc < size + SLOP)
-		buffer = xrealloc(buffer, size + SLOP);
-	memset((char *) buffer + size, 0, SLOP);
-	return buffer;
+	strbuf_grow(&buf, SLOP);
+	memset(buf.buf + buf.len, 0, SLOP);
+	return strbuf_detach(&buf);
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
diff --git a/builtin-blame.c b/builtin-blame.c
index dc88a95..1b1e6da 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -18,6 +18,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "mailmap.h"
+#include "strbuf.h"
 
 static char blame_usage[] =
 "git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
@@ -2001,11 +2002,10 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	struct commit *commit;
 	struct origin *origin;
 	unsigned char head_sha1[20];
-	char *buf;
+	struct strbuf buf;
 	const char *ident;
 	int fd;
 	time_t now;
-	unsigned long fin_size;
 	int size, len;
 	struct cache_entry *ce;
 	unsigned mode;
@@ -2023,9 +2023,11 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 
 	origin = make_origin(commit, path);
 
+	strbuf_init(&buf);
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
 		const char *read_from;
+		unsigned long fin_size;
 
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
@@ -2038,19 +2040,19 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 			read_from = path;
 		}
 		fin_size = xsize_t(st.st_size);
-		buf = xmalloc(fin_size+1);
 		mode = canon_mode(st.st_mode);
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			fd = open(read_from, O_RDONLY);
 			if (fd < 0)
 				die("cannot open %s", read_from);
-			if (read_in_full(fd, buf, fin_size) != fin_size)
+			if (strbuf_read(&buf, fd) != xsize_t(st.st_size))
 				die("cannot read %s", read_from);
 			break;
 		case S_IFLNK:
-			if (readlink(read_from, buf, fin_size+1) != fin_size)
+			if (readlink(read_from, buf.buf, buf.alloc) != fin_size)
 				die("cannot readlink %s", read_from);
+			buf.len = fin_size;
 			break;
 		default:
 			die("unsupported file type %s", read_from);
@@ -2059,26 +2061,13 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	else {
 		/* Reading from stdin */
 		contents_from = "standard input";
-		buf = NULL;
-		fin_size = 0;
 		mode = 0;
-		while (1) {
-			ssize_t cnt = 8192;
-			buf = xrealloc(buf, fin_size + cnt);
-			cnt = xread(0, buf + fin_size, cnt);
-			if (cnt < 0)
-				die("read error %s from stdin",
-				    strerror(errno));
-			if (!cnt)
-				break;
-			fin_size += cnt;
-		}
-		buf = xrealloc(buf, fin_size + 1);
+		if (strbuf_read(&buf, 0) < 0)
+			die("read error %s from stdin", strerror(errno));
 	}
-	buf[fin_size] = 0;
-	origin->file.ptr = buf;
-	origin->file.size = fin_size;
-	pretend_sha1_file(buf, fin_size, OBJ_BLOB, origin->blob_sha1);
+	origin->file.ptr = buf.buf;
+	origin->file.size = buf.len;
+	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
 	commit->util = origin;
 
 	/*
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ccbcbe3..bc9502c 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -8,42 +8,13 @@
 #include "tree.h"
 #include "builtin.h"
 #include "utf8.h"
+#include "strbuf.h"
 
 #define BLOCKING (1ul << 14)
 
 /*
  * FIXME! Share the code with "write-tree.c"
  */
-static void init_buffer(char **bufp, unsigned int *sizep)
-{
-	*bufp = xmalloc(BLOCKING);
-	*sizep = 0;
-}
-
-static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
-{
-	char one_line[2048];
-	va_list args;
-	int len;
-	unsigned long alloc, size, newsize;
-	char *buf;
-
-	va_start(args, fmt);
-	len = vsnprintf(one_line, sizeof(one_line), fmt, args);
-	va_end(args);
-	size = *sizep;
-	newsize = size + len + 1;
-	alloc = (size + 32767) & ~32767;
-	buf = *bufp;
-	if (newsize > alloc) {
-		alloc = (newsize + 32767) & ~32767;
-		buf = xrealloc(buf, alloc);
-		*bufp = buf;
-	}
-	*sizep = newsize - 1;
-	memcpy(buf + size, one_line, len);
-}
-
 static void check_valid(unsigned char *sha1, enum object_type expect)
 {
 	enum object_type type = sha1_object_info(sha1, NULL);
@@ -87,9 +58,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	int parents = 0;
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
-	char comment[1000];
-	char *buffer;
-	unsigned int size;
+	struct strbuf buffer;
 	int encoding_is_utf8;
 
 	git_config(git_default_config);
@@ -118,8 +87,9 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
-	init_buffer(&buffer, &size);
-	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
+	strbuf_init(&buffer);
+	strbuf_grow(&buffer, 8192); /* should avoid reallocs for the headers */
+	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree_sha1));
 
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
@@ -127,26 +97,24 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	 * if everything else stays the same.
 	 */
 	for (i = 0; i < parents; i++)
-		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
+		strbuf_addf(&buffer, "parent %s\n", sha1_to_hex(parent_sha1[i]));
 
 	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
-	add_buffer(&buffer, &size, "committer %s\n", git_committer_info(1));
+	strbuf_addf(&buffer, "author %s\n", git_author_info(1));
+	strbuf_addf(&buffer, "committer %s\n", git_committer_info(1));
 	if (!encoding_is_utf8)
-		add_buffer(&buffer, &size,
-				"encoding %s\n", git_commit_encoding);
-	add_buffer(&buffer, &size, "\n");
+		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
-	while (fgets(comment, sizeof(comment), stdin) != NULL)
-		add_buffer(&buffer, &size, "%s", comment);
+	if (strbuf_read(&buffer, 0) < 0)
+		die("git-commit-tree: read returned %s", strerror(errno));
 
 	/* And check the encoding */
-	buffer[size] = '\0';
-	if (encoding_is_utf8 && !is_utf8(buffer))
+	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
-	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
+	if (!write_sha1_file(buffer.buf, buffer.len, commit_type, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
diff --git a/diff.c b/diff.c
index 0d30d05..c054b23 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "color.h"
 #include "attr.h"
+#include "strbuf.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1545,26 +1546,16 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 
 static int populate_from_stdin(struct diff_filespec *s)
 {
-#define INCREMENT 1024
-	char *buf;
-	unsigned long size;
-	ssize_t got;
-
-	size = 0;
-	buf = NULL;
-	while (1) {
-		buf = xrealloc(buf, size + INCREMENT);
-		got = xread(0, buf + size, INCREMENT);
-		if (!got)
-			break; /* EOF */
-		if (got < 0)
-			return error("error while reading from stdin %s",
+	struct strbuf buf;
+
+	strbuf_init(&buf);
+	if (strbuf_read(&buf, 0) < 0)
+		return error("error while reading from stdin %s",
 				     strerror(errno));
-		size += got;
-	}
+
 	s->should_munmap = 0;
-	s->data = buf;
-	s->size = size;
+	s->size = buf.len;
+	s->data = strbuf_detach(&buf);
 	s->should_free = 1;
 	return 0;
 }
-- 
1.5.3.1
