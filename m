From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Sun, 8 May 2011 17:19:25 +0700
Message-ID: <20110508101925.GA19525@do>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
 <1304844455-23570-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 12:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ188-0002zo-Rg
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 12:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab1EHKWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 06:22:23 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:62522 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1EHKWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 06:22:22 -0400
Received: by pxi16 with SMTP id 16so3066906pxi.4
        for <git@vger.kernel.org>; Sun, 08 May 2011 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wsYx+lgNwi9l75dOMVWh4vprIUv5zJNGdMUGwXKvTd0=;
        b=tvCDBFnr4lqUIXWHrOMzzYpULjmoEUWcOda4mStIn1enSDAy3NsyCR4dD8lh3sEo5X
         KN+TPzCamDmhEIOQGjRvewkt2ijykt+v32Psf5b5hcx4wnfJZmIgK9L1xrckJXIkzV7+
         KZVlcyBvUEccR5z59wDqL4ANyBa1jsbkZbIAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=abZniCKlIuZbzrs5ZlEdA0tO6Vsq+VJdQqHEX+djuOJNq1veaWlyJ4fnTIv7DqQbze
         Yub/ho0tuH6TURpE8Stq3cCmSFKNjYQVE/DT6Ks9DiVQ/Mv4Tji57RZmrtCbr5MJJBFp
         UOFhqCDCLGk8vz4CmveLs88xN3spdCFx07GPo=
Received: by 10.68.19.134 with SMTP id f6mr4203536pbe.31.1304850141876;
        Sun, 08 May 2011 03:22:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.196.42])
        by mx.google.com with ESMTPS id i7sm3373489pbs.20.2011.05.08.03.22.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 03:22:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 May 2011 17:19:25 +0700
Content-Disposition: inline
In-Reply-To: <1304844455-23570-4-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173089>

On Sun, May 08, 2011 at 01:47:35AM -0700, Junio C Hamano wrote:
>  * The decision to stream in this patch is based on the size of the
>    blob, but it should be tied to an attribute, "bigdata". The
>    attribute should also mean the blob will not undergo any
>    convert-to-git processing.

Instead we could detect if convert-from/to-git is unnecessary and
stream big blobs based on core.bigFileThresold. The below patch may
help. I made it in order to checkout files without inflating in memory
but that part's still not ready.

By the way, is there any way we can mark an object in the pack as
"non-compressed" so we can read it without inflating? zlib compression
level =3D=3D 0 still splits the object into multiple parts.

-- 8< --
Subject: [PATCH] convert: add functions to determine whether conversion=
 is needed

Blob conversion from/to repository requires the entire blob in memory.
The conversion is rarely used most of the time and that requirement
could put more pressure on memory for large blobs.

Add two functions to determine early whether we can bypass conversion
without looking at the content.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |    3 ++
 convert.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++------=
-------
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index 08a9022..be3845d 100644
--- a/cache.h
+++ b/cache.h
@@ -1091,7 +1091,10 @@ extern void trace_repo_setup(const char *prefix)=
;
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
                           struct strbuf *dst, enum safe_crlf checksafe=
);
+extern int convert_to_git_needed(const char *path, size_t len,
+				 enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
+extern int convert_to_working_tree_needed(const char *path, size_t len=
);
 extern int renormalize_buffer(const char *path, const char *src, size_=
t len, struct strbuf *dst);
=20
 /* add */
diff --git a/convert.c b/convert.c
index d5aebed..39545ed 100644
--- a/convert.c
+++ b/convert.c
@@ -188,7 +188,8 @@ static int has_cr_in_index(const char *path)
 }
=20
 static int crlf_to_git(const char *path, const char *src, size_t len,
-		       struct strbuf *buf, enum action action, enum safe_crlf checks=
afe)
+		       struct strbuf *buf, enum action action,
+		       enum safe_crlf checksafe, int dry_run)
 {
 	struct text_stat stats;
 	char *dst;
@@ -197,6 +198,9 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	    (action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALSE) ||=
 !len)
 		return 0;
=20
+	if (dry_run)
+		return 1;
+
 	gather_stats(src, len, &stats);
=20
 	if (action =3D=3D CRLF_AUTO || action =3D=3D CRLF_GUESS) {
@@ -257,7 +261,7 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 }
=20
 static int crlf_to_worktree(const char *path, const char *src, size_t =
len,
-			    struct strbuf *buf, enum action action)
+			    struct strbuf *buf, enum action action, int dry_run)
 {
 	char *to_free =3D NULL;
 	struct text_stat stats;
@@ -265,6 +269,9 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 	if (!len || determine_output_conversion(action) !=3D EOL_CRLF)
 		return 0;
=20
+	if (dry_run)
+		return 1;
+
 	gather_stats(src, len, &stats);
=20
 	/* No LF? Nothing to convert, regardless. */
@@ -374,7 +381,7 @@ static int filter_buffer(int in, int out, void *dat=
a)
 }
=20
 static int apply_filter(const char *path, const char *src, size_t len,
-                        struct strbuf *dst, const char *cmd)
+			struct strbuf *dst, const char *cmd, int dry_run)
 {
 	/*
 	 * Create a pipeline to have the command filter the buffer's
@@ -390,6 +397,9 @@ static int apply_filter(const char *path, const cha=
r *src, size_t len,
 	if (!cmd)
 		return 0;
=20
+	if (dry_run)
+		return 1;
+
 	memset(&async, 0, sizeof(async));
 	async.proc =3D filter_buffer;
 	async.data =3D &params;
@@ -541,11 +551,17 @@ static int count_ident(const char *cp, unsigned l=
ong size)
 }
=20
 static int ident_to_git(const char *path, const char *src, size_t len,
-                        struct strbuf *buf, int ident)
+			struct strbuf *buf, int ident, int dry_run)
 {
 	char *dst, *dollar;
=20
-	if (!ident || !count_ident(src, len))
+	if (!ident)
+		return 0;
+
+	if (dry_run)
+		return 1;
+
+	if(!count_ident(src, len))
 		return 0;
=20
 	/* only grow if not in place */
@@ -582,7 +598,7 @@ static int ident_to_git(const char *path, const cha=
r *src, size_t len,
 }
=20
 static int ident_to_worktree(const char *path, const char *src, size_t=
 len,
-                             struct strbuf *buf, int ident)
+			     struct strbuf *buf, int ident, int dry_run)
 {
 	unsigned char sha1[20];
 	char *to_free =3D NULL, *dollar, *spc;
@@ -591,6 +607,9 @@ static int ident_to_worktree(const char *path, cons=
t char *src, size_t len,
 	if (!ident)
 		return 0;
=20
+	if (dry_run)
+		return 1;
+
 	cnt =3D count_ident(src, len);
 	if (!cnt)
 		return 0;
@@ -726,8 +745,9 @@ static enum action determine_action(enum action tex=
t_attr, enum eol eol_attr)
 	return text_attr;
 }
=20
-int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+static int convert_to_git_1(const char *path, const char *src, size_t =
len,
+			    struct strbuf *dst, enum safe_crlf checksafe,
+			    int dry_run)
 {
 	struct git_attr_check check[5];
 	enum action action =3D CRLF_GUESS;
@@ -748,23 +768,39 @@ int convert_to_git(const char *path, const char *=
src, size_t len,
 			filter =3D drv->clean;
 	}
=20
-	ret |=3D apply_filter(path, src, len, dst, filter);
+	ret |=3D apply_filter(path, src, len, dst, filter, dry_run);
 	if (ret) {
+		if (dry_run)
+			return 1;
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
 	action =3D determine_action(action, eol_attr);
-	ret |=3D crlf_to_git(path, src, len, dst, action, checksafe);
+	ret |=3D crlf_to_git(path, src, len, dst, action, checksafe, dry_run)=
;
 	if (ret) {
+		if (dry_run)
+			return 1;
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	return ret | ident_to_git(path, src, len, dst, ident);
+	return ret | ident_to_git(path, src, len, dst, ident, dry_run);
+}
+
+int convert_to_git(const char *path, const char *src, size_t len,
+		   struct strbuf *dst, enum safe_crlf checksafe)
+{
+	return convert_to_git_1(path, src, len, dst, checksafe, 0);
+}
+
+int convert_to_git_needed(const char *path, size_t len,
+			  enum safe_crlf checksafe)
+{
+	return convert_to_git_1(path, NULL, len, NULL, checksafe, 1);
 }
=20
 static int convert_to_working_tree_internal(const char *path, const ch=
ar *src,
 					    size_t len, struct strbuf *dst,
-					    int normalizing)
+					    int normalizing, int dry_run)
 {
 	struct git_attr_check check[5];
 	enum action action =3D CRLF_GUESS;
@@ -785,8 +821,10 @@ static int convert_to_working_tree_internal(const =
char *path, const char *src,
 			filter =3D drv->smudge;
 	}
=20
-	ret |=3D ident_to_worktree(path, src, len, dst, ident);
+	ret |=3D ident_to_worktree(path, src, len, dst, ident, dry_run);
 	if (ret) {
+		if (dry_run)
+			return 1;
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
@@ -796,23 +834,30 @@ static int convert_to_working_tree_internal(const=
 char *path, const char *src,
 	 */
 	if (filter || !normalizing) {
 		action =3D determine_action(action, eol_attr);
-		ret |=3D crlf_to_worktree(path, src, len, dst, action);
+		ret |=3D crlf_to_worktree(path, src, len, dst, action, dry_run);
 		if (ret) {
+			if (dry_run)
+				return 1;
 			src =3D dst->buf;
 			len =3D dst->len;
 		}
 	}
-	return ret | apply_filter(path, src, len, dst, filter);
+	return ret | apply_filter(path, src, len, dst, filter, dry_run);
 }
=20
 int convert_to_working_tree(const char *path, const char *src, size_t =
len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	return convert_to_working_tree_internal(path, src, len, dst, 0, 0);
+}
+
+int convert_to_working_tree_needed(const char *path, size_t len)
+{
+	return convert_to_working_tree_internal(path, NULL, len, NULL, 0, 1);
 }
=20
 int renormalize_buffer(const char *path, const char *src, size_t len, =
struct strbuf *dst)
 {
-	int ret =3D convert_to_working_tree_internal(path, src, len, dst, 1);
+	int ret =3D convert_to_working_tree_internal(path, src, len, dst, 1, =
0);
 	if (ret) {
 		src =3D dst->buf;
 		len =3D dst->len;
--=20
1.7.4.74.g639db


-- 8< --

--=20
Duy
