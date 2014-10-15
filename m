From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/11] refs.c: refactor resolve_ref_unsafe() to use strbuf internally
Date: Wed, 15 Oct 2014 17:06:17 +0200
Message-ID: <1413385583-4872-6-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQA9-0002Oj-4f
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaJOPGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:06:44 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53580 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581AbaJOPGj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:39 -0400
X-AuditID: 1207440f-f79ea6d000004f72-4a-543e8d7e05e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.CB.20338.E7D8E345; Wed, 15 Oct 2014 11:06:38 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNX020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:37 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqFvXaxdi8KNV0aLrSjeTRUPvFWaL
	2yvmM1t0T3nLaPFvQo3FmTeNjA5sHn/ff2Dy2DnrLrvHgk2lHhcvKXssfuDl8XmTXABbFLdN
	UmJJWXBmep6+XQJ3xvt204L3lhVTW1QaGJfodDFyckgImEjMWrWVCcIWk7hwbz1bFyMXh5DA
	ZUaJL9N/MUM4x5kktm9sZwOpYhPQlVjU08wEkhARaGCUOPRqIVgLs8AiRon2VVeYQaqEBSIk
	fjw6BGazCKhKTPv5ihXE5hVwljjd/ocVYp+cxN7Jq1lAbE4BF4lfL7cxgthCQDULlk5mgagX
	lDg58wmQzQG0QF1i/TwhkDCzgLxE89bZzBMYBWYhqZqFUDULSdUCRuZVjHKJOaW5urmJmTnF
	qcm6xcmJeXmpRbomermZJXqpKaWbGCHhzr+DsWu9zCFGAQ5GJR5ezgO2IUKsiWXFlbmHGCU5
	mJREeRf02IUI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGdnwCU401JrKxKLcqHSUlzsCiJ86ov
	UfcTEkhPLEnNTk0tSC2CycpwcChJ8O4DGSpYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFha
	khEPitP4YmCkgqR4gPaCtfMWFyTmAkUhWk8xKkqJ82aBJARAEhmleXBjYUnsFaM40JfCvD0g
	VTzABAjX/QpoMBPQ4ImhtiCDSxIRUlINjNP4pQOv3VKy/FBVOtfT2qFO660db8PenaWH017x
	s7uYibIcWWHMJL3pd8jv/gUiex7+X8Xwp4fl/vT3C7qMVfINA17veFt/dFc1S+ba 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

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
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |   1 +
 refs.c  | 115 +++++++++++++++++++++++++++++++++++++-------------------=
--------
 2 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
index 3e6a914..e36084d 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,6 +1004,7 @@ extern int read_ref(const char *refname, unsigned=
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
index 020ee3f..29ea7e0 100644
--- a/refs.c
+++ b/refs.c
@@ -1397,34 +1397,41 @@ static int handle_missing_loose_ref(const char =
*refname,
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
 		struct stat st;
 		const char *buf;
-		int fd;
=20
 		if (--depth < 0) {
 			errno =3D ELOOP;
-			return NULL;
+			break;
 		}
=20
-		git_snpath(path, sizeof(path), "%s", refname);
+		git_snpath(path, sizeof(path), "%s", result->buf);
=20
 		/*
 		 * We might have to loop back here to avoid a race
@@ -1437,30 +1444,26 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 		 */
 	stat_ref:
 		if (lstat(path, &st) < 0) {
-			if (errno =3D=3D ENOENT) {
-				if (handle_missing_loose_ref(refname, sha1,
-							     reading, flag))
-					return NULL;
-				return refname;
-			} else
-				return NULL;
+			if (errno =3D=3D ENOENT)
+				ret =3D handle_missing_loose_ref(result->buf, sha1,
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
@@ -1470,34 +1473,24 @@ const char *resolve_ref_unsafe(const char *refn=
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
-		if (skip_prefix(buffer, "ref:", &buf)) {
+		if (skip_prefix(buffer.buf, "ref:", &buf)) {
 			/* It is a symbolic ref */
 			if (flag)
 				*flag |=3D REF_ISSYMREF;
@@ -1507,9 +1500,10 @@ const char *resolve_ref_unsafe(const char *refna=
me, unsigned char *sha1, int rea
 				if (flag)
 					*flag |=3D REF_ISBROKEN;
 				errno =3D EINVAL;
-				return NULL;
+				break;
 			}
-			refname =3D strcpy(refname_buffer, buf);
+			strbuf_reset(result);
+			strbuf_add(result, buf, buffer.buf + buffer.len - buf);
 			continue;
 		}
=20
@@ -1517,21 +1511,44 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 		 * It must be a normal ref. Please note that
 		 * FETCH_HEAD has a second line containing other data.
 		 */
-		if (get_sha1_hex(buffer, sha1) ||
-		    (buffer[40] !=3D '\0' && !isspace(buffer[40]))) {
+		if (get_sha1_hex(buffer.buf, sha1) ||
+		    (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[40]))) {
 			if (flag)
 				*flag |=3D REF_ISBROKEN;
 			errno =3D EINVAL;
-			return NULL;
-		}
-		return refname;
+		} else
+			ret =3D 0;
+		break;
 	}
+	strbuf_release(&buffer);
+	return ret;
+}
+
+const char *resolve_ref_unsafe(const char *refname, unsigned char *sha=
1, int reading, int *flag)
+{
+	static struct strbuf buf =3D STRBUF_INIT;
+
+	if (!resolve_ref(refname, &buf, sha1, reading, flag))
+		/*
+		 * Please note: true to the "unsafe" name of this
+		 * function, we return a pointer to our internal
+		 * memory here rather than passing ownership to the
+		 * caller by calling strbuf_detach():
+		 */
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
+		return strbuf_detach(&buf, NULL);
+	else {
+		strbuf_release(&buf);
+		return NULL;
+	}
 }
=20
 /* The argument to filter_refs */
--=20
2.1.1
