From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] attr: do not attempt to expand when we know it's not a macro
Date: Sun, 28 Dec 2014 06:39:47 +0700
Message-ID: <1419723588-13236-3-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
 <1419723588-13236-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 00:29:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y50nT-00027O-3k
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 00:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbaL0X3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2014 18:29:20 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:32875 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbaL0X3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 18:29:19 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so14977372pdi.3
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 15:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Xz8TJmrmcWcfL0iuakttlne+ueKIFaS0KVMsalw+AaI=;
        b=bLxoGgis8onn87VOWW5qCb5BELJMb0QymgHa8joneqVSgAvqfkGu8gIb3PD+dG1f2I
         duWR5Y5kI4seTzmysASYlb2wjwy5flZtID7YwSXYbZAfI0BymAdYnMjWg6ouG8TzNFhH
         Dj+biUfOd3E9peRqq+TZN71Tifv8CIwIDMquURWvZ+ojXBpRcu3h9MhA+ZNRNlACuilK
         A7M6TiUTgan9s2epn8s0rY6fY4Tqrjnwrk/ktiMvwKUqOTkLBcD7iU8s5UKpNJXNuKV1
         bFsLcuPx0liHUqjrVUDi2t6lKyNF/CDHTwTffLfVVWpORu/OnOBMarcmlD8FIh6/11Pi
         4TCQ==
X-Received: by 10.68.195.233 with SMTP id ih9mr51212710pbc.92.1419722958801;
        Sat, 27 Dec 2014 15:29:18 -0800 (PST)
Received: from lanh ([115.73.209.146])
        by mx.google.com with ESMTPSA id ug6sm31917718pab.7.2014.12.27.15.29.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 15:29:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Dec 2014 06:40:12 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1419723588-13236-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261844>

Keep track of all recognized macros in the new "maybe_macro" field.
If this field is true, it _may_ be a macro (depending on what's in the
current attr stack). But if the field is false, it's definitely not a
macro, no need to go through the whole attr stack in macroexpand_one()
to search for one.

Without this, "git grep abcdefghi" on git.git hits the inner loop in
macroexpand_one() 2481 times. With this, it's 66 times.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index a1758bf..b80e52b 100644
--- a/attr.c
+++ b/attr.c
@@ -32,6 +32,7 @@ struct git_attr {
 	struct git_attr *next;
 	unsigned h;
 	int attr_nr;
+	int maybe_macro;
 	char name[FLEX_ARRAY];
 };
 static int attr_nr;
@@ -95,6 +96,7 @@ static struct git_attr *git_attr_internal(const char =
*name, int len)
 	a->h =3D hval;
 	a->next =3D git_attr_hash[pos];
 	a->attr_nr =3D attr_nr++;
+	a->maybe_macro =3D 0;
 	git_attr_hash[pos] =3D a;
=20
 	REALLOC_ARRAY(check_all_attr, attr_nr);
@@ -244,9 +246,10 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 		      sizeof(*res) +
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
-	if (is_macro)
+	if (is_macro) {
 		res->u.attr =3D git_attr_internal(name, namelen);
-	else {
+		res->u.attr->maybe_macro =3D 1;
+	} else {
 		char *p =3D (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
 		res->u.pat.pattern =3D p;
@@ -687,7 +690,8 @@ static int macroexpand_one(int nr, int rem)
 	struct match_attr *a =3D NULL;
 	int i;
=20
-	if (check_all_attr[nr].value !=3D ATTR__TRUE)
+	if (check_all_attr[nr].value !=3D ATTR__TRUE ||
+	    !check_all_attr[nr].attr->maybe_macro)
 		return rem;
=20
 	for (stk =3D attr_stack; !a && stk; stk =3D stk->prev)
--=20
2.2.0.84.ge9c7a8a
