From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Implement safe_strncpy() as strlcpy() and use it more. [Take 2]
Date: Sun, 11 Jun 2006 14:03:28 +0200
Message-ID: <20060611120328.GC10430@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Jun 11 14:03:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpOfG-0002fj-4S
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWFKMDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Jun 2006 08:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWFKMDa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:03:30 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:13699 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751160AbWFKMD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:03:29 -0400
Received: (qmail 24971 invoked by uid 5842); 11 Jun 2006 14:03:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21647>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---

This time, as Ren=C3=A9 suggested, I've taken strlcpy() from the Linux =
kernel
lib/string.c.  Is it OK to not include copyright information then?

My other comments from take 1 still applies.

Peter
=20
 builtin-log.c      |    2 +-
 builtin-tar-tree.c |    4 ++--
 cache.h            |    2 +-
 config.c           |    6 +++---
 http-fetch.c       |   10 ++++------
 http-push.c        |   10 +++++-----
 ident.c            |    5 ++---
 path.c             |   13 +++++++++----
 sha1_name.c        |    3 +--
 9 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 29a8851..5b0ea28 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -112,7 +112,7 @@ static void reopen_stdout(struct commit=20
 	int len =3D 0;
=20
 	if (output_directory) {
-		strncpy(filename, output_directory, 1010);
+		safe_strncpy(filename, output_directory, 1010);
 		len =3D strlen(filename);
 		if (filename[len - 1] !=3D '/')
 			filename[len++] =3D '/';
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
=20
diff --git a/cache.h b/cache.h
index d5d7fe4..f630cf4 100644
--- a/cache.h
+++ b/cache.h
@@ -210,7 +210,7 @@ int git_mkstemp(char *path, size_t n, co
=20
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
-char *safe_strncpy(char *, const char *, size_t);
+size_t safe_strncpy(char *, const char *, size_t);
 char *enter_repo(char *path, int strict);
=20
 /* Read and unpack a sha1 file into memory, write memory to a sha1 fil=
e */
diff --git a/config.c b/config.c
index c474970..984c75f 100644
--- a/config.c
+++ b/config.c
@@ -280,17 +280,17 @@ int git_default_config(const char *var,=20
 	}
=20
 	if (!strcmp(var, "user.name")) {
-		strncpy(git_default_name, value, sizeof(git_default_name));
+		safe_strncpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
 	}
=20
 	if (!strcmp(var, "user.email")) {
-		strncpy(git_default_email, value, sizeof(git_default_email));
+		safe_strncpy(git_default_email, value, sizeof(git_default_email));
 		return 0;
 	}
=20
 	if (!strcmp(var, "i18n.commitencoding")) {
-		strncpy(git_commit_encoding, value, sizeof(git_commit_encoding));
+		safe_strncpy(git_commit_encoding, value, sizeof(git_commit_encoding)=
);
 		return 0;
 	}
=20
diff --git a/http-fetch.c b/http-fetch.c
index d3602b7..da1a7f5 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -584,10 +584,8 @@ static void process_alternates_response(
 			// skip 'objects' at end
 			if (okay) {
 				target =3D xmalloc(serverlen + posn - i - 6);
-				strncpy(target, base, serverlen);
-				strncpy(target + serverlen, data + i,
-					posn - i - 7);
-				target[serverlen + posn - i - 7] =3D '\0';
+				safe_strncpy(target, base, serverlen);
+				safe_strncpy(target + serverlen, data + i, posn - i - 6);
 				if (get_verbosely)
 					fprintf(stderr,
 						"Also look at %s\n", target);
@@ -728,8 +726,8 @@ xml_cdata(void *userData, const XML_Char
 	struct xml_ctx *ctx =3D (struct xml_ctx *)userData;
 	if (ctx->cdata)
 		free(ctx->cdata);
-	ctx->cdata =3D xcalloc(len+1, 1);
-	strncpy(ctx->cdata, s, len);
+	ctx->cdata =3D xmalloc(len + 1);
+	safe_strncpy(ctx->cdata, s, len + 1);
 }
=20
 static int remote_ls(struct alt_base *repo, const char *path, int flag=
s,
diff --git a/http-push.c b/http-push.c
index b39b36b..2d9441e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1269,8 +1269,8 @@ xml_cdata(void *userData, const XML_Char
 	struct xml_ctx *ctx =3D (struct xml_ctx *)userData;
 	if (ctx->cdata)
 		free(ctx->cdata);
-	ctx->cdata =3D xcalloc(len+1, 1);
-	strncpy(ctx->cdata, s, len);
+	ctx->cdata =3D xmalloc(len + 1);
+	safe_strncpy(ctx->cdata, s, len + 1);
 }
=20
 static struct remote_lock *lock_remote(char *path, long timeout)
@@ -1472,7 +1472,7 @@ static void process_ls_object(struct rem
 		return;
 	path +=3D 8;
 	obj_hex =3D xmalloc(strlen(path));
-	strncpy(obj_hex, path, 2);
+	safe_strncpy(obj_hex, path, 3);
 	strcpy(obj_hex + 2, path + 3);
 	one_remote_object(obj_hex);
 	free(obj_hex);
@@ -2160,8 +2160,8 @@ static void fetch_symref(char *path, cha
=20
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
 	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
-		*symref =3D xcalloc(buffer.posn - 5, 1);
-		strncpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 6);
+		*symref =3D xmalloc(buffer.posn - 5);
+		safe_strncpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
 	} else {
 		get_sha1_hex(buffer.buffer, sha1);
 	}
diff --git a/ident.c b/ident.c
index 7c81fe8..7b44cbd 100644
--- a/ident.c
+++ b/ident.c
@@ -71,10 +71,9 @@ int setup_ident(void)
 		len =3D strlen(git_default_email);
 		git_default_email[len++] =3D '.';
 		if (he && (domainname =3D strchr(he->h_name, '.')))
-			strncpy(git_default_email + len, domainname + 1, sizeof(git_default=
_email) - len);
+			safe_strncpy(git_default_email + len, domainname + 1, sizeof(git_de=
fault_email) - len);
 		else
-			strncpy(git_default_email + len, "(none)", sizeof(git_default_email=
) - len);
-		git_default_email[sizeof(git_default_email) - 1] =3D 0;
+			safe_strncpy(git_default_email + len, "(none)", sizeof(git_default_=
email) - len);
 	}
 	/* And set the default date */
 	datestamp(git_default_date, sizeof(git_default_date));
diff --git a/path.c b/path.c
index 5168b5f..194e0b5 100644
--- a/path.c
+++ b/path.c
@@ -83,14 +83,19 @@ int git_mkstemp(char *path, size_t len,=20
 }
=20
=20
-char *safe_strncpy(char *dest, const char *src, size_t n)
+size_t safe_strncpy(char *dest, const char *src, size_t size)
 {
-	strncpy(dest, src, n);
-	dest[n - 1] =3D '\0';
+	size_t ret =3D strlen(src);
=20
-	return dest;
+	if (size) {
+		size_t len =3D (ret >=3D size) ? size - 1 : ret;
+		memcpy(dest, src, len);
+		dest[len] =3D '\0';
+	}
+	return ret;
 }
=20
+
 int validate_symref(const char *path)
 {
 	struct stat st;
diff --git a/sha1_name.c b/sha1_name.c
index fbbde1c..8fe9b7a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -262,8 +262,7 @@ static int get_sha1_basic(const char *st
 		if (str[am] =3D=3D '@' && str[am+1] =3D=3D '{' && str[len-1] =3D=3D =
'}') {
 			int date_len =3D len - am - 3;
 			char *date_spec =3D xmalloc(date_len + 1);
-			strncpy(date_spec, str + am + 2, date_len);
-			date_spec[date_len] =3D 0;
+			safe_strncpy(date_spec, str + am + 2, date_len + 1);
 			at_time =3D approxidate(date_spec);
 			free(date_spec);
 			len =3D am;
--=20
1.3.3.g16a4
