From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/13] test-wildmatch: avoid Windows path mangling
Date: Tue, 13 Nov 2012 17:06:09 +0700
Message-ID: <1352801169-10501-1-git-send-email-pclouds@gmail.com>
References: <7vvcdco1pf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYDNx-0003Yg-8x
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 11:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab2KMKGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 05:06:11 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51374 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2KMKGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 05:06:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4936204pad.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XQ7HkPSMYVuMaE3wXRtcAUs2MRLQm7oaG24GXCNCaSo=;
        b=dwHn/iVHo2DS/bS4RgtYGpuya/beJ7+9Th7mmOaGcOAvE8FdQMoyamBFtF9b7Gxhl2
         8BFF3RtfQ59ZCkzHwJ/bSqqpeQcIDqVl+ydiKz3Up6YQ9omiZx4nfLghAJk+wQ09rgEQ
         /mPa6WgAjWoc1Pul2imGWPPQm+SEYxzE7KJuo73ACKvrV8Lx/4ZUGD8yJSUyX1e+yrA6
         sHL3f1fxL7oJhV8Mj0LP9SGXp/bhX1c3tvkogACAE/mXaH5JOzslIL5laKjiJr/BxZG9
         i+qk3UjlcbBSQ7t3zlI01CndYDqL+JD1d48MYoPDXe/dDu23zZSZ8xmdfU2nvwoMCirL
         64FA==
Received: by 10.66.80.65 with SMTP id p1mr56765162pax.20.1352801168806;
        Tue, 13 Nov 2012 02:06:08 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id d2sm5888368paw.19.2012.11.13.02.06.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 02:06:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 Nov 2012 17:06:10 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <7vvcdco1pf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209591>

On Windows, arguments starting with a forward slash is mangled as if
it were full pathname. This causes the patterns beginning with a slash
not to be passed to test-wildmatch correctly. Avoid mangling by never
accepting patterns starting with a slash. Those arguments must be
rewritten with a leading "XXX" (e.g. "/abc" becomes "XXX/abc"), which
will be removed by test-wildmatch itself before feeding the patterns
to wildmatch() or fnmatch().

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sun, Nov 11, 2012 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > The title taken together with the above explanation makes it sound
 > as if wildmatch code does not work with the pattern /foo on Windows
 > at all and to avoid the issue (instead of fixing the breakage) this
 > patch removes such tests....

 OK how about this?

 t/t3070-wildmatch.sh | 10 +++++-----
 test-wildmatch.c     |  8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index e6ad6f4..3155eab 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -74,7 +74,7 @@ match 0 0 'foo/bar' 'foo[/]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 0 'foo' '**/foo'
-match 1 x '/foo' '**/foo'
+match 1 x 'XXX/foo' '**/foo'
 match 1 0 'bar/baz/foo' '**/foo'
 match 0 0 'bar/baz/foo' '*/foo'
 match 0 0 'foo/bar/baz' '**/bar*'
@@ -95,8 +95,8 @@ match 0 0 ']' '[!]-]'
 match 1 x 'a' '[!]-]'
 match 0 0 '' '\'
 match 0 x '\' '\'
-match 0 x '/\' '*/\'
-match 1 x '/\' '*/\\'
+match 0 x 'XXX/\' '*/\'
+match 1 x 'XXX/\' '*/\\'
 match 1 1 'foo' 'foo'
 match 1 1 '@foo' '@foo'
 match 0 0 'foo' '@foo'
@@ -187,8 +187,8 @@ match 0 0 '-' '[[-\]]'
 match 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
 match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
 match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 1 1 '/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' =
'/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 0 0 '/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' =
'/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 1 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/=
1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 0 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/=
1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
 match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n=
*t'
 match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*=
n*t'
=20
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 74c0864..e384c8e 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -3,6 +3,14 @@
=20
 int main(int argc, char **argv)
 {
+	int i;
+	for (i =3D 2; i < argc; i++) {
+		if (argv[i][0] =3D=3D '/')
+			die("Forward slash is not allowed at the beginning of the\n"
+			    "pattern because Windows does not like it. Use `XXX/' instead."=
);
+		else if (!strncmp(argv[i], "XXX/", 4))
+			argv[i] +=3D 3;
+	}
 	if (!strcmp(argv[1], "wildmatch"))
 		return !!wildmatch(argv[3], argv[2], 0);
 	else if (!strcmp(argv[1], "iwildmatch"))
--=20
1.8.0.rc2.23.g1fb49df
