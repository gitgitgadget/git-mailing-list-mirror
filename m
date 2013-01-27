From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] Reduce false positive in check-non-portable-shell.pl
Date: Sun, 27 Jan 2013 08:46:00 +0100
Message-ID: <201301270846.00842.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 08:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzMxs-0006aH-3k
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 08:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab3A0HrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 02:47:23 -0500
Received: from mout.web.de ([212.227.15.3]:63986 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121Ab3A0HrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 02:47:22 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MI63m-1U10qt0OFC-003wCF; Sun, 27 Jan 2013 08:47:21 +0100
X-Provags-ID: V02:K0:AEXVSed96hRP/o3Cmllpq0CJPYfE8AfyfBEMbuJJxRz
 I6EqNRlg4oCFCoX4It/tQgMQaHBfgx1gr+5SU5PfD/G/3ID6Zm
 ft3EBwfiBQ6d0/XZkEtSYRj4mHh+wlgvxAuxjmO6/TCGBX82qH
 0FEDNEpm84Y3MMVCKbV1GDebSF2GZsr30veqlyxf0mGCHhY4yS
 Zv37kER5zviEqY5SdTcbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214685>

check-non-portable-shell.pl is using simple regular expressions to
find illegal shell syntax.

Improve the expressions and reduce the chance for false positves:

"sed -i" must be followed by 1..n whitespace and 1 non whitespace
"declare" must be followed by 1..n whitespace and 1 non whitespace
"echo -n" must be followed by 1..n whitespace and 1 non whitespace
"which": catch lines like "if which foo"

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index 8b5a71d..d9ddcdf 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -16,10 +16,10 @@ sub err {
=20
 while (<>) {
 	chomp;
-	/^\s*sed\s+-i/ and err 'sed -i is not portable';
-	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)'=
;
-	/^\s*declare\s+/ and err 'arrays/declare not portable';
-	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
+	/^\s*sed\s+-i\s+\S/ and err 'sed -i is not portable';
+	/^\s*echo\s+-n\s+\S/ and err 'echo -n is not portable (please use pri=
ntf)';
+	/^\s*declare\s+\S/ and err 'arrays/declare not portable';
+	/^\s*if\s+which\s+\S/ and err 'which is not portable (please use type=
)';
 	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (pl=
ease use =3D)';
 	# this resets our $. for each file
 	close ARGV if eof;
--=20
1.8.1.1
