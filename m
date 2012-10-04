From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] attr: avoid searching for basename on every match
Date: Thu,  4 Oct 2012 14:39:49 +0700
Message-ID: <1349336392-1772-4-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUJ-0001w8-R5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab2JDHkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab2JDHk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so235863pad.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f6aVe93c4Mg54fD5Pi+kgmzmn9uiXnDJBbstobEFUuU=;
        b=U/9yqn5MZBXF8g/c82nN/5RWzfhVdQEQcLZZ8K7MuL6DnnKP4ImVoQ/0Ut9xbFI9To
         V25Zh6nWbXk7ENgo3ORQNEk0BVUoEDYDtv0IVZyQsx4i/rfeE1ah3iPIdQygPLl0zQjN
         4V3DuGk18ppGljcQx/QJqAtrH0FR39/YVv1BOn1DKhx1FPRFAECdhNkzkUddY5pXtbE6
         u9h3OtOPpDW99Okcr6lIlMiNzGylq+5YiSBzZbuCACxOZg/gisAsZunSzs1CxbV82OKO
         FtHOpLBx/XdtnTM/Lpz2RNdgp9sJuTq6JD2AG5H+irXJEIREM30f+dz5T6nBzYOlyq1J
         XL9Q==
Received: by 10.68.129.38 with SMTP id nt6mr19830510pbb.76.1349336428752;
        Thu, 04 Oct 2012 00:40:28 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id uu10sm3947424pbc.2.2012.10.04.00.40.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:40:16 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206972>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 66b96d9..eb576ac 100644
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
@@ -693,7 +691,8 @@ static int fill_one(const char *what, struct match_=
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
@@ -702,7 +701,7 @@ static int fill(const char *path, int pathlen, stru=
ct attr_stack *stk, int rem)
 		struct match_attr *a =3D stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen,
+		if (path_matches(path, pathlen, basename,
 				 a->pattern, base, stk->originlen))
 			rem =3D fill_one("fill", a, rem);
 	}
@@ -741,15 +740,19 @@ static void collect_all_attrs(const char *path)
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
