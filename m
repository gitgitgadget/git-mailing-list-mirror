From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH RFC] t0027: check the eol conversion warnings
Date: Thu, 20 Nov 2014 22:29:10 +0100
Message-ID: <546E5D26.8030109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 22:29:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZI6-0000XX-EK
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbaKTV3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014 16:29:15 -0500
Received: from mout.web.de ([212.227.17.11]:52991 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758185AbaKTV3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:29:13 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MQelV-1XO64A29cb-00U4LN; Thu, 20 Nov 2014 22:29:11
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:5nmGcKO3SjyQg+SHEO7EGxqLKnwTjYvgbbKhqb7tBcO3bMyPhMO
 JjbBx/fUmmN1rWzrbQCL+ugpk/1Uk4pQdyTj2TNoqd7abkvnWyeYKEUkDOGwezOlaP5WdS9
 jM7c4MxQRuQ3v8d7V+zQxfxcyd7Ra/ho0qsJETjeMAjerdusc8BE7OXwDVEMwjuuAm4451Z
 +SImnUnIY2e6RQh8fElUw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to check the warnings when adding file with eol=3Dlf and eol=3D=
crlf.

Add a function check_warning() to check the warnings on stderr
"CRLF will be replaced..." or "LF will be replaced..."

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 103 +++++++++++++++++++++++++++++++++++++++----=
--------
 1 file changed, 80 insertions(+), 23 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2a4a6c1..9570947 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -55,16 +55,36 @@ create_gitattributes () {
 	esac
 }
=20
-create_file_in_repo () {
+check_warning () {
+	case "$1" in
+	LF_CRLF) grep "LF will be replaced by CRLF" $2;;
+	CRLF_LF) grep "CRLF will be replaced by LF" $2;;
+	*) test_cmp /dev/null $2;;
+	esac
+}
+
+add_check_warn () {
 	crlf=3D$1
 	attr=3D$2
+	lfname=3D$3
+	crlfname=3D$4
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
 	create_gitattributes "$attr" &&
+	pfx=3Dcrlf_${crlf}_attr_${attr}
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
 	do
-		pfx=3Dcrlf_${crlf}_attr_${attr}_$f.txt &&
-		cp $f $pfx && git -c core.autocrlf=3D$crlf add $pfx
+		fname=3D${pfx}_$f.txt &&
+		cp $f $fname &&
+		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
 	done &&
-	git commit -m "core.autocrlf $crlf"
+	git commit -m "core.autocrlf $crlf" &&
+	check_warning "$lfname" ${pfx}_LF.err &&
+	check_warning "$crlfname" ${pfx}_CRLF.err &&
+	check_warning "$lfmixcrlf" ${pfx}_LF_mix_CR.err &&
+	check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err &&
+	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 }
=20
 check_files_in_repo () {
@@ -140,50 +160,87 @@ test_expect_success 'setup master' '
 '
=20
=20
-test_expect_success 'create files' '
-	create_file_in_repo false "" &&
-	create_file_in_repo true  "" &&
-	create_file_in_repo input "" &&
=20
-	create_file_in_repo false "auto" &&
-	create_file_in_repo true  "auto" &&
-	create_file_in_repo input "auto" &&
+warn_LF_CRLF=3D"LF will be replaced by CRLF"
+warn_CRLF_LF=3D"CRLF will be replaced by LF"
+
+test_expect_success 'add files empty attr' '
+	add_check_warn false ""     ""        ""        ""        ""        "=
" &&
+	add_check_warn true  ""     "LF_CRLF" ""        ""        ""        "=
" &&
+	add_check_warn input ""     ""        "CRLF_LF" ""        ""        "=
"
+'
=20
-	create_file_in_repo false "text" &&
-	create_file_in_repo true  "text" &&
-	create_file_in_repo input "text" &&
+test_expect_success 'add files attr=3Dauto' '
+	add_check_warn false "auto" ""        "CRLF_LF" ""        ""        "=
" &&
+	add_check_warn true  "auto" "LF_CRLF" ""        ""        ""        "=
" &&
+	add_check_warn input "auto" ""        "CRLF_LF" ""        ""        "=
"
+'
=20
-	create_file_in_repo false "-text" &&
-	create_file_in_repo true  "-text" &&
-	create_file_in_repo input "-text" &&
+test_expect_success 'add files attr=3Dtext' '
+	add_check_warn false "text" ""        "CRLF_LF" ""        ""        "=
CRLF_LF" &&
+	add_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" "=
"        &&
+	add_check_warn input "text" ""        "CRLF_LF" ""        ""        "=
CRLF_LF"
+'
+
+test_expect_success 'add files attr=3D-text' '
+	add_check_warn false "-text" ""       ""        ""        ""        "=
" &&
+	add_check_warn true  "-text" ""       ""        ""        ""        "=
" &&
+	add_check_warn input "-text" ""       ""        ""        ""        "=
"
+'
+
+test_expect_success 'add files attr=3Dlf' '
+	add_check_warn false "lf"    ""       "CRLF_LF" ""         ""       "=
CRLF_LF" &&
+	add_check_warn true  "lf"    ""       "CRLF_LF" ""         ""       "=
CRLF_LF" &&
+	add_check_warn input "lf"    ""       "CRLF_LF" ""         ""       "=
CRLF_LF"
+'
+
+test_expect_success 'add files attr=3Dcrlf' '
+	add_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" "=
" &&
+	add_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" "=
" &&
+	add_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" "=
"
+'
+
+test_expect_success 'create files cleanup' '
 	rm -f *.txt &&
 	git reset --hard
 '
=20
-test_expect_success 'commit empty gitattribues' '
+test_expect_success 'check file in repo empty gitattribues' '
 	check_files_in_repo false ""      LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul &&
 	check_files_in_repo true  ""      LF LF   LF          LF_mix_CR CRLF_=
nul &&
 	check_files_in_repo input ""      LF LF   LF          LF_mix_CR CRLF_=
nul
 '
=20
-test_expect_success 'commit text=3Dauto' '
+test_expect_success 'check file in repo text=3Dauto' '
 	check_files_in_repo false "auto"  LF LF   LF          LF_mix_CR CRLF_=
nul &&
 	check_files_in_repo true  "auto"  LF LF   LF          LF_mix_CR CRLF_=
nul &&
 	check_files_in_repo input "auto"  LF LF   LF          LF_mix_CR CRLF_=
nul
 '
=20
-test_expect_success 'commit text' '
+test_expect_success 'check file in repo text' '
 	check_files_in_repo false "text"  LF LF   LF          LF_mix_CR LF_nu=
l &&
 	check_files_in_repo true  "text"  LF LF   LF          LF_mix_CR LF_nu=
l &&
 	check_files_in_repo input "text"  LF LF   LF          LF_mix_CR LF_nu=
l
 '
=20
-test_expect_success 'commit -text' '
+test_expect_success 'check file in repo -text' '
 	check_files_in_repo false "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul &&
 	check_files_in_repo true  "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul &&
 	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul
 '
=20
+test_expect_success 'check file in repo lf' '
+	check_files_in_repo false "lf"    LF LF   LF          LF_mix_CR LF_nu=
l &&
+	check_files_in_repo true  "lf"    LF LF   LF          LF_mix_CR LF_nu=
l &&
+	check_files_in_repo input "lf"    LF LF   LF          LF_mix_CR LF_nu=
l
+'
+
+test_expect_success 'check file in repo crlf' '
+	check_files_in_repo false "crlf"  LF LF   LF          LF_mix_CR LF_nu=
l &&
+	check_files_in_repo true  "crlf"  LF LF   LF          LF_mix_CR LF_nu=
l &&
+	check_files_in_repo input "crlf"  LF LF   LF          LF_mix_CR LF_nu=
l
+'
+
 ######################################################################=
##########
 # Check how files in the repo are changed when they are checked out
 # How to read the table below:
@@ -199,8 +256,8 @@ test_expect_success 'commit -text' '
 # - parameter $8 : reference for a file with CRLF and a NUL (should be=
 handled as binary when auto)
=20
 #                                            What we have in the repo:
-#                														 ----------------- EOL in repo --------=
--------
-#                														 LF    CRLF  CRLF_mix_LF  LF_mix_CR    =
CRLF_nul
+#                                            ----------------- EOL in =
repo ----------------
+#                                            LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
 #                   settings with checkout:
 #                   core.   core.   .gitattr
 #                    eol     acrlf
--=20
1.9.1.dirty
