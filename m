From: tboegi@web.de
Subject: [PATCH v1] t0027: Add tests for get_stream_filter()
Date: Sat, 23 Jan 2016 15:08:21 +0100
Message-ID: <1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Jan 23 15:08:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMyrS-0000Eo-8d
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 15:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbcAWOIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2016 09:08:07 -0500
Received: from mout.web.de ([212.227.15.14]:55686 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbcAWOIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 09:08:05 -0500
Received: from tor.lan ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lzs0p-1a08pO3qTr-0153TS; Sat, 23 Jan 2016 15:08:02
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
X-Provags-ID: V03:K0:ljIaaaLECoXC36tXaeqql6pqhXRWXl2lUgw4IVVLPLmuHGIMCa4
 wxrDQV5IKQ3fBRE9WYfvHTCTzTfyxgSx8c4n8tDHRZYBJSZnIpl+3iy+f9rYAH3n2E0Tdy/
 vpshtqsMXnbVdRWr6pYxGr3qyOIXsRKlic2e6gCYLP6xocOuXwEV7kq+JEFgadaxgCo2skm
 17w+dpvPhgw/N5/kLc2VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FW+aw8bsiSA=:NF7T9ECLRbPRoXleID0Eeb
 Y/US0+MZDfTFhaLsCurTN+hZfGlYrBOSePvTsqsXAJzBw9UYMLx4uKjUWfXOQq3eUbaXnVlkb
 5aUxseDKftyDC7MQcKG1RoLlrGADhd0OYA4ywFIbmpUHnjLU9HsiLn2yWgkvW31MqncNd2Ftq
 n3MzqfZv10OyiGx3NnnrlWOmfIakPJL15KZE2POliY5p/Ah+xh+TH3hefIlGjhOaFOPBoGi2e
 V2QQEk1Kd64hAUmGwGUDUQ+me1fWy3rHA98pEg5O76tt9jEHfwmnsq7HbP9UIK4J1icNpJKRd
 fx4fHQ9BGIagXqpeKJYIyvFAADhT00ORULCYv4DvlSkOT1KJm//tyN/oQagpaxjo51P3Y2y5Z
 oySGRMExHKQf2ku73yAIQnAAkoqKKQDZ9sTkvl16txSM1LVuHzSpQwZAvvNNTGQO2EMRkyTkP
 63B20ezTUeFjpIWpwj0YvhG5Y+pdY4lf4e67UHqg5Klg9lGK1rkzY31GdUr99iyZlVpm/DTdU
 Wxa04KeEs5tafTYy3478cLA6SgNXBiQmwz7XomTutk9MCph1PfmpB5RHit2k8ha/Mm1IK2QUc
 4TzhmDP4OXyA3X+hEnkQd1RzuypEcfD9hV9PN34FXEVPbPGI2CZgFkd5ihnEi//T9j/ksSuae
 kVhicQ9tlVVa7o1x4MywEKHMa3x6hoTEbfHdfzQL8jKv5uZzF8D58E6pinMRGvJREhX+7BbBH
 5s5XSfGXgCj12EWV4V0ucYG+o5GjBGbxFmWTjYjOBJcQqW866QXEbJd4tUaAIWF6CYCu7c1L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284629>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When a filter is configured, a different code-path is used in
convert.c and entry.c via get_stream_filter(), but there are no test ca=
ses yet.

Add tests for the filter API by configuring the ident filter.
The result of the SHA1 conversion is not checked, this is already
done in other TC.

Add a paramter to checkout_files() in t0027.
While changing the signature, add another parameter for the eol=3D attr=
ibute.
This is currently unused,
tests for e.g. "* text=3Dauto eol=3Dlf" will be added in a separate com=
mit.
---
 t/t0027-auto-crlf.sh | 261 ++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 146 insertions(+), 115 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 504e5a0..c148edc 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -22,31 +22,45 @@ compare_ws_file () {
 	exp=3D$2.expect
 	act=3D$pfx.actual.$3
 	tr '\015\000' QN <"$2" >"$exp" &&
-	tr '\015\000' QN <"$3" >"$act" &&
+	tr '\015\000' QN <"$3" |
+		sed -e "s/Id: ........................................ /Id: 00000000=
00000000000000000000000000000000 /" >"$2".actual >"$act" &&
 	test_cmp $exp $act &&
 	rm $exp $act
 }
=20
 create_gitattributes () {
 	attr=3D$1
+	ident=3D$2
+	case "$2" in
+		"")
+			>.gitattributes
+			;;
+		i)
+			echo "* ident" >.gitattributes
+			;;
+		*)
+			echo >&2 invalid ident: $2
+			exit 1
+	esac
+		=20
 	case "$attr" in
 		auto)
-		echo "*.txt text=3Dauto" >.gitattributes
+		echo "*.txt text=3Dauto" >>.gitattributes
 		;;
 		text)
-		echo "*.txt text" >.gitattributes
+		echo "*.txt text" >>.gitattributes
 		;;
 		-text)
-		echo "*.txt -text" >.gitattributes
+		echo "*.txt -text" >>.gitattributes
 		;;
 		crlf)
-		echo "*.txt eol=3Dcrlf" >.gitattributes
+		echo "*.txt eol=3Dcrlf" >>.gitattributes
 		;;
 		lf)
-		echo "*.txt eol=3Dlf" >.gitattributes
+		echo "*.txt eol=3Dlf" >>.gitattributes
 		;;
 		"")
-		echo >.gitattributes
+		#echo >.gitattributes
 		;;
 		*)
 		echo >&2 invalid attribute: $attr
@@ -90,7 +104,7 @@ commit_check_warn () {
 	lfmixcr=3D$6
 	crlfnul=3D$7
 	pfx=3Dcrlf_${crlf}_attr_${attr}
-	create_gitattributes "$attr" &&
+	create_gitattributes "$attr" "" &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
@@ -115,7 +129,7 @@ commit_chk_wrnNNO () {
 	crlfnul=3D$7
 	pfx=3DNNO_${crlf}_attr_${attr}
 	#Commit files on top of existing file
-	create_gitattributes "$attr" &&
+	create_gitattributes "$attr" "" &&
 	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
@@ -208,28 +222,30 @@ check_in_repo_NNO () {
 }
=20
 checkout_files () {
-	eol=3D$1
-	crlf=3D$2
-	attr=3D$3
-	lfname=3D$4
-	crlfname=3D$5
-	lfmixcrlf=3D$6
-	lfmixcr=3D$7
-	crlfnul=3D$8
-	create_gitattributes $attr &&
+	attr=3D$1 ; shift
+	ident=3D$1; shift
+	aeol=3D$1 ; shift
+	crlf=3D$1 ; shift
+	ceol=3D$1 ; shift
+	lfname=3D$1 ; shift
+	crlfname=3D$1 ; shift
+	lfmixcrlf=3D$1 ; shift
+	lfmixcr=3D$1 ; shift
+	crlfnul=3D$1 ; shift
+	create_gitattributes "$attr" "$ident" &&
 	git config core.autocrlf $crlf &&
-	pfx=3Deol_${eol}_crlf_${crlf}_attr_${attr}_ &&
+	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
 		rm crlf_false_attr__$f.txt &&
-		if test -z "$eol"; then
+		if test -z "$ceol"; then
 			git checkout crlf_false_attr__$f.txt
 		else
-			git -c core.eol=3D$eol checkout crlf_false_attr__$f.txt
+			git -c core.eol=3D$ceol checkout crlf_false_attr__$f.txt
 		fi
 	done
=20
-	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" '
+	test_expect_success "ls-files --eol i=3D$ident attributes=3D$attr $ae=
ol core.autocrlf=3D$crlf core.eol=3D$ceol" '
 		test_when_finished "rm expect actual" &&
 		sort <<-EOF >expect &&
 		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
@@ -244,19 +260,19 @@ checkout_files () {
 		sort >actual &&
 		test_cmp expect actual
 	'
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DLF" "
 		compare_ws_file $pfx $lfname    crlf_false_attr__LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DCRLF" "
 		compare_ws_file $pfx $crlfname  crlf_false_attr__CRLF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_mix_LF" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DCRLF_mix_LF" "
 		compare_ws_file $pfx $lfmixcrlf crlf_false_attr__CRLF_mix_LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_mix_CR" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DLF_mix_CR" "
 		compare_ws_file $pfx $lfmixcr   crlf_false_attr__LF_mix_CR.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_nul" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DLF_nul" "
 		compare_ws_file $pfx $crlfnul   crlf_false_attr__LF_nul.txt
 	"
 }
@@ -301,14 +317,13 @@ test_expect_success 'setup master' '
 	git checkout -b master &&
 	git add .gitattributes &&
 	git commit -m "add .gitattributes" "" &&
-	printf "line1\nline2\nline3"     >LF &&
-	printf "line1\r\nline2\r\nline3" >CRLF &&
-	printf "line1\r\nline2\nline3"   >repoMIX &&
-	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
-	printf "line1\nline2\rline3"     >LF_mix_CR &&
-	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
-	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
-	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nline1\nlin=
e2\nline3"     >LF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nline1\r\=
nline2\r\nline3" >CRLF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nline1\r\nl=
ine2\nline3"   >CRLF_mix_LF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nline1\nlin=
e2\rline3"     >LF_mix_CR &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nline1\r\=
nline2\rline3"   >CRLF_mix_CR &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nline1Q\r=
\nline2\r\nline3" | q_to_nul >CRLF_nul &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nline1Q\nli=
ne2\nline3" | q_to_nul >LF_nul &&
 	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF=
_mix_LF &&
 	git -c core.autocrlf=3Dfalse add NNO_*.txt &&
 	git commit -m "mixed line endings" &&
@@ -449,23 +464,18 @@ check_in_repo_NNO input "-text" LF        CRLF   =
   CRLF_mix_LF  LF_mix_CR 	CRLF
 # How to read the table below:
 # - checkout_files will check multiple files with a combination of set=
tings
 #   and attributes (core.autocrlf=3Dinput is forbidden with core.eol=3D=
crlf)
-# - parameter $1 : core.eol               lf | crlf
-# - parameter $2 : core.autocrlf          false | true | input
-# - parameter $3 : text in .gitattributs  "" (empty) | auto | text | -=
text
-# - parameter $4 : reference for a file with only LF in the repo
-# - parameter $5 : reference for a file with only CRLF in the repo
-# - parameter $6 : reference for a file with mixed LF and CRLF in the =
repo
-# - parameter $7 : reference for a file with LF and CR in the repo (do=
es somebody uses this ?)
-# - parameter $8 : reference for a file with CRLF and a NUL (should be=
 handled as binary when auto)
-
-#                                            What we have in the repo:
-#                                            ----------------- EOL in =
repo ----------------
-#                                            LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-#                   settings with checkout:
-#                   core.   core.   .gitattr
-#                    eol     acrlf
-#                                            -------------------------=
---------------------
-#                                            What we want to have in t=
he working tree:
+#
+# - parameter $1 	: text in .gitattributs  "" (empty) | auto | text | =
-text
+# - parameter $2 	: ident                  "" | i (i =3D=3D ident)
+# - parameter $3 	: eol in .gitattributs   "" (empty) | lf | crlf
+# - parameter $4 	: core.autocrlf          false | true | input
+# - parameter $5 	: core.eol               "" | lf | crlf | "native"
+# - parameter $6 	: reference for a file with only LF in the repo
+# - parameter $7 	: reference for a file with only CRLF in the repo
+# - parameter $8 	: reference for a file with mixed LF and CRLF in the=
 repo
+# - parameter $9 	: reference for a file with LF and CR in the repo
+# - parameter $10 : reference for a file with CRLF and a NUL (should b=
e handled as binary when auto)
+
 if test_have_prereq NATIVE_CRLF
 then
 MIX_CRLF_LF=3DCRLF
@@ -480,69 +490,90 @@ LFNUL=3DLF_nul
 fi
 export CRLF_MIX_LF_CR MIX NL
=20
-checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    LF_nul
-checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   $LFNUL
-checkout_files    ""      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    LF_nul
-checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   $LFNUL
-checkout_files    native  true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files ""      "" ""    false  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    false  crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    false  native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   ""       CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   crlf     CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   lf       CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   native   CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  ""       $NL   CRLF  $MIX_CRLF_=
LF LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  crlf     CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  native   $NL   CRLF  $MIX_CRLF_=
LF LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   ""       CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   crlf     CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   lf       CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   native   CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  ""       $NL   CRLF  $MIX_CRLF_=
LF LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  native   $NL   CRLF  $MIX_CRLF_=
LF LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+
+for id in "" i;
+do
+	checkout_files "crlf"  "$id" ""    false  ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    false  crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    false  lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    false  native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    input  ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    input  lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "lf"    "$id" ""    false  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    false  crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    false  native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    false  ""       $NL   CRLF  $MIX_C=
RLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id" ""    false  crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    false  native   $NL   CRLF  $MIX_C=
RLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    true   ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    true   crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    true   lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    true   native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "-text" "$id" ""    false  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    false  crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    false  native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+done
=20
 # Should be the last test case: remove some files from the worktree
 test_expect_success 'ls-files --eol -d -z' '
--=20
2.1.4
