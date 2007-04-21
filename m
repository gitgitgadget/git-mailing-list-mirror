From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Simplify calling of CR/LF conversion routines
Date: Sat, 21 Apr 2007 03:40:56 -0700
Message-ID: <11771520593461-git-send-email-junkio@cox.net>
References: <11771520591529-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 12:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfD1k-0004KC-24
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 12:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030658AbXDUKlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030580AbXDUKlD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 06:41:03 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51769 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030656AbXDUKlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 06:41:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421104100.RSFE1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 21 Apr 2007 06:41:00 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pmgz1W00A1kojtg0000100; Sat, 21 Apr 2007 06:40:59 -0400
X-Mailer: git-send-email 1.5.1.1.948.g9f6f
In-Reply-To: <11771520591529-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45163>

From: Alex Riesen <raa.lkml@gmail.com>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is rebased on 'next'

 builtin-apply.c |   18 +++++--------
 cache.h         |    4 +-
 convert.c       |   71 +++++++++++++++++++++++++++----------------------------
 diff.c          |    4 +-
 entry.c         |    7 +----
 sha1_file.c     |    7 ++---
 6 files changed, 51 insertions(+), 60 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index fd92ef7..ccd342c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1475,8 +1475,8 @@ static int read_old_data(struct stat *st, const char *path, char **buf_p, unsign
 		}
 		close(fd);
 		nsize = got;
-		nbuf = buf;
-		if (convert_to_git(path, &nbuf, &nsize)) {
+		nbuf = convert_to_git(path, buf, &nsize);
+		if (nbuf) {
 			free(buf);
 			*buf_p = nbuf;
 			*alloc_p = nsize;
@@ -2355,9 +2355,8 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
-	int fd, converted;
+	int fd;
 	char *nbuf;
-	unsigned long nsize;
 
 	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
@@ -2369,13 +2368,10 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return -1;
 
-	nsize = size;
-	nbuf = (char *) buf;
-	converted = convert_to_working_tree(path, &nbuf, &nsize);
-	if (converted) {
+	nbuf = convert_to_working_tree(path, buf, &size);
+	if (nbuf)
 		buf = nbuf;
-		size = nsize;
-	}
+
 	while (size) {
 		int written = xwrite(fd, buf, size);
 		if (written < 0)
@@ -2387,7 +2383,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	}
 	if (close(fd) < 0)
 		die("closing file %s: %s", path, strerror(errno));
-	if (converted)
+	if (nbuf)
 		free(nbuf);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 38ad006..8c804cb 100644
--- a/cache.h
+++ b/cache.h
@@ -496,8 +496,8 @@ extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
 /* convert.c */
-extern int convert_to_git(const char *path, char **bufp, unsigned long *sizep);
-extern int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep);
+extern char *convert_to_git(const char *path, const char *src, unsigned long *sizep);
+extern char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep);
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
diff --git a/convert.c b/convert.c
index da64253..742b895 100644
--- a/convert.c
+++ b/convert.c
@@ -79,25 +79,24 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int action)
+static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep, int action)
 {
-	char *buffer, *nbuf;
+	char *buffer, *dst;
 	unsigned long size, nsize;
 	struct text_stat stats;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_GUESS && !auto_crlf))
-		return 0;
+		return NULL;
 
 	size = *sizep;
 	if (!size)
-		return 0;
-	buffer = *bufp;
+		return NULL;
 
-	gather_stats(buffer, size, &stats);
+	gather_stats(src, size, &stats);
 
 	/* No CR? Nothing to convert, regardless. */
 	if (!stats.cr)
-		return 0;
+		return NULL;
 
 	if (action == CRLF_GUESS) {
 		/*
@@ -106,13 +105,13 @@ static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int
 		 * stuff?
 		 */
 		if (stats.cr != stats.crlf)
-			return 0;
+			return NULL;
 
 		/*
 		 * And add some heuristics for binary vs text, of course...
 		 */
 		if (is_binary(size, &stats))
-			return 0;
+			return NULL;
 	}
 
 	/*
@@ -120,10 +119,10 @@ static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int
 	 * to let the caller know that we switched buffers on it.
 	 */
 	nsize = size - stats.crlf;
-	nbuf = xmalloc(nsize);
-	*bufp = nbuf;
+	buffer = xmalloc(nsize);
 	*sizep = nsize;
 
+	dst = buffer;
 	if (action == CRLF_GUESS) {
 		/*
 		 * If we guessed, we already know we rejected a file with
@@ -131,54 +130,53 @@ static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int
 		 * follow it.
 		 */
 		do {
-			unsigned char c = *buffer++;
+			unsigned char c = *src++;
 			if (c != '\r')
-				*nbuf++ = c;
+				*dst++ = c;
 		} while (--size);
 	} else {
 		do {
-			unsigned char c = *buffer++;
+			unsigned char c = *src++;
 			if (! (c == '\r' && (1 < size && *buffer == '\n')))
-				*nbuf++ = c;
+				*dst++ = c;
 		} while (--size);
 	}
 
-	return 1;
+	return buffer;
 }
 
-static int crlf_to_worktree(const char *path, char **bufp, unsigned long *sizep, int action)
+static char *crlf_to_worktree(const char *path, const char *src, unsigned long *sizep, int action)
 {
-	char *buffer, *nbuf;
+	char *buffer, *dst;
 	unsigned long size, nsize;
 	struct text_stat stats;
 	unsigned char last;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
 	    (action == CRLF_GUESS && auto_crlf <= 0))
-		return 0;
+		return NULL;
 
 	size = *sizep;
 	if (!size)
-		return 0;
-	buffer = *bufp;
+		return NULL;
 
-	gather_stats(buffer, size, &stats);
+	gather_stats(src, size, &stats);
 
 	/* No LF? Nothing to convert, regardless. */
 	if (!stats.lf)
-		return 0;
+		return NULL;
 
 	/* Was it already in CRLF format? */
 	if (stats.lf == stats.crlf)
-		return 0;
+		return NULL;
 
 	if (action == CRLF_GUESS) {
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
-			return 0;
+			return NULL;
 
 		if (is_binary(size, &stats))
-			return 0;
+			return NULL;
 	}
 
 	/*
@@ -186,19 +184,20 @@ static int crlf_to_worktree(const char *path, char **bufp, unsigned long *sizep,
 	 * to let the caller know that we switched buffers on it.
 	 */
 	nsize = size + stats.lf - stats.crlf;
-	nbuf = xmalloc(nsize);
-	*bufp = nbuf;
+	buffer = xmalloc(nsize);
 	*sizep = nsize;
 	last = 0;
+
+	dst = buffer;
 	do {
-		unsigned char c = *buffer++;
+		unsigned char c = *src++;
 		if (c == '\n' && last != '\r')
-			*nbuf++ = '\r';
-		*nbuf++ = c;
+			*dst++ = '\r';
+		*dst++ = c;
 		last = c;
 	} while (--size);
 
-	return 1;
+	return buffer;
 }
 
 static void setup_crlf_check(struct git_attr_check *check)
@@ -231,12 +230,12 @@ static int git_path_check_crlf(const char *path)
 	return CRLF_GUESS;
 }
 
-int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
+char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
 {
-	return crlf_to_git(path, bufp, sizep, git_path_check_crlf(path));
+	return crlf_to_git(path, src, sizep, git_path_check_crlf(path));
 }
 
-int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep)
 {
-	return crlf_to_worktree(path, bufp, sizep, git_path_check_crlf(path));
+	return crlf_to_worktree(path, src, sizep, git_path_check_crlf(path));
 }
diff --git a/diff.c b/diff.c
index 5f50186..1cb1230 100644
--- a/diff.c
+++ b/diff.c
@@ -1493,9 +1493,9 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		buf = s->data;
 		size = s->size;
-		if (convert_to_git(s->path, &buf, &size)) {
+		buf = convert_to_git(s->path, s->data, &size);
+		if (buf) {
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
 			s->data = buf;
diff --git a/entry.c b/entry.c
index d72f811..3771209 100644
--- a/entry.c
+++ b/entry.c
@@ -79,7 +79,6 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 	}
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 		char *buf;
-		unsigned long nsize;
 
 	case S_IFREG:
 		if (to_tempfile) {
@@ -96,12 +95,10 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		buf = new;
-		nsize = size;
-		if (convert_to_working_tree(ce->name, &buf, &nsize)) {
+		buf = convert_to_working_tree(ce->name, new, &size);
+		if (buf) {
 			free(new);
 			new = buf;
-			size = nsize;
 		}
 
 		wrote = write_in_full(fd, new, size);
diff --git a/sha1_file.c b/sha1_file.c
index 4304fe9..1978d5f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2277,10 +2277,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	 */
 	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
 		unsigned long nsize = size;
-		char *nbuf = buf;
-		if (convert_to_git(path, &nbuf, &nsize)) {
-			if (size)
-				munmap(buf, size);
+		char *nbuf = convert_to_git(path, buf, &nsize);
+		if (nbuf) {
+			munmap(buf, size);
 			size = nsize;
 			buf = nbuf;
 			re_allocated = 1;
-- 
1.5.1.1.948.g9f6f
