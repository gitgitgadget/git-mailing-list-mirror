From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] attr: avoid heavy work when we know the specified attr is not defined
Date: Sun, 28 Dec 2014 06:39:48 +0700
Message-ID: <1419723588-13236-4-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
 <1419723588-13236-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 00:29:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y50na-0002AK-9L
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 00:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaL0X3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2014 18:29:25 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47896 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbaL0X3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 18:29:24 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so15128297pac.11
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yksixip9ifLvOzlfoXwUlNwjAOnLg+MGdv1RZgInVuM=;
        b=DJsmhhk9Bc5NwEEbJzy/5On9uJc64bsUOV5kFv0SjqJ1PD+x+trswRXe5g5XqKX+xk
         qjDC0uLvGJA05/sn9iKNlKefC2qqp1oRAoYy8ua0svUVW840PREwoG2g+yh6uuYcwjiH
         Hud6tRY/H0e1dFu0OO187oYeIYsztUN2fxZ2d7Ymzvg5F8Xe1ZhxGN+727V5e4Gfp4zI
         PpHZG4+GojeDi8KK+xRRilknVfwiYcnLiefOu+hibZrFrthJKboR5ei54TnK4tGceai2
         02CgHuM1msM+WdoEnJvHcN0T39f0Us9sQrPXJM4moFWXUwFhGfwYDU5e0f4Fy3pctQab
         5IjQ==
X-Received: by 10.68.136.98 with SMTP id pz2mr79661760pbb.154.1419722963858;
        Sat, 27 Dec 2014 15:29:23 -0800 (PST)
Received: from lanh ([115.73.209.146])
        by mx.google.com with ESMTPSA id qv9sm182226pab.27.2014.12.27.15.29.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 15:29:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Dec 2014 06:40:17 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1419723588-13236-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261845>

If we have never seen attr 'X' in any .gitattributes file we have
examined so far, we can be sure that 'X' is not defined. So no need to
go over all the attr stack to look for attr 'X'. This is the purpose
behind this new field maybe_real.

This optimization breaks down if macros are involved because we can't
know for sure what macro would expand to 'X' at attr parsing time. But
if we go the pessimistic way and assume all macros are expanded, we hit
the builtin "binary" macro. At least the "diff" attr defined in this
macro will disable this optimization for git-grep. So we wait until
any attr lines _may_ reference to a macro before we turn this off.

In git.git, this reduces the number of fill_one() call for "git grep
abcdefghi" from ~5348 to 2955. The optimization stops when it reads
t/.gitattributes, which uses 'binary' macro. We could probably reduce
it further by limiting the 'binary' reference to t/ and subdirs only
in this case.

"git grep" is actually a good example to justify this patch. The
command checks "diff" attribute on every file. People usually don't
define this attribute. But they pay the attr lookup penalty anyway
without this patch, proportional to the number of attr lines they have
in repo.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index b80e52b..1f9eebd 100644
--- a/attr.c
+++ b/attr.c
@@ -33,9 +33,11 @@ struct git_attr {
 	unsigned h;
 	int attr_nr;
 	int maybe_macro;
+	int maybe_real;
 	char name[FLEX_ARRAY];
 };
 static int attr_nr;
+static int cannot_trust_maybe_real;
=20
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
@@ -97,6 +99,7 @@ static struct git_attr *git_attr_internal(const char =
*name, int len)
 	a->next =3D git_attr_hash[pos];
 	a->attr_nr =3D attr_nr++;
 	a->maybe_macro =3D 0;
+	a->maybe_real =3D 0;
 	git_attr_hash[pos] =3D a;
=20
 	REALLOC_ARRAY(check_all_attr, attr_nr);
@@ -269,6 +272,10 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 	/* Second pass to fill the attr_states */
 	for (cp =3D states, i =3D 0; *cp; i++) {
 		cp =3D parse_attr(src, lineno, cp, &(res->state[i]));
+		if (!is_macro)
+			res->state[i].attr->maybe_real =3D 1;
+		if (res->state[i].attr->maybe_macro)
+			cannot_trust_maybe_real =3D 1;
 	}
=20
 	return res;
@@ -710,10 +717,13 @@ static int macroexpand_one(int nr, int rem)
 }
=20
 /*
- * Collect all attributes for path into the array pointed to by
- * check_all_attr.
+ * Collect attributes for path into the array pointed to by
+ * check_all_attr. If num is non-zero, only attributes in check[] are
+ * collected. Otherwise all attributes are collected.
  */
-static void collect_all_attrs(const char *path)
+static void collect_some_attrs(const char *path, int num,
+			       struct git_attr_check *check)
+
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
@@ -736,6 +746,19 @@ static void collect_all_attrs(const char *path)
 	prepare_attr_stack(path, dirlen);
 	for (i =3D 0; i < attr_nr; i++)
 		check_all_attr[i].value =3D ATTR__UNKNOWN;
+	if (num && !cannot_trust_maybe_real) {
+		rem =3D 0;
+		for (i =3D 0; i < num; i++) {
+			if (!check[i].attr->maybe_real) {
+				struct git_attr_check *c;
+				c =3D check_all_attr + check[i].attr->attr_nr;
+				c->value =3D ATTR__UNSET;
+				rem++;
+			}
+		}
+		if (rem =3D=3D num)
+			return;
+	}
=20
 	rem =3D attr_nr;
 	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
@@ -746,7 +769,7 @@ int git_check_attr(const char *path, int num, struc=
t git_attr_check *check)
 {
 	int i;
=20
-	collect_all_attrs(path);
+	collect_some_attrs(path, num, check);
=20
 	for (i =3D 0; i < num; i++) {
 		const char *value =3D check_all_attr[check[i].attr->attr_nr].value;
@@ -762,7 +785,7 @@ int git_all_attrs(const char *path, int *num, struc=
t git_attr_check **check)
 {
 	int i, count, j;
=20
-	collect_all_attrs(path);
+	collect_some_attrs(path, 0, NULL);
=20
 	/* Count the number of attributes that are set. */
 	count =3D 0;
--=20
2.2.0.84.ge9c7a8a
