From: tboegi@web.de
Subject: [PATCH v2 3/3] Correct ce_compare_data() in a middle of a merge
Date: Tue,  7 Jun 2016 17:20:51 +0200
Message-ID: <1465312851-4908-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 17:16:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAIjW-0005Nw-TU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 17:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbcFGPPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 11:15:52 -0400
Received: from mout.web.de ([212.227.17.11]:52306 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932560AbcFGPOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 11:14:19 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M41Bm-1bR92I2qGY-00rbJ4; Tue, 07 Jun 2016 17:14:16
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Nl6OsktMojfkDjU6CeJ9Ly6XsAaUczqIdLaxZh5LZMcx/VUxqSz
 2qajyD+9UP2ZrMlpLNzE8VBnypQhX5wGbKq/Hgq6JiNgZe4gyNME/OuVCV6hLWBiFMkeGjL
 7CDNhnaA8VVz/7YTSs2uKD/8td+v+tXsCUwh+4UiupSz1yoEeJGCeJiUdRNz9rl43VwJKa7
 cBKBpDi7pYZcnbXHCxWUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GoMlSVPLUNw=:LwFWRE1XEvXDoucflDN1rP
 QC7C1YD/zbg6urYhQVEOnZe025ksxSnAhNrg9p7DK53m1W9k4Po+zJZIdtSSIbf4y04Nxed3F
 6uTA1I2lTHfMpkdwLONXT3SKnzA1kr5b6Ef1thLoWUN6DbdNqN8qbSgXQ9XJpM0HOL+dBJJsH
 jPGjHv2HArSvLF+ReSPO5GSKIM4TpuKdKolM8U4yCEHvpkzto0EtiuQJVAd03hWd3yoyhdgRG
 yRE05hcUxTZPJSHVhmCggCc12Gly/VQnmBNWobMqor3yvwx1q0B8MpZ6oJqoYn8Iyv8KuT4FC
 gSXyJEkpjvvqS9pKsmUCHYDTpwLQiwmF03yt1W1cWj0AKdzZgS0PKeZEMpiotTouKW6vmK8yF
 dvU6W/OHvhxIgzBkvX9IqMxNC2HPKeK3TgKxHyyrHeRHGNjkSNU7kwHWaUQ+p3rh8h4cUdt9e
 1hp1jHHKbCys/fPSDEEDYinbiOvnnwlzliQ0vfSv3vITO24L+IL7/RIlK43sdOz4lXIKU74WF
 8FmO5X1mN7VaowoBep/CRVG8IS9PRRgq4vk3fFky4FXMfJAqw8eb7YmXpHXzvdeoSRQrlZmrd
 o5JhDm9F/Z4J2nN6KzQkptQmvuk6wWq0JY9M56hYM3XDasK/2VkMnoGx+j9qChRNfsJ9ba7ce
 4Y8woDnXS8kA9K7C6Fe8NczGxiT28dteYUCt2h6BgdXSNtfVpxuKKPoAGIAhV7vUjGDR5vgTT
 nnuD/6Xf/I/sYJWDDR6+cNqXvOfdylXAbhQ/F2MNHLAbeWJNnK6MNMd/fIpQvKOzRD1ppIP9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296691>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

The following didn't work as expected:
- In a middle of a merge
- merge.renormalize is true,
- .gitattributes =3D "* text=3Dauto"
- core.eol =3D crlf

Merge a blob with CRLF "first line\r\nsame line\r\n" and a blob
with LF "first line\nsame line\n".

The expected result of the merge is "first line\nsame line\n".

The content in the working tree is "first line\r\nsame line\r\n",
and ce_compare_data() should find that the content is clean and return =
0.

Deep down crlf_to_git() is invoked, to check if CRLF are converted or n=
ot.

The "new safer autocrlf handling" calls blob_has_cr().

Instead of using the sha1 of the blob, (CRLF in this example),
the function get_sha1_from_index() is invoked.
get_sha1_from_index() decides to return "ours" when in the middle of
the merge, which is LF.

As a result, the CRLF in the worktree are converted into LF before
the comparison.
The contents of LF and CRLF don't match any more.

The problem is that ce_compare_data() has ce->sha1, but the sha1 is los=
t
on it's way into blob_has_cr().

=46orwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
that blob_has_cr() looks at the appropriate blob.

Add a new parameter index_blob_sha1 to convert_to_git(), and forward th=
e
sha1 from ce_compare_data() into convert_to_git(). Other callers use NU=
LL
for index_blob_sha1, and the sha1 is determined from path
using get_sha1_from_cache(path). This is the same handling as before.

In the same spirit, forward the sha1 into would_convert_to_git().

While at it, rename has_cr_in_index() into blob_has_cr()
and replace 0 with SAFE_CRLF_FALSE.

Add a TC in t6038 to have a test coverage under Linux.

Signed-off-by: Torsten B=C3=83=C2=B6gershausen <tboegi@web.de>
---
 builtin/apply.c            |  3 ++-
 builtin/blame.c            |  2 +-
 cache.h                    |  1 +
 combine-diff.c             |  3 ++-
 convert.c                  | 43 ++++++++++++++++++++++++++------------
 convert.h                  | 15 ++++++++++----
 diff.c                     |  3 ++-
 dir.c                      |  2 +-
 read-cache.c               |  4 +++-
 sha1_file.c                | 12 ++++++++---
 t/t6038-merge-text-auto.sh | 51 +++++++++++++++++++++++++-------------=
--------
 11 files changed, 90 insertions(+), 49 deletions(-)

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
index 322ee40..86f48f9 100644
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
index 8f2313d..8b535a7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1052,7 +1052,8 @@ static void show_patch_diff(struct combine_diff_p=
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
index 67d69b5..802ee7c 100644
--- a/convert.c
+++ b/convert.c
@@ -219,23 +219,28 @@ static void check_safe_crlf(const char *path, enu=
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
@@ -256,14 +261,23 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
 			return 0;
+
 		/*
 		 * If the file in the index has any CR in it, do not convert.
 		 * This is the new safer autocrlf handling.
 		 */
 		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
 			checksafe =3D SAFE_CRLF_FALSE;
-		else if (has_cr_in_index(path))
-			return 0;
+		else {
+			/*
+			 * If the file in the index has any CR in it, do not convert.
+			 * This is the new safer autocrlf handling.
+			 */
+			if (!index_blob_sha1)
+				index_blob_sha1 =3D get_sha1_from_cache(path);
+			if (blob_has_cr(index_blob_sha1))
+				return 0;
+		}
 	}
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
=20
@@ -855,7 +869,8 @@ const char *get_convert_attr_ascii(const char *path=
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
@@ -876,7 +891,7 @@ int convert_to_git(const char *path, const char *sr=
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
@@ -885,7 +900,8 @@ int convert_to_git(const char *path, const char *sr=
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
@@ -896,7 +912,8 @@ void convert_to_git_filter_fd(const char *path, int=
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
@@ -951,7 +968,7 @@ int renormalize_buffer(const char *path, const char=
 *src, size_t len, struct str
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZ=
E);
+	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZ=
E, NULL);
 }
=20
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 81b6cdf..8c34dd5 100644
--- a/convert.h
+++ b/convert.h
@@ -39,19 +39,26 @@ extern const char *get_convert_attr_ascii(const cha=
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
index 6172b34..66f1ffb 100644
--- a/dir.c
+++ b/dir.c
@@ -712,7 +712,7 @@ static int add_excludes(const char *fname, const ch=
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
index d5e1121..10630f0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3273,6 +3273,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 {
 	int ret, re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_USE_SHA_NOT_PATH;
=20
 	if (!type)
 		type =3D OBJ_BLOB;
@@ -3283,7 +3284,8 @@ static int index_mem(unsigned char *sha1, void *b=
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
@@ -3311,13 +3313,15 @@ static int index_stream_convert_blob(unsigned c=
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
@@ -3394,6 +3398,8 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
+	const unsigned char *sha1_ce;
+	sha1_ce =3D flags & HASH_USE_SHA_NOT_PATH ? sha1 : NULL;
=20
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -3404,7 +3410,7 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret =3D index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <=3D big_file_threshold || type !=3D OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git(path,sha1_ce)))
 		ret =3D index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 33b77ee..5e8d5fa 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -91,16 +91,13 @@ test_expect_success 'Merge after setting text=3Daut=
o' '
 	compare_files expected file
 '
=20
-test_expect_success 'Merge addition of text=3Dauto' '
+test_expect_success 'Merge addition of text=3Dauto eol=3DLF' '
+	git config core.eol lf &&
 	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
=20
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -109,17 +106,31 @@ test_expect_success 'Merge addition of text=3Daut=
o' '
 	compare_files  expected file
 '
=20
+test_expect_success 'Merge addition of text=3Dauto eol=3DCRLF' '
+	git config core.eol crlf &&
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
+	git config merge.renormalize true &&
+	git rm -fr . &&
+	rm -f .gitattributes &&
+	git reset --hard b &&
+	echo >&2 "After git reset --hard b" &&
+	git ls-files -s --eol >&2 &&
+	git merge a &&
+	compare_files  expected file
+'
+
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
+	git config core.eol native &&
 	echo "<<<<<<<" >expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected &&
-		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected
-	else
-		echo first line >>expected &&
-		echo same line >>expected &&
-		echo =3D=3D=3D=3D=3D=3D=3D >>expected
-	fi &&
+	echo first line >>expected &&
+	echo same line >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -135,15 +146,9 @@ test_expect_success 'Detect LF/CRLF conflict from =
addition of text=3Dauto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected
-	else
-		echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
-		echo first line >>expected &&
-		echo same line >>expected
-	fi &&
+	echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
+	echo first line >>expected &&
+	echo same line >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
--=20
2.0.0.rc1.6318.g0c2c796
