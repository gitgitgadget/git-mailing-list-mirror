From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v2 3/3] Attr: Expand macros immediately when encountered.
Date: Fri,  2 Apr 2010 21:33:41 +0200
Message-ID: <11d7b9c938dd84cfff7d12798ac402ee8a28c91b.1270236242.git.grubba@grubba.org>
References: <cover.1270236242.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxmdL-0003Hd-B4
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab0DBTeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 15:34:11 -0400
Received: from mail.roxen.com ([212.247.29.220]:45950 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab0DBTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:34:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 23BCE62817B
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 21:34:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXL9AVoq9070; Fri,  2 Apr 2010 21:34:00 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 89402628163;
	Fri,  2 Apr 2010 21:34:00 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o32JY0aT026566;
	Fri, 2 Apr 2010 21:34:00 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o32JY0xi026565;
	Fri, 2 Apr 2010 21:34:00 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270236242.git.grubba@grubba.org>
In-Reply-To: <cover.1270236242.git.grubba@grubba.org>
References: <cover.1270236242.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143843>

When using macros it is otherwise hard to know whether an
attribute set by the macro should override an already set
attribute. Consider the following .gitattributes file:

[attr]mybinary	binary -ident
*		ident
foo.bin		mybinary
bar.bin		mybinary ident

Without this patch both foo.bin and bar.bin will have
the ident attribute set, which is probably not what
the user expects. With this patch foo.bin will have an
unset ident attribute, while bar.bin will have it set.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 attr.c                |   32 ++++++++++++++++++++------------
 t/t0003-attributes.sh |    9 +++++++++
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/attr.c b/attr.c
index 968fb8b..f90bb8e 100644
--- a/attr.c
+++ b/attr.c
@@ -594,6 +594,8 @@ static int path_matches(const char *pathname, int p=
athlen,
 	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D 0;
 }
=20
+static int macroexpand_one(int attr_nr, int rem);
+
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
 	struct git_attr_check *check =3D check_all_attr;
@@ -610,6 +612,7 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
 				  attr, v);
 			*n =3D v;
 			rem--;
+			rem =3D macroexpand_one(attr->attr_nr, rem);
 		}
 	}
 	return rem;
@@ -631,19 +634,27 @@ static int fill(const char *path, int pathlen, st=
ruct attr_stack *stk, int rem)
 	return rem;
 }
=20
-static int macroexpand(struct attr_stack *stk, int rem)
+static int macroexpand_one(int attr_nr, int rem)
 {
+	struct attr_stack *stk;
+	struct match_attr *a =3D NULL;
 	int i;
-	struct git_attr_check *check =3D check_all_attr;
=20
-	for (i =3D stk->num_matches - 1; 0 < rem && 0 <=3D i; i--) {
-		struct match_attr *a =3D stk->attrs[i];
-		if (!a->is_macro)
-			continue;
-		if (check[a->u.attr->attr_nr].value !=3D ATTR__TRUE)
-			continue;
+	if (check_all_attr[attr_nr].value !=3D ATTR__TRUE)
+		return rem;
+
+	for (stk =3D attr_stack; !a && stk; stk =3D stk->prev)
+		for (i =3D stk->num_matches - 1; !a && 0 <=3D i; i--) {
+			struct match_attr *ma =3D stk->attrs[i];
+			if (!ma->is_macro)
+				continue;
+			if (ma->u.attr->attr_nr =3D=3D attr_nr)
+				a =3D ma;
+		}
+
+	if (a)
 		rem =3D fill_one("expand", a, rem);
-	}
+
 	return rem;
 }
=20
@@ -668,9 +679,6 @@ int git_checkattr(const char *path, int num, struct=
 git_attr_check *check)
 	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
 		rem =3D fill(path, pathlen, stk, rem);
=20
-	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
-		rem =3D macroexpand(stk, rem);
-
 	for (i =3D 0; i < num; i++) {
 		const char *value =3D check_all_attr[check[i].attr->attr_nr].value;
 		if (value =3D=3D ATTR__UNKNOWN)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index bd9c8de..53bd7fc 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -20,10 +20,12 @@ test_expect_success 'setup' '
=20
 	mkdir -p a/b/d a/c &&
 	(
+		echo "[attr]notest !test"
 		echo "f	test=3Df"
 		echo "a/i test=3Da/i"
 		echo "onoff test -test"
 		echo "offon -test test"
+		echo "no notest"
 	) >.gitattributes &&
 	(
 		echo "g test=3Da/g" &&
@@ -32,6 +34,7 @@ test_expect_success 'setup' '
 	(
 		echo "h test=3Da/b/h" &&
 		echo "d/* test=3Da/b/d/*"
+		echo "d/yes notest"
 	) >a/b/.gitattributes
=20
 '
@@ -48,6 +51,9 @@ test_expect_success 'attribute test' '
 	attr_check a/b/d/g "a/b/d/*"
 	attr_check onoff unset
 	attr_check offon set
+	attr_check no unspecified
+	attr_check a/b/d/no "a/b/d/*"
+	attr_check a/b/d/yes unspecified
=20
 '
=20
@@ -64,6 +70,9 @@ a/b/h: test: a/b/h
 a/b/d/g: test: a/b/d/*
 onoff: test: unset
 offon: test: set
+no: test: unspecified
+a/b/d/no: test: a/b/d/*
+a/b/d/yes: test: unspecified
 EOF
=20
 	sed -e "s/:.*//" < expect | git check-attr --stdin test > actual &&
--=20
1.7.0.3.316.g33b5e
