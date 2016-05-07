From: tboegi@web.de
Subject: [PATCH v9 6/6] convert: ce_compare_data() checks for a sha1 of a path
Date: Sat,  7 May 2016 08:11:07 +0200
Message-ID: <1462601467-23741-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:06:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvNd-0003Wj-AB
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbcEGGGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 02:06:16 -0400
Received: from mout.web.de ([212.227.17.11]:54694 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbcEGGGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:06:12 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M1X0v-1bnBU31a13-00tVGC; Sat, 07 May 2016 08:06:10
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:pxf8EMgBB0Gah/FPhGk/OXsQg0pO6VjtJgc8EmgxTtwB19xgs1n
 pkXBqxlrJDaJa/v7g/hqGfqvn+G34rUGOq4PRz/a9zCMiXzH/QENeguyAO9AhAgiFqdFFVw
 rJ2oLJPhKzE3YOicqDL7qLA1kCEj5iEZKVw+UJKaYHPH4KDJTxpvRv1GI3H6w1wrPNUY5KA
 NxeUsHCeV6EXIz3orV7ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vWu75Rhvg/4=:amYYMef6DUT5t9EAsEBVOQ
 f/YMisW/Ma9Fo1khBk3Su0LikpBS4iF8TyKLN9dnBuvY1Jn1xDgRqZq6pgwco3Y0PBn6N4WCa
 1Xw3c+MuAgeWlbEDQL1BKJhNJ1dQ5ql+hyDdTQL9vLeL4gqskAaSNbxori4GgfzGv3KwwQ28r
 w1cxUzhdnUt22BmmXZqYTZ9fWEJ2NfTHymToCij+rTarklo5kjidbpY0bXU1x19U8W8iloRBY
 tBFtcsSGGgU8NTknbx08TS5uefmNK/usmNKQRSYPU++d4BsDzG++I4Mv9IQbn18rRkk4UnmAE
 Dd7gjIV37O0oEnSlBiaIeDElSJJnbSyRtR3KZpzXeeU3IOXMTcGit6/O7kuCYoq7p5nV13Dge
 mZ+xu4CFurgP5oUUvqDVM+DOe/3IWAVJENnF1SfWfjr5qaQQ6w/NdSMpW15BZQv80eW2R1a7+
 hnGvxqtbtretws9g8xLNA+2INZJ8U4Wgg26UCC6oA9AKB+WsrHgBU4O42hiXNZt5zkCsO8e1U
 Y4Beu5ua/cBSiGRCk7nuMMlAjG0tyRRy0IqAR+in4gseN4mVnedJcXXpg3LMgcM2vopX8J2F9
 N/TWYx9yfamGBwVKD2NN3oWq8t/YsT2I3XXfTchEwYqwvdecqNcx+5zh/skAhB5EKCzw0K3b3
 QPNQtMmE4S4jnTqmi+s86Dg165QS+q+6EfddeLTcJ30hAoI52JNel2f25zpHBD79EY47Pix87
 EWDHVX4xeYbe6CJyEu2d0wBBhpOwaX1LJ2b7VbsIYCZMa803+SmsjtBPfQN+O8gdKju10Obd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293877>

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
---
 cache.h                    |  1 +
 convert.c                  | 30 ++++++++++++++++++++----------
 convert.h                  | 23 +++++++++++++++++++----
 read-cache.c               |  4 +++-
 sha1_file.c                | 17 +++++++++++++----
 t/t6038-merge-text-auto.sh | 12 ++++++------
 6 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index 28f23d7..43a4fd6 100644
--- a/cache.h
+++ b/cache.h
@@ -605,6 +605,7 @@ extern int ie_modified(const struct index_state *, =
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
index 8d4c42a..ccbd2e9 100644
--- a/convert.c
+++ b/convert.c
@@ -254,9 +254,8 @@ static int would_convert_lf_at_checkout(unsigned co=
nvert_stats,
=20
 }
=20
-static int would_convert_crlf_at_commit(const char * path,
+static int would_convert_crlf_at_commit(const unsigned char *sha1,
 					const struct text_stat *stats,
-					size_t len,
 					enum crlf_action crlf_action)
 {
 	unsigned stat_bits_index;
@@ -267,7 +266,7 @@ static int would_convert_crlf_at_commit(const char =
* path,
 	 * If the file in the index has any CRLF in it, do not convert.
 	 * This is the new safer autocrlf handling.
 	 */
-	stat_bits_index =3D get_convert_stats_sha1(get_sha1_from_cache(path),
+	stat_bits_index =3D get_convert_stats_sha1(sha1,
 						 CONVERT_STAT_BITS_TXT_CRLF);
 	if (stat_bits_index & CONVERT_STAT_BITS_TXT_CRLF)
 		return 0;
@@ -319,7 +318,8 @@ static void check_safe_crlf(const char *path, enum =
crlf_action crlf_action,
 	}
 }
=20
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const char *path, const unsigned char *sha1,
+		       const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -350,7 +350,14 @@ static int crlf_to_git(const char *path, const cha=
r *src, size_t len,
 		convert_crlf =3D 1;
 		checksafe =3D SAFE_CRLF_FALSE;
 	} else {
-		convert_crlf =3D would_convert_crlf_at_commit(path, &stats, len,
+		/*
+		 * If ce_compare_data() wants to check a specic blob,
+		 * then sha1 !=3D NULL and should be used
+		 */
+		if (!sha1)
+			sha1 =3D get_sha1_from_cache(path);
+
+		convert_crlf =3D would_convert_crlf_at_commit(sha1, &stats,
 							    crlf_action);
 	}
=20
@@ -949,8 +956,9 @@ const char *get_convert_attr_ascii(const char *path=
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
@@ -971,7 +979,7 @@ int convert_to_git(const char *path, const char *sr=
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
@@ -979,7 +987,9 @@ int convert_to_git(const char *path, const char *sr=
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
@@ -991,7 +1001,7 @@ void convert_to_git_filter_fd(const char *path, in=
t fd, struct strbuf *dst,
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
index 81b6cdf..769e9c9 100644
--- a/convert.h
+++ b/convert.h
@@ -38,8 +38,16 @@ extern const char *get_wt_convert_stats_ascii(const =
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
@@ -48,9 +56,16 @@ static inline int would_convert_to_git(const char *p=
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
index a3ef967..0ebc237 100644
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
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 0108ead..5450cba 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -108,9 +108,9 @@ test_expect_success 'Merge addition of text=3Dauto'=
 '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
 	echo "<<<<<<<" >expected &&
-	echo first line | append_cr >>expected &&
-	echo same line | append_cr >>expected &&
-	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
+	echo first line >>expected &&
+	echo same line >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -126,9 +126,9 @@ test_expect_success 'Detect LF/CRLF conflict from a=
ddition of text=3Dauto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
-	echo first line | append_cr >>expected &&
-	echo same line | append_cr >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D  >>expected &&
+	echo first line >>expected &&
+	echo same line  >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
--=20
2.0.0.rc1.6318.g0c2c796
