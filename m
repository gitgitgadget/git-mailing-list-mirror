From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] ce_path_match: drop prefix matching in favor of match_pathspec
Date: Mon, 20 Sep 2010 09:30:00 +1000
Message-ID: <1284939000-16907-6-git-send-email-pclouds@gmail.com>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 01:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTLR-0001es-TH
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab0ISXan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:30:43 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44795 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0ISXam (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:30:42 -0400
Received: by pxi10 with SMTP id 10so1011549pxi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sIh+4R54jt3RZ6Pzezmh9EtylKtdJpzg36mPlU/hstc=;
        b=murZOXlOKzkidZzUnUp6jkgD9h0bhWimSs5p2/qS3IGvwW2/io7dMgZ3FCNMQocrav
         Dj5kgwu9ci8t2UHD4R/pFQTCiTWMAv+XsvXjP/hPCI3ww3tSYF+OfAnh6E4Tf5frpXKl
         iuOl+wCaoV8CTgG9zW1fryDwXEXVOtasw9g7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rCZJTgG8BnagBVLzmDiSUfrZAI6fQ1x7darPqww894b/fVvnUs8wHRu1e4rnkRrN9g
         W7p+xNhiwa9D4igy2PuSi4ANbfYB0uzY+KmRcBfpELpcTj+kCmLPheUXmyyJaFHcOrtM
         YD4tzxlNlodxeXGEtnurF2lN7VGLsxssLraPU=
Received: by 10.114.88.15 with SMTP id l15mr8993692wab.191.1284939041793;
        Sun, 19 Sep 2010 16:30:41 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id c24sm12280387wam.7.2010.09.19.16.30.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:30:40 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:30:34 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156536>

ce_path_match() and tree_entry_interesting() are two functions that do
entry filtering when traversing trees. Now that
tree_entry_interesting() understands wildcard, ce_path_match() can
just use match_pathspec() to also understand wildcard.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c             |   25 +------------------------
 t/t4010-diff-pathspec.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 918a90c..c67d9e0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -685,30 +685,7 @@ int ce_same_name(struct cache_entry *a, struct cac=
he_entry *b)
=20
 int ce_path_match(const struct cache_entry *ce, const struct pathspec =
*pathspec)
 {
-	const char *match, *name;
-	const char **p;
-	int len;
-
-	if (!pathspec || !pathspec->nr)
-		return 1;
-
-	len =3D ce_namelen(ce);
-	name =3D ce->name;
-	p =3D pathspec->raw;
-	while ((match =3D *p++) !=3D NULL) {
-		int matchlen =3D strlen(match);
-		if (matchlen > len)
-			continue;
-		if (memcmp(name, match, matchlen))
-			continue;
-		if (matchlen && name[matchlen-1] =3D=3D '/')
-			return 1;
-		if (name[matchlen] =3D=3D '/' || !name[matchlen])
-			return 1;
-		if (!matchlen)
-			return 1;
-	}
-	return 0;
+	return match_pathspec(pathspec->raw, ce->name, ce_namelen(ce), 0, NUL=
L) > 0;
 }
=20
 /*
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 4b120f8..d50fd2d 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -55,6 +55,15 @@ test_expect_success \
     'git diff-index --cached $tree -- file0 >current &&
      compare_diff_raw current expected'
=20
+cat >expected.template <<\EOF
+:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be=
0328a19b29f18cdcb49338d516 M	path1/file1
+EOF
+test_expect_success 'diff-index with wildcard' '
+	git diff-index --cached $tree -- "*1" >current &&
+	cp expected.template expected &&
+	compare_diff_raw current expected
+'
+
 cat >expected <<\EOF
 EOF
 test_expect_success \
--=20
1.7.1.rc1.70.g788ca
