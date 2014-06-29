From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 2/2] t0027: combinations of core.autocrlf, core.eol and text
Date: Sun, 29 Jun 2014 08:34:54 +0200
Message-ID: <53AFB38E.8000401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 08:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X18hZ-0001VN-VC
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 08:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbaF2Ge6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2014 02:34:58 -0400
Received: from mout.web.de ([212.227.15.14]:65230 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbaF2Ge5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 02:34:57 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MF3Nr-1WtfWe2h6h-00GGcZ; Sun, 29 Jun 2014 08:34:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:mJwigYJZGV0/AZyKgiI+YHDzcTqkwCWeDZTGs5HEY0kTpL/2KEv
 YidXTVbqjRG4aPafOFFA02xNrgIJOpNskYnQkS38DaVT7nRJwAXndjRfU9ZyOs9NvTdBjDY
 ZsKKxsQpSBo6Cf5Dxbl+HJLSlXr9bUXMCLmthE8Maez333c6mAsME5ECvNcn5NOIe4+wx6P
 BxAf+nWEjPL+dtZFv2fWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252632>

Historically there are 3 different parameters controlling how line endi=
ngs
are handled by Git:
- core.autocrlf
- core.eol
- the "text" attribute in .gitattributes

There are different types of content:
- (1) Files with only LF
- (2) Files with only CRLF
- (3) Files with mixed LF and CRLF
- (4) Files with LF and/or CRLF with CR not followed by LF
- (5) Files which are binary (e.g. have NUL bytes)

Recently the question came up, how files with mixed EOLs are handled by=
 Git
(and libgit2) when they are checked out and core.autocrlf=3Dtrue.

See
http://git.661346.n2.nabble.com/The-different-EOL-behavior-between-libg=
it2-based-software-and-official-Git-td7613670.html#a7613801

Add the EXPENSIVE t0027-auto-crlf.sh to test all combination of files
and parameters for both "git add/commit" and "git checkout".

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 265 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 265 insertions(+)
 create mode 100755 t/t0027-auto-crlf.sh

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
new file mode 100755
index 0000000..72dd3e8
--- /dev/null
+++ b/t/t0027-auto-crlf.sh
@@ -0,0 +1,265 @@
+#!/bin/sh
+
+test_description=3D'CRLF conversion all combinations'
+
+. ./test-lib.sh
+
+if ! test_have_prereq EXPENSIVE
+then
+	skip_all=3D"EXPENSIVE not set"
+	test_done
+fi
+
+
+compare_files()
+{
+	od -c <"$1" >"$1".expect &&
+	od -c <"$2" >"$2".actual &&
+	test_cmp "$1".expect "$2".actual &&
+	rm "$1".expect "$2".actual
+}
+
+compare_ws_file()
+{
+	pfx=3D$1
+	exp=3D$2.expect
+	act=3D$pfx.actual.$3
+	od -c <"$2" >"$exp" &&
+	od -c <"$3" >"$act" &&
+	test_cmp $exp $act &&
+	rm $exp $act
+}
+
+create_gitattributes()
+{
+	txtbin=3D$1
+	case "$txtbin" in
+		auto)
+		echo "*.txt text=3Dauto" >.gitattributes
+		;;
+		text)
+		echo "*.txt text" >.gitattributes
+		;;
+		-text)
+		echo "*.txt -text" >.gitattributes
+		;;
+		*)
+		echo >.gitattributes
+		;;
+	esac
+}
+
+create_file_in_repo()
+{
+	crlf=3D$1
+	txtbin=3D$2
+	create_gitattributes "$txtbin" &&
+	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
+	do
+		pfx=3Dcrlf_${crlf}_attr_${txtbin}_$f.txt &&
+		cp $f $pfx && git -c core.autocrlf=3D$crlf add $pfx
+	done &&
+	git commit -m "core.autocrlf $crlf"
+}
+
+check_files_in_repo()
+{
+	crlf=3D$1
+	txtbin=3D$2
+	lfname=3D$3
+	crlfname=3D$4
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
+	pfx=3Dcrlf_${crlf}_attr_${txtbin}_ &&
+	compare_files $lfname ${pfx}LF.txt &&
+	compare_files $crlfname ${pfx}CRLF.txt &&
+	compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt &&
+	compare_files $lfmixcr ${pfx}LF_mix_CR.txt &&
+	compare_files $crlfnul ${pfx}CRLF_nul.txt
+}
+
+
+check_files_in_ws()
+{
+	eol=3D$1
+	crlf=3D$2
+	txtbin=3D$3
+	lfname=3D$4
+	crlfname=3D$5
+	lfmixcrlf=3D$6
+	lfmixcr=3D$7
+	crlfnul=3D$8
+	create_gitattributes $txtbin &&
+	git config core.autocrlf $crlf &&
+	pfx=3Deol_${eol}_crlf_${crlf}_attr_${txtbin}_ &&
+	src=3Dcrlf_false_attr__ &&
+	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
+	do
+		rm $src$f.txt &&
+		if test -z "$eol"; then
+			git checkout $src$f.txt
+		else
+			git -c core.eol=3D$eol checkout $src$f.txt
+		fi
+	done
+
+
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DLF" "
+		compare_ws_file $pfx $lfname    ${src}LF.txt
+	"
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DCRLF" "
+		compare_ws_file $pfx $crlfname  ${src}CRLF.txt
+	"
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DCRLF_mix_LF" "
+		compare_ws_file $pfx $lfmixcrlf ${src}CRLF_mix_LF.txt
+	"
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DLF_mix_CR" "
+		compare_ws_file $pfx $lfmixcr   ${src}LF_mix_CR.txt
+	"
+	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$txtbin file=3DCRLF_nul" "
+		compare_ws_file $pfx $crlfnul   ${src}CRLF_nul.txt
+	"
+}
+
+#######
+(
+	type od >/dev/null &&
+	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
+	cat >expect <<-EOF &&
+	0000000 l i n e 1 \0 \r \n l i n e 2 \r \n l
+	0000020 i n e 3
+	0000024
+EOF
+	od -c CRLF_nul | sed -e "s/[ 	][	 ]*/ /g" -e "s/ *$//" >actual
+	test_cmp expect actual &&
+	rm expect actual
+) || {
+		skip_all=3D"od not found or od -c not usable"
+		exit 0
+		test_done
+}
+
+test_expect_success 'setup master' '
+	echo >.gitattributes &&
+	git checkout -b master &&
+	git add .gitattributes &&
+	git commit -m "add .gitattributes" "" &&
+	printf "line1\nline2\nline3"     >LF &&
+	printf "line1\r\nline2\r\nline3" >CRLF &&
+	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
+	printf "line1\nline2\rline3"     >LF_mix_CR &&
+	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
+	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul
+'
+#  CRLF_nul had been created above
+
+test_expect_success 'create files' '
+	create_file_in_repo false "" &&
+	create_file_in_repo true  "" &&
+	create_file_in_repo input "" &&
+
+	create_file_in_repo false "auto" &&
+	create_file_in_repo true  "auto" &&
+	create_file_in_repo input "auto" &&
+
+	create_file_in_repo false "text" &&
+	create_file_in_repo true  "text" &&
+	create_file_in_repo input "text" &&
+
+	create_file_in_repo false "-text" &&
+	create_file_in_repo true  "-text" &&
+	create_file_in_repo input "-text" &&
+	rm -f *.txt &&
+	git reset --hard
+'
+
+test_expect_success 'commit empty gitattribues' '
+	check_files_in_repo false ""      LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul &&
+	check_files_in_repo true  ""      LF LF   LF          LF_mix_CR CRLF_=
nul &&
+	check_files_in_repo input ""      LF LF   LF          LF_mix_CR CRLF_=
nul
+'
+
+test_expect_success 'commit text=3Dauto' '
+	check_files_in_repo false "auto"  LF LF   LF          LF_mix_CR CRLF_=
nul &&
+	check_files_in_repo true  "auto"  LF LF   LF          LF_mix_CR CRLF_=
nul &&
+	check_files_in_repo input "auto"  LF LF   LF          LF_mix_CR CRLF_=
nul
+'
+
+test_expect_success 'commit text' '
+	check_files_in_repo false "text"  LF LF   LF          LF_mix_CR LF_nu=
l &&
+	check_files_in_repo true  "text"  LF LF   LF          LF_mix_CR LF_nu=
l &&
+	check_files_in_repo input "text"  LF LF   LF          LF_mix_CR LF_nu=
l
+'
+
+test_expect_success 'commit -text' '
+	check_files_in_repo false "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul &&
+	check_files_in_repo true  "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul &&
+	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul
+'
+
+######################################################################=
##########
+# Check how files in the repo are changed when they are checked out
+# How to read the table below:
+# - check_files_in_ws will check multiple files, see below
+# - parameter $1 : core.eol               lf | crlf
+# - parameter $2 : core.autocrlf          false | true | input
+# - parameter $3 : text in .gitattributs  "" (empty) | auto | text | -=
text
+# - parameter $4 : reference for a file with only LF in the repo
+# - parameter $5 : reference for a file with only CRLF in the repo
+# - parameter $6 : reference for a file with mixed LF and CRLF in the =
repo
+# - parameter $7 : reference for a file with LF and CR in the repo (do=
es somebody uses this ?)
+# - parameter $8 : reference for a file with CRLF and a NUL (should be=
 handled as binary when auto)
+
+check_files_in_ws lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+check_files_in_ws lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+check_files_in_ws lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+check_files_in_ws lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+check_files_in_ws lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+###########
+#core.autocrlf=3Dinput is forbidden with core.eol=3Dcrlf
+check_files_in_ws crlf    false ""        LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws crlf    true  ""        CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+check_files_in_ws crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+check_files_in_ws crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+
+check_files_in_ws crlf    false "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+check_files_in_ws crlf    true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+
+check_files_in_ws crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+if test_have_prereq MINGW
+then
+check_files_in_ws ""      false ""        LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws ""      true  ""        CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws ""      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+check_files_in_ws ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+
+check_files_in_ws native  false ""        LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws native  true  ""        CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws native  true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+check_files_in_ws native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+check_files_in_ws native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+fi
+
+test_done
--=20
2.0.0.9631.g7e872d2
