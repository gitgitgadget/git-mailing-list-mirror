From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m?= <grubba@grubba.org>
Subject: [PATCH 3/4] convert: Inhibit contraction of foreign $Id$ during stats.
Date: Mon,  1 Mar 2010 17:16:57 +0100
Message-ID: <1267460218-1172-3-git-send-email-grubba@grubba.org>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
 <1267460218-1172-2-git-send-email-grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 17:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm8ok-00019C-3P
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 17:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab0CAQt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 11:49:58 -0500
Received: from mail.roxen.com ([212.247.29.220]:48350 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab0CAQty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 11:49:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 5D2506280EF
	for <git@vger.kernel.org>; Mon,  1 Mar 2010 17:17:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDAJODUKwVcw; Mon,  1 Mar 2010 17:17:05 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 345726280ED;
	Mon,  1 Mar 2010 17:17:05 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o21GH5FO001229;
	Mon, 1 Mar 2010 17:17:05 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o21GH5Ob001228;
	Mon, 1 Mar 2010 17:17:05 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1267460218-1172-2-git-send-email-grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141328>

=46rom: Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>

=46iles containing foreign $Id$'s were reported as modified directly
on checkout, which ment that it was difficult to keep a clean working
tree when handling commits with files containing such. convert_to_git()
now takes one more mode parameter for controlling this.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 builtin-apply.c |    2 +-
 builtin-blame.c |    2 +-
 cache.h         |    8 +++++++-
 combine-diff.c  |    2 +-
 convert.c       |   20 +++++++++++++++++---
 diff.c          |    2 +-
 sha1_file.c     |    3 ++-
 7 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 3af4ae0..25adef8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1759,7 +1759,7 @@ static int read_old_data(struct stat *st, const c=
har *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(path, buf->buf, buf->len, buf, 0, 0);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin-blame.c b/builtin-blame.c
index 10f7eac..f21bf3d 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2050,7 +2050,7 @@ static struct commit *fake_working_tree_commit(co=
nst char *path, const char *con
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(path, buf.buf, buf.len, &buf, 0, 0);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index d478eff..1c9f491 100644
--- a/cache.h
+++ b/cache.h
@@ -547,6 +547,11 @@ enum safe_crlf {
 	SAFE_CRLF_WARN =3D 2,
 };
=20
+enum ident_mode {
+	IDENT_MODE_FALSE =3D 0,
+	IDENT_MODE_KEEP_FOREIGN =3D 1,
+};
+
 extern enum safe_crlf safe_crlf;
=20
 enum branch_track {
@@ -996,7 +1001,8 @@ extern void trace_argv_printf(const char **argv, c=
onst char *format, ...);
 /* convert.c */
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
-                          struct strbuf *dst, enum safe_crlf checksafe=
);
+                          struct strbuf *dst, enum safe_crlf checksafe=
,
+                          enum ident_mode identmode);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
=20
 /* add */
diff --git a/combine-diff.c b/combine-diff.c
index 6162691..8c9320a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -758,7 +758,7 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf =3D STRBUF_INIT;
=20
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(elem->path, result, len, &buf, safe_crlf, 0)) {
 					free(result);
 					result =3D strbuf_detach(&buf, &len);
 					result_size =3D len;
diff --git a/convert.c b/convert.c
index 28aeea3..c053bcd 100644
--- a/convert.c
+++ b/convert.c
@@ -432,7 +432,8 @@ static int count_ident(const char *cp, unsigned lon=
g size)
 }
=20
 static int ident_to_git(const char *path, const char *src, size_t len,
-                        struct strbuf *buf, int ident)
+                        struct strbuf *buf, int ident,
+                        enum ident_mode identmode)
 {
 	char *dst, *dollar, *nl;
=20
@@ -462,6 +463,18 @@ static int ident_to_git(const char *path, const ch=
ar *src, size_t len,
 				continue;
 			}
=20
+			if ((identmode =3D=3D IDENT_MODE_KEEP_FOREIGN) &&
+			    ((src[3] !=3D ' ') ||
+			     (memchr(src + 4, ' ', len - 4) !=3D dollar-1))) {
+				/* Foreign id.
+				 * Contraction of these is inhibited during
+				 * status operations to avoid all files
+				 * containing such being marked as modified
+				 * on checkout. cf sha1_file.c:index_mem().
+				 */
+				continue;
+			}
+
 			memcpy(dst, "Id$", 3);
 			dst +=3D 3;
 			len -=3D dollar + 1 - src;
@@ -594,7 +607,8 @@ static int git_path_check_ident(const char *path, s=
truct git_attr_check *check)
 }
=20
 int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+                   struct strbuf *dst, enum safe_crlf checksafe,
+                   enum ident_mode identmode)
 {
 	struct git_attr_check check[3];
 	int crlf =3D CRLF_GUESS;
@@ -621,7 +635,7 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	return ret | ident_to_git(path, src, len, dst, ident);
+	return ret | ident_to_git(path, src, len, dst, ident, identmode);
 }
=20
 int convert_to_working_tree(const char *path, const char *src, size_t =
len, struct strbuf *dst)
diff --git a/diff.c b/diff.c
index 989dbc5..64726c8 100644
--- a/diff.c
+++ b/diff.c
@@ -2113,7 +2113,7 @@ int diff_populate_filespec(struct diff_filespec *=
s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf, 0)) {
 			size_t size =3D 0;
 			munmap(s->data, s->size);
 			s->should_munmap =3D 0;
diff --git a/sha1_file.c b/sha1_file.c
index 657825e..fd8c5df 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2419,7 +2419,8 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 	if ((type =3D=3D OBJ_BLOB) && path) {
 		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? safe_crlf : 0)) {
+		                   write_object ? safe_crlf : 0,
+		                   write_object ? 0 : IDENT_MODE_KEEP_FOREIGN)) {
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
--=20
1.6.4.122.g6ffd7
