From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 1/2] t0027: Tests for core.eol=native, eol=lf, eol=crlf
Date: Sat, 16 Aug 2014 22:16:58 +0200
Message-ID: <53EFBC3A.5020805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 22:17:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIkPU-000204-Nh
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 22:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbaHPURD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Aug 2014 16:17:03 -0400
Received: from mout.web.de ([212.227.15.3]:65226 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbaHPURC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 16:17:02 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M2dt7-1WQVMP0TQ5-00sKBX; Sat, 16 Aug 2014 22:17:00
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:B0teYvqPRptMx9QjtyBv1yNw2dMe9+ZfpvV4lLonJnGWTWAgsC9
 eUwM6bvAJnZYzy4Ehtr2qH2GWXuqA34fse1GFrf9U0Z6sv3UkDhdiOm7Wd82XiIhpij4m2Q
 3PTlfbl9EYe3SPQbyAdk5XEc3qWO7UnQRDdzfziXgQUrGj0lU04SSMOYJpBRkO0zc3cc6UJ
 ZM5bqCPxQhfNx6pvlkEXA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255340>

Add test cases for core.eol "native" and "" (unset).
(MINGW uses CRLF, all other systems LF as native line endings)

Add test cases for the attributes "eol=3Dlf" and "eol=3Dcrlf"

Other minor changes:
- Use the more portable 'tr' instead of 'od -c' to convert '\n' into 'Q=
'
  and '\0' into 'N'
- Style fixes for shell functions according to the coding guide lines
- Replace "txtbin" with "attr"

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 220 ++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 120 insertions(+), 100 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 72dd3e8..2a4a6c1 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -10,30 +10,26 @@ then
 	test_done
 fi
=20
-
-compare_files()
-{
-	od -c <"$1" >"$1".expect &&
-	od -c <"$2" >"$2".actual &&
+compare_files () {
+	tr '\015\000' QN <"$1" >"$1".expect &&
+	tr '\015\000' QN <"$2" >"$2".actual &&
 	test_cmp "$1".expect "$2".actual &&
 	rm "$1".expect "$2".actual
 }
=20
-compare_ws_file()
-{
+compare_ws_file () {
 	pfx=3D$1
 	exp=3D$2.expect
 	act=3D$pfx.actual.$3
-	od -c <"$2" >"$exp" &&
-	od -c <"$3" >"$act" &&
+	tr '\015\000' QN <"$2" >"$exp" &&
+	tr '\015\000' QN <"$3" >"$act" &&
 	test_cmp $exp $act &&
 	rm $exp $act
 }
=20
-create_gitattributes()
-{
-	txtbin=3D$1
-	case "$txtbin" in
+create_gitattributes () {
+	attr=3D$1
+	case "$attr" in
 		auto)
 		echo "*.txt text=3Dauto" >.gitattributes
 		;;
@@ -43,35 +39,43 @@ create_gitattributes()
 		-text)
 		echo "*.txt -text" >.gitattributes
 		;;
-		*)
+		crlf)
+		echo "*.txt eol=3Dcrlf" >.gitattributes
+		;;
+		lf)
+		echo "*.txt eol=3Dlf" >.gitattributes
+		;;
+		"")
 		echo >.gitattributes
 		;;
+		*)
+		echo >&2 invalid attribute: $attr
+		exit 1
+		;;
 	esac
 }
=20
-create_file_in_repo()
-{
+create_file_in_repo () {
 	crlf=3D$1
-	txtbin=3D$2
-	create_gitattributes "$txtbin" &&
+	attr=3D$2
+	create_gitattributes "$attr" &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
 	do
-		pfx=3Dcrlf_${crlf}_attr_${txtbin}_$f.txt &&
+		pfx=3Dcrlf_${crlf}_attr_${attr}_$f.txt &&
 		cp $f $pfx && git -c core.autocrlf=3D$crlf add $pfx
 	done &&
 	git commit -m "core.autocrlf $crlf"
 }
=20
-check_files_in_repo()
-{
+check_files_in_repo () {
 	crlf=3D$1
-	txtbin=3D$2
+	attr=3D$2
 	lfname=3D$3
 	crlfname=3D$4
 	lfmixcrlf=3D$5
 	lfmixcr=3D$6
 	crlfnul=3D$7
-	pfx=3Dcrlf_${crlf}_attr_${txtbin}_ &&
+	pfx=3Dcrlf_${crlf}_attr_${attr}_ &&
 	compare_files $lfname ${pfx}LF.txt &&
 	compare_files $crlfname ${pfx}CRLF.txt &&
 	compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt &&
@@ -80,19 +84,18 @@ check_files_in_repo()
 }
=20
=20
-check_files_in_ws()
-{
+check_files_in_ws () {
 	eol=3D$1
 	crlf=3D$2
-	txtbin=3D$3
+	attr=3D$3
 	lfname=3D$4
 	crlfname=3D$5
 	lfmixcrlf=3D$6
 	lfmixcr=3D$7
 	crlfnul=3D$8
-	create_gitattributes $txtbin &&
+	create_gitattributes $attr &&
 	git config core.autocrlf $crlf &&
-	pfx=3Deol_${eol}_crlf_${crlf}_attr_${txtbin}_ &&
+	pfx=3Deol_${eol}_crlf_${crlf}_attr_${attr}_ &&
 	src=3Dcrlf_false_attr__ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
 	do
@@ -104,42 +107,24 @@ check_files_in_ws()
 		fi
 	done
=20
-
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DLF" "
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
 		compare_ws_file $pfx $lfname    ${src}LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DCRLF" "
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF" "
 		compare_ws_file $pfx $crlfname  ${src}CRLF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DCRLF_mix_LF" "
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_mix_LF" "
 		compare_ws_file $pfx $lfmixcrlf ${src}CRLF_mix_LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DLF_mix_CR" "
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_mix_CR" "
 		compare_ws_file $pfx $lfmixcr   ${src}LF_mix_CR.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DCRLF_nul" "
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_nul" "
 		compare_ws_file $pfx $crlfnul   ${src}CRLF_nul.txt
 	"
 }
=20
 #######
-(
-	type od >/dev/null &&
-	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
-	cat >expect <<-EOF &&
-	0000000 l i n e 1 \0 \r \n l i n e 2 \r \n l
-	0000020 i n e 3
-	0000024
-EOF
-	od -c CRLF_nul | sed -e "s/[ 	][	 ]*/ /g" -e "s/ *$//" >actual
-	test_cmp expect actual &&
-	rm expect actual
-) || {
-		skip_all=3D"od not found or od -c not usable"
-		exit 0
-		test_done
-}
-
 test_expect_success 'setup master' '
 	echo >.gitattributes &&
 	git checkout -b master &&
@@ -150,9 +135,10 @@ test_expect_success 'setup master' '
 	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
 	printf "line1\nline2\rline3"     >LF_mix_CR &&
 	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
+	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
 	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul
 '
-#  CRLF_nul had been created above
+
=20
 test_expect_success 'create files' '
 	create_file_in_repo false "" &&
@@ -201,7 +187,8 @@ test_expect_success 'commit -text' '
 ######################################################################=
##########
 # Check how files in the repo are changed when they are checked out
 # How to read the table below:
-# - check_files_in_ws will check multiple files, see below
+# - check_files_in_ws will check multiple files with a combination of =
settings
+#   and attributes (core.autocrlf=3Dinput is forbidden with core.eol=3D=
crlf)
 # - parameter $1 : core.eol               lf | crlf
 # - parameter $2 : core.autocrlf          false | true | input
 # - parameter $3 : text in .gitattributs  "" (empty) | auto | text | -=
text
@@ -211,55 +198,88 @@ test_expect_success 'commit -text' '
 # - parameter $7 : reference for a file with LF and CR in the repo (do=
es somebody uses this ?)
 # - parameter $8 : reference for a file with CRLF and a NUL (should be=
 handled as binary when auto)
=20
-check_files_in_ws lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
-check_files_in_ws lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
-check_files_in_ws lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-check_files_in_ws lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
-check_files_in_ws lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
-###########
-#core.autocrlf=3Dinput is forbidden with core.eol=3Dcrlf
-check_files_in_ws crlf    false ""        LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws crlf    true  ""        CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
-check_files_in_ws crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-check_files_in_ws crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-
-check_files_in_ws crlf    false "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-check_files_in_ws crlf    true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-check_files_in_ws crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
+#                                            What we have in the repo:
+#                														 ----------------- EOL in repo --------=
--------
+#                														 LF    CRLF  CRLF_mix_LF  LF_mix_CR    =
CRLF_nul
+#                   settings with checkout:
+#                   core.   core.   .gitattr
+#                    eol     acrlf
+#                                            -------------------------=
---------------------
+#                                            What we want to have in t=
he working tree:
 if test_have_prereq MINGW
 then
-check_files_in_ws ""      false ""        LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws ""      true  ""        CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws ""      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-check_files_in_ws ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-
-check_files_in_ws native  false ""        LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws native  true  ""        CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
-check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws native  true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-check_files_in_ws native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
-check_files_in_ws native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+MIX_CRLF_LF=3DCRLF
+MIX_LF_CR=3DCRLF_mix_CR
+NL=3DCRLF
+else
+MIX_CRLF_LF=3DCRLF_mix_LF
+MIX_LF_CR=3DLF_mix_CR
+NL=3DLF
 fi
+export CRLF_MIX_LF_CR MIX NL
+
+check_files_in_ws    lf      false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      input  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      false "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      input "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      false "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    lf      input "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      input "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      input "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    lf      false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    lf      true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    lf      input "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+
+check_files_in_ws    crlf    false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    false "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    false "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    crlf    true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    crlf    false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    crlf    true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+
+check_files_in_ws    ""      false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      input  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      input "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF =
$MIX_LF_CR   CRLF_nul
+check_files_in_ws    ""      true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    ""      input "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      input "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      input "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    ""      false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    ""      true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    ""      input "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+
+check_files_in_ws    native  false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  false "text"    $NL   CRLF  $MIX_CRLF_LF =
$MIX_LF_CR   CRLF_nul
+check_files_in_ws    native  true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    native  false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
+check_files_in_ws    native  false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+check_files_in_ws    native  true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
=20
 test_done
--=20
2.1.0.rc2.210.g636bceb
