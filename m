From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/7] completion: make the 'basic' test more tester-friendly
Date: Sat, 17 Nov 2012 12:05:47 +0100
Message-ID: <1353150353-29874-2-git-send-email-szeder@ira.uka.de>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 12:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgEV-00077n-DT
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2KQLG2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:28 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:56507 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2KQLG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:27 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Mcctw-1TrD6m17LM-00HiYO; Sat, 17 Nov 2012 12:06:08 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:u9//psoQwaZarU6dvnYX77VhpiE1ePwfXa8N6RGiLxA
 IwPTnf+GuGjbsFrjp6UmnsACKasrvHPd3mMceLl6+I4NJqXA4h
 ZzgiEBtVyTssxj1DzmR+/5bu4+AO2N1ZlvaHQ7UPNLckc6fxpA
 iK176IHSeu5rY1LPBbTY5rqwDgsH6y2Lnc3gjKdKyKdkDJuhMp
 do71BiQIKvbhvO0Ymgjwt0T4XjtccxJnIFuC6LRaI5YOelHtAL
 k2A4WDBDGZuIBMyMLIOk9cIJhvwufYIjpVZFxpfjp6xIPF65CG
 6RPJeZ3a/OuwBseLERt8BPzCMJCAJobV2osSPZUfSQLpKlkdyG
 eHllfD5bEW+l9fiUxcjcUxNdRvBkTggwIeR3HUu6zWe4gaf9be
 Se5zrJs0wP1BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209943>

The 'basic' test uses 'grep -q' to filter the resulting possible
completion words while looking for the presence or absence of certain
git commands, and relies on grep's exit status to indicate a failure.

This works fine as long as there are no errors.  However, in case of a
failure it doesn't give any indication whatsoever about the reason of
the failure, i.e. which condition failed.

To make testers' life easier provide some output about the failed
condition: store the results of the filtering in a file and compare
its contents to the expected results by the good old test_cmp helper.
However, to actually get output from test_cmp in case of an error we
must make sure that test_cmp is always executed.  Since in case of an
error grep's exit code aborts the test immediately, before running the
subsequent test_cmp, do the filtering using sed instead of grep.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8fa025f9..b56759f7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -158,14 +158,22 @@ test_expect_success '__gitcomp - suffix' '
 test_expect_success 'basic' '
 	run_completion "git \"\"" &&
 	# built-in
-	grep -q "^add \$" out &&
+	echo "add " >expected &&
+	sed -n "/^add \$/p" out >out2 &&
+	test_cmp expected out2 &&
 	# script
-	grep -q "^filter-branch \$" out &&
+	echo "filter-branch " >expected &&
+	sed -n "/^filter-branch \$/p" out >out2 &&
+	test_cmp expected out2 &&
 	# plumbing
-	! grep -q "^ls-files \$" out &&
+	>expected &&
+	sed -n "/^ls-files \$/p" out >out2 &&
+	test_cmp expected out2 &&
=20
 	run_completion "git f" &&
-	! grep -q -v "^f" out
+	>expected &&
+	sed -n "/^[^f]/p" out >out2 &&
+	test_cmp expected out2
 '
=20
 test_expect_success 'double dash "git" itself' '
--=20
1.8.0.220.g4d14ece
