From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/7] completion: fix args of run_completion() test helper
Date: Sat, 17 Nov 2012 12:05:48 +0100
Message-ID: <1353150353-29874-3-git-send-email-szeder@ira.uka.de>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 12:06:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgEO-00071y-T1
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab2KQLGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:21 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:60136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2KQLGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:20 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MbLRw-1Tq6e82xYi-00JBCR; Sat, 17 Nov 2012 12:06:13 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:uCV+yr4MWvtcVJL06uwlvPP30cwA81tMgEgDwoLEtMA
 jzRm11VSAPtgnPMWuWtye6azuakm7V+b0lv6TJriP9cXaIv0+W
 DU6mTt8orlQ2aQBSM9larpb2a7dxW5S1PkUPIzQs4C0VMLe7Na
 AaXtluZLh/BKMEw8ehFjd/X+ha8LdokRN8ERGIvQULz5Dj+P3t
 61I3bgTFv+yCWMv4OWKzc7z8sH8tAbjJPiWs+9+22XXteokI79
 Djf6JJLGvKummbaLBmag2Rg0u5mVGKLO/XKp181FzppwmqpPFA
 lWIxQm8nJnDsM3vHPuvZVs29sOPpReB3+p1SQAOMc1JDO2CfF/
 dF6c6oPKzD0xdbAH2x1mj7Pqr2oZj+yYUoxz9UHWtXaby7UxOL
 +62hn97TqAjow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209941>

To simulate that the user hit 'git <TAB>, the 'basic' test sets up the
rather strange command line containing the two words

  git ""

i.e. the second word on the command line consists of two double
quotes.  This is not what happens for real, however, because after
'git <TAB>' the second word on the command line is just an empty
string.  Luckily, the test works nevertheless.

=46ix this by passing the command line to run_completion() as separate
words.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b56759f7..3af75872 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -49,7 +49,7 @@ run_completion ()
 {
 	local -a COMPREPLY _words
 	local _cword
-	_words=3D( $1 )
+	_words=3D( "$@" )
 	(( _cword =3D ${#_words[@]} - 1 ))
 	__git_wrap__git_main && print_comp
 }
@@ -57,7 +57,7 @@ run_completion ()
 test_completion ()
 {
 	test $# -gt 1 && echo "$2" > expected
-	run_completion "$@" &&
+	run_completion $1 &&
 	test_cmp expected out
 }
=20
@@ -156,7 +156,7 @@ test_expect_success '__gitcomp - suffix' '
 '
=20
 test_expect_success 'basic' '
-	run_completion "git \"\"" &&
+	run_completion git "" &&
 	# built-in
 	echo "add " >expected &&
 	sed -n "/^add \$/p" out >out2 &&
@@ -170,7 +170,7 @@ test_expect_success 'basic' '
 	sed -n "/^ls-files \$/p" out >out2 &&
 	test_cmp expected out2 &&
=20
-	run_completion "git f" &&
+	run_completion git f &&
 	>expected &&
 	sed -n "/^[^f]/p" out >out2 &&
 	test_cmp expected out2
--=20
1.8.0.220.g4d14ece
