From: tboegi@web.de
Subject: [PATCH v7 2/2] convert: ce_compare_data() checks for a sha1 of a path
Date: Sat, 21 May 2016 12:01:49 +0200
Message-ID: <1463824909-10229-1-git-send-email-tboegi@web.de>
References: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 11:56:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b43du-0002Gb-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 11:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbcEUJ4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2016 05:56:14 -0400
Received: from mout.web.de ([212.227.15.3]:62845 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbcEUJ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 05:56:11 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MLg8p-1b4sz616f5-000qF1; Sat, 21 May 2016 11:56:07
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:fYga0zXSy12IdttuX4RBhf20XIjUDzaTk7pHfNWS5CBKnDBJchA
 CdvjngMQz71PAaQtZ1G4UzUhXbTeISPa378G/8Ke0t3LWJ6c6sXD+gu6qZ5OD7FCOwCQu1y
 sby7nfPpr5Ehdr58pxfuPZ+vAIi/W+Taww6POPEuHHLWP76EClbTT1t9DlADG/IZEXUWK2d
 jWVd03TpVHen7hY6YlPNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pu4N1IG1DtU=:rXBO+JINpYOwCMnye6Evnh
 hMjTbZ+CpgXdJ9rAwF6afyCryrdUGImilYG61xircX/Nyy0GXBERuIOu6pCsMvhbEaUQJBRtE
 xvpSva0uryf5UoW19GUOBsTA4ZfLZ7FfyYFVTdZuLQrSY5ZyDmnvvlvAkWYUg5FcHDGwXU1iC
 xTsHnTbx5o/Zxz5RnJj7ClHwXs0iwlRTc9MmgfpECBBYnGV+ugJU1zkOdBK8EyRapFXfiNf//
 lHyiBkXyuwvgsyVSKKgvmPIwQDubqAVCGq2DTXIoLjCR4ZRIe1rFjhl/5CuoWUnXLILMbtnHx
 vRCjF9/+R98AbzHCE6fNOsXlxujqhPXrtTZpRigrGl1SKOOqJLTNfuKzXehb3OTJfI0MkChRT
 gRRMp6H6eDmt/UHXQrSa3cn3ZZZ5zSOdRw1KU6SA1/umG9/nulLPdXZ1aYArdFADvmc2Ot1Tq
 NHjYiCnzk0/vAUPgKEVpsG2DMNWPI+YsW//IME27BSevvYbKnnk39O05d0TMIFR6T1LvZXpY8
 GYlOLv/f6KZP8WWL2UwGA5359LOumqjg9x7iNRiE5auVs435Jn9ZNtPDEfGaSc3UMhjwiGJ0q
 FPjEg9ftvNiD1N+OLQI+tl5Y3BQbAu09zBiPliQsZhHbDu+qZnn+/mQA0CZemDQDuib1c1PIO
 Zd4NSlWK5z+8eEa+8mURNPc9QEuI1ls8L9HlyfCcIEv2idIhAJ9Psw0kstNril4xadciZctcH
 pgyaYwDPy2ffI5SKJyrVC6s1h/9HDGQMPME/128qNoGckKIlltSQ90kMIkTg2+2gB+RuusJQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295226>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

To compare a file in working tree with the index, convert_to_git() is u=
sed,
the result is hashed and the hash value compared with ce->sha1.

Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
are converted or not.
The "new safer autocrlf handling" checks if CRLF had been in the index =
before,
and if, the CRLF in the working tree are not converted.

While in a merge, a file name in the working tree has different blobs
in the index with different hash values.
=46orwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
the would_convert_crlf_at_commit() looks at the appropriate blob.

Add a new parameter index_blob_sha1 to convert_to_git(), and forward th=
e
sha1 from ce_compare_data() into convert_to_git(). Other callers use NU=
LL
for index_blob_sha1, and the sha1 is determined from path
using get_sha1_from_cache(path). This is the same handling as before.

In the same spirit, forward the sha1 into would_convert_to_git().

While at it, rename has_cr_in_index() into blob_has_cr() and replace
0 with SAFE_CRLF_FALSE.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 V6 went into the wrong direction.
 V5 -> V7: Adds parameter index_blob_sha1 to (convert_to_git() and woul=
d_convert_to_git().

 builtin/apply.c |  3 ++-
 builtin/blame.c |  2 +-
 cache.h         |  1 +
 combine-diff.c  |  3 ++-
 convert.c       | 34 ++++++++++++++++++++++------------
 convert.h       | 15 +++++++++++----
 diff.c          |  3 ++-
 dir.c           |  2 +-
 read-cache.c    |  4 +++-
 sha1_file.c     | 12 +++++++++---
 10 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..0cf9a0a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2140,7 +2140,8 @@ static int read_old_data(struct stat *st, const c=
har *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(path, buf->buf, buf->len, buf,
+			       SAFE_CRLF_FALSE, NULL);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..1c523b6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2377,7 +2377,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(path, buf.buf, buf.len, &buf, SAFE_CRLF_FALSE, NULL);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 15a2a10..868599e 100644
--- a/cache.h
+++ b/cache.h
@@ -605,6 +605,7 @@ extern int ie_modified(const struct index_state *, =
const struct cache_entry *, s
=20
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
+#define HASH_USE_SHA_NOT_PATH 4
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum=
 object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, unsigned flags);
=20
diff --git a/combine-diff.c b/combine-diff.c
index 0e1d4b0..c4fa884 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,8 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf =3D STRBUF_INIT;
=20
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(elem->path, result, len,
+						   &buf, safe_crlf, NULL)) {
 					free(result);
 					result =3D strbuf_detach(&buf, &len);
 					result_size =3D len;
diff --git a/convert.c b/convert.c
index f524b8d..f0eb4ed 100644
--- a/convert.c
+++ b/convert.c
@@ -217,23 +217,28 @@ static void check_safe_crlf(const char *path, enu=
m crlf_action crlf_action,
 	}
 }
=20
-static int has_cr_in_index(const char *path)
+static int blob_has_cr(const unsigned char *index_blob_sha1)
 {
 	unsigned long sz;
 	void *data;
-	int has_cr;
-
-	data =3D read_blob_data_from_cache(path, &sz);
+	int has_cr =3D 0;
+	enum object_type type;
+	if (!index_blob_sha1)
+		return 0;
+	data =3D read_sha1_file(index_blob_sha1, &type, &sz);
 	if (!data)
 		return 0;
-	has_cr =3D memchr(data, '\r', sz) !=3D NULL;
+	if (type =3D=3D OBJ_BLOB)
+		has_cr =3D memchr(data, '\r', sz) !=3D NULL;
+
 	free(data);
 	return has_cr;
 }
=20
 static int crlf_to_git(const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, enum safe_crlf checksafe,
+		       const unsigned char *index_blob_sha1)
 {
 	struct text_stat stats;
 	char *dst;
@@ -260,7 +265,9 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
 			 */
-			if (has_cr_in_index(path))
+			if (!index_blob_sha1)
+				index_blob_sha1 =3D get_sha1_from_cache(path);
+			if (blob_has_cr(index_blob_sha1))
 				return 0;
 		}
 	}
@@ -853,7 +860,8 @@ const char *get_convert_attr_ascii(const char *path=
)
 }
=20
 int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, enum safe_crlf checksafe,
+		   const unsigned char *index_blob_sha1)
 {
 	int ret =3D 0;
 	const char *filter =3D NULL;
@@ -874,7 +882,7 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe, =
index_blob_sha1);
 	if (ret && dst) {
 		src =3D dst->buf;
 		len =3D dst->len;
@@ -883,7 +891,8 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 }
=20
 void convert_to_git_filter_fd(const char *path, int fd, struct strbuf =
*dst,
-			      enum safe_crlf checksafe)
+			      enum safe_crlf checksafe,
+			      const unsigned char *index_blob_sha1)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -894,7 +903,8 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
=20
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe)=
;
+	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action,
+		    checksafe, index_blob_sha1);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
=20
@@ -949,7 +959,7 @@ int renormalize_buffer(const char *path, const char=
 *src, size_t len, struct str
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_FALSE);
+	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_FALSE, NUL=
L);
 }
=20
 /*****************************************************************
diff --git a/convert.h b/convert.h
index ccf436b..60c46b8 100644
--- a/convert.h
+++ b/convert.h
@@ -38,19 +38,26 @@ extern const char *get_convert_attr_ascii(const cha=
r *path);
=20
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, enum safe_crlf checksafe,
+			  const unsigned char *index_blob_sha1);
+
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_=
t len,
 			      struct strbuf *dst);
-static inline int would_convert_to_git(const char *path)
+static inline int would_convert_to_git(const char *path,
+				       const unsigned char *index_blob_sha1)
 {
-	return convert_to_git(path, NULL, 0, NULL, 0);
+	return convert_to_git(path, NULL, 0, NULL, SAFE_CRLF_FALSE,
+			      index_blob_sha1);
 }
+
 /* Precondition: would_convert_to_git_filter_fd(path) =3D=3D true */
 extern void convert_to_git_filter_fd(const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     enum safe_crlf checksafe,
+				     const unsigned char *index_blob_sha1);
+
 extern int would_convert_to_git_filter_fd(const char *path);
=20
 /*****************************************************************
diff --git a/diff.c b/diff.c
index d3734d3..a8308e0 100644
--- a/diff.c
+++ b/diff.c
@@ -2810,7 +2810,8 @@ int diff_populate_filespec(struct diff_filespec *=
s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf,
+				   crlf_warn, NULL)) {
 			size_t size =3D 0;
 			munmap(s->data, s->size);
 			s->should_munmap =3D 0;
diff --git a/dir.c b/dir.c
index 656f272..5ac379d 100644
--- a/dir.c
+++ b/dir.c
@@ -713,7 +713,7 @@ static int add_excludes(const char *fname, const ch=
ar *base, int baselen,
 				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
 				 !ce_stage(active_cache[pos]) &&
 				 ce_uptodate(active_cache[pos]) &&
-				 !would_convert_to_git(fname))
+				 !would_convert_to_git(fname, NULL))
 				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
diff --git a/read-cache.c b/read-cache.c
index a3ef967..c109b6d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry=
 *ce, struct stat *st)
=20
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
+		unsigned flags =3D HASH_USE_SHA_NOT_PATH;
+		memcpy(sha1, ce->sha1, sizeof(sha1));
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..52e5c6f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3275,6 +3275,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 {
 	int ret, re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_USE_SHA_NOT_PATH;
=20
 	if (!type)
 		type =3D OBJ_BLOB;
@@ -3285,7 +3286,8 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 	if ((type =3D=3D OBJ_BLOB) && path) {
 		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
+				   write_object ? safe_crlf : SAFE_CRLF_FALSE,
+				   valid_sha1 ? sha1 : NULL)) {
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
@@ -3313,13 +3315,15 @@ static int index_stream_convert_blob(unsigned c=
har *sha1, int fd,
 {
 	int ret;
 	const int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_USE_SHA_NOT_PATH;
 	struct strbuf sbuf =3D STRBUF_INIT;
=20
 	assert(path);
 	assert(would_convert_to_git_filter_fd(path));
=20
 	convert_to_git_filter_fd(path, fd, &sbuf,
-				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
+				 write_object ? safe_crlf : SAFE_CRLF_FALSE,
+				 valid_sha1 ? sha1 : NULL);
=20
 	if (write_object)
 		ret =3D write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
@@ -3396,6 +3400,8 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
+	const unsigned char *sha1_ce;
+	sha1_ce =3D flags & HASH_USE_SHA_NOT_PATH ? sha1 : NULL;
=20
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -3406,7 +3412,7 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret =3D index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <=3D big_file_threshold || type !=3D OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git(path,sha1_ce)))
 		ret =3D index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
--=20
2.0.0.rc1.6318.g0c2c796
