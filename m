From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Teach ignore machinery about pattern "/"
Date: Fri, 25 May 2012 19:47:36 +0700
Message-ID: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 14:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXtzi-0000kS-3X
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 14:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab2EYMvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 08:51:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57898 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2EYMvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 08:51:44 -0400
Received: by pbbrp8 with SMTP id rp8so1728381pbb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rqruody3CLGs0cj1P+TKKEFl5fB9n/Yji8Yvly9a3W0=;
        b=XfmJG2YQgutYB/rVvBRaCuTmBIYKER1jqo6RLbpgh+FLdZJAaGqm0FofMIREk5paG/
         3n+FVYxNScSkb3m/qUuvAQbhdlmgolrmDMteg2USAebXDdYRpZZeGA27O3cnUYwYAxTv
         LiT3qtqhTA1saznJkjyJI75ANpi27WuTHye0XdExvTyNoxAjkElDlNU72cII528l+EPs
         A81LEtyKOZeAbuTFDfPkD3PqHgxwg58wXWD6oEFwpuoaGzAXe7kC6i6Anjlx2h6lHg+R
         NOuxeKYS/muDFPLDwUFx+WIwwGaHyKlzF7UbGDHoi+aL1CrMIZO2i2Cod8d+NO3o6bi7
         XjZg==
Received: by 10.68.213.104 with SMTP id nr8mr32550593pbc.26.1337950303990;
        Fri, 25 May 2012 05:51:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.39.86])
        by mx.google.com with ESMTPS id pb4sm8969507pbc.55.2012.05.25.05.51.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 05:51:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 25 May 2012 19:47:37 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198475>

Pattern "/" is ambiguous because the slash can mean "anchor the
pattern to this location" (e.g. /path), but it can also mean
"match directories only" (e.g. path/). Currently git interprets it as
the latter except that 'path' is an empty string, which makes this
pattern totally useless.

On the other hand, it's intuitive to read '/' as "match root
directory", or equivalent to "/*". (The other way to see it is "match
all directories", which leads to the same result).

One may wonder why bother an "ignore all" pattern. The pattern is
useful when you want to keep just a small portion of the working
directory. But that's still a rare case.

A more popular case would be sparse checkout, where ignore rules are
used to _include_. The thus now "include all" pattern is used to say
"make a sparse checkout that includes everything except this and
this".

Recognize this special pattern and turn it the working equivalence
pattern "/*"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                              | 3 +++
 t/t3001-ls-files-others-exclude.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/dir.c b/dir.c
index c6a98cc..b65d37c 100644
--- a/dir.c
+++ b/dir.c
@@ -308,6 +308,9 @@ void add_exclude(const char *string, const char *ba=
se,
 	int to_exclude =3D 1;
 	int flags =3D 0;
=20
+	if (string[0] =3D=3D '/' && string[1] =3D=3D '\0')
+		string =3D "/*";
+
 	if (*string =3D=3D '!') {
 		to_exclude =3D 0;
 		string++;
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index c8fe978..7cb790d 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -175,6 +175,12 @@ test_expect_success 'negated exclude matches can o=
verride previous ones' '
 	grep "^a.1" output
 '
=20
+test_expect_success '"/" pattern is equivalent to "/*" (exclude all)' =
'
+	git ls-files --others --exclude=3D/ >output &&
+	: >expected &&
+	test_cmp expected output
+'
+
 test_expect_success 'subdirectory ignore (setup)' '
 	mkdir -p top/l1/l2 &&
 	(
--=20
1.7.10.2.549.g9354186
