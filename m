From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] tests: add tests for the __gitcomp() completion helper
	function
Date: Tue, 17 Apr 2012 12:27:15 +0200
Message-ID: <1334658435-30769-1-git-send-email-szeder@ira.uka.de>
References: <20120417102215.GA22778@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 12:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK5db-0004cr-38
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 12:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2DQK1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 06:27:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:49376 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2DQK1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 06:27:48 -0400
Received: from localhost6.localdomain6 (p5B1306D0.dip0.t-ipconnect.de [91.19.6.208])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MR6aY-1Shi812uZa-00UNn2; Tue, 17 Apr 2012 12:27:20 +0200
X-Mailer: git-send-email 1.7.10.216.gb52c0
In-Reply-To: <20120417102215.GA22778@goldbirke>
X-Provags-ID: V02:K0:rjKnTJCF3TsRFqiE3FwDCo9kd2Hoyg+Ecdau7TRawtz
 8bNw4sv7L3WLNNc065HcjD57iDsbZd/GJtsigC5xdDA+qTneHH
 MyfJT3YYyX/EaQB6zr/SOz/TGQcKptVgXai23t50jdJ0UZOUhg
 B1k/zQT0I/vfx2LOP5N91m+y16a1UOoeaDVGn596xFCBXrh7VC
 U7iP7S4lI0lRqJw3LNARXKBgxg+GyMVb1wYRnA8Ii2RKP29q1H
 mL0QJQ4RRMXF4k2K6LtdpiffKi3stKiZG/Gdc0KYPfqnvMmoxA
 GAhD8Z6aW7MN31hyD5P7QC/5CV4DlKyOiIevLpORBCemcLjvA3
 YK3K2V5cDmf4TvUUNsQeJ6NLJJVDSsGbEHDfksB7JrqIcsOvbl
 BttdQ16feNTmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195750>

These tests check that trailing space, prefix, and suffix are added
correctly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh |   85 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 85 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cc127320..5bda6b6e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -73,6 +73,91 @@ test_completion ()
 	test_cmp expected out
 }
=20
+newline=3D$'\n'
+
+test_expect_success '__gitcomp - trailing space - options' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	--reuse-message=3DZ
+	--reedit-message=3DZ
+	--reset-author Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"--re" &&
+		__gitcomp "--dry-run --reuse-message=3D --reedit-message=3D
+				--reset-author" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp - trailing space - config keys' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	branch.Z
+	branch.autosetupmerge Z
+	branch.autosetuprebase Z
+	browser.Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"br" &&
+		__gitcomp "branch. branch.autosetupmerge
+				branch.autosetuprebase browser." &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp - option parameter' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	recursive Z
+	resolve Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"--strategy=3Dre" &&
+		__gitcomp "octopus ours recursive resolve subtree
+			" "" "re" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp - prefix' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	branch.maint.merge Z
+	branch.maint.mergeoptions Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"branch.me" &&
+		__gitcomp "remote merge mergeoptions rebase
+			" "branch.maint." "me" &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__gitcomp - suffix' '
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	branch.master.Z
+	branch.maint.Z
+	EOF
+	(
+		local -a COMPREPLY &&
+		cur=3D"branch.me" &&
+		__gitcomp "master maint next pu
+			" "branch." "ma" "." &&
+		IFS=3D"$newline" &&
+		echo "${COMPREPLY[*]}" > out
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'basic' '
 	run_completion "git \"\"" &&
 	# built-in
--=20
1.7.10.216.gb52c0
