From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/7] completion: add tests for the __gitcomp_nl() completion
 helper function
Date: Sat, 17 Nov 2012 12:05:49 +0100
Message-ID: <1353150353-29874-4-git-send-email-szeder@ira.uka.de>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 12:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgEP-00071y-Bo
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2KQLGX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:23 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:50313 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2KQLGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:21 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LcrNk-1Srmkm1Ubw-00idOn; Sat, 17 Nov 2012 12:06:20 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:4E9ZRPoJDEo+J8qHSsc0PPWwNGMMMpG4qM6TJ9eVCYP
 CWqvIow2ewamx4sGN3hbxZLX2GydcwuoO4eaYz/ppZrAac1IuM
 BwglhBVQBCMVDAD1gSnuTBcMAf4cPcwPHZauZD6fJbE3UBze2X
 u/Elvhj9XIInZNpwHkxQb5jSdGD2g2bTGAG+uLW4S1js5WD+3m
 wVEXSPxGGuH/ssgIH4zgicPv4yyoMe3ij0mV0TyJJO2RjAP1gC
 bf/8g8K1kURx/0iT196azpiE38OrfRHDas+5Y0P6mJrSF/DzIy
 sPm89/5UvMtfAXlbtEpxYCgoMxNxREYUWSI55NqnEPmGCYwEJF
 MRinyl90JcRfYmRTpJ7TTqyvHGqxe08PmH+lEla75oON78S/w5
 SDCcvvs3Z72xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209942>

Test __gitcomp_nl()'s basic functionality, i.e. that trailing space,
prefix, and suffix are added correctly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 84 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3af75872..32b3e8c4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -155,6 +155,90 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
=20
+test_expect_success '__gitcomp_nl - trailing space' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	maint Z
+	master Z
+	EOF
+	(
+		declare -a COMPREPLY &&
+		refs=3D"$(cat <<-\EOF
+			maint
+			master
+			next
+			pu
+			EOF
+		)" &&
+		cur=3D"m" &&
+		__gitcomp_nl "$refs" &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp_nl - prefix' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	--fixup=3Dmaint Z
+	--fixup=3Dmaster Z
+	EOF
+	(
+		declare -a COMPREPLY &&
+		refs=3D"$(cat <<-\EOF
+			maint
+			master
+			next
+			pu
+			EOF
+		)" &&
+		cur=3D"--fixup=3Dm" &&
+		__gitcomp_nl "$refs" "--fixup=3D" "m" &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp_nl - suffix' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	branch.maint.Z
+	branch.master.Z
+	EOF
+	(
+		declare -a COMPREPLY &&
+		refs=3D"$(cat <<-\EOF
+			maint
+			master
+			next
+			pu
+			EOF
+		)" &&
+		cur=3D"branch.ma" &&
+		__gitcomp_nl "$refs" "branch." "ma" "." &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp_nl - no suffix' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	maintZ
+	masterZ
+	EOF
+	(
+		declare -a COMPREPLY &&
+		refs=3D"$(cat <<-\EOF
+			maint
+			master
+			next
+			pu
+			EOF
+		)" &&
+		cur=3D"ma" &&
+		__gitcomp_nl "$refs" "" "ma" "" &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'basic' '
 	run_completion git "" &&
 	# built-in
--=20
1.8.0.220.g4d14ece
