From: tboegi@web.de
Subject: [PATCH v3 1/1] convert: ce_compare_data() checks for a sha1 of a path
Date: Mon, 16 May 2016 17:51:31 +0200
Message-ID: <1463413891-12529-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 17:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Kj8-0000hc-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbcEPPq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2016 11:46:28 -0400
Received: from mout.web.de ([212.227.15.4]:57161 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbcEPPqH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:46:07 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M1lTm-1brGPW0wrC-00tmJ5; Mon, 16 May 2016 17:46:04
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:u8NM2nMFm+CO9fb611iEpbNtGFQF/DmS3vIoIS5Ie+6tOZiuR4Z
 /FUpE/YsZfVHUdOYQK2MXOdItVZyUIMcNPgFb7jzwPFZ6hhJ1fLf7C2sQl8+QIyGVGn3vMB
 FbKApoLLveZR5m0jEWKgDjE/Rn7eFu4a0WSk+zJAFT60Ua/NXWCPIdKO8uzHPRRot8BE6hc
 aNVYbFzkVUItiu6MwJWzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/L+NF+PpLp4=:qr/WVbBWtLeBB0TS2wahkO
 y/WNxtzFgaHIwUARwufV7fuF8a9UtMyG/DeCmW3DFZzacbpH/8/vAQY4SA3Qf0PqzzoDzJS0A
 Cr3rANjjgL1ZbUJg1c6EYQ5E0GSjj0yXj3S5F3NiYCpjLa2CgZbKGTDOPT66BjCMW4t/l3awq
 Wl2glFdcZcWjO/y8T05ejRO8/WMgqen+VOgNkhcLeP3XZH3VkrVbC15QnI2q18x3DBMUaW+wA
 uhZDnTkhrC4P3gJLhA9tZEa/QtLkxjwNC09nFMeAE8vwpeFYgE86Yx66nLi11dEDvfA2GsxYX
 ZFfoyIVSI8DCVGdw13uAy4hrEqe23STZvmyR6NQmdrloEVFtlv8Se3Zq+LHsrzy6X4w5Kmspo
 AHnU17mKxnzn/dd8fKMYFnlrsidE7bTmMCuD/RP6rBMvw5kQgFuNUTuaGWaD/VcBK1+YWJ3l2
 RHOwqXSKPRGy22w+ZIQOFjBCVBYMqmNuJS0KNtY/MuHGHVNxlAk5gKCOJDm4DOJ5WRyKA3H6L
 nQcfsWJ6BXrsx41UVxZ8AW9I8AYQf6kKzDb0Bs/YutI5nrdFbLn92v5BHbAOBrlPsPeWVKaKs
 Me3+I9T70MpeFqh7TcGHGPF7x4fcXrEME3/Vg6c6f9nMfsugTHJ26vpR+CAt7w7qisJowffze
 LjxdO4KjmBlypRTAHaCVDiZ7Cthd5QLd3V93EdPQIjAinwXhj7toTikV3GhRVTaDQfNCK5ubf
 Rb01THvhfNG3eCjsktZ9bxJXF8+Id7Gb6iWCk7g5OzU/tQ03WZpx96S3BQOL9h4/ghabP8jX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294744>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

To compare a file in working tree with the index, convert_to_git() is u=
sed,
the the result is hashed and the hash value compared with ce->sha1.

Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
are converted or not: When a CRLF had been in the index before, CRLF in
the working tree are not converted.

While in a merge, a file name in the working tree has different blobs
in the index with different hash values.
=46orwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
the would_convert_crlf_at_commit() looks at the appropriate blob.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h      |  1 +
 convert.c    | 35 +++++++++++++++++++++--------------
 convert.h    | 23 +++++++++++++++++++----
 read-cache.c |  4 +++-
 sha1_file.c  | 17 +++++++++++++----
 5 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 160f8e3..5b25462 100644
--- a/cache.h
+++ b/cache.h
@@ -604,6 +604,7 @@ extern int ie_modified(const struct index_state *, =
const struct cache_entry *, s
=20
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
+#define HASH_CE_HAS_SHA1  4
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum=
 object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, unsigned flags);
=20
diff --git a/convert.c b/convert.c
index f524b8d..dc86899 100644
--- a/convert.c
+++ b/convert.c
@@ -217,21 +217,25 @@ static void check_safe_crlf(const char *path, enu=
m crlf_action crlf_action,
 	}
 }
=20
-static int has_cr_in_index(const char *path)
+static int has_cr_in_index(const char *path, const unsigned char *sha1=
)
 {
 	unsigned long sz;
 	void *data;
-	int has_cr;
-
-	data =3D read_blob_data_from_cache(path, &sz);
-	if (!data)
-		return 0;
-	has_cr =3D memchr(data, '\r', sz) !=3D NULL;
+	int has_cr =3D 0;
+	enum object_type type =3D OBJ_BLOB;
+	if (sha1)
+		data =3D read_sha1_file(sha1, &type, &sz);
+	else
+		data =3D read_blob_data_from_cache(path, &sz);
+
+	if (data)
+		has_cr =3D memchr(data, '\r', sz) !=3D NULL;
 	free(data);
 	return has_cr;
 }
=20
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const char *path, const unsigned char *sha1,
+		       const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -260,7 +264,7 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
 			 */
-			if (has_cr_in_index(path))
+			if (has_cr_in_index(path, sha1))
 				return 0;
 		}
 	}
@@ -852,8 +856,9 @@ const char *get_convert_attr_ascii(const char *path=
)
 	return "";
 }
=20
-int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+int convert_to_git_ce_sha1(const char *path, const unsigned char *sha1=
,
+			   const char *src, size_t len,
+			   struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret =3D 0;
 	const char *filter =3D NULL;
@@ -874,7 +879,7 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |=3D crlf_to_git(path, sha1, src, len, dst, ca.crlf_action, check=
safe);
 	if (ret && dst) {
 		src =3D dst->buf;
 		len =3D dst->len;
@@ -882,7 +887,9 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
=20
-void convert_to_git_filter_fd(const char *path, int fd, struct strbuf =
*dst,
+void convert_to_git_filter_fd(const char *path,
+			      const unsigned char *sha1,
+			      int fd, struct strbuf *dst,
 			      enum safe_crlf checksafe)
 {
 	struct conv_attrs ca;
@@ -894,7 +901,7 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
=20
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe)=
;
+	crlf_to_git(path, sha1, dst->buf, dst->len, dst, ca.crlf_action, chec=
ksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
=20
diff --git a/convert.h b/convert.h
index ccf436b..1634d37 100644
--- a/convert.h
+++ b/convert.h
@@ -37,8 +37,16 @@ extern const char *get_wt_convert_stats_ascii(const =
char *path);
 extern const char *get_convert_attr_ascii(const char *path);
=20
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t le=
n,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+extern int convert_to_git_ce_sha1(const char *path, const unsigned cha=
r *sha1,
+				  const char *src, size_t len,
+				  struct strbuf *dst, enum safe_crlf checksafe);
+
+static inline int convert_to_git(const char *path, const char *src, si=
ze_t len,
+				 struct strbuf *dst, enum safe_crlf checksafe)
+{
+	return convert_to_git_ce_sha1(path, NULL, src, len, dst, checksafe);
+}
+
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_=
t len,
@@ -47,9 +55,16 @@ static inline int would_convert_to_git(const char *p=
ath)
 {
 	return convert_to_git(path, NULL, 0, NULL, 0);
 }
+static inline int would_convert_to_git_ce_sha1(const char *path,
+					       const unsigned char *sha1)
+{
+	return convert_to_git_ce_sha1(path, sha1, NULL, 0, NULL, 0);
+}
+
 /* Precondition: would_convert_to_git_filter_fd(path) =3D=3D true */
-extern void convert_to_git_filter_fd(const char *path, int fd,
-				     struct strbuf *dst,
+extern void convert_to_git_filter_fd(const char *path,
+				     const unsigned char *sha1,
+				     int fd, struct strbuf *dst,
 				     enum safe_crlf checksafe);
 extern int would_convert_to_git_filter_fd(const char *path);
=20
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..4b0e3c3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry=
 *ce, struct stat *st)
=20
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
+		unsigned flags =3D HASH_CE_HAS_SHA1;
+		memcpy(sha1, ce->sha1, sizeof(sha1));
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..dd013d5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3275,6 +3275,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 {
 	int ret, re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_CE_HAS_SHA1;
=20
 	if (!type)
 		type =3D OBJ_BLOB;
@@ -3284,8 +3285,11 @@ static int index_mem(unsigned char *sha1, void *=
buf, size_t size,
 	 */
 	if ((type =3D=3D OBJ_BLOB) && path) {
 		struct strbuf nbuf =3D STRBUF_INIT;
-		if (convert_to_git(path, buf, size, &nbuf,
-				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
+		if (convert_to_git_ce_sha1(path,
+					   valid_sha1 ? sha1 : NULL,
+					   buf, size, &nbuf,
+					   write_object ? safe_crlf : SAFE_CRLF_FALSE)){
+
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
@@ -3313,12 +3317,15 @@ static int index_stream_convert_blob(unsigned c=
har *sha1, int fd,
 {
 	int ret;
 	const int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_CE_HAS_SHA1;
 	struct strbuf sbuf =3D STRBUF_INIT;
=20
 	assert(path);
 	assert(would_convert_to_git_filter_fd(path));
=20
-	convert_to_git_filter_fd(path, fd, &sbuf,
+	convert_to_git_filter_fd(path,
+				 valid_sha1 ? sha1 : NULL,
+				 fd, &sbuf,
 				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
=20
 	if (write_object)
@@ -3396,6 +3403,8 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
+	const unsigned char *sha1_ce;
+	sha1_ce =3D flags & HASH_CE_HAS_SHA1 ? sha1 : NULL;
=20
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -3406,7 +3415,7 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret =3D index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <=3D big_file_threshold || type !=3D OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git_ce_sha1(path,sha1_ce)))
 		ret =3D index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
--=20
2.0.0.rc1.6318.g0c2c796
