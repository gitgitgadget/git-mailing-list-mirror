From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Simplify calling of CR/LF conversion routines
Date: Thu, 19 Apr 2007 00:28:27 +0200
Message-ID: <20070418222827.GB2477@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 00:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeIdf-0008P4-F9
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 00:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992847AbXDRW2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 18:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992891AbXDRW2a
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 18:28:30 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61906 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992847AbXDRW23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 18:28:29 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (fruni mo17) (RZmta 5.5)
	with ESMTP id E02504j3IL5stj ; Thu, 19 Apr 2007 00:28:27 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 83201277BD;
	Thu, 19 Apr 2007 00:28:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 60697BDDE; Thu, 19 Apr 2007 00:28:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44958>

What is the point of having a return value if it is discarded
afterwords anyway?

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

It passes the tests.

 builtin-apply.c |   18 +++++++-----------
 cache.h         |    4 ++--
 convert.c       |   46 +++++++++++++++++++++-------------------------
 diff.c          |    4 ++--
 entry.c         |    7 ++-----
 sha1_file.c     |    7 +++----
 6 files changed, 37 insertions(+), 49 deletions(-)

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
index 53c2341..67fd050 100644
--- a/cache.h
+++ b/cache.h
@@ -493,8 +493,8 @@ extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
 /* convert.c */
-extern int convert_to_git(const char *path, char **bufp, unsigned long *sizep);
-extern int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep);
+extern char *convert_to_git(const char *path, const char *bufp, unsigned long *sizep);
+extern char *convert_to_working_tree(const char *path, const char *bufp, unsigned long *sizep);
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
diff --git a/convert.c b/convert.c
index 898bfe3..b219c39 100644
--- a/convert.c
+++ b/convert.c
@@ -72,7 +72,7 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
+char *convert_to_git(const char *path, const char *bufp, unsigned long *sizep)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
@@ -84,18 +84,17 @@ int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 	 * stupid auto-CRLF one.
 	 */
 	if (!auto_crlf)
-		return 0;
+		return NULL;
 
 	size = *sizep;
 	if (!size)
-		return 0;
-	buffer = *bufp;
+		return NULL;
 
-	gather_stats(buffer, size, &stats);
+	gather_stats(bufp, size, &stats);
 
 	/* No CR? Nothing to convert, regardless. */
 	if (!stats.cr)
-		return 0;
+		return NULL;
 
 	/*
 	 * We're currently not going to even try to convert stuff
@@ -103,32 +102,31 @@ int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 	 * stuff?
 	 */
 	if (stats.cr != stats.crlf)
-		return 0;
+		return NULL;
 
 	/*
 	 * And add some heuristics for binary vs text, of course...
 	 */
 	if (is_binary(size, &stats))
-		return 0;
+		return NULL;
 
 	/*
 	 * Ok, allocate a new buffer, fill it in, and return true
 	 * to let the caller know that we switched buffers on it.
 	 */
 	nsize = size - stats.crlf;
-	nbuf = xmalloc(nsize);
-	*bufp = nbuf;
+	buffer = nbuf = xmalloc(nsize);
 	*sizep = nsize;
 	do {
-		unsigned char c = *buffer++;
+		unsigned char c = *bufp++;
 		if (c != '\r')
 			*nbuf++ = c;
 	} while (--size);
 
-	return 1;
+	return buffer;
 }
 
-int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+char *convert_to_working_tree(const char *path, const char *bufp, unsigned long *sizep)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
@@ -141,46 +139,44 @@ int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 	 * stupid auto-CRLF one.
 	 */
 	if (auto_crlf <= 0)
-		return 0;
+		return NULL;
 
 	size = *sizep;
 	if (!size)
-		return 0;
-	buffer = *bufp;
+		return NULL;
 
-	gather_stats(buffer, size, &stats);
+	gather_stats(bufp, size, &stats);
 
 	/* No LF? Nothing to convert, regardless. */
 	if (!stats.lf)
-		return 0;
+		return NULL;
 
 	/* Was it already in CRLF format? */
 	if (stats.lf == stats.crlf)
-		return 0;
+		return NULL;
 
 	/* If we have any bare CR characters, we're not going to touch it */
 	if (stats.cr != stats.crlf)
-		return 0;
+		return NULL;
 
 	if (is_binary(size, &stats))
-		return 0;
+		return NULL;
 
 	/*
 	 * Ok, allocate a new buffer, fill it in, and return true
 	 * to let the caller know that we switched buffers on it.
 	 */
 	nsize = size + stats.lf - stats.crlf;
-	nbuf = xmalloc(nsize);
-	*bufp = nbuf;
+	buffer = nbuf = xmalloc(nsize);
 	*sizep = nsize;
 	last = 0;
 	do {
-		unsigned char c = *buffer++;
+		unsigned char c = *bufp++;
 		if (c == '\n' && last != '\r')
 			*nbuf++ = '\r';
 		*nbuf++ = c;
 		last = c;
 	} while (--size);
 
-	return 1;
+	return buffer;
 }
diff --git a/diff.c b/diff.c
index fbb79d7..ee72cc6 100644
--- a/diff.c
+++ b/diff.c
@@ -1461,9 +1461,9 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
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
1.5.1.1.876.ge36f76
