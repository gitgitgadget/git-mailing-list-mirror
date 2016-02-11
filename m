From: tboegi@web.de
Subject: [PATCH 2/3] Factor out convert_cmp_checkout() into convert.c
Date: Thu, 11 Feb 2016 17:16:09 +0100
Message-ID: <1455207369-24931-1-git-send-email-tboegi@web.de>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 17:15:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTttU-0007j7-7X
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 17:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcBKQOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 11:14:50 -0500
Received: from mout.web.de ([212.227.17.11]:49528 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbcBKQOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 11:14:47 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LxOQ2-1ZxL481146-016zom; Thu, 11 Feb 2016 17:14:46
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:uLodl8k7JGYEbBpviw26uBJLKlKtgZSsUftljfHTvGMxJkrbICK
 70MGet8qYcn+UOA6xIm+UPS62jOQ5jOfJW0AE4iQTfQ2v3dpjhsftX5abOMpbs4Wo7q8onI
 Vaqwgj19sh0yfCOx5QAB1IswzmxymtBVeWiboLI1U8leYfKpTrgNqzZ4yvAggwK6Gwpoo7P
 NCI1aG7SH5RojMAAwrKGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q60Zn5ha+6U=:XjHu9EkRrYOQCmc5Ps2E8X
 zFWKyzG1PelkKivMFiXty/QJFQuestt37vL4gRHzd70LrOVhCWKfuxtPpeO8G0rKkUTSzVLQ4
 PWO4UTr+aa4Fc7kqSglx6ycJLvCf2NNxwtoQeK9lkmQ/aE7ZJmfTm+ca3mF+gnkVt+bKy2ULn
 pJr8AGwby0JMT5siJBIXpTZYOyQgui7Hvjas0mCRTD3pEox6zhdP412jzJ/JsSTTWv22oGqxe
 K/6BLsM7v7r4Er4UWQFb+S5JUv2k0MFRk3eDvb40/2rwd8saxaAiUBTY5aUkuxJ8iUA3FPpxV
 R3YEpQ9O+8QEZL+wEamSsdk9UtohFY9F97gZL8MNOXaTdzaIZX7kk9+1p0mNMf3XcVZ3RmUmA
 8uV6A/LVRpgIXZKIsZnJIYJXh5cy9yD07bfdtpREialepo0Lh1z87roLCA7/7qXUozMZPOkGS
 q6axEEEUPjHt6z3CNIWuPvHyAQ9CNKRi97f9LkhQ+nGuxW7Rk4wFEsFiLNy0BKYGsfiQMB+X5
 ZWe1CVpEdARm6fpe+hGWZYdQ43Guv9mRLE1tUa8KCx7aBV279ZCGVIPErD1Ws6JpSck+s/wK0
 5hQbCJ8JI/9tgBOZPmt07/qHaLanr74M8tivvdNXYLzqD0X3bErqo3gdA7mwyKnHJHtxeNUp/
 rILWAOlFEBSyoSW6w6tWo5gD40vlQXLK40vp64wZst+V8rQUzNFeMIZBzocJjwTrdvtvOJeN5
 naDA24EYOcZDyIFse4Bh0IFiJgN7/u5pIb4AiJxDh5aE6gG47hK5YaTJfeK5tC8wAFBn+hBk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285985>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

=46actor out the code  from read_cache.c retrieveing the blob, converti=
ng to
worktree format and comparing with the file on disc into convert.c.

Move static compare_with_fd() from read_cache.c to convert.c as well.

Add a shortcut in convert_cmp_checkout(): When no converting attributes=
 are
set, no filters defined and core.autocrlf is false, skip the additional=
 compare.

To avoid that attributes needs to be searched on the file system twice,=
 change
convert_to_working_tree_internal() to take an additional parameter conv=
_attrs*.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h      |  2 ++
 convert.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++-=
--------
 read-cache.c | 21 +--------------
 3 files changed, 78 insertions(+), 32 deletions(-)

diff --git a/cache.h b/cache.h
index 22ef4f1..a0dfa5e 100644
--- a/cache.h
+++ b/cache.h
@@ -568,6 +568,8 @@ extern int ce_same_name(const struct cache_entry *a=
, const struct cache_entry *b
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry=
 *ce);
 extern int index_name_is_other(const struct index_state *, const char =
*, int);
 extern void *read_blob_data_from_index(struct index_state *, const cha=
r *, unsigned long *);
+extern int convert_cmp_checkout(const char *);
+
=20
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/convert.c b/convert.c
index 18af685..9cbc62c 100644
--- a/convert.c
+++ b/convert.c
@@ -217,6 +217,34 @@ static void check_safe_crlf(const char *path, enum=
 crlf_action crlf_action,
 	}
 }
=20
+/*
+ * Compare the data in buf with the data in the file pointed by fd and
+ * return 0 if they are identical, and non-zero if they differ.
+ */
+static int compare_with_fd(const char *input, unsigned long len, int f=
d)
+{
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t chunk_len, read_len;
+
+		chunk_len =3D sizeof(buf) < len ? sizeof(buf) : len;
+		read_len =3D xread(fd, buf, chunk_len ? chunk_len : 1);
+
+		if (!read_len)
+			/* EOF on the working tree file */
+			return !len ? 0 : -1;
+
+		if (!len)
+			/* we expected there is nothing left */
+			return -1;
+
+		if (memcmp(buf, input, read_len))
+			return -1;
+		input +=3D read_len;
+		len -=3D read_len;
+	}
+}
+
 static int has_cr_in_index(const char *path)
 {
 	unsigned long sz;
@@ -807,6 +835,37 @@ static void convert_attrs(struct conv_attrs *ca, c=
onst char *path)
 		ca->crlf_action =3D CRLF_AUTO_INPUT;
 }
=20
+int convert_cmp_checkout(const char *path)
+{
+	struct conv_attrs ca;
+	int match =3D -1; /* no match */
+	int fd;
+	convert_attrs(&ca, path);
+	if (ca.crlf_action =3D=3D CRLF_BINARY && !ca.drv && !ca.ident)
+	  return -1; /* No eol conversion, no ident, no filter */
+
+	fd =3D open(path, O_RDONLY);
+	if (fd >=3D 0) {
+		unsigned long sz;
+		void *data;
+		data =3D read_blob_data_from_cache(path, &sz);
+		if (!data)
+			match =3D -1;
+		else {
+			struct strbuf worktree =3D STRBUF_INIT;
+			if (convert_to_working_tree(path, data, sz, &worktree)) {
+				free(data);
+				data =3D strbuf_detach(&worktree, &sz);
+			}
+			if (!compare_with_fd(data, sz, fd))
+				match =3D 0;
+		}
+		free(data);
+		close(fd);
+	}
+	return match;
+}
+
 int would_convert_to_git_filter_fd(const char *path)
 {
 	struct conv_attrs ca;
@@ -898,22 +957,21 @@ void convert_to_git_filter_fd(const char *path, i=
nt fd, struct strbuf *dst,
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
=20
-static int convert_to_working_tree_internal(const char *path, const ch=
ar *src,
+static int convert_to_working_tree_internal(const char *path,
+					    struct conv_attrs *ca,
+					    const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
 {
 	int ret =3D 0, ret_filter =3D 0;
 	const char *filter =3D NULL;
 	int required =3D 0;
-	struct conv_attrs ca;
-
-	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter =3D ca.drv->smudge;
-		required =3D ca.drv->required;
+	if (ca->drv) {
+		filter =3D ca->drv->smudge;
+		required =3D ca->drv->required;
 	}
=20
-	ret |=3D ident_to_worktree(path, src, len, dst, ca.ident);
+	ret |=3D ident_to_worktree(path, src, len, dst, ca->ident);
 	if (ret) {
 		src =3D dst->buf;
 		len =3D dst->len;
@@ -923,7 +981,7 @@ static int convert_to_working_tree_internal(const c=
har *path, const char *src,
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
-		ret |=3D crlf_to_worktree(path, src, len, dst, ca.crlf_action);
+		ret |=3D crlf_to_worktree(path, src, len, dst, ca->crlf_action);
 		if (ret) {
 			src =3D dst->buf;
 			len =3D dst->len;
@@ -932,19 +990,24 @@ static int convert_to_working_tree_internal(const=
 char *path, const char *src,
=20
 	ret_filter =3D apply_filter(path, src, len, -1, dst, filter);
 	if (!ret_filter && required)
-		die("%s: smudge filter %s failed", path, ca.drv->name);
+		die("%s: smudge filter %s failed", path, ca->drv->name);
=20
 	return ret | ret_filter;
 }
=20
 int convert_to_working_tree(const char *path, const char *src, size_t =
len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	struct conv_attrs ca;
+	convert_attrs(&ca, path);
+	return convert_to_working_tree_internal(path, &ca, src, len, dst, 0);
 }
=20
 int renormalize_buffer(const char *path, const char *src, size_t len, =
struct strbuf *dst)
 {
-	int ret =3D convert_to_working_tree_internal(path, src, len, dst, 1);
+	struct conv_attrs ca;
+	int ret;
+	convert_attrs(&ca, path);
+	ret =3D convert_to_working_tree_internal(path, &ca, src, len, dst, 1)=
;
 	if (ret) {
 		src =3D dst->buf;
 		len =3D dst->len;
diff --git a/read-cache.c b/read-cache.c
index 2948b8f..35481b0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -206,26 +206,7 @@ static int ce_compare_data(const struct cache_entr=
y *ce, struct stat *st)
 	 * Would another "git checkout -f" out of the index change
 	 * what is in the working tree file?
 	 */
-	fd =3D open(ce->name, O_RDONLY);
-	if (fd >=3D 0) {
-		enum object_type type;
-		unsigned long size;
-		void *data =3D read_sha1_file(ce->sha1, &type, &size);
-
-		if (type =3D=3D OBJ_BLOB) {
-			struct strbuf worktree =3D STRBUF_INIT;
-			if (convert_to_working_tree(ce->name, data, size,
-																	&worktree)) {
-				free(data);
-				data =3D strbuf_detach(&worktree, &size);
-			}
-			if (!compare_with_fd(data, size, fd))
-				match =3D 0;
-		}
-		free(data);
-		close(fd);
-	}
-	return match;
+	return convert_cmp_checkout(ce->name);
 }
=20
 static int ce_compare_link(const struct cache_entry *ce, size_t expect=
ed_size)
--=20
2.7.0.303.g2c4f448.dirty
