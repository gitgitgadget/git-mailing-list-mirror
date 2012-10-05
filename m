From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/10] attr: avoid searching for basename on every match
Date: Fri,  5 Oct 2012 11:41:02 +0700
Message-ID: <1349412069-627-4-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2WZ-0004MJ-3p
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab2JEHkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:40:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52522 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab2JEHkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:40:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1405531pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=y7j5VbcmxjbtlpjHIvOr7XYP08UdnJJqT6WpBLk+cVo=;
        b=Vig4pTapyQJZkDTyo4L7KtABoWImGkA+9GhaTbDdmgDg9Bn4kGQJ56cIOSH0fJIFim
         2h5kCoCdqOWTowCXCKzDnQtdGvNc+wSOnY5E+bWT538jOz2gsUqoZ1EH6I5O1VOadDZ/
         CU5J7d2CIcN1j1Rv8OLDnxWFWxMMBamNxS57O7LswJAypq7I27J9B23G/yXpA3agnY5P
         MOojysGQSDUe60ZdWaEdbHRgZ7zqVZzSVRDtj1dv5l5ZJpKs19wiDeqPBdHafGO5qlGn
         05J7hZjR+ywaLK5L27nroYOQ4aRlBVrGBVjFh8iN7i6V1MbkXGm8LdSmZj3kGnksfJec
         59Ig==
Received: by 10.68.226.38 with SMTP id rp6mr27880528pbc.116.1349412079337;
        Thu, 04 Oct 2012 21:41:19 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id b10sm5374539pav.17.2012.10.04.21.41.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:18 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:27 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207090>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 2942bf6..aeac564 100644
--- a/attr.c
+++ b/attr.c
@@ -644,13 +644,11 @@ static void prepare_attr_stack(const char *path)
 }
=20
 static int path_matches(const char *pathname, int pathlen,
+			const char *basename,
 			const char *pattern,
 			const char *base, int baselen)
 {
 	if (!strchr(pattern, '/')) {
-		/* match basename */
-		const char *basename =3D strrchr(pathname, '/');
-		basename =3D basename ? basename + 1 : pathname;
 		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
 	}
 	/*
@@ -692,7 +690,8 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
 	return rem;
 }
=20
-static int fill(const char *path, int pathlen, struct attr_stack *stk,=
 int rem)
+static int fill(const char *path, int pathlen, const char *basename,
+		struct attr_stack *stk, int rem)
 {
 	int i;
 	const char *base =3D stk->origin ? stk->origin : "";
@@ -701,7 +700,7 @@ static int fill(const char *path, int pathlen, stru=
ct attr_stack *stk, int rem)
 		struct match_attr *a =3D stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen,
+		if (path_matches(path, pathlen, basename,
 				 a->u.pattern, base, stk->originlen))
 			rem =3D fill_one("fill", a, rem);
 	}
@@ -740,15 +739,19 @@ static void collect_all_attrs(const char *path)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem;
+	const char *basename;
=20
 	prepare_attr_stack(path);
 	for (i =3D 0; i < attr_nr; i++)
 		check_all_attr[i].value =3D ATTR__UNKNOWN;
=20
+	basename =3D strrchr(path, '/');
+	basename =3D basename ? basename + 1 : path;
+
 	pathlen =3D strlen(path);
 	rem =3D attr_nr;
 	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
-		rem =3D fill(path, pathlen, stk, rem);
+		rem =3D fill(path, pathlen, basename, stk, rem);
 }
=20
 int git_check_attr(const char *path, int num, struct git_attr_check *c=
heck)
--=20
1.7.12.1.405.gb727dc9
