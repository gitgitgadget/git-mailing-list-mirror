From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/9] General const correctness fixes
Date: Tue, 6 Mar 2007 20:44:17 -0500
Message-ID: <20070307014417.GE26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEH-00070d-PJ
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbXCGBpB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbXCGBo7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49207 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161175AbXCGBoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCK-0003pS-8i; Tue, 06 Mar 2007 20:44:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F90320FB65; Tue,  6 Mar 2007 20:44:17 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41642>

We shouldn't attempt to assign constant strings into char*, as the
string is not writable at runtime.  Likewise we should always be
treating unsigned values as unsigned values, not as signed values.

Most of these are very straightforward.  The only exception is the
(unnecessary) xstrdup/free in builtin-branch.c for the detached
head case.  Since this is a user-level interactive type program
and that particular code path is executed no more than once, I feel
that the extra xstrdup call is well worth the easy elimination of
this warning.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-blame.c        |   20 ++++++++++----------
 builtin-branch.c       |    3 ++-
 builtin-for-each-ref.c |    6 +++---
 builtin-mailinfo.c     |    6 +++---
 builtin-shortlog.c     |    4 ++--
 builtin-show-branch.c  |    3 ++-
 cache.h                |    2 +-
 commit.c               |   21 +++++++++------------
 convert-objects.c      |    2 +-
 environment.c          |    2 +-
 fast-import.c          |    2 +-
 index-pack.c           |    2 +-
 interpolate.c          |    2 +-
 interpolate.h          |    2 +-
 path.c                 |    2 +-
 sha1_file.c            |    3 +--
 16 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 9f7dd4e..20966b9 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1244,26 +1244,26 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
  */
 struct commit_info
 {
-	char *author;
-	char *author_mail;
+	const char *author;
+	const char *author_mail;
 	unsigned long author_time;
-	char *author_tz;
+	const char *author_tz;
 
 	/* filled only when asked for details */
-	char *committer;
-	char *committer_mail;
+	const char *committer;
+	const char *committer_mail;
 	unsigned long committer_time;
-	char *committer_tz;
+	const char *committer_tz;
 
-	char *summary;
+	const char *summary;
 };
 
 /*
  * Parse author/committer line in the commit object buffer
  */
 static void get_ac_line(const char *inbuf, const char *what,
-			int bufsz, char *person, char **mail,
-			unsigned long *time, char **tz)
+			int bufsz, char *person, const char **mail,
+			unsigned long *time, const char **tz)
 {
 	int len;
 	char *tmp, *endp;
@@ -1280,7 +1280,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	if (bufsz <= len) {
 	error_out:
 		/* Ugh */
-		person = *mail = *tz = "(unknown)";
+		*mail = *tz = "(unknown)";
 		*time = 0;
 		return;
 	}
diff --git a/builtin-branch.c b/builtin-branch.c
index d371849..06d8a8c 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -289,12 +289,13 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
 	if (detached) {
 		struct ref_item item;
-		item.name = "(no branch)";
+		item.name = xstrdup("(no branch)");
 		item.kind = REF_LOCAL_BRANCH;
 		hashcpy(item.sha1, head_sha1);
 		if (strlen(item.name) > ref_list.maxwidth)
 			      ref_list.maxwidth = strlen(item.name);
 		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+		free(item.name);
 	}
 
 	for (i = 0; i < ref_list.index; i++) {
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index b11ca92..2b21842 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -301,7 +301,7 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
 	return "";
 }
 
-static char *copy_line(const char *buf)
+static const char *copy_line(const char *buf)
 {
 	const char *eol = strchr(buf, '\n');
 	char *line;
@@ -315,7 +315,7 @@ static char *copy_line(const char *buf)
 	return line;
 }
 
-static char *copy_name(const char *buf)
+static const char *copy_name(const char *buf)
 {
 	const char *eol = strchr(buf, '\n');
 	const char *eoname = strstr(buf, " <");
@@ -330,7 +330,7 @@ static char *copy_name(const char *buf)
 	return line;
 }
 
-static char *copy_email(const char *buf)
+static const char *copy_email(const char *buf)
 {
 	const char *email = strchr(buf, '<');
 	const char *eoemail = strchr(email, '>');
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 766a37e..f54e875 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -545,10 +545,10 @@ static int decode_b_segment(char *in, char *ot, char *ep)
 	return 0;
 }
 
-static void convert_to_utf8(char *line, char *charset)
+static void convert_to_utf8(char *line, const char *charset)
 {
-	static char latin_one[] = "latin1";
-	char *input_charset = *charset ? charset : latin_one;
+	static const char latin_one[] = "latin1";
+	const char *input_charset = *charset ? charset : latin_one;
 	char *out = reencode_string(line, metainfo_charset, input_charset);
 
 	if (!out)
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 2f71a2a..2d7726e 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -217,13 +217,13 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 
 	prepare_revision_walk(rev);
 	while ((commit = get_revision(rev)) != NULL) {
-		char *author = NULL, *oneline, *buffer;
+		const char *author = NULL, *oneline, *buffer;
 		int authorlen = authorlen, onelinelen;
 
 		/* get author and oneline */
 		for (buffer = commit->buffer; buffer && *buffer != '\0' &&
 				*buffer != '\n'; ) {
-			char *eol = strchr(buffer, '\n');
+			const char *eol = strchr(buffer, '\n');
 
 			if (eol == NULL)
 				eol = buffer + strlen(buffer);
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 67ae6ba..c892f1f 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -721,7 +721,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 
 		for (i = 0; i < reflog; i++) {
-			char *logmsg, *msg, *m;
+			char *logmsg, *m;
+			const char *msg;
 			unsigned long timestamp;
 			int tz;
 
diff --git a/cache.h b/cache.h
index c291163..f3d7538 100644
--- a/cache.h
+++ b/cache.h
@@ -451,7 +451,7 @@ extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 
 extern char *git_commit_encoding;
-extern char *git_log_output_encoding;
+extern const char *git_log_output_encoding;
 
 extern int copy_fd(int ifd, int ofd);
 extern int read_in_full(int fd, void *buf, size_t count);
diff --git a/commit.c b/commit.c
index 5552527..5b9234e 100644
--- a/commit.c
+++ b/commit.c
@@ -651,7 +651,7 @@ static char *get_header(const struct commit *commit, const char *key)
 	}
 }
 
-static char *replace_encoding_header(char *buf, char *encoding)
+static char *replace_encoding_header(char *buf, const char *encoding)
 {
 	char *encoding_header = strstr(buf, "\nencoding ");
 	char *end_of_encoding_header;
@@ -694,29 +694,26 @@ static char *replace_encoding_header(char *buf, char *encoding)
 }
 
 static char *logmsg_reencode(const struct commit *commit,
-			     char *output_encoding)
+			     const char *output_encoding)
 {
+	static const char *utf8 = "utf-8";
+	const char *use_encoding;
 	char *encoding;
 	char *out;
-	char *utf8 = "utf-8";
 
 	if (!*output_encoding)
 		return NULL;
 	encoding = get_header(commit, "encoding");
-	if (!encoding)
-		encoding = utf8;
-	if (!strcmp(encoding, output_encoding))
+	use_encoding = encoding ? encoding : utf8;
+	if (!strcmp(use_encoding, output_encoding))
 		out = strdup(commit->buffer);
 	else
 		out = reencode_string(commit->buffer,
-				      output_encoding, encoding);
+				      output_encoding, use_encoding);
 	if (out)
 		out = replace_encoding_header(out, output_encoding);
 
-	if (encoding != utf8)
-		free(encoding);
-	if (!out)
-		return NULL;
+	free(encoding);
 	return out;
 }
 
@@ -917,7 +914,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	const char *msg = commit->buffer;
 	int plain_non_ascii = 0;
 	char *reencoded;
-	char *encoding;
+	const char *encoding;
 
 	if (fmt == CMIT_FMT_USERFORMAT)
 		return format_commit_message(commit, msg, buf, space);
diff --git a/convert-objects.c b/convert-objects.c
index b5f41ae..4809f91 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -132,7 +132,7 @@ static void convert_tree(void *buffer, unsigned long size, unsigned char *result
 	unsigned long orig_size = size;
 
 	while (size) {
-		int len = 1+strlen(buffer);
+		size_t len = 1+strlen(buffer);
 
 		convert_binary_sha1((char *) buffer + len);
 
diff --git a/environment.c b/environment.c
index 49486dd..0151ad0 100644
--- a/environment.c
+++ b/environment.c
@@ -21,7 +21,7 @@ int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 char *git_commit_encoding;
-char *git_log_output_encoding;
+const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
diff --git a/fast-import.c b/fast-import.c
index cc3347b..132dd9c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -757,7 +757,7 @@ static char *create_index(void)
 static char *keep_pack(char *curr_index_name)
 {
 	static char name[PATH_MAX];
-	static char *keep_msg = "fast-import";
+	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
 	chmod(pack_data->pack_name, 0444);
diff --git a/index-pack.c b/index-pack.c
index cf81a99..b405864 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -753,7 +753,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *keep_name, const char *keep_msg,
 		  unsigned char *sha1)
 {
-	char *report = "pack";
+	const char *report = "pack";
 	char name[PATH_MAX];
 	int err;
 
diff --git a/interpolate.c b/interpolate.c
index f992ef7..fb30694 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -55,7 +55,7 @@ int interpolate(char *result, int reslen,
 	const char *src = orig;
 	char *dest = result;
 	int newlen = 0;
-	char *name, *value;
+	const char *name, *value;
 	int namelen, valuelen;
 	int i;
 	char c;
diff --git a/interpolate.h b/interpolate.h
index 190a180..16a26b9 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -12,7 +12,7 @@
  */
 
 struct interp {
-	char *name;
+	const char *name;
 	char *value;
 };
 
diff --git a/path.c b/path.c
index c5d25a4..6395cf2 100644
--- a/path.c
+++ b/path.c
@@ -252,7 +252,7 @@ char *enter_repo(char *path, int strict)
 
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_headref("HEAD") == 0) {
-		putenv("GIT_DIR=.");
+		setenv("GIT_DIR", ".", 1);
 		check_repository_format();
 		return path;
 	}
diff --git a/sha1_file.c b/sha1_file.c
index cfce7ac..b17a828 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2065,10 +2065,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	     enum object_type type, const char *path)
 {
 	unsigned long size = st->st_size;
-	void *buf;
+	void *buf = NULL;
 	int ret, re_allocated = 0;
 
-	buf = "";
 	if (size)
 		buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-- 
1.5.0.3.863.gf0989
