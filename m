From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 06/10] t5500: Test case for diag-url
Date: Thu, 28 Nov 2013 20:49:29 +0100
Message-ID: <201311282049.30311.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7am-0002xl-Si
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457Ab3K1Tth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:49:37 -0500
Received: from mout.web.de ([212.227.17.11]:63778 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab3K1Ttg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:49:36 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MAvGa-1Vtqpe36fs-009y2F for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:49:34 +0100
X-Provags-ID: V03:K0:BdhlT/sCO+PlIDKLUoNvbg8EZ73YRuGw2EZxHNJlr/RSouKtTw+
 5l2wSYM6UlpvACDENTWtIDf9aMCiuU9QriPwMnyTRvSJToWKFy6pbTjzuinG23f0hliTDtU
 8FZNr+sYz7NbFNIi4dQAmpuwJsgGnM/UFUGADyZmRaAGwNRsOVn+jivIi2JZOk5ISmI6q2o
 aB1aMICxHwfuhQNKdoa3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238508>

Add test cases using git fetch-pack --diag-url:

- parse out host and path for URLs with a scheme (git:// file:// ssh://=
)
- parse host names embedded by [] correctly
- extract the port number, if present
- separate URLs like "file" (which are local)
  from URLs like "host:repo" which should use ssh

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t5500-fetch-pack.sh | 59 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d87ddf7..a2b37af 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -531,5 +531,64 @@ test_expect_success 'shallow fetch with tags does =
not break the repository' '
 		git fsck
 	)
 '
+check_prot_path() {
+	cat >expected <<-EOF &&
+	Diag: url=3D$1
+	Diag: protocol=3D$2
+	Diag: path=3D$3
+	EOF
+	git fetch-pack --diag-url "$1" | grep -v hostandport=3D >actual &&
+	test_cmp expected actual
+}
+
+check_prot_host_path() {
+	cat >expected <<-EOF &&
+	Diag: url=3D$1
+	Diag: protocol=3D$2
+	Diag: hostandport=3D$3
+	Diag: path=3D$4
+	EOF
+	git fetch-pack --diag-url "$1" >actual &&
+	test_cmp expected actual
+}
+
+for r in repo re:po re/po
+do
+	# git or ssh with scheme
+	for p in "ssh+git" "git+ssh" git ssh
+	do
+		for h in host host:12 [::1] [::1]:23
+		do
+			case "$p" in
+			*ssh*)
+				hh=3D$(echo $h | tr -d "[]")
+				pp=3Dssh
+				;;
+			*)
+				hh=3D$h
+				pp=3D$p
+			;;
+			esac
+			test_expect_success "fetch-pack --diag-url $p://$h/$r" '
+				check_prot_host_path $p://$h/$r $pp "$hh" "/$r"
+			'
+			# "/~" -> "~" conversion
+			test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
+				check_prot_host_path $p://$h/~$r $pp "$hh" "~$r"
+			'
+		done
+	done
+	# file with scheme
+	for p in file
+	do
+		test_expect_success "fetch-pack --diag-url $p://$h/$r" '
+			check_prot_path $p://$h/$r $p "/$r"
+		'
+		# No "/~" -> "~" conversion for file
+		test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
+			check_prot_path $p://$h/~$r $p "/~$r"
+		'
+	done
+done
=20
 test_done
--=20
1.8.5.rc0.23.gaa27064
