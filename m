From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/5] completion: add tests for the __gitcomp_nl() completion
 helper function
Date: Fri, 28 Sep 2012 12:09:33 +0200
Message-ID: <1348826975-2225-3-git-send-email-szeder@ira.uka.de>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THXWk-0005iT-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 12:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408Ab2I1KKB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 06:10:01 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52623 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab2I1KKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 06:10:00 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Mb9Rr-1T2Lsr2QGJ-00KexD; Fri, 28 Sep 2012 12:09:59 +0200
X-Mailer: git-send-email 1.7.12.1.438.g7dfa67b
In-Reply-To: <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:s30G6ZB46Kxtw9mu0iU9eR/klAXc+617MSfv3cAwOuF
 sGJwy0QBiuzOzBFskn8bOrBZZ0tIrLpXouyneGMpwAPMdLP/ar
 e+Oy8/kM26V9e5aSy6vAjB2RazPIkAIytI7+3qdX/L+Bxytqhs
 eVeVQtXVVKYa5EXnSulFf00zLvMSm1CWEnWcX641EXTadLr/Do
 sKTGuXG6ID0NLvPUGX4QSNlfi7aVJ7VdTMAm520S0Mk9QXmDP5
 koiM8JIT7GiZTiJRNvB2LLnW5C/nK+hSeHrOmCy+sKMryNW8tR
 8tCnSATy/EEyLfu0CkjPrCt5u1mncokz4PBO0Qh0gLZjceV0Tn
 ftWWfd2GVHrTzWFXmzKQ88tMjkp/mOuTFSHVnNHfgpuDcbFgHf
 3AxwyJQByglUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206553>

Test __gitcomp_nl()'s basic functionality, i.e. that trailing space,
prefix, and suffix are added correctly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 47 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f5e68834..01f33220 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -146,6 +146,53 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
=20
+test_expect_success '__gitcomp_nl - trailing space' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	maint Z
+	master Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"m" &&
+		__gitcomp_nl "maint${newline}master${newline}pu" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
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
+		local -a COMPREPLY &&
+		cur=3D"--fixup=3Dm" &&
+		__gitcomp_nl "maint${newline}master${newline}next${newline}pu"\
+				"--fixup=3D" "m" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp_nl - suffix' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	branch.master.Z
+	branch.maint.Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"branch.ma" &&
+		__gitcomp_nl "master${newline}maint${newline}next${newline}pu"\
+				"branch." "ma" "." &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'basic' '
 	run_completion git "" &&
 	# built-in
--=20
1.7.12.1.438.g7dfa67b
