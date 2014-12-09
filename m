From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 3/4] attr: do not attempt to expand when we know it's not a macro
Date: Tue,  9 Dec 2014 20:53:24 +0700
Message-ID: <1418133205-18213-4-git-send-email-pclouds@gmail.com>
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
	id 1XyLEw-0001sZ-6c
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 14:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177AbaLINxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 08:53:47 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59824 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173AbaLINxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 08:53:46 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so596708pab.18
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nEJvRfmqMb43Y+KZoR39yrjqXYu1L4Pm20I/ndHlK78=;
        b=fUytcosM7MmXGMuaYI16iLjeTNRCqGSQTbRE5Q0zHtNil2hEnzZ28D6UPwahJI5dDN
         hY4cBGbsa3YV5Y086z1O97IHSLJHeUz9AxnIi9byRNxxCS+HKMrAwW8134arXQ/bgoFA
         szo5hSml5BLG384Nos4AncRwvvqPioeocbEOMDO4xLKq7yyLrH3frneL9Yk4dET0AfMu
         gWRPwNd4pYBO0OvfasKuCfLRTzkS7P/a/n1LXaQJyn+PznDPdU9yhaWnH1u5W8dmz1Rs
         v0UXNHqxhHSux/ILUiIin48nzfpxxvFgw5lvxz45d1BGurVAgtCSF4YYtcUSo3ts18ec
         IFRQ==
X-Received: by 10.66.102.41 with SMTP id fl9mr5588137pab.7.1418133225689;
        Tue, 09 Dec 2014 05:53:45 -0800 (PST)
Received: from lanh ([115.73.216.238])
        by mx.google.com with ESMTPSA id ug6sm1645364pab.7.2014.12.09.05.53.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 05:53:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Dec 2014 20:53:42 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261125>

Keep track of all recognized macros in the new "maybe_macro" field.
This this field is true, it _may_ be a macro (depending on what's in
the current attr stack). But if the field is false, it's definitely
not a macro, no need to go through the whole attr stack in
macroexpand_one() to search for one.

Without this, "git grep abcdefghi" on git.git hits the inner loop in
macroexpand_one() about 2500 times. With this, it's about 60 times.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index def09c7..4ec6186 100644
--- a/attr.c
+++ b/attr.c
@@ -32,6 +32,7 @@ struct git_attr {
 	struct git_attr *next;
 	unsigned h;
 	int attr_nr;
+	int maybe_macro;
 	char name[FLEX_ARRAY];
 };
 static int git_attr_nr;
@@ -95,6 +96,7 @@ static struct git_attr *git_attr_internal(const char =
*name, int len)
 	a->h =3D hval;
 	a->next =3D git_attr_hash[pos];
 	a->attr_nr =3D git_attr_nr++;
+	a->maybe_macro =3D 0;
 	git_attr_hash[pos] =3D a;
=20
 	REALLOC_ARRAY(check_all_attr, git_attr_nr);
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
@@ -687,7 +690,8 @@ static int macroexpand_one(int attr_nr, int rem)
 	struct match_attr *a =3D NULL;
 	int i;
=20
-	if (check_all_attr[attr_nr].value !=3D ATTR__TRUE)
+	if (check_all_attr[attr_nr].value !=3D ATTR__TRUE ||
+	    !check_all_attr[attr_nr].attr->maybe_macro)
 		return rem;
=20
 	for (stk =3D attr_stack; !a && stk; stk =3D stk->prev)
--=20
2.2.0.84.ge9c7a8a
