Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7194D1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 07:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbcF1Hxi (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 03:53:38 -0400
Received: from mout.web.de ([212.227.15.14]:49687 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbcF1Hxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 03:53:35 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MDxSJ-1b7bLW18Xf-00HKpg; Tue, 28 Jun 2016 09:53:33
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
Date:	Tue, 28 Jun 2016 10:01:16 +0200
Message-Id: <1467100876-2803-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gy6WQjlUE55ofHBwhN8xE87dxUgdeFgA3Ff1G3VnBayf95af5X7
 dzuwdgzZoWzr/EOot8WWyK2xJBsXZmZ//0s4GLLTOa8a4sgtYSkz1MmXOWQAEjjy4JP4/+E
 GoD/7OfMhxECLLlsspYhn+0bECroaGE2Pdd5hucW1rIh5Q2UuqXkpcZgARzK1HXdjbxCA4g
 A/09v2fv32LHUZQ2kyzBw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xP5xUrmSX1U=:h+rq0u73jouux/YVTAcF7H
 ciFmyBj5kg/TEGub4mqt7sw1IPKJZFgixzc2sNGGgjo3ycdqnIPx7txAGTfdyUjvncFPY7zXD
 g+ZxspyUXVkho2HDNG0fNBosD3Vc4B8GEZu0hr3G+hh02Jqpr3LUfUMvPRNHKm1oIg1pa4s8a
 pV9etLBqhBysZ91tz+QljkmVxMZy+4ZTiC1ym7H4yEUH4QFA8B1OEFJXWVHV+yRGNxNJqpFgT
 3bTLChjQ6huy73FlLFMz2aPlCWXWLTn/hij3mb1ehQmbQ19m7lcJDdQ6LjxZW6a83PlGuF0Zm
 igC1053eKoImLQ5X12l3VdKlYSi5J/SbYgx/lOmvfO/VLW0mntUDa6Q1BFCZJgdc93h/lFfI+
 uE6fCthOgOrwXh8KUFP22W3UgE2y6+ucU0OnjvJPeCVs0YCxUpamgEuRz5eHdzVq/KuDGsS1K
 kSWrarbke5enfuYt5C1GlfkaySpKrJ7jKdyBVun47Uu4BLtc2hnQejN+0oZWJmmKsoeZMqJZK
 G9/dArFQ8IrsSEw503fT5RulEKXSiGj/WleA6aGQWIEl9RXVmLH6RepF3hdRci/4IGSCIGCBY
 M/oknvrgjeebZUitgxU+J602335xo5ygc9Bo0zfaN6qn/bVBI2nVrMYYqdaa/V5rx/7tEgj2K
 AelVCx8PIIb0KJrxhGH4E1725baXHiDytQANJymHKiEWKQ+DKUK2Ld4vQlZNV6cWBlQbfGJzZ
 Zou0g0k8V7/rErocx/sgwmcFe7Jc2MjXv6L1/2msPOLhrYGI7rTmYR99WM+s5tK+ngYq3g0H5
 g7TNzwO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The following didn't work as expected:

 - In a middle of a merge
 - merge.renormalize is true,
 - .gitattributes = "* text=auto"
 - core.eol = crlf

Merge a blob with CRLF "first line\r\nsame line\r\n" and a blob
with LF "first line\nsame line\n".

The expected result of the merge is "first line\nsame line\n".

The content in the working tree is "first line\r\nsame line\r\n",
and ce_compare_data() should find that the content is clean and return 0.

Deep down crlf_to_git() is invoked, to check if CRLF are converted or not.

The "new safer autocrlf handling" calls blob_has_cr().

Instead of using the sha1 of the blob, (CRLF in this example),
the function get_sha1_from_index() is invoked.
get_sha1_from_index() decides to return "ours" when in the middle of
the merge, which is LF.

As a result, the CRLF in the worktree are converted into LF before
the comparison.
The contents of LF and CRLF don't match any more.

The problem is that ce_compare_data() has ce->sha1, but the sha1 is lost
on it's way into blob_has_cr().

Forwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes sure
that blob_has_cr() looks at the appropriate blob.

Add a new parameter index_blob_sha1 to convert_to_git(), and forward the
sha1 from ce_compare_data() into convert_to_git(). Other callers use NULL
for index_blob_sha1, and the sha1 is determined from path
using get_sha1_from_cache(path). This is the same handling as before.

In the same spirit, forward the sha1 into would_convert_to_git().

While at it, rename has_cr_in_index() into blob_has_cr()
and replace 0 with SAFE_CRLF_FALSE.

Add a TC in t6038 to have a test coverage under Linux.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
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
 t/t6038-merge-text-auto.sh | 51 +++++++++++++++++++++++++---------------------
 11 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..f33d9cf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2142,7 +2142,8 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(path, buf->buf, buf->len, buf,
+			       SAFE_CRLF_FALSE, NULL);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index e982fb8..6305a1e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2376,7 +2376,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(path, buf.buf, buf.len, &buf, SAFE_CRLF_FALSE, NULL);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index bd1210a..42b74b6 100644
--- a/cache.h
+++ b/cache.h
@@ -605,6 +605,7 @@ extern int ie_modified(const struct index_state *, const struct cache_entry *, s
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
+#define HASH_USE_SHA_NOT_PATH 4
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
 
diff --git a/combine-diff.c b/combine-diff.c
index 0e1d4b0..c4fa884 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(elem->path, result, len,
+						   &buf, safe_crlf, NULL)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index 67d69b5..802ee7c 100644
--- a/convert.c
+++ b/convert.c
@@ -219,23 +219,28 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 	}
 }
 
-static int has_cr_in_index(const char *path)
+static int blob_has_cr(const unsigned char *index_blob_sha1)
 {
 	unsigned long sz;
 	void *data;
-	int has_cr;
-
-	data = read_blob_data_from_cache(path, &sz);
+	int has_cr = 0;
+	enum object_type type;
+	if (!index_blob_sha1)
+		return 0;
+	data = read_sha1_file(index_blob_sha1, &type, &sz);
 	if (!data)
 		return 0;
-	has_cr = memchr(data, '\r', sz) != NULL;
+	if (type == OBJ_BLOB)
+		has_cr = memchr(data, '\r', sz) != NULL;
+
 	free(data);
 	return has_cr;
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, enum safe_crlf checksafe,
+		       const unsigned char *index_blob_sha1)
 {
 	struct text_stat stats;
 	char *dst;
@@ -256,14 +261,23 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
 			return 0;
+
 		/*
 		 * If the file in the index has any CR in it, do not convert.
 		 * This is the new safer autocrlf handling.
 		 */
 		if (checksafe == SAFE_CRLF_RENORMALIZE)
 			checksafe = SAFE_CRLF_FALSE;
-		else if (has_cr_in_index(path))
-			return 0;
+		else {
+			/*
+			 * If the file in the index has any CR in it, do not convert.
+			 * This is the new safer autocrlf handling.
+			 */
+			if (!index_blob_sha1)
+				index_blob_sha1 = get_sha1_from_cache(path);
+			if (blob_has_cr(index_blob_sha1))
+				return 0;
+		}
 	}
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
 
@@ -855,7 +869,8 @@ const char *get_convert_attr_ascii(const char *path)
 }
 
 int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, enum safe_crlf checksafe,
+		   const unsigned char *index_blob_sha1)
 {
 	int ret = 0;
 	const char *filter = NULL;
@@ -876,7 +891,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe, index_blob_sha1);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -885,7 +900,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 }
 
 void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      enum safe_crlf checksafe,
+			      const unsigned char *index_blob_sha1)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -896,7 +912,8 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action,
+		    checksafe, index_blob_sha1);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
@@ -951,7 +968,7 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE, NULL);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 82871a1..97d4272 100644
--- a/convert.h
+++ b/convert.h
@@ -39,19 +39,26 @@ extern const char *get_convert_attr_ascii(const char *path);
 
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, enum safe_crlf checksafe,
+			  const unsigned char *index_blob_sha1);
+
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
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
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
 extern void convert_to_git_filter_fd(const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     enum safe_crlf checksafe,
+				     const unsigned char *index_blob_sha1);
+
 extern int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
diff --git a/diff.c b/diff.c
index 059123c..b973469 100644
--- a/diff.c
+++ b/diff.c
@@ -2800,7 +2800,8 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf,
+				   crlf_warn, NULL)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/dir.c b/dir.c
index a4a9d9f..8709fc0 100644
--- a/dir.c
+++ b/dir.c
@@ -720,7 +720,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				 (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
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
@@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
+		unsigned flags = HASH_USE_SHA_NOT_PATH;
+		memcpy(sha1, ce->sha1, sizeof(sha1));
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
 			match = hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..52e5c6f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3275,6 +3275,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 {
 	int ret, re_allocated = 0;
 	int write_object = flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 = flags & HASH_USE_SHA_NOT_PATH;
 
 	if (!type)
 		type = OBJ_BLOB;
@@ -3285,7 +3286,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
+				   write_object ? safe_crlf : SAFE_CRLF_FALSE,
+				   valid_sha1 ? sha1 : NULL)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -3313,13 +3315,15 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 {
 	int ret;
 	const int write_object = flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 = flags & HASH_USE_SHA_NOT_PATH;
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
 	assert(would_convert_to_git_filter_fd(path));
 
 	convert_to_git_filter_fd(path, fd, &sbuf,
-				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
+				 write_object ? safe_crlf : SAFE_CRLF_FALSE,
+				 valid_sha1 ? sha1 : NULL);
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
@@ -3396,6 +3400,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
+	const unsigned char *sha1_ce;
+	sha1_ce = flags & HASH_USE_SHA_NOT_PATH ? sha1 : NULL;
 
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -3406,7 +3412,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git(path,sha1_ce)))
 		ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 33b77ee..5e8d5fa 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -91,16 +91,13 @@ test_expect_success 'Merge after setting text=auto' '
 	compare_files expected file
 '
 
-test_expect_success 'Merge addition of text=auto' '
+test_expect_success 'Merge addition of text=auto eol=LF' '
+	git config core.eol lf &&
 	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
 
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -109,17 +106,31 @@ test_expect_success 'Merge addition of text=auto' '
 	compare_files  expected file
 '
 
+test_expect_success 'Merge addition of text=auto eol=CRLF' '
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
 test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
+	git config core.eol native &&
 	echo "<<<<<<<" >expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected &&
-		echo ======= | append_cr >>expected
-	else
-		echo first line >>expected &&
-		echo same line >>expected &&
-		echo ======= >>expected
-	fi &&
+	echo first line >>expected &&
+	echo same line >>expected &&
+	echo ======= >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -135,15 +146,9 @@ test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo ======= | append_cr >>expected &&
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected
-	else
-		echo ======= >>expected &&
-		echo first line >>expected &&
-		echo same line >>expected
-	fi &&
+	echo ======= >>expected &&
+	echo first line >>expected &&
+	echo same line >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
-- 
2.0.0.rc1.6318.g0c2c796

