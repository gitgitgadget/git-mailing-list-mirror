From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 11:07:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 20:07:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH30E-0004K3-RE
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 20:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbXBMTHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 14:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXBMTHo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 14:07:44 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48785 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbXBMTHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 14:07:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DJ7PhB000365
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 11:07:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DJ7NwG006474;
	Tue, 13 Feb 2007 11:07:24 -0800
In-Reply-To: <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.42 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39581>



On Tue, 13 Feb 2007, Junio C Hamano wrote:
> 
> Thanks, applied.  I think git-apply has separate codepaths for
> both reading and writing; I won't look into them before 1.5.0
> but people are welcome to help advancing the cause before I get
> to it ;-).

Actually, I did it myself.

This is a "lazy man's auto-CRLF", and it really is pretty simple.

It currently does NOT know about file attributes, so it does its 
conversion purely based on content. Maybe that is more in the "git 
philosophy" anyway, since content is king, but I think we should try to do 
the file attributes to turn it off on demand.

Anyway, BY DEFAULT it is off regardless, because it requires a

	[core]
		AutoCRLF = true

in your config file to be enabled. We could make that the default for 
Windows, of course, the same way we do some other things (filemode etc).

But you can actually enable it on UNIX, and it will cause:

 - "git update-index" will write blobs without CRLF
 - "git diff" will diff working tree files without CRLF
 - "git checkout" will write files to the working tree _with_ CRLF

and things work fine.

Funnily, it actually shows an odd file in git itself:

	git clone -n git test-crlf
	cd test-crlf
	git config core.autocrlf true
	git checkout
	git diff

shows a diff for "Documentation/docbook-xsl.css". Why? Because we have 
actually checked in that file *with* CRLF! So when "core.autocrlf" is 
true, we'll always generate a *different* hash for it in the index, 
because the index hash will be for the content _without_ CRLF.

Is this complete? I dunno. It seems to work for me. It doesn't use the 
filename at all right now, and that's probably a deficiency (we could 
certainly make the "is_binary()" heuristics also take standard filename 
heuristics into account).

I don't pass in the filename at all for the "index_fd()" case 
(git-update-index), so that would need to be passed around, but this 
actually works fine.

NOTE NOTE NOTE! The "is_binary()" heuristics are totally made-up by yours 
truly. I will not guarantee that they work at all reasonable. Caveat 
emptor. But it _is_ simple, and it _is_ safe, since it's all off by 
default.

The patch is pretty simple - the biggest part is the new "convert.c" file, 
but even that is really just basic stuff that anybody can write in 
"Teaching C 101" as a final project for their first class in programming. 
Not to say that it's bug-free, of course - but at least we're not talking 
about rocket surgery here.

		Linus

---
commit f0731319497ac8121bd901a91fc33d715745d3af
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Tue Feb 13 10:56:50 2007 -0800

    Add "auto-CRLF" conversion logic
    
    It's simple and it's stupid.  But it actually seems to work.  What more
    can you want?
    
    It's not enabled by default: you need to add a
    
    	[core]
    		AutoCRLF = true
    
    to your .git/config file to enable it universally.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile      |    3 +-
 cache.h       |    5 ++
 config.c      |    5 ++
 convert.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff.c        |   16 +++++
 entry.c       |   15 +++++
 environment.c |    1 +
 sha1_file.c   |   22 +++++++-
 8 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 convert.c

diff --git a/Makefile b/Makefile
index 40bdcff..60496ff 100644
--- a/Makefile
+++ b/Makefile
@@ -262,7 +262,8 @@ LIB_OBJS = \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o
+	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
+	convert.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/cache.h b/cache.h
index c62b0b0..9c019e8 100644
--- a/cache.h
+++ b/cache.h
@@ -201,6 +201,7 @@ extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
+extern int auto_crlf;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
@@ -468,4 +469,8 @@ extern int nfvasprintf(char **str, const char *fmt, va_list va);
 extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
+/* convert.c */
+extern int convert_to_git(const char *path, char **bufp, unsigned long *sizep);
+extern int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep);
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index d821071..ffe0212 100644
--- a/config.c
+++ b/config.c
@@ -324,6 +324,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.autocrlf")) {
+		auto_crlf = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/convert.c b/convert.c
new file mode 100644
index 0000000..c04b6c2
--- /dev/null
+++ b/convert.c
@@ -0,0 +1,179 @@
+#include "cache.h"
+/*
+ * convert.c - convert a file when checking it out and checking it in.
+ *
+ * This should use the pathname to decide on whether it wants to do some
+ * more interesting conversions (automatic gzip/unzip, general format
+ * conversions etc etc), but by default it just does automatic CRLF<->LF
+ * translation when the "auto_crlf" option is set.
+ */
+
+struct text_stat {
+	/* CR, LF and CRLF counts */
+	unsigned cr, lf, crlf;
+
+	/* These are just approximations! */
+	unsigned printable, nonprintable;
+};
+
+static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
+{
+	unsigned long i;
+
+	memset(stats, 0, sizeof(*stats));
+
+	for (i = 0; i < size; i++) {
+		unsigned char c = buf[i];
+		if (c == '\r') {
+			stats->cr++;
+			if (i+1 < size && buf[i+1] == '\n')
+				stats->crlf++;
+			continue;
+		}
+		if (c == '\n') {
+			stats->lf++;
+			continue;
+		}
+		if (c == '\t' || (c >= 32 && c < 127)) {
+			stats->printable++;
+			continue;
+		}
+		stats->nonprintable++;
+	}
+}
+
+/*
+ * This is just a heuristic!
+ *
+ * We do allow nonprintable characters (utf-8 and latin1 etc), but we
+ * require that they are just a fairly small percentage of the total
+ * file. 
+ */
+static int is_binary(unsigned long size, struct text_stat *stats)
+{
+	if (stats->nonprintable > (size >> 3))
+		return 1;
+	/*
+	 * Other heuristics? Average line length might be relevant,
+	 * as might LF vs CR vs CRLF counts..
+	 *
+	 * NOTE! It might be normal to have a low ratio of CRLF to LF
+	 * (somebody starts with a LF-only file and edits it with an editor
+	 * that adds CRLF only to lines that are added..). But do  we
+	 * want to support CR-only? Probably not.
+	 */
+	return 0;
+}
+
+int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
+{
+	char *buffer, *nbuf;
+	unsigned long size, nsize;
+	struct text_stat stats;
+
+	/*
+	 * FIXME! Other pluggable conversions should go here,
+	 * based on filename patterns. Right now we just do the
+	 * stupid auto-CRLF one.
+	 */
+	if (!auto_crlf)
+		return 0;
+
+	size = *sizep;
+	if (!size)
+		return 0;
+	buffer = *bufp;
+
+	gather_stats(buffer, size, &stats);
+
+	/* No CR? Nothing to convert, regardless. */
+	if (!stats.cr)
+		return 0;
+
+	/*
+	 * We're currently not going to even try to convert stuff
+	 * that has bare CR characters. Does anybody do that crazy
+	 * stuff?
+	 */
+	if (stats.cr != stats.crlf)
+		return 0;
+
+	/*
+	 * And add some heuristics for binary vs text, of course.. 
+	 */
+	if (is_binary(size, &stats))
+		return 0;
+
+	/*
+	 * Ok, allocate a new buffer, fill it in, and return true
+	 * to let the caller know that we switched buffers on it.
+	 */
+	nsize = size - stats.crlf;
+	nbuf = xmalloc(nsize);
+	*bufp = nbuf;
+	*sizep = nsize;
+	do {
+		unsigned char c = *buffer++;
+		if (c != '\r')
+			*nbuf++ = c;
+	} while (--size);
+
+	return 1;
+}
+
+int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+{
+	char *buffer, *nbuf;
+	unsigned long size, nsize;
+	struct text_stat stats;
+	unsigned char last;
+
+	/*
+	 * FIXME! Other pluggable conversions should go here,
+	 * based on filename patterns. Right now we just do the
+	 * stupid auto-CRLF one.
+	 */
+	if (!auto_crlf)
+		return 0;
+
+	size = *sizep;
+	if (!size)
+		return 0;
+	buffer = *bufp;
+
+	gather_stats(buffer, size, &stats);
+
+	/* No LF? Nothing to convert, regardless. */
+	if (!stats.lf)
+		return 0;
+
+	/* Was it already in CRLF format? */
+	if (stats.lf == stats.crlf)
+		return 0;
+
+	/* If we have any bare CR characters, we're not going to touch it */
+	if (stats.cr != stats.crlf)
+		return 0;
+
+	if (is_binary(size, &stats))
+		return 0;
+
+	/*
+	 * Ok, allocate a new buffer, fill it in, and return true
+	 * to let the caller know that we switched buffers on it.
+	 */
+	nsize = size + stats.lf - stats.crlf;
+	nbuf = xmalloc(nsize);
+	*bufp = nbuf;
+	*sizep = nsize;
+	last = 0;
+	do {
+		unsigned char c = *buffer++;
+		if (c == '\n' && last != '\r')
+			*nbuf++ = '\r';
+		*nbuf++ = c;
+		last = c;
+	} while (--size);
+
+	return 1;
+}
diff --git a/diff.c b/diff.c
index aaab309..561587c 100644
--- a/diff.c
+++ b/diff.c
@@ -1332,6 +1332,9 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	    reuse_worktree_file(s->path, s->sha1, 0)) {
 		struct stat st;
 		int fd;
+		char *buf;
+		unsigned long size;
+
 		if (lstat(s->path, &st) < 0) {
 			if (errno == ENOENT) {
 			err_empty:
@@ -1364,6 +1367,19 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		s->should_munmap = 1;
+
+		/*
+		 * Convert from working tree format to canonical git format
+		 */
+		buf = s->data;
+		size = s->size;
+		if (convert_to_git(s->path, &buf, &size)) {
+			munmap(s->data, s->size);
+			s->should_munmap = 0;
+			s->data = buf;
+			s->size = size;
+			s->should_free = 1;
+		}
 	}
 	else {
 		char type[20];
diff --git a/entry.c b/entry.c
index 0ebf0f0..472a9ef 100644
--- a/entry.c
+++ b/entry.c
@@ -78,6 +78,9 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 			path, sha1_to_hex(ce->sha1));
 	}
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
+		char *buf;
+		unsigned long nsize;
+
 	case S_IFREG:
 		if (to_tempfile) {
 			strcpy(path, ".merge_file_XXXXXX");
@@ -89,6 +92,18 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 			return error("git-checkout-index: unable to create file %s (%s)",
 				path, strerror(errno));
 		}
+
+		/*
+		 * Convert from git internal format to working tree format
+		 */
+		buf = new;
+		nsize = size;
+		if (convert_to_working_tree(ce->name, &buf, &nsize)) {
+			free(new);
+			new = buf;
+			size = nsize;
+		}
+
 		wrote = write_in_full(fd, new, size);
 		close(fd);
 		free(new);
diff --git a/environment.c b/environment.c
index 54c22f8..2fa0960 100644
--- a/environment.c
+++ b/environment.c
@@ -28,6 +28,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 int pager_in_use;
 int pager_use_color = 1;
+int auto_crlf = 0;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
diff --git a/sha1_file.c b/sha1_file.c
index 0d4bf80..6ec67b2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2082,7 +2082,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, con
 {
 	unsigned long size = st->st_size;
 	void *buf;
-	int ret;
+	int ret, re_allocated = 0;
 
 	buf = "";
 	if (size)
@@ -2091,10 +2091,30 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, con
 
 	if (!type)
 		type = blob_type;
+
+	/*
+	 * Convert blobs to git internal format
+	 */
+	if (!strcmp(type, blob_type)) {
+		unsigned long nsize = size;
+		char *nbuf = buf;
+		if (convert_to_git(NULL, &nbuf, &nsize)) {
+			if (size)
+				munmap(buf, size);
+			size = nsize;
+			buf = nbuf;
+			re_allocated = 1;
+		}
+	}
+
 	if (write_object)
 		ret = write_sha1_file(buf, size, type, sha1);
 	else
 		ret = hash_sha1_file(buf, size, type, sha1);
+	if (re_allocated) {
+		free(buf);
+		return ret;
+	}
 	if (size)
 		munmap(buf, size);
 	return ret;
