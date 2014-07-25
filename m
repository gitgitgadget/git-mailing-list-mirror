From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] refs.c: refactor resolve_ref_unsafe() to use strbuf internally
Date: Fri, 25 Jul 2014 17:43:57 +0700
Message-ID: <1406285039-22469-3-git-send-email-pclouds@gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAczC-000494-RE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 12:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760113AbaGYKoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 06:44:22 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34114 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaGYKoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 06:44:21 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so5491883pdj.36
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yGkN4Au/aaXptaBZB0/Bhk3iQAJmPZFW7NW/pL07SJk=;
        b=MaPEgJT68233+Tdfrx7bCGMdM9ekqy4A6H0W97XZfCFX7q3m3huyCrEHPpqsirLipr
         Vv6s5XIh/bcO4jddrXKNX6UvfBk0iEQIg+5w5zFWDOkyTe8UYtyahX5pUQ0T+FV+reZO
         lMlt7kOFEYRlGYgHgm81gHuGv0vB+bXxae73UReMnWuUYZnoNkmQGLb8svUU4UK4Fh9w
         HP0EyEbAEDe4xMbOkRuoAF6s0nYGod4vyw/9r5s5nrjQ1ENSHhcX5xvMw7+xit9W0xwG
         lGMC7+WSudm6AsXbdeAnz7kcEwMFOH3XtGpzE5qqqJZJxSofBMcGdHFYxzpHS46C0KVi
         HhOw==
X-Received: by 10.70.88.205 with SMTP id bi13mr17791338pdb.43.1406285061177;
        Fri, 25 Jul 2014 03:44:21 -0700 (PDT)
Received: from lanh ([115.73.251.194])
        by mx.google.com with ESMTPSA id oy12sm8426902pbb.27.2014.07.25.03.44.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jul 2014 03:44:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jul 2014 17:44:18 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254205>

In the beginning, we had resolve_ref() that returns a buffer owned by
this function. Then we started to move away from that direction because
the buffer could be overwritten by the next resolve_ref() call and
introduced two new functions: resolve_ref_unsafe() and resolve_refdup()=
=2E
The static buffer is still kept internally.

This patch makes the core of resolve_ref use a strbuf instead of static
buffer. Which makes resolve_refdup() more efficient (no need to copy
from the static buffer to a new buffer). It also removes the (random?)
256 char limit. In future, resolve_ref() could be used directly without
going through resolve_refdup() wrapper.

A minor bonus. resolve_ref(dup) are now more thread-friendly (although =
I'm
not 100% sure if they are thread-safe yet).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   1 +
 refs.c  | 122 +++++++++++++++++++++++++++++++++++---------------------=
--------
 2 files changed, 68 insertions(+), 55 deletions(-)

diff --git a/cache.h b/cache.h
index fcb511d..5ffbafb 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,6 +1002,7 @@ extern int read_ref(const char *refname, unsigned=
 char *sha1);
  */
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *=
sha1, int reading, int *flag);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
+extern int resolve_ref(const char *refname, struct strbuf *result, uns=
igned char *sha1, int reading, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/refs.c b/refs.c
index 84b9070..bec2bb1 100644
--- a/refs.c
+++ b/refs.c
@@ -1506,10 +1506,10 @@ static struct ref_entry *get_packed_ref(const c=
har *refname)
  * A loose ref file doesn't exist; check for a packed ref.  The
  * options are forwarded from resolve_safe_unsafe().
  */
-static const char *handle_missing_loose_ref(const char *refname,
-					    unsigned char *sha1,
-					    int reading,
-					    int *flag)
+static int handle_missing_loose_ref(const char *refname,
+				    unsigned char *sha1,
+				    int reading,
+				    int *flag)
 {
 	struct ref_entry *entry;
=20
@@ -1522,45 +1522,53 @@ static const char *handle_missing_loose_ref(con=
st char *refname,
 		hashcpy(sha1, entry->u.value.sha1);
 		if (flag)
 			*flag |=3D REF_ISPACKED;
-		return refname;
+		return 0;
 	}
 	/* The reference is not a packed reference, either. */
 	if (reading) {
-		return NULL;
+		return -1;
 	} else {
 		hashclr(sha1);
-		return refname;
+		return 0;
 	}
 }
=20
-/* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha=
1, int reading, int *flag)
+/*
+ * 'result' content will be destroyed. Its value may be undefined if
+ * resolve_ref returns -1.
+ *
+ * This function needs to return a meaningful errno on failure
+ */
+int resolve_ref(const char *refname, struct strbuf *result,
+		unsigned char *sha1, int reading, int *flag)
 {
+	struct strbuf buffer =3D STRBUF_INIT;
 	int depth =3D MAXDEPTH;
-	ssize_t len;
-	char buffer[256];
-	static char refname_buffer[256];
+	int ret =3D -1;
=20
 	if (flag)
 		*flag =3D 0;
=20
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		errno =3D EINVAL;
-		return NULL;
+		return -1;
 	}
=20
+	strbuf_reset(result);
+	strbuf_addstr(result, refname);
+
 	for (;;) {
 		char path[PATH_MAX];
+		const char *ref =3D result->buf;
 		struct stat st;
-		char *buf;
-		int fd;
+		const char *buf;
=20
 		if (--depth < 0) {
 			errno =3D ELOOP;
-			return NULL;
+			break;
 		}
=20
-		git_snpath(path, sizeof(path), "%s", refname);
+		git_snpath(path, sizeof(path), "%s", ref);
=20
 		/*
 		 * We might have to loop back here to avoid a race
@@ -1574,27 +1582,25 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 	stat_ref:
 		if (lstat(path, &st) < 0) {
 			if (errno =3D=3D ENOENT)
-				return handle_missing_loose_ref(refname, sha1,
-								reading, flag);
-			else
-				return NULL;
+				ret =3D handle_missing_loose_ref(ref, sha1,
+							       reading, flag);
+			break;
 		}
=20
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
-			len =3D readlink(path, buffer, sizeof(buffer)-1);
-			if (len < 0) {
+			/* no need to reset buffer, strbuf_readlink does that */
+			if (strbuf_readlink(&buffer, path, 256) < 0) {
 				if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
 					/* inconsistent with lstat; retry */
 					goto stat_ref;
 				else
-					return NULL;
+					break;
 			}
-			buffer[len] =3D 0;
-			if (starts_with(buffer, "refs/") &&
-					!check_refname_format(buffer, 0)) {
-				strcpy(refname_buffer, buffer);
-				refname =3D refname_buffer;
+			if (starts_with(buffer.buf, "refs/") &&
+			    !check_refname_format(buffer.buf, 0)) {
+				strbuf_reset(result);
+				strbuf_addbuf(result, &buffer);
 				if (flag)
 					*flag |=3D REF_ISSYMREF;
 				continue;
@@ -1604,69 +1610,75 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 		/* Is it a directory? */
 		if (S_ISDIR(st.st_mode)) {
 			errno =3D EISDIR;
-			return NULL;
+			break;
 		}
=20
 		/*
 		 * Anything else, just open it and try to use it as
 		 * a ref
 		 */
-		fd =3D open(path, O_RDONLY);
-		if (fd < 0) {
+		strbuf_reset(&buffer);
+		if (strbuf_read_file(&buffer, path, 256) < 0) {
 			if (errno =3D=3D ENOENT)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
-				return NULL;
-		}
-		len =3D read_in_full(fd, buffer, sizeof(buffer)-1);
-		if (len < 0) {
-			int save_errno =3D errno;
-			close(fd);
-			errno =3D save_errno;
-			return NULL;
+				break;
 		}
-		close(fd);
-		while (len && isspace(buffer[len-1]))
-			len--;
-		buffer[len] =3D '\0';
+		strbuf_rtrim(&buffer);
=20
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (!starts_with(buffer, "ref:")) {
+		if (!skip_prefix(buffer.buf, "ref:", &buf)) {
 			/*
 			 * Please note that FETCH_HEAD has a second
 			 * line containing other data.
 			 */
-			if (get_sha1_hex(buffer, sha1) ||
-			    (buffer[40] !=3D '\0' && !isspace(buffer[40]))) {
+			if (get_sha1_hex(buffer.buf, sha1) ||
+			    (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[40]))) {
 				if (flag)
 					*flag |=3D REF_ISBROKEN;
 				errno =3D EINVAL;
-				return NULL;
-			}
-			return refname;
+			} else
+				ret =3D 0;
+			break;
 		}
 		if (flag)
 			*flag |=3D REF_ISSYMREF;
-		buf =3D buffer + 4;
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flag)
 				*flag |=3D REF_ISBROKEN;
 			errno =3D EINVAL;
-			return NULL;
+			break;
 		}
-		refname =3D strcpy(refname_buffer, buf);
+		strbuf_reset(result);
+		strbuf_addstr(result, buf);
 	}
+	strbuf_release(&buffer);
+	return ret;
+}
+
+const char *resolve_ref_unsafe(const char *refname, unsigned char *sha=
1, int reading, int *flag)
+{
+	static struct strbuf buf =3D STRBUF_INIT;
+	if (!resolve_ref(refname, &buf, sha1, reading, flag))
+		return buf.buf;
+	else
+		return NULL;
 }
=20
 char *resolve_refdup(const char *ref, unsigned char *sha1, int reading=
, int *flag)
 {
-	const char *ret =3D resolve_ref_unsafe(ref, sha1, reading, flag);
-	return ret ? xstrdup(ret) : NULL;
+	struct strbuf buf =3D STRBUF_INIT;
+	if (!resolve_ref(ref, &buf, sha1, reading, flag))
+		return buf.buf;
+	else {
+		strbuf_release(&buf);
+		return NULL;
+	}
 }
=20
 /* The argument to filter_refs */
--=20
1.9.1.346.ga2b5940
