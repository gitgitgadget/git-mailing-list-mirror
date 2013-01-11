From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] upload-pack: fix off-by-one depth calculation in shallow clone
Date: Fri, 11 Jan 2013 10:30:05 +0700
Message-ID: <1357875005-21956-2-git-send-email-pclouds@gmail.com>
References: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
 <1357875005-21956-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 04:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtVKP-0001zo-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab3AKDaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 22:30:23 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:37822 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab3AKDaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 22:30:21 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so694789pbb.10
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 19:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=7wXUy5M0w3ELRReEq/EYDnso2T8LA97pQfAh3JRMjuM=;
        b=O3nyT6bXl0PGeNWY5NgBJCj3xozCXDTSvBcd112lIZR4boLag/0q9iER9mUEN8RW9j
         7w3Kn9jghD9CY2AZqQXq1hPi27afWF3I8r3QznAWM/zCgGuMI2XUPz+fIhmWgIuFUYsM
         NNrSUnQCr09C6V4GkFUSX9CKT2HVRp1rRUTWJZhuc29Qg7Pu1ec8Y4Daclf0pvERbBm7
         yhIUVurwjyDFYS0Ghh59UruDP0F8wiIsxGisX9ufVC4R4AH2Z0k7S7ubZHlxuwL14ZI9
         p8iRqoquUIGAz4fBsovvnDDaiwVK8FUkXyT9uYmpJEQHVrdteu8Sm+VWnaUHnbC1Yjmk
         3l1w==
X-Received: by 10.68.218.97 with SMTP id pf1mr224383403pbc.96.1357875021161;
        Thu, 10 Jan 2013 19:30:21 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id s5sm2197904pay.31.2013.01.10.19.30.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 19:30:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 10:30:34 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357875005-21956-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213169>

get_shallow_commits() is used to determine the cut points at a given
depth (i.e. the number of commits in a chain that the user likes to
get). However we count current depth up to the commit "commit" but we
do the cutting at its parents (i.e. current depth + 1). This makes
upload-pack always return one commit more than requested. This patch
fixes it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 shallow.c             |  8 +++++++-
 t/t5500-fetch-pack.sh | 25 +++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/shallow.c b/shallow.c
index a0363de..6be915f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -72,8 +72,14 @@ struct commit_list *get_shallow_commits(struct objec=
t_array *heads, int depth,
 		}
 		if (parse_commit(commit))
 			die("invalid commit");
-		commit->object.flags |=3D not_shallow_flag;
 		cur_depth++;
+		if (cur_depth >=3D depth) {
+			commit_list_insert(commit, &result);
+			commit->object.flags |=3D shallow_flag;
+			commit =3D NULL;
+			continue;
+		}
+		commit->object.flags |=3D not_shallow_flag;
 		for (p =3D commit->parents, commit =3D NULL; p; p =3D p->next) {
 			if (!p->item->util) {
 				int *pointer =3D xmalloc(sizeof(int));
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 6a6e672..58d3bdf 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -130,16 +130,25 @@ test_expect_success 'single given branch clone' '
 	test_must_fail git --git-dir=3Dbranch-a/.git rev-parse origin/B
 '
=20
+test_expect_success 'clone shallow depth 1' '
+	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0
+	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
+'
+
 test_expect_success 'clone shallow' '
 	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
=20
+test_expect_success 'clone shallow depth count' '
+	test "`git --git-dir=3Dshallow/.git rev-list --count HEAD`" =3D 2
+'
+
 test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^in-pack: 18" count.shallow
+	grep "^in-pack: 12" count.shallow
 '
=20
 test_expect_success 'clone shallow object count (part 2)' '
@@ -256,12 +265,16 @@ test_expect_success 'additional simple shallow de=
epenings' '
 	)
 '
=20
+test_expect_success 'clone shallow depth count' '
+	test "`git --git-dir=3Dshallow/.git rev-list --count HEAD`" =3D 11
+'
+
 test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 52" count.shallow
+	grep "^count: 55" count.shallow
 '
=20
 test_expect_success 'fetch --depth --no-shallow' '
@@ -289,7 +302,7 @@ test_expect_success 'clone shallow object count' '
 		cd shallow2 &&
 		git count-objects -v
 	) > count.shallow2 &&
-	grep "^in-pack: 6" count.shallow2
+	grep "^in-pack: 3" count.shallow2
 '
=20
 test_expect_success 'clone shallow with --branch' '
@@ -297,7 +310,7 @@ test_expect_success 'clone shallow with --branch' '
 '
=20
 test_expect_success 'clone shallow object count' '
-	echo "in-pack: 6" > count3.expected &&
+	echo "in-pack: 3" > count3.expected &&
 	GIT_DIR=3Dshallow3/.git git count-objects -v |
 		grep "^in-pack" > count3.actual &&
 	test_cmp count3.expected count3.actual
@@ -326,7 +339,7 @@ EOF
 	GIT_DIR=3Dshallow6/.git git tag -l >taglist.actual &&
 	test_cmp taglist.expected taglist.actual &&
=20
-	echo "in-pack: 7" > count6.expected &&
+	echo "in-pack: 4" > count6.expected &&
 	GIT_DIR=3Dshallow6/.git git count-objects -v |
 		grep "^in-pack" > count6.actual &&
 	test_cmp count6.expected count6.actual
@@ -341,7 +354,7 @@ EOF
 	GIT_DIR=3Dshallow7/.git git tag -l >taglist.actual &&
 	test_cmp taglist.expected taglist.actual &&
=20
-	echo "in-pack: 7" > count7.expected &&
+	echo "in-pack: 4" > count7.expected &&
 	GIT_DIR=3Dshallow7/.git git count-objects -v |
 		grep "^in-pack" > count7.actual &&
 	test_cmp count7.expected count7.actual
--=20
1.8.0.rc2.23.g1fb49df
