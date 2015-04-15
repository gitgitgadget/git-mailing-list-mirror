From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 3/3] t0027: Add repoMIX and LF_nul
Date: Wed, 15 Apr 2015 19:01:04 +0200
Message-ID: <552E9950.9050008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 19:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQgb-00086S-RG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbbDORBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 13:01:08 -0400
Received: from mout.web.de ([212.227.17.12]:65126 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396AbbDORBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:01:06 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MYeys-1YvANn0LTO-00VOwI; Wed, 15 Apr 2015 19:01:05
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:talcyrB7ky/1S02mDbVmX2YGK7DG0lEF3VnYCoQvXAcN7PoibBL
 7pEjyZkiZ39LWUDMHtQuJmU4+z2oq8qveMjluJECXLV3ix/UPzmiUJ9vOY6yi64L5ecqCYR
 0iTMIE6AFSS7sLMMPW9pTRJoVAWaPZtCNXDJz0zZiJhKYeSPjjb+BZ0sRCaUZqX9I1MWg7p
 nU0kXyPmYCK6ogXMBWj3w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267220>

"new safer autocrlf handling":
  Check if eols are converted at commit, which have CR (or CLLF) in the=
 repo
  (technically speaking in the index)
  Add a test-file repoMIX with mixed line-endings.
  Check the warnings when converting LF->CRLF or CRLF->LF

checkout_files():
  Checking out CRLF_nul and checking eol coversion does not
  make much sense (CRLF will stay CRLF).
  Use the file LF_nul instead: It is handled a binary in "auto" modes, =
and when
  declared as text the LF should be replaced with CRLF

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 155 ++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 84 insertions(+), 71 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 59dfe02..7b85ffb 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -71,12 +71,21 @@ commit_check_warn () {
 	attr=3D$2
 	lfname=3D$3
 	crlfname=3D$4
-	lfmixcrlf=3D$5
-	lfmixcr=3D$6
-	crlfnul=3D$7
-	create_gitattributes "$attr" &&
+  repoMIX=3D$5
+	lfmixcrlf=3D$6
+	lfmixcr=3D$7
+	crlfnul=3D$8
 	pfx=3Dcrlf_${crlf}_attr_${attr}
-	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
+	# Special handling for repoMIX: It should already be in the repo
+	# with CRLF
+	f=3DrepoMIX
+	fname=3D${pfx}_$f.txt
+	echo >.gitattributes &&
+	cp $f $fname &&
+	git -c core.autocrlf=3Dfalse add $fname 2>"${pfx}_$f.err" &&
+	git commit -m "repoMIX" &&
+	create_gitattributes "$attr" &&
+	for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
 		cp $f $fname &&
@@ -120,7 +129,7 @@ checkout_files () {
 	git config core.autocrlf $crlf &&
 	pfx=3Deol_${eol}_crlf_${crlf}_attr_${attr}_ &&
 	src=3Dcrlf_false_attr__ &&
-	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
+	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
 		rm $src$f.txt &&
 		if test -z "$eol"; then
@@ -142,8 +151,8 @@ checkout_files () {
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_mix_CR" "
 		compare_ws_file $pfx $lfmixcr   ${src}LF_mix_CR.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_nul" "
-		compare_ws_file $pfx $crlfnul   ${src}CRLF_nul.txt
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_nul" "
+		compare_ws_file $pfx $crlfnul   ${src}LF_nul.txt
 	"
 }
=20
@@ -155,6 +164,7 @@ test_expect_success 'setup master' '
 	git commit -m "add .gitattributes" "" &&
 	printf "line1\nline2\nline3"     >LF &&
 	printf "line1\r\nline2\r\nline3" >CRLF &&
+	printf "line1\r\nline2\nline3"   >repoMIX &&
 	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
 	printf "line1\nline2\rline3"     >LF_mix_CR &&
 	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
@@ -178,40 +188,41 @@ WCL=3DCRLF_LF
 WMIX=3DCRLF_LF
 fi
=20
+#                         attr   LF        CRLF      repoMIX   CRLFmix=
LF LFmixCR   CRLFNUL
 test_expect_success 'commit files empty attr' '
-	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
-	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
-	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
+	commit_check_warn false ""     ""        ""        ""        ""      =
  ""        "" &&
+	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        "" &&
+	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""        ""
 '
=20
 test_expect_success 'commit files attr=3Dauto' '
-	commit_check_warn false "auto" "$WLC"    "$WCL"    "$WMIX"   ""      =
  "" &&
-	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
-	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
+	commit_check_warn false "auto" "$WLC"    "$WCL"    "$WMIX"   "$WMIX" =
  ""        "" &&
+	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        "" &&
+	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""        ""
 '
=20
 test_expect_success 'commit files attr=3Dtext' '
-	commit_check_warn false "text" "$WLC"    "$WCL"    "$WMIX"   "$WLC"  =
  "$WCL" &&
-	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        &&
-	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF"
+	commit_check_warn false "text" "$WLC"    "$WCL"    "$WMIX"   "$WMIX" =
  "$WLC"    "$WCL"    &&
+	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" ""        &&
+	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""        "CRLF_LF"
 '
=20
 test_expect_success 'commit files attr=3D-text' '
-	commit_check_warn false "-text" ""       ""        ""        ""      =
  "" &&
-	commit_check_warn true  "-text" ""       ""        ""        ""      =
  "" &&
-	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""
+	commit_check_warn false "-text" ""       ""        ""        ""      =
  ""        "" &&
+	commit_check_warn true  "-text" ""       ""        ""        ""      =
  ""        "" &&
+	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""        ""
 '
=20
 test_expect_success 'commit files attr=3Dlf' '
-	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF" &&
-	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF" &&
-	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF"
+	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""       "CRLF_LF" &&
+	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""       "CRLF_LF" &&
+	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""       "CRLF_LF"
 '
=20
 test_expect_success 'commit files attr=3Dcrlf' '
-	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
-	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
-	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
+	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" "" &&
+	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" "" &&
+	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "LF_CRLF" ""
 '
=20
 test_expect_success 'create files cleanup' '
@@ -270,74 +281,76 @@ then
 MIX_CRLF_LF=3DCRLF
 MIX_LF_CR=3DCRLF_mix_CR
 NL=3DCRLF
+LFNUL=3DCRLF_nul
 else
 MIX_CRLF_LF=3DCRLF_mix_LF
 MIX_LF_CR=3DLF_mix_CR
 NL=3DLF
+LFNUL=3DLF_nul
 fi
 export CRLF_MIX_LF_CR MIX NL
=20
-checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
+checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
 checkout_files    lf      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
 checkout_files    lf      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    lf      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    lf      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
-checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
+checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
 checkout_files    crlf    false "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    crlf    true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
 checkout_files    crlf    false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    crlf    true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
-checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    CRLF_nul
-checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   CRLF_nul
+checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    LF_nul
+checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
+checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   $LFNUL
 checkout_files    ""      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
 checkout_files    ""      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    ""      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    ""      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
-checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    CRLF_nul
-checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   CRLF_nul
+checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    LF_nul
+checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
+checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   $LFNUL
 checkout_files    native  true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
+checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
 checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
--=20
2.2.0.rc1.790.ge19fcd2
