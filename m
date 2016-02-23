From: tboegi@web.de
Subject: [PATCH v2 1/1] convert.c: correct attr_action
Date: Tue, 23 Feb 2016 18:07:19 +0100
Message-ID: <1456247239-5988-1-git-send-email-tboegi@web.de>
References: <56CBED82.5040400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYGOq-000078-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbcBWRFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 12:05:18 -0500
Received: from mout.web.de ([212.227.17.11]:56548 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbcBWRFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:05:17 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MLgQp-1aZ5bs11vv-000qTd; Tue, 23 Feb 2016 18:05:15
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <56CBED82.5040400@web.de>
X-Provags-ID: V03:K0:tBj9t/4syUIkedshK44qTaZkWYg5bxe6G/BVeRtsn8aHFZmw1lu
 R6FiF6etbJ4weciwgE+/Fh7iRfVhzbCUOuiFrxcOylwdZ5WBJkGOGtHSuJ8IWO6Mlu99DEw
 POt30fpb6JKloinosHQHJtarsDxcl2MbqvGRlJ64JgZDcrEpS5RSbPLmnmjDopkL7SjNCbu
 aWoEbwCLoa+8ElL74vk6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:slTiTcP2oXI=:Dcwd+ouKvTqcKqQ7/J1DXx
 1TB7AG+1hWPcfMOitCL5SgQRYc0pTO8uzhnmjuob3JhO1I43Bpx+bR7SRoMRVOCV/RnamChyP
 w/kwt9pWnJsh8fAOhzzHvRye27es1B6YXBEU8x7dJlLZAtymBWV35BwZDDIcnrGawqtMjjcuj
 jr/cO9UZnwtMBmDh0LIgOCc20lWVPDMC8VNIDnRv3HyBiEDKzTIwVJhGFcv1EBTfrit3bND0f
 +gHjPOigWZtadpjFanv8OHVHEj1WYGqlOiFMm2GxNZC71cc+JbxSDxwAWcz9izKynTgW0DD+o
 ozSmlzkPX8fo/V6h5CIVjj7VmkUgGXMZCCeF3QxKkiBi5jIrle8+xabjJ2/uRolslKKs72zRE
 RjlJMePca96TxQxClHmg8+/LrsmQ9RzxPYbdrtC0XAPKKO7Rmj5Epa1lD4Ant0IvJ88nrwKDI
 QG57GVwXMwm6hD+ubg66oGJn7qMlb29Rf8mXWLy3XcSQKkPiE7lFt9H29fl0m7It65bntp/SL
 EBHylVja6vKEIwarmUtwzPr90fswg3RoKZU3W9GGJ8MMdCtCIWQWqk5CozTgOy883oC3o1D6A
 nxprtuf55hXyDTzmtEzpKBUvPlThWlKJYczKtJiNYmjru2QozsDwh7YoDr3kYmrZqrklPh4kL
 wIQbR0bXbPMJAbj81CAYKliFh40EoWJzqbKJiWWU+9I98M7cMAUKCLyqoHwZUVwqeG58iQ7MC
 FjdBzwHRNsoBngKI6s0X2/T/RqGWaNJLkqdvt4c4eYdQli+CejAs4MEPUti/ZOn8YrihEyUh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287084>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit "convert.c: refactor crlf_action" unified the crlf_handling
and introdused a bug for "git ls-files --eol".
The "text" attribute was shown as "text eol=3Dlf" or "text eol=3Dcrlf",
depending on core.autpcrlf or core.eol.
Correct this and add test cases in t0027.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c            | 18 +++++++++---------
 t/t0027-auto-crlf.sh | 33 ++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/convert.c b/convert.c
index 18af685..d8b1f17 100644
--- a/convert.c
+++ b/convert.c
@@ -708,7 +708,7 @@ static enum crlf_action git_path_check_crlf(struct =
git_attr_check *check)
 	const char *value =3D check->value;
=20
 	if (ATTR_TRUE(value))
-		return text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
+		return CRLF_TEXT;
 	else if (ATTR_FALSE(value))
 		return CRLF_BINARY;
 	else if (ATTR_UNSET(value))
@@ -778,20 +778,20 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 	}
=20
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
-		enum eol eol_attr;
 		ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
 			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
 		ca->attr_action =3D ca->crlf_action;
 		ca->ident =3D git_path_check_ident(ccheck + 1);
 		ca->drv =3D git_path_check_convert(ccheck + 2);
-		if (ca->crlf_action =3D=3D CRLF_BINARY)
-			return;
-		eol_attr =3D git_path_check_eol(ccheck + 3);
-		if (eol_attr =3D=3D EOL_LF)
-			ca->crlf_action =3D CRLF_TEXT_INPUT;
-		else if (eol_attr =3D=3D EOL_CRLF)
-			ca->crlf_action =3D CRLF_TEXT_CRLF;
+		if (ca->crlf_action !=3D CRLF_BINARY) {
+			enum eol eol_attr =3D git_path_check_eol(ccheck + 3);
+			if (eol_attr =3D=3D EOL_LF)
+				ca->crlf_action =3D CRLF_TEXT_INPUT;
+			else if (eol_attr =3D=3D EOL_CRLF)
+				ca->crlf_action =3D CRLF_TEXT_CRLF;
+		}
+		ca->attr_action =3D ca->crlf_action;
 	} else {
 		ca->drv =3D NULL;
 		ca->crlf_action =3D CRLF_UNDEFINED;
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index fc4c628..f33962b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -159,6 +159,25 @@ stats_ascii () {
=20
 }
=20
+
+# contruct the attr/ returned by git ls-files --eol
+# Take none (=3Dempty), one or two args
+attr_ascii () {
+	case $1,$2 in
+	-text,*)   echo "-text" ;;
+	text,)     echo "text" ;;
+	text,lf)   echo "text eol=3Dlf" ;;
+	text,crlf) echo "text eol=3Dcrlf" ;;
+	auto,)     echo "text=3Dauto" ;;
+	auto,lf)   echo "text=3Dauto eol=3Dlf" ;;
+	auto,crlf) echo "text=3Dauto eol=3Dcrlf" ;;
+	lf,)       echo "text eol=3Dlf" ;;
+	crlf,)     echo "text eol=3Dcrlf" ;;
+	,) echo "" ;;
+	*) echo invalid_attr "$1,$2" ;;
+	esac
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -228,15 +247,15 @@ checkout_files () {
 	test_expect_success "ls-files --eol attr=3D$attr $ident $aeol core.au=
tocrlf=3D$crlf core.eol=3D$ceol" '
 		test_when_finished "rm expect actual" &&
 		sort <<-EOF >expect &&
-		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
-		i/mixed w/$(stats_ascii $lfmixcrlf) crlf_false_attr__CRLF_mix_LF.txt
-		i/lf w/$(stats_ascii $lfname) crlf_false_attr__LF.txt
-		i/-text w/$(stats_ascii $lfmixcr) crlf_false_attr__LF_mix_CR.txt
-		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__CRLF_nul.txt
-		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__LF_nul.txt
+		i/crlf w/$(stats_ascii $crlfname) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__CRLF.txt
+		i/mixed w/$(stats_ascii $lfmixcrlf) attr/$(attr_ascii $attr $aeol) c=
rlf_false_attr__CRLF_mix_LF.txt
+		i/lf w/$(stats_ascii $lfname) attr/$(attr_ascii $attr $aeol) crlf_fa=
lse_attr__LF.txt
+		i/-text w/$(stats_ascii $lfmixcr) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__LF_mix_CR.txt
+		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__CRLF_nul.txt
+		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__LF_nul.txt
 		EOF
 		git ls-files --eol crlf_false_attr__* |
-		sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
+		sed -e "s/	/ /g" -e "s/  */ /g" |
 		sort >actual &&
 		test_cmp expect actual
 	'
--=20
2.7.0.303.g2c4f448.dirty
