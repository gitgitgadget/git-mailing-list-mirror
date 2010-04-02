From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 2/2] Attr: Allow macros to override earlier attributes.
Date: Fri,  2 Apr 2010 15:53:48 +0200
Message-ID: <f02815e3761a8050aa76f46cd19288e72da14206.1270216006.git.grubba@grubba.org>
References: <ca1f7f974d72a036dd8369309d487bbd047a8e2d.1270216006.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 15:54:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxhK9-0005Uk-GF
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 15:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab0DBNyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 09:54:03 -0400
Received: from mail.roxen.com ([212.247.29.220]:33030 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895Ab0DBNx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 09:53:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 4215F628165
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 15:53:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QI2F1vbwvV5; Fri,  2 Apr 2010 15:53:57 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 1A0DD62813E;
	Fri,  2 Apr 2010 15:53:57 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o32DrvW0026394;
	Fri, 2 Apr 2010 15:53:57 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o32DruOM026393;
	Fri, 2 Apr 2010 15:53:56 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <ca1f7f974d72a036dd8369309d487bbd047a8e2d.1270216006.git.grubba@grubba.org>
In-Reply-To: <ca1f7f974d72a036dd8369309d487bbd047a8e2d.1270216006.git.grubba@grubba.org>
References: <ca1f7f974d72a036dd8369309d487bbd047a8e2d.1270216006.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143815>

Macros need to be able to override earlier attribute values.
Consider a .gitattributes file with the following content:

[attr]mybinary	binary -ident
*		ident
foo.bin		mybinary

Without this patch foo.bin will still have the ident attribute set.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 attr.c                |    8 ++++----
 t/t0003-attributes.sh |    6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 5c6464e..4d7ff02 100644
--- a/attr.c
+++ b/attr.c
@@ -594,7 +594,7 @@ static int path_matches(const char *pathname, int p=
athlen,
 	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D 0;
 }
=20
-static int fill_one(const char *what, struct match_attr *a, int rem)
+static int fill_one(const char *what, struct match_attr *a, int rem, i=
nt force)
 {
 	struct git_attr_check *check =3D check_all_attr;
 	int i;
@@ -604,7 +604,7 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
 		const char **n =3D &(check[attr->attr_nr].value);
 		const char *v =3D a->state[i].setto;
=20
-		if (*n =3D=3D ATTR__UNKNOWN) {
+		if (force || *n =3D=3D ATTR__UNKNOWN) {
 			debug_set(what,
 				  a->is_macro?a->u.attr->name:a->u.pattern,
 				  attr, v);
@@ -626,7 +626,7 @@ static int fill(const char *path, int pathlen, stru=
ct attr_stack *stk, int rem)
 			continue;
 		if (path_matches(path, pathlen,
 				 a->u.pattern, base, strlen(base)))
-			rem =3D fill_one("fill", a, rem);
+			rem =3D fill_one("fill", a, rem, 0);
 	}
 	return rem;
 }
@@ -642,7 +642,7 @@ static int macroexpand(struct attr_stack *stk, int =
rem)
 			continue;
 		if (check[a->u.attr->attr_nr].value !=3D ATTR__TRUE)
 			continue;
-		rem =3D fill_one("expand", a, rem);
+		rem =3D fill_one("expand", a, rem, 1);
 	}
 	return rem;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 1c77192..f8bc43b 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -20,8 +20,10 @@ test_expect_success 'setup' '
=20
 	mkdir -p a/b/d a/c &&
 	(
+		echo "[attr]notest !test"
 		echo "f	test=3Df"
 		echo "a/i test=3Da/i"
+		echo "no notest"
 	) >.gitattributes &&
 	(
 		echo "g test=3Da/g" &&
@@ -44,6 +46,8 @@ test_expect_success 'attribute test' '
 	attr_check b/g unspecified &&
 	attr_check a/b/h a/b/h &&
 	attr_check a/b/d/g "a/b/d/*"
+	attr_check no unspecified
+	attr_check a/b/d/no unspecified
=20
 '
=20
@@ -58,6 +62,8 @@ a/b/g: test: a/b/g
 b/g: test: unspecified
 a/b/h: test: a/b/h
 a/b/d/g: test: a/b/d/*
+no: test: unspecified
+a/b/d/no: test: unspecified
 EOF
=20
 	sed -e "s/:.*//" < expect | git check-attr --stdin test > actual &&
--=20
1.7.0.3.316.g33b5e
