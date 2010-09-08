From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] tree_entry_interesting(): support negative pathspec
Date: Thu,  9 Sep 2010 01:50:23 +1000
Message-ID: <1283961023-4491-9-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXk7-0000fi-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab0IIDXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:23:31 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44921 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab0IIDXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:23:24 -0400
Received: by pxi10 with SMTP id 10so316667pxi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TizXThIcnaE0RTxxm+/4ddtjRFn3yP/0oaGxocCm9/8=;
        b=PlqSgxQfbQxdq12rej14A/a+7AnxtZwwoPMKmeHkEB44o+bb0ywSt/fktn1PTKtldd
         iutC2ACMUXDsch1p1Y0DDuASyBwYjU6quBGNB7g2M5fWbApMNiT+SirV6e0KxKVeaSKG
         hbgu/4yM48uwd6C/O/hIDSfOXQIVTC1GorMuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uBjazL+QKsw29DxWtnczbfJLAfCiIuCz++T2K+vcnOKQtzkuKhwpxy/CsRTHJtAU6w
         n2x8Z7SJzXAB6NWjeYKG7hX6uey4wiR9qXzJmiQiXiGFrF4enKYuh+aui+N2as4CeyCO
         tdKpohNslGuqIC9wBrUTzUgQlFX57Inhoq8DE=
Received: by 10.114.108.14 with SMTP id g14mr598815wac.185.1284002604505;
        Wed, 08 Sep 2010 20:23:24 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm1311045wad.18.2010.09.08.20.23.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:23:23 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:51:28 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155837>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t9999-test.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 tree-walk.c     |   36 +++++++++++++++++++++++++++++++-----
 2 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100755 t/t9999-test.sh

diff --git a/t/t9999-test.sh b/t/t9999-test.sh
new file mode 100755
index 0000000..535386e
--- /dev/null
+++ b/t/t9999-test.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+test_description=3Df
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir one one/two &&
+	touch file one/file one/two/file one/zoo &&
+	git add . &&
+	git commit -m 1 &&
+	for i in file one/file one/two/file one/zoo; do echo 1 >>$i;done &&
+	git add . && git commit -m 2
+'
+
+test_expect_success 'diff' '
+	cat >expected <<-\EOF &&
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/file
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/two/file
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/zoo
+EOF
+	git diff-tree -r HEAD^ HEAD -- one >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff one ^one/two' '
+	cat >expected <<-\EOF &&
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/file
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/zoo
+EOF
+	git diff-tree -r HEAD^ HEAD -- one ^one/two >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff ^one/two' '
+	cat >expected <<-\EOF &&
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	file
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/file
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5bb6=
fa28c517a0bb32b8b506539d4d M	one/zoo
+EOF
+	git diff-tree -r HEAD^ HEAD -- ^one/two >result &&
+	test_cmp expected result
+'
+
+test_done
diff --git a/tree-walk.c b/tree-walk.c
index a2f4a00..fd19681 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -532,7 +532,7 @@ int tree_entry_interesting(const struct name_entry =
*entry, const char *base, int
=20
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
-	for (i =3D 0; i < ps->nr; i++) {
+	for (i =3D ps->nr-1; i >=3D 0; i--) {
 		const char *match =3D ps->info[i].path;
 		int matchlen =3D ps->info[i].pathlen;
 		int m =3D -1; /* signals that we haven't called strncmp() */
@@ -548,8 +548,18 @@ int tree_entry_interesting(const struct name_entry=
 *entry, const char *base, int
 			 */
 			if (!matchlen ||
 			    base[matchlen] =3D=3D '/' ||
-			    match[matchlen - 1] =3D=3D '/')
-				return 2;
+			    match[matchlen - 1] =3D=3D '/') {
+				if (!ps->info[i].has_sub_pathspec &&
+				    ps->info[i].to_exclude)
+					return -1;
+				/*
+				 * If has_sub_pathspec is 1, there is
+				 * another sub pathspec that will
+				 * negate the result. Don't return "2"
+				 * in that case.
+				 */
+				return ps->info[i].has_sub_pathspec ? 1 : 2;
+			}
=20
 			/* Just a random prefix match */
 			continue;
@@ -615,8 +625,24 @@ int tree_entry_interesting(const struct name_entry=
 *entry, const char *base, int
 		 * because we rejected the case where path is not a
 		 * leading directory and is shorter than match.
 		 */
-		if (!m)
+		if (!m) {
+			/*
+			 * If this is negative pathspec, we exclude
+			 * the path only if it's a perfect
+			 * match. Otherwise assume it's in, because
+			 * there could be a positive subpathspec,
+			 * which includes some trees again.
+			 */
+			if (ps->info[i].to_exclude)
+				return matchlen =3D=3D pathlen ? 0 : 1;
 			return 1;
+		}
 	}
-	return never_interesting; /* No matches */
+
+	/*
+	 * if include_by_default is 1, all items should be included by
+	 * default, because some of them will be excluded later on by
+	 * negative pathspecs.
+	 */
+	return ps->include_by_default ? 1 : never_interesting; /* No matches =
*/
 }
--=20
1.7.1.rc1.70.g13aff
