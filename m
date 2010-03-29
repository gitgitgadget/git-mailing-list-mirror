From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 4/5] convert: Inhibit contraction of foreign $Id$ during stats.
Date: Mon, 29 Mar 2010 13:28:58 +0200
Message-ID: <81e71814080d0eca72809a751e4e90026f8fe0ea.1269860022.git.grubba@grubba.org>
References: <cover.1269860022.git.grubba@grubba.org>
 <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
 <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
 <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 13:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwDA6-0005rg-QE
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 13:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab0C2L3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 07:29:23 -0400
Received: from mail.roxen.com ([212.247.29.220]:43198 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab0C2L3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 07:29:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 62234628259
	for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:29:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htJq8aHYXnFY; Mon, 29 Mar 2010 13:29:06 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 38A16628254;
	Mon, 29 Mar 2010 13:29:06 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2TBT6QK006187;
	Mon, 29 Mar 2010 13:29:06 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2TBT61x006186;
	Mon, 29 Mar 2010 13:29:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
In-Reply-To: <cover.1269860022.git.grubba@grubba.org>
References: <cover.1269860022.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143461>

=46iles containing foreign $Id$'s were reported as modified directly
on checkout, which ment that it was difficult to keep a clean working
tree when handling commits with files containing such. convert_to_git()
now takes one more mode parameter for controlling this.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
Changed from last time to use enum constant IDENT_MODE_FALSE instead
of a plain zero, as suggested by Bert Wesarg <bert.wesarg@googlemail.co=
m>.

 builtin/apply.c       |    3 ++-
 builtin/blame.c       |    3 ++-
 cache.h               |    8 +++++++-
 combine-diff.c        |    3 ++-
 convert.c             |   24 ++++++++++++++++++++----
 diff.c                |    3 ++-
 sha1_file.c           |    3 ++-
 t/t0021-conversion.sh |   21 +++++++++++++++++++++
 8 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6dbe1d7..19fe436 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1759,7 +1759,8 @@ static int read_old_data(struct stat *st, const c=
har *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, SAFE_CRLF_FALSE);
+		convert_to_git(path, buf->buf, buf->len, buf, SAFE_CRLF_FALSE,
+			       IDENT_MODE_FALSE);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 3af045b..4cefaba 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2050,7 +2050,8 @@ static struct commit *fake_working_tree_commit(co=
nst char *path, const char *con
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, SAFE_CRLF_FALSE);
+	convert_to_git(path, buf.buf, buf.len, &buf, SAFE_CRLF_FALSE,
+		       IDENT_MODE_FALSE);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 6dcb100..d510a22 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,11 @@ enum safe_crlf {
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
@@ -1014,7 +1019,8 @@ extern void trace_argv_printf(const char **argv, =
const char *format, ...);
 /* convert.c */
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
-                          struct strbuf *dst, enum safe_crlf checksafe=
);
+			  struct strbuf *dst, enum safe_crlf checksafe,
+			  enum ident_mode identmode);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
=20
 /* add */
diff --git a/combine-diff.c b/combine-diff.c
index 6162691..ba37bcc 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -758,7 +758,8 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf =3D STRBUF_INIT;
=20
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(elem->path, result, len, &buf,
+						   safe_crlf, IDENT_MODE_FALSE)) {
 					free(result);
 					result =3D strbuf_detach(&buf, &len);
 					result_size =3D len;
diff --git a/convert.c b/convert.c
index 5a0b7fb..2726c0c 100644
--- a/convert.c
+++ b/convert.c
@@ -433,9 +433,10 @@ static int count_ident(const char *cp, unsigned lo=
ng size)
 }
=20
 static int ident_to_git(const char *path, const char *src, size_t len,
-                        struct strbuf *buf, int ident)
+			struct strbuf *buf, int ident,
+			enum ident_mode identmode)
 {
-	char *dst, *dollar;
+	char *dst, *dollar, *spc;
=20
 	if (!ident || !count_ident(src, len))
 		return 0;
@@ -462,6 +463,20 @@ static int ident_to_git(const char *path, const ch=
ar *src, size_t len,
 				continue;
 			}
=20
+			if ((identmode =3D=3D IDENT_MODE_KEEP_FOREIGN) && len > 5) {
+				spc =3D memchr(src + 4, ' ', dollar - src - 4);
+				if (spc && spc < dollar-1) {
+					/* Foreign id.
+					 * Contraction of these is inhibited
+					 * during status operations to avoid
+					 * all files containing such being
+					 * marked as modified on checkout.
+					 * cf sha1_file.c:index_mem().
+					 */
+					continue;
+				}
+			}
+
 			memcpy(dst, "Id$", 3);
 			dst +=3D 3;
 			len -=3D dollar + 1 - src;
@@ -593,7 +608,8 @@ static int git_path_check_ident(const char *path, s=
truct git_attr_check *check)
 }
=20
 int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, enum safe_crlf checksafe,
+		   enum ident_mode identmode)
 {
 	struct git_attr_check check[3];
 	int crlf =3D CRLF_GUESS;
@@ -620,7 +636,7 @@ int convert_to_git(const char *path, const char *sr=
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
index f5d93e9..9ae688b 100644
--- a/diff.c
+++ b/diff.c
@@ -2113,7 +2113,8 @@ int diff_populate_filespec(struct diff_filespec *=
s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf,
+				   safe_crlf, IDENT_MODE_FALSE)) {
 			size_t size =3D 0;
 			munmap(s->data, s->size);
 			s->should_munmap =3D 0;
diff --git a/sha1_file.c b/sha1_file.c
index 96c69cc..b7114fc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2417,7 +2417,8 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 	if ((type =3D=3D OBJ_BLOB) && path) {
 		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
+		                   write_object ? safe_crlf : SAFE_CRLF_FALSE,
+				   write_object ? IDENT_MODE_FALSE : IDENT_MODE_KEEP_FOREIGN)) {
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 828e35b..f695581 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -93,4 +93,25 @@ test_expect_success expanded_in_repo '
 	cmp expanded-keywords expected-output
 '
=20
+# Check that files containing keywords with proper markup aren't marke=
d
+# as modified on checkout.
+test_expect_success keywords_not_modified '
+	{
+		echo "File with foreign keywords"
+		echo "\$Id\$"
+		echo "\$Id: NoTerminatingSymbol"
+		echo "\$Id: Foreign Commit With Spaces $"
+		echo "\$Id: NoTerminatingSymbolAtEOF"
+	} > expanded-keywords2 &&
+
+	git add expanded-keywords2 &&
+	git commit -m "File with keywords expanded" &&
+
+	echo "expanded-keywords2 ident" >> .gitattributes &&
+
+	rm -f expanded-keywords2 &&
+	git checkout -- expanded-keywords2 &&
+	test "x`git status --porcelain -- expanded-keywords2`" =3D x
+'
+
 test_done
--=20
1.6.4.122.g6ffd7
