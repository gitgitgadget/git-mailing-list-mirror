From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/25] list-files: delete redundant cached entries
Date: Mon,  6 Apr 2015 20:52:27 +0700
Message-ID: <1428328354-14897-19-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7U5-0005wR-7P
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbDFNyd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:33 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35974 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbDFNyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:32 -0400
Received: by pdea3 with SMTP id a3so45259818pde.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Te3aByKTSvqbeI4S0PstCXEeNaJDuUA79FokSJXgNxg=;
        b=WGwundmSXqXL4kIL8u3yrpouwj/z6ZA3Omlc8ALbgZSyI73QQt/wWRl/kDsRGZXk9b
         EFFViv1vClT60/fXJE9LOIqLMf8K+uIHsXrjW/v0UVBj2w+GTITmghx+FGXIwoBEdaId
         6LUSfjS7SnFe58lXNLmeA9ApFUn9LwiF3XEFumulNmzCnL4goH/1+XVFfvIKzOYa6vlX
         h/sSGZoRnhLnK321Dx5YATb/oyBK3lSw44sLOjhxuvUP0zX6PlH5Ch3iohpoilxqm1Ru
         E7WgeMFXy0dY0BUgzg6U3jyDlIeivO6ZNiYYGEodOY9B8FR6gymW112G17VXFEH0aJXl
         SAng==
X-Received: by 10.66.184.48 with SMTP id er16mr27157031pac.91.1428328471939;
        Mon, 06 Apr 2015 06:54:31 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id ic7sm4767630pbc.70.2015.04.06.06.54.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266865>

When both --cached and one of -amdAMD is used together we may have two
entries of the same path, e.g. "  foo" and "MM foo". In this case it's
pretty clear that "foo" must be tracked, no need to display "   foo".
The new function does that.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 12 ++++++++++--
 t/t7013-list-files.sh | 12 ++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 14ffd62..31c2336 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -93,7 +93,10 @@ static int compare_item(const void *a_, const void *=
b_)
 {
 	const struct item *a =3D a_;
 	const struct item *b =3D b_;
-	return strcmp(a->path, b->path);
+	int ret =3D strcmp(a->path, b->path);
+	if (ret)
+		return ret;
+	return strncmp(a->tag, b->tag, 2);
 }
=20
 static void free_item(struct item *item)
@@ -132,7 +135,12 @@ static void remove_duplicates(struct item_list *li=
st)
 	for (src =3D dst =3D 1; src < list->nr; src++) {
 		if (!compare_item(list->items + dst - 1, list->items + src))
 			free_item(list->items + src);
-		else
+		else if ((list->items[dst - 1].tag[0] =3D=3D ' ' &&
+			  list->items[dst - 1].tag[1] =3D=3D ' ' &&
+			  !strcmp(list->items[src].path, list->items[dst - 1].path))) {
+			free_item(list->items + dst - 1);
+			list->items[dst - 1] =3D list->items[src];
+		} else
 			list->items[dst++] =3D list->items[src];
 	}
 	list->nr =3D dst;
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index c747453..392cce1 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -315,4 +315,16 @@ test_expect_success 'list-files --wt-modifed --mod=
ified' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'list-files -mMc' '
+	git list-files -mMc >actual &&
+	cat >expected <<-\EOF &&
+	D  a
+	AD b
+	AM c
+	   sa
+	   sc
+	EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
