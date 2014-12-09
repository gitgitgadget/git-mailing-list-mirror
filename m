From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 4/4] attr: avoid heavy work when we know the specified attr is not defined
Date: Tue,  9 Dec 2014 20:53:25 +0700
Message-ID: <1418133205-18213-5-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 14:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyLF8-00021s-3o
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 14:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbaLINyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 08:54:12 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44693 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203AbaLINxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 08:53:51 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so589579pac.25
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FGY9EsTo7KZdkA/0oV7oA453cM71FWWwBeC7M9dShVs=;
        b=Z5ouf71ONYCNpI6eC4ujAOW/Q49LGLbAcMNhNbXovVlFV7n1/thD0cQyxUMWfMMGue
         SfC5Mwxg1fT2LEMyoVBopj5/2qmTigrE5/jrhW+9FXcy9V4rkAAMPxEhfyrK49RqPhSr
         pCiZgDz5AmQ8q3PPzcQNE3WNmcl5au237Nhw6H6l7RtHT6wqIHhnQPaoNXxPNtPp4Ybw
         7c42AhKGC9e5LbraRC9P2b3wgVSkj6uIePlzRFeIn503KOL0Ymrt2cMplnjMBJe4Bf5S
         B9gDMtn5OfZXg2iUdLvN/BnRQv0dofRIZ9O+XJVswEJd4kaCaCtmF58LuVU6WAOphRGl
         nRgw==
X-Received: by 10.70.34.65 with SMTP id x1mr3145133pdi.165.1418133230656;
        Tue, 09 Dec 2014 05:53:50 -0800 (PST)
Received: from lanh ([115.73.216.238])
        by mx.google.com with ESMTPSA id w8sm1576129pbt.71.2014.12.09.05.53.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 05:53:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Dec 2014 20:53:47 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261124>

If we have never seen attr 'X' in any .gitattributes file we have
examined so far, we can be sure that 'X' is not defined. So no need to
go over all the attr stack to look for attr 'X'. This is the purpose
behind this new field maybe_real.

This optimization breaks down if macros are involved because we can't
know for sure what macro would expand to 'X' at attr parsing time. But
if we go the permisstic way and assume all macros are expanded, we hit
the builtin "binary" macro. At least the "diff" attr defined in this
macro will disable this optimization for git-grep. So we wait until
any attr lines _may_ reference to a macro before we turn this off.

In git.git, this reduces the number of fill_one() call for "git grep
abcdefghi" from ~5300 to 3000. The optimization stops when it reads
t/.gitattributes, which uses 'binary' macro.

"git grep" is actually a good example to justify this patch. The
command checks "diff" attribute on every file. People usually don't
define this attribute. But they pay the attr lookup penalty anyway
without this patch, proportional to the number of attr lines they have
in repo.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 4ec6186..ba41761 100644
--- a/attr.c
+++ b/attr.c
@@ -33,9 +33,11 @@ struct git_attr {
 	unsigned h;
 	int attr_nr;
 	int maybe_macro;
+	int maybe_real;
 	char name[FLEX_ARRAY];
 };
 static int git_attr_nr;
+static int cannot_trust_maybe_real;
=20
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
@@ -97,6 +99,7 @@ static struct git_attr *git_attr_internal(const char =
*name, int len)
 	a->next =3D git_attr_hash[pos];
 	a->attr_nr =3D git_attr_nr++;
 	a->maybe_macro =3D 0;
+	a->maybe_real =3D 0;
 	git_attr_hash[pos] =3D a;
=20
 	REALLOC_ARRAY(check_all_attr, git_attr_nr);
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
@@ -752,11 +759,46 @@ static void collect_all_attrs(const char *path)
 		rem =3D fill(path, pathlen, basename_offset, stk, rem);
 }
=20
+static void collect_selected_attrs(const char *path, int num,
+				   struct git_attr_check *check)
+{
+	struct attr_stack *stk;
+	int i, pathlen, rem, dirlen;
+	int basename_offset;
+
+	pathlen =3D split_path(path, &dirlen, &basename_offset);
+	prepare_attr_stack(path, dirlen);
+	if (cannot_trust_maybe_real) {
+		for (i =3D 0; i < git_attr_nr; i++)
+			check_all_attr[i].value =3D ATTR__UNKNOWN;
+	} else {
+		rem =3D num;
+		for (i =3D 0; i < num; i++) {
+			struct git_attr_check *c;
+			c =3D check_all_attr + check[i].attr->attr_nr;
+			if (check[i].attr->maybe_real)
+				c->value =3D ATTR__UNKNOWN;
+			else {
+				c->value =3D ATTR__UNSET;
+				rem--;
+			}
+		}
+		if (!rem)
+			return;
+	}
+	rem =3D git_attr_nr;
+	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
+		rem =3D fill(path, pathlen, basename_offset, stk, rem);
+}
+
 int git_check_attr(const char *path, int num, struct git_attr_check *c=
heck)
 {
 	int i;
=20
-	collect_all_attrs(path);
+	if (cannot_trust_maybe_real)
+		collect_all_attrs(path);
+	else
+		collect_selected_attrs(path, num, check);
=20
 	for (i =3D 0; i < num; i++) {
 		const char *value =3D check_all_attr[check[i].attr->attr_nr].value;
--=20
2.2.0.84.ge9c7a8a
