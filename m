From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 12:09:32 +0200
Message-ID: <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:10:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THXWQ-0005Vq-8O
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 12:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419Ab2I1KKD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 06:10:03 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:56821 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab2I1KKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 06:10:00 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MK1R7-1TG9wH2XZN-0020Jr; Fri, 28 Sep 2012 12:09:57 +0200
X-Mailer: git-send-email 1.7.12.1.438.g7dfa67b
In-Reply-To: <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:/fFsAjLrYsc3EXapuLDAR7ic+Pzkxqvf2fvZp8E1LDp
 Lb7dOjiexdTJ9kwvA3CnbSRvRWq0Honj171qqWn4RtL0SglZFa
 NVgcLVzOns0gpUUx9SkfXzt/+mMkyiVlOOE8/lVnAJG4A24LN/
 EHhuQT6K1Ah9i0YQhkQfR7rMx2GqExK9LJU9AGW+75IxwkoP8u
 E5WVE3PdfmWy16Sk95YO08+T6DGh7M5g3I8kuLAsAYM+ZSqepx
 JBTY7wPKS3tb6t40rk8RBL8k/o+ubi00BpT+9Icudjf9dpxgZc
 Z+GUL5d30DvwmtBV7OX0yV8dqSRsKGm6THEimensEYaTvc5bkI
 6AdNLfDxzq94vJiuQGJTaDL2B5hOBprUhdqW16wiJP6KtDl2lY
 PWjWMRK3lTQYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206550>

To simulate the the user hit 'git <TAB>, one of the completion tests
sets up the rather strange command line

  git ""

i.e. the second word on the command line consists of two double
quotes.  However, this is not what happens for real, because after
'git <TAB>' the second word on the command line is just an empty
string.  Luckily, the test works nevertheless.

=46ix this by passing the command line to run_completion() as separate
words.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e7657537..f5e68834 100755
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
@@ -147,7 +147,7 @@ test_expect_success '__gitcomp - suffix' '
 '
=20
 test_expect_success 'basic' '
-	run_completion "git \"\"" &&
+	run_completion git "" &&
 	# built-in
 	grep -q "^add \$" out &&
 	# script
@@ -155,7 +155,7 @@ test_expect_success 'basic' '
 	# plumbing
 	! grep -q "^ls-files \$" out &&
=20
-	run_completion "git f" &&
+	run_completion git f &&
 	! grep -q -v "^f" out
 '
=20
--=20
1.7.12.1.438.g7dfa67b
