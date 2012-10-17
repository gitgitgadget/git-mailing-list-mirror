From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: clean up __gitcomp() tests
Date: Wed, 17 Oct 2012 19:54:28 +0200
Message-ID: <20121017175428.GF2156@goldbirke>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
 <1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
 <20121017175040.GE2156@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 19:54:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOXpM-00016N-EP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446Ab2JQRyd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 13:54:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51857 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab2JQRyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 13:54:32 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LdEVV-1Tp2xB17In-00j5BL; Wed, 17 Oct 2012 19:54:28 +0200
Content-Disposition: inline
In-Reply-To: <20121017175040.GE2156@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:q2hjI84kY2ZIF4GNWJmpecyek8Im+iwW/kyizprYzpA
 4QXOEvUUjFvf5P6/cOB9JDRAiZgqMvwREu0LdLdfYyl+q8YsbO
 aSxdOQrw3rnwGWKbwH5izwuOFV9fkkE5nFg43Yln9Zqqw0G6MO
 9arulYGeyK1wUy4U2RR2XWomTTeqeM59H+kv10rWoAZoimVyKy
 XnvzdxogETmBO0iGcSCIeRZLFUhgKiMD63cL5jnWcIrxhB3C5k
 05KUDsuHPvRDupqxvWdvfQGaR8nOLeO/zMiaUhtlCXRrFFWOVr
 f4MI9JCoxi6NNO37Km2Ap060v+yREkmoC3DaqdrnUKF2EjhNBL
 HOu8SWt3kWmEebDtVRxE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207927>

Clean up two issues in the tests I added in 74a8c849 (tests: add tests
for the __gitcomp() completion helper function, 2012-04-17):

 - The COMPREPLY array is created using 'local -a' while in a
   subshell.  However, the local keyword should only be used in a
   shell function, and a variable created in a subshell is by
   definition local to that subshell.  Use 'declare -a' instead.

 - The contents of the COMPREPLY array is written through an IFS
   fiddling + echo + redirection combo, although there is the
   print_comp() helper function for exactly this purpose.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb66..cc375ed0 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -70,8 +70,6 @@ test_completion_long ()
 	test_completion "$1"
 }
=20
-newline=3D$'\n'
-
 test_expect_success '__gitcomp - trailing space - options' '
 	sed -e "s/Z$//" >expected <<-\EOF &&
 	--reuse-message=3DZ
@@ -79,12 +77,11 @@ test_expect_success '__gitcomp - trailing space - o=
ptions' '
 	--reset-author Z
 	EOF
 	(
-		local -a COMPREPLY &&
+		declare -a COMPREPLY &&
 		cur=3D"--re" &&
 		__gitcomp "--dry-run --reuse-message=3D --reedit-message=3D
 				--reset-author" &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		print_comp
 	) &&
 	test_cmp expected out
 '
@@ -97,12 +94,11 @@ test_expect_success '__gitcomp - trailing space - c=
onfig keys' '
 	browser.Z
 	EOF
 	(
-		local -a COMPREPLY &&
+		declare -a COMPREPLY &&
 		cur=3D"br" &&
 		__gitcomp "branch. branch.autosetupmerge
 				branch.autosetuprebase browser." &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		print_comp
 	) &&
 	test_cmp expected out
 '
@@ -113,12 +109,11 @@ test_expect_success '__gitcomp - option parameter=
' '
 	resolve Z
 	EOF
 	(
-		local -a COMPREPLY &&
+		declare -a COMPREPLY &&
 		cur=3D"--strategy=3Dre" &&
 		__gitcomp "octopus ours recursive resolve subtree
 			" "" "re" &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		print_comp
 	) &&
 	test_cmp expected out
 '
@@ -129,12 +124,11 @@ test_expect_success '__gitcomp - prefix' '
 	branch.maint.mergeoptions Z
 	EOF
 	(
-		local -a COMPREPLY &&
+		declare -a COMPREPLY &&
 		cur=3D"branch.me" &&
 		__gitcomp "remote merge mergeoptions rebase
 			" "branch.maint." "me" &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		print_comp
 	) &&
 	test_cmp expected out
 '
@@ -145,12 +139,11 @@ test_expect_success '__gitcomp - suffix' '
 	branch.maint.Z
 	EOF
 	(
-		local -a COMPREPLY &&
+		declare -a COMPREPLY &&
 		cur=3D"branch.me" &&
 		__gitcomp "master maint next pu
 			" "branch." "ma" "." &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
+		print_comp
 	) &&
 	test_cmp expected out
 '
--=20
1.8.0.rc0.83.gc8e1777
