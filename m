From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Implement safe_strncpy() as strlcpy() and use it more.
Date: Sun, 11 Jun 2006 12:06:28 +0200
Message-ID: <20060611100628.GA10430@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 11 12:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpMqD-0000Fh-S8
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 12:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWFKKGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 06:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFKKGb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 06:06:31 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:53485 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1750836AbWFKKGa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 06:06:30 -0400
Received: (qmail 1456 invoked by uid 5842); 11 Jun 2006 12:06:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21643>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---

I've taken strlcpy() from the OpenBSD CVS without attribution.  Is this
allowed?  If it is, how should it be stated?

I think this fixes some small errors, but might introduce some new ones.
I've tried to be very careful, but this really needs some more eyeballs.
What do you think?

Peter

P.S. By the way, the diff of safe_strncpy() isn't so pretty, because
what I really did was replace the entire function, not edit it.

 builtin-log.c      |    2 +-
 builtin-tar-tree.c |    4 ++--
 cache.h            |    2 +-
 config.c           |    6 +++---
 http-fetch.c       |   10 ++++------
 http-push.c        |   10 +++++-----
 ident.c            |    5 ++---
 path.c             |   31 +++++++++++++++++++++++++++----
 sha1_name.c        |    3 +--
 9 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 29a8851..5b0ea28 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -112,7 +112,7 @@ static void reopen_stdout(struct commit 
 	int len = 0;
 
 	if (output_directory) {
-		strncpy(filename, output_directory, 1010);
+		safe_strncpy(filename, output_directory, 1010);
 		len = strlen(filename);
 		if (filename[len - 1] != '/')
 			filename[len++] = '/';
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 58a8ccd..f6310b9 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -240,8 +240,8 @@ static void write_entry(const unsigned c
 	/* XXX: should we provide more meaningful info here? */
 	sprintf(header.uid, "%07o", 0);
 	sprintf(header.gid, "%07o", 0);
-	strncpy(header.uname, "git", 31);
-	strncpy(header.gname, "git", 31);
+	safe_strncpy(header.uname, "git", sizeof(header.uname));
+	safe_strncpy(header.gname, "git", sizeof(header.gname));
 	sprintf(header.devmajor, "%07o", 0);
 	sprintf(header.devminor, "%07o", 0);
 
diff --git a/cache.h b/cache.h
index d5d7fe4..f630cf4 100644
--- a/cache.h
+++ b/cache.h
@@ -210,7 +210,7 @@ int git_mkstemp(char *path, size_t n, co
 
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
-char *safe_strncpy(char *, const char *, size_t);
+size_t safe_strncpy(char *, const char *, size_t);
 char *enter_repo(char *path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
diff --git a/config.c b/config.c
index c474970..984c75f 100644
--- a/config.c
+++ b/config.c
@@ -280,17 +280,17 @@ int git_default_config(const char *var, 
 	}
 
 	if (!strcmp(var, "user.name")) {
-		strncpy(git_default_name, value, sizeof(git_default_name));
+		safe_strncpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
 	}
 
 	if (!strcmp(var, "user.email")) {
-		strncpy(git_default_email, value, sizeof(git_default_email));
+		safe_strncpy(git_default_email, value, sizeof(git_default_email));
 		return 0;
 	}
 
 	if (!strcmp(var, "i18n.commitencoding")) {
-		strncpy(git_commit_encoding, value, sizeof(git_commit_encoding));
+		safe_strncpy(git_commit_encoding, value, sizeof(git_commit_encoding));
 		return 0;
 	}
 
diff --git a/http-fetch.c b/http-fetch.c
index d3602b7..da1a7f5 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -584,10 +584,8 @@ static void process_alternates_response(
 			// skip 'objects' at end
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
-				strncpy(target, base, serverlen);
-				strncpy(target + serverlen, data + i,
-					posn - i - 7);
-				target[serverlen + posn - i - 7] = '\0';
+				safe_strncpy(target, base, serverlen);
+				safe_strncpy(target + serverlen, data + i, posn - i - 6);
 				if (get_verbosely)
 					fprintf(stderr,
 						"Also look at %s\n", target);
@@ -728,8 +726,8 @@ xml_cdata(void *userData, const XML_Char
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
 	if (ctx->cdata)
 		free(ctx->cdata);
-	ctx->cdata = xcalloc(len+1, 1);
-	strncpy(ctx->cdata, s, len);
+	ctx->cdata = xmalloc(len + 1);
+	safe_strncpy(ctx->cdata, s, len + 1);
 }
 
 static int remote_ls(struct alt_base *repo, const char *path, int flags,
diff --git a/http-push.c b/http-push.c
index b39b36b..2d9441e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1269,8 +1269,8 @@ xml_cdata(void *userData, const XML_Char
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
 	if (ctx->cdata)
 		free(ctx->cdata);
-	ctx->cdata = xcalloc(len+1, 1);
-	strncpy(ctx->cdata, s, len);
+	ctx->cdata = xmalloc(len + 1);
+	safe_strncpy(ctx->cdata, s, len + 1);
 }
 
 static struct remote_lock *lock_remote(char *path, long timeout)
@@ -1472,7 +1472,7 @@ static void process_ls_object(struct rem
 		return;
 	path += 8;
 	obj_hex = xmalloc(strlen(path));
-	strncpy(obj_hex, path, 2);
+	safe_strncpy(obj_hex, path, 3);
 	strcpy(obj_hex + 2, path + 3);
 	one_remote_object(obj_hex);
 	free(obj_hex);
@@ -2160,8 +2160,8 @@ static void fetch_symref(char *path, cha
 
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
 	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
-		*symref = xcalloc(buffer.posn - 5, 1);
-		strncpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 6);
+		*symref = xmalloc(buffer.posn - 5);
+		safe_strncpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
 	} else {
 		get_sha1_hex(buffer.buffer, sha1);
 	}
diff --git a/ident.c b/ident.c
index 7c81fe8..7b44cbd 100644
--- a/ident.c
+++ b/ident.c
@@ -71,10 +71,9 @@ int setup_ident(void)
 		len = strlen(git_default_email);
 		git_default_email[len++] = '.';
 		if (he && (domainname = strchr(he->h_name, '.')))
-			strncpy(git_default_email + len, domainname + 1, sizeof(git_default_email) - len);
+			safe_strncpy(git_default_email + len, domainname + 1, sizeof(git_default_email) - len);
 		else
-			strncpy(git_default_email + len, "(none)", sizeof(git_default_email) - len);
-		git_default_email[sizeof(git_default_email) - 1] = 0;
+			safe_strncpy(git_default_email + len, "(none)", sizeof(git_default_email) - len);
 	}
 	/* And set the default date */
 	datestamp(git_default_date, sizeof(git_default_date));
diff --git a/path.c b/path.c
index 5168b5f..86f51e0 100644
--- a/path.c
+++ b/path.c
@@ -83,14 +83,37 @@ int git_mkstemp(char *path, size_t len, 
 }
 
 
-char *safe_strncpy(char *dest, const char *src, size_t n)
+/*
+ * Copy src to string dst of size siz.  At most siz-1 characters
+ * will be copied.  Always NUL terminates (unless siz == 0).
+ * Returns strlen(src); if retval >= siz, truncation occurred.
+ */
+size_t safe_strncpy(char *dst, const char *src, size_t siz)
 {
-	strncpy(dest, src, n);
-	dest[n - 1] = '\0';
+	char *d = dst;
+	const char *s = src;
+	size_t n = siz;
 
-	return dest;
+	/* Copy as many bytes as will fit */
+	if (n != 0) {
+		while (--n != 0) {
+			if ((*d++ = *s++) == '\0')
+				break;
+		}
+	}
+
+	/* Not enough room in dst, add NUL and traverse rest of src */
+	if (n == 0) {
+		if (siz != 0)
+			*d = '\0';		/* NUL-terminate dst */
+		while (*s++)
+			;
+	}
+
+	return(s - src - 1);	/* count does not include NUL */
 }
 
+
 int validate_symref(const char *path)
 {
 	struct stat st;
diff --git a/sha1_name.c b/sha1_name.c
index fbbde1c..8fe9b7a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -262,8 +262,7 @@ static int get_sha1_basic(const char *st
 		if (str[am] == '@' && str[am+1] == '{' && str[len-1] == '}') {
 			int date_len = len - am - 3;
 			char *date_spec = xmalloc(date_len + 1);
-			strncpy(date_spec, str + am + 2, date_len);
-			date_spec[date_len] = 0;
+			safe_strncpy(date_spec, str + am + 2, date_len + 1);
 			at_time = approxidate(date_spec);
 			free(date_spec);
 			len = am;
-- 
1.3.3.g16a4
