From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v2 2/3] Attr: Allow multiple changes to an attribute on the same line.
Date: Fri,  2 Apr 2010 21:33:40 +0200
Message-ID: <def1a3522057cf3a172b60d8e41fc552e728b5af.1270236242.git.grubba@grubba.org>
References: <cover.1270236242.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxmd9-0003Cl-DD
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab0DBTeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 15:34:08 -0400
Received: from mail.roxen.com ([212.247.29.220]:48755 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab0DBTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:34:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 5C99F628181
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 21:34:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eR38JlbW-lVy; Fri,  2 Apr 2010 21:33:59 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id CC27162815D;
	Fri,  2 Apr 2010 21:33:59 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o32JXxla026562;
	Fri, 2 Apr 2010 21:33:59 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o32JXx9K026561;
	Fri, 2 Apr 2010 21:33:59 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270236242.git.grubba@grubba.org>
In-Reply-To: <cover.1270236242.git.grubba@grubba.org>
References: <cover.1270236242.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143841>

When using macros it isn't inconceivable to have an attribute
being set by a macro, and then being reset explicitly. Always
use the latest value.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 attr.c                |    2 +-
 t/t0003-attributes.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 5c6464e..968fb8b 100644
--- a/attr.c
+++ b/attr.c
@@ -599,7 +599,7 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
 	struct git_attr_check *check =3D check_all_attr;
 	int i;
=20
-	for (i =3D 0; 0 < rem && i < a->num_attr; i++) {
+	for (i =3D a->num_attr - 1; 0 < rem && 0 <=3D i; i--) {
 		struct git_attr *attr =3D a->state[i].attr;
 		const char **n =3D &(check[attr->attr_nr].value);
 		const char *v =3D a->state[i].setto;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 1c77192..bd9c8de 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -22,6 +22,8 @@ test_expect_success 'setup' '
 	(
 		echo "f	test=3Df"
 		echo "a/i test=3Da/i"
+		echo "onoff test -test"
+		echo "offon -test test"
 	) >.gitattributes &&
 	(
 		echo "g test=3Da/g" &&
@@ -44,6 +46,8 @@ test_expect_success 'attribute test' '
 	attr_check b/g unspecified &&
 	attr_check a/b/h a/b/h &&
 	attr_check a/b/d/g "a/b/d/*"
+	attr_check onoff unset
+	attr_check offon set
=20
 '
=20
@@ -58,6 +62,8 @@ a/b/g: test: a/b/g
 b/g: test: unspecified
 a/b/h: test: a/b/h
 a/b/d/g: test: a/b/d/*
+onoff: test: unset
+offon: test: set
 EOF
=20
 	sed -e "s/:.*//" < expect | git check-attr --stdin test > actual &&
--=20
1.7.0.3.316.g33b5e
