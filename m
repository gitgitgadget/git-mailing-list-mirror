From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Rename safe_strncpy() to strlcpy().
Date: Sat, 24 Jun 2006 16:01:25 +0200
Message-ID: <20060624140124.GA1323@ebar092.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 24 16:19:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu8yU-0000b8-GA
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 16:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbWFXOS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 10:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbWFXOS7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 10:18:59 -0400
Received: from ebar092.ebar.dtu.dk ([192.38.93.107]:40935 "HELO
	ebar092.ebar.dtu.dk") by vger.kernel.org with SMTP id S1752244AbWFXOS7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 10:18:59 -0400
Received: (qmail 1673 invoked by uid 5842); 24 Jun 2006 14:01:25 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22519>

This cleans up the use of safe_strncpy() even more.  Since it has the
same semantics as strlcpy() use this name instead.  Also move the
definition from inside path.c to its own file compat/strlcpy.c, and use
it conditionally at compile time, since some platforms already has
strlcpy().  It's included in the same way as compat/setenv.c.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---

I've introduced a NO_STRLCPY variable in the Makefile.  What do
you think about this?

I've made a qualified guess as to what systems have strlcpy() in
their standard library, but I am probably not completely right.

These are the ones I've said have it:
OpenBSD, FreeBSD, NetBSD

These I've said don't:
Linux, Darwin, SunOS, Cygwin, AIX, IRIX64

Regards,

Peter

 Makefile           |   14 ++++++++++++++
 builtin-log.c      |    2 +-
 builtin-tar-tree.c |    4 ++--
 cache.h            |    1 -
 compat/strlcpy.c   |   13 +++++++++++++
 config.c           |    6 +++---
 git-compat-util.h  |    5 +++++
 http-fetch.c       |    6 +++---
 http-push.c        |    6 +++---
 ident.c            |    4 ++--
 path.c             |   15 +--------------
 sha1_name.c        |    2 +-
 12 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index e29e3fa..cde619c 100644
--- a/Makefile
+++ b/Makefile
@@ -26,6 +26,8 @@ # d_type in struct dirent (latest Cygwin
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
+# Define NO_STRLCPY if you don't have strlcpy.
+#
 # Define NO_SETENV if you don't have setenv in the C library.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -240,9 +242,13 @@ # We choose to avoid "if .. else if .. e
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
+ifeq ($(uname_S),Linux)
+	NO_STRLCPY = YesPlease
+endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	NO_STRLCPY = YesPlease
 	## fink
 	ifeq ($(shell test -d /sw/lib && echo y),y)
 		ALL_CFLAGS += -I/sw/include
@@ -259,6 +265,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
@@ -276,6 +283,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	# There are conflicting reports about this.
@@ -305,12 +313,14 @@ ifeq ($(uname_S),NetBSD)
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
+	NO_STRLCPY = YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
+	NO_STRLCPY = YesPlease
 	NO_SOCKADDR_STORAGE=YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	ALL_CFLAGS += -DPATH_MAX=1024
@@ -403,6 +413,10 @@ ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
 	COMPAT_OBJS += compat/strcasestr.o
 endif
+ifdef NO_STRLCPY
+	COMPAT_CFLAGS += -DNO_STRLCPY
+	COMPAT_OBJS += compat/strlcpy.o
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
diff --git a/builtin-log.c b/builtin-log.c
index 5a8a50b..44d2d13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -115,7 +115,7 @@ static void reopen_stdout(struct commit 
 	int len = 0;
 
 	if (output_directory) {
-		safe_strncpy(filename, output_directory, 1010);
+		strlcpy(filename, output_directory, 1010);
 		len = strlen(filename);
 		if (filename[len - 1] != '/')
 			filename[len++] = '/';
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 39a61b6..f2e48aa 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -233,8 +233,8 @@ static void write_entry(const unsigned c
 	/* XXX: should we provide more meaningful info here? */
 	sprintf(header.uid, "%07o", 0);
 	sprintf(header.gid, "%07o", 0);
-	safe_strncpy(header.uname, "git", sizeof(header.uname));
-	safe_strncpy(header.gname, "git", sizeof(header.gname));
+	strlcpy(header.uname, "git", sizeof(header.uname));
+	strlcpy(header.gname, "git", sizeof(header.gname));
 	sprintf(header.devmajor, "%07o", 0);
 	sprintf(header.devminor, "%07o", 0);
 
diff --git a/cache.h b/cache.h
index efeafea..14358a8 100644
--- a/cache.h
+++ b/cache.h
@@ -216,7 +216,6 @@ enum sharedrepo {
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
-size_t safe_strncpy(char *, const char *, size_t);
 char *enter_repo(char *path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
diff --git a/compat/strlcpy.c b/compat/strlcpy.c
new file mode 100644
index 0000000..b66856a
--- /dev/null
+++ b/compat/strlcpy.c
@@ -0,0 +1,13 @@
+#include <string.h>
+
+size_t gitstrlcpy(char *dest, const char *src, size_t size)
+{
+	size_t ret = strlen(src);
+
+	if (size) {
+		size_t len = (ret >= size) ? size - 1 : ret;
+		memcpy(dest, src, len);
+		dest[len] = '\0';
+	}
+	return ret;
+}
diff --git a/config.c b/config.c
index 3e077d4..ec44827 100644
--- a/config.c
+++ b/config.c
@@ -280,17 +280,17 @@ int git_default_config(const char *var, 
 	}
 
 	if (!strcmp(var, "user.name")) {
-		safe_strncpy(git_default_name, value, sizeof(git_default_name));
+		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
 	}
 
 	if (!strcmp(var, "user.email")) {
-		safe_strncpy(git_default_email, value, sizeof(git_default_email));
+		strlcpy(git_default_email, value, sizeof(git_default_email));
 		return 0;
 	}
 
 	if (!strcmp(var, "i18n.commitencoding")) {
-		safe_strncpy(git_commit_encoding, value, sizeof(git_commit_encoding));
+		strlcpy(git_commit_encoding, value, sizeof(git_commit_encoding));
 		return 0;
 	}
 
diff --git a/git-compat-util.h b/git-compat-util.h
index b3d4cf5..93f5580 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -79,6 +79,11 @@ #define strcasestr gitstrcasestr
 extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
+#ifdef NO_STRLCPY
+#define strlcpy gitstrlcpy
+extern size_t gitstrlcpy(char *, const char *, size_t);
+#endif
+
 static inline void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
diff --git a/http-fetch.c b/http-fetch.c
index 2b63d89..44eba5f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -584,8 +584,8 @@ static void process_alternates_response(
 			// skip 'objects' at end
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
-				safe_strncpy(target, base, serverlen);
-				safe_strncpy(target + serverlen, data + i, posn - i - 6);
+				strlcpy(target, base, serverlen);
+				strlcpy(target + serverlen, data + i, posn - i - 6);
 				if (get_verbosely)
 					fprintf(stderr,
 						"Also look at %s\n", target);
@@ -727,7 +727,7 @@ xml_cdata(void *userData, const XML_Char
 	if (ctx->cdata)
 		free(ctx->cdata);
 	ctx->cdata = xmalloc(len + 1);
-	safe_strncpy(ctx->cdata, s, len + 1);
+	strlcpy(ctx->cdata, s, len + 1);
 }
 
 static int remote_ls(struct alt_base *repo, const char *path, int flags,
diff --git a/http-push.c b/http-push.c
index 8d472f0..3c89a17 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1271,7 +1271,7 @@ xml_cdata(void *userData, const XML_Char
 	if (ctx->cdata)
 		free(ctx->cdata);
 	ctx->cdata = xmalloc(len + 1);
-	safe_strncpy(ctx->cdata, s, len + 1);
+	strlcpy(ctx->cdata, s, len + 1);
 }
 
 static struct remote_lock *lock_remote(char *path, long timeout)
@@ -1473,7 +1473,7 @@ static void process_ls_object(struct rem
 		return;
 	path += 8;
 	obj_hex = xmalloc(strlen(path));
-	safe_strncpy(obj_hex, path, 3);
+	strlcpy(obj_hex, path, 3);
 	strcpy(obj_hex + 2, path + 3);
 	one_remote_object(obj_hex);
 	free(obj_hex);
@@ -2172,7 +2172,7 @@ static void fetch_symref(char *path, cha
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
 	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
 		*symref = xmalloc(buffer.posn - 5);
-		safe_strncpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
+		strlcpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
 	} else {
 		get_sha1_hex(buffer.buffer, sha1);
 	}
diff --git a/ident.c b/ident.c
index 7b44cbd..efec97f 100644
--- a/ident.c
+++ b/ident.c
@@ -71,9 +71,9 @@ int setup_ident(void)
 		len = strlen(git_default_email);
 		git_default_email[len++] = '.';
 		if (he && (domainname = strchr(he->h_name, '.')))
-			safe_strncpy(git_default_email + len, domainname + 1, sizeof(git_default_email) - len);
+			strlcpy(git_default_email + len, domainname + 1, sizeof(git_default_email) - len);
 		else
-			safe_strncpy(git_default_email + len, "(none)", sizeof(git_default_email) - len);
+			strlcpy(git_default_email + len, "(none)", sizeof(git_default_email) - len);
 	}
 	/* And set the default date */
 	datestamp(git_default_date, sizeof(git_default_date));
diff --git a/path.c b/path.c
index 36972fd..db8905f 100644
--- a/path.c
+++ b/path.c
@@ -77,25 +77,12 @@ int git_mkstemp(char *path, size_t len, 
 		pch += n;
 	}
 
-	safe_strncpy(pch, template, len);
+	strlcpy(pch, template, len);
 
 	return mkstemp(path);
 }
 
 
-size_t safe_strncpy(char *dest, const char *src, size_t size)
-{
-	size_t ret = strlen(src);
-
-	if (size) {
-		size_t len = (ret >= size) ? size - 1 : ret;
-		memcpy(dest, src, len);
-		dest[len] = '\0';
-	}
-	return ret;
-}
-
-
 int validate_symref(const char *path)
 {
 	struct stat st;
diff --git a/sha1_name.c b/sha1_name.c
index cd85d1f..f2cbafa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -262,7 +262,7 @@ static int get_sha1_basic(const char *st
 		if (str[am] == '@' && str[am+1] == '{' && str[len-1] == '}') {
 			int date_len = len - am - 3;
 			char *date_spec = xmalloc(date_len + 1);
-			safe_strncpy(date_spec, str + am + 2, date_len + 1);
+			strlcpy(date_spec, str + am + 2, date_len + 1);
 			at_time = approxidate(date_spec);
 			free(date_spec);
 			len = am;
-- 
1.4.1.rc1.g8637
