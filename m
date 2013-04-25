From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] test-lint-shell-syntax: Allow bash syntax in bash tests
Date: Thu, 25 Apr 2013 20:48:33 +0200
Message-ID: <201304252048.33803.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 20:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRDq-000848-MX
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759447Ab3DYSsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 14:48:40 -0400
Received: from mout.web.de ([212.227.17.11]:51140 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758669Ab3DYSsi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 14:48:38 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lh6PP-1Ustso1jrr-00nmoY for <git@vger.kernel.org>; Thu,
 25 Apr 2013 20:48:37 +0200
X-Provags-ID: V02:K0:9ND1NTYvo+wiHbWC4/v/Y9n8gtpY/0S8CN4xGgjEWWT
 cUbtaBpyC7om5D1SkW9T+eks+umWfavNwCeqxgnrbuzwv948un
 gDV6xvJ9+I13HBFsXrBHtn/CJpLWXLoL3nbwqNTu/UtVBJWcwV
 fhFK0MxMCvH11PRomlvHjuPnmlI/sxHfA8f6GGFa/g2Wy0jGTG
 OoUip036AwDqCuSYPo1jQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222411>

t/check-non-portable-sh.pl checks for bash only syntax like test $a =3D=
=3D $b
This is wrong when bash is used.
Switch to bash mode and skip this test

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index 58f8e2c..1ca8c8b 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -7,23 +7,26 @@ use strict;
 use warnings;
=20
 my $exit_code=3D0;
+my $bashmode=3D0;
=20
 sub err {
 	my $msg =3D shift;
-	print "$ARGV:$.: error: $msg: $_\n";
+	print "$ARGV:$.: error: (bashmode=3D$bashmode) $msg: $_\n";
 	$exit_code =3D 1;
 }
=20
 while (<>) {
 	chomp;
+	/^\. \.\/lib\-bash.sh/ and $bashmode=3D1;
 	/ e?grep\s+\"[^"]*\\([st])/ and err "grep \\$1 is not portable)";
 	/ [^e]grep.*\\\+/ and err 'grep with \+ is not portable (please use e=
grep)';
 	/^\s*sed\s+-i/ and err 'sed -i is not portable';
 	/^\s*echo\s+-(\S)\s+/ and err "echo -$1 is not portable (please use p=
rintf)";
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
-	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (pl=
ease use =3D)';
+	$bashmode=3D=3D0 and /test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b=
" is not portable (please use =3D)';
 	# this resets our $. for each file
 	close ARGV if eof;
+	$bashmode=3D0 if eof;
 }
 exit $exit_code;
--=20
1.8.2.1.614.g66d7af5
