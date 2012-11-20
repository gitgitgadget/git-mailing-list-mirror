From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 14/13] test-wildmatch: avoid Windows path mangling
Date: Tue, 20 Nov 2012 08:02:39 +0100
Message-ID: <50AB2B0F.8090808@viscovery.net>
References: <7vvcdco1pf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4g?= =?UTF-8?B?VGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 08:03:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TahrK-0003t6-Re
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 08:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab2KTHCs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 02:02:48 -0500
Received: from so.liwest.at ([212.33.55.13]:13422 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab2KTHCr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 02:02:47 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Tahqy-000262-CD; Tue, 20 Nov 2012 08:02:40 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F01511660F;
	Tue, 20 Nov 2012 08:02:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <7vvcdco1pf.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210080>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The MSYS bash mangles arguments that begin with a forward slash
when they are passed to test-wildmatch. This causes tests to fail.
Avoid mangling by prepending "XXX", which is removed by
test-wildmatch before further processing.

[J6t: reworded commit message]

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Works well, and I'm fine with this work-around.

 -- Hannes

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
 diff --git a/test-wildmatch.c b/test-wildmatch.c
index 74c0864..e384c8e 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -3,6 +3,14 @@
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
