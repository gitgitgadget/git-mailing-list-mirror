From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2] t0027: check the eol conversion warnings
Date: Sun, 30 Nov 2014 21:15:52 +0100
Message-ID: <547B7AF8.80700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 21:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvAvB-00045N-Kz
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 21:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaK3UP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 15:15:56 -0500
Received: from mout.web.de ([212.227.17.12]:58600 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaK3UPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 15:15:55 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MIvbh-1Xsh041FBh-002WcD; Sun, 30 Nov 2014 21:15:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:wpvj3jWRrONonnwt6iqIVMr1k7YKEXxjWGo1EmCUwjmLEl5qMjy
 VdW/Xx40rXwbYZUmd5bGshqGwdWxlQnQbQ28lvIshqtFhLf9zhnDIE6eUqKh6j2vdAbTxqy
 RDVxfEiGalS8irLvvUJSRNfyPSTJH/FNYp+bjpMI0BlnO2pTNsQZ8iZGo/5NWFj9IHtHxJ8
 HqtAdCY2RNnwZaxcjwuYg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260454>

Depending on the file content, eol parameters and .gitattributes
"git add" may give a warning when the eol of a file will change
when the file is checked out again.

There are 2 different warnings, either "CRLF will be replaced..." or
"LF will be replaced...".

Let t0027 check for these warnings:
call create_file_in_repo() with additional parameters,
which will be used to call check_warning().

When a file has eol=3Dlf or eol=3Dcrlf in .gitattributes, it is handled
as text and should be normalized.
Add missing test cases in t0027.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since V1:
- Simplified the diff
- Fixed a bug (LF_mix_CR.err was mixed with CRLF_mix_LF)
- Changed the commit message
 t/t0027-auto-crlf.sh | 82 ++++++++++++++++++++++++++++++++++++++++++--=
--------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2a4a6c1..452320d 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -55,16 +55,41 @@ create_gitattributes () {
 	esac
 }
=20
+check_warning () {
+	case "$1" in
+	LF_CRLF) grep "LF will be replaced by CRLF" $2;;
+	CRLF_LF) grep "CRLF will be replaced by LF" $2;;
+	'')
+		>expect
+		grep "will be replaced by" $2 >actual
+		test_cmp expect actual
+		;;
+	*) false ;;
+	esac
+}
+
 create_file_in_repo () {
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
+	check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err &&
+	check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err &&
+	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 }
=20
 check_files_in_repo () {
@@ -140,22 +165,47 @@ test_expect_success 'setup master' '
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
+	create_file_in_repo false ""     ""        ""        ""        ""    =
    "" &&
+	create_file_in_repo true  ""     "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
+	create_file_in_repo input ""     ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
+'
+
+test_expect_success 'add files attr=3Dauto' '
+	create_file_in_repo false "auto" ""        "CRLF_LF" "CRLF_LF" ""    =
    "" &&
+	create_file_in_repo true  "auto" "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
+	create_file_in_repo input "auto" ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
+'
+
+test_expect_success 'add files attr=3Dtext' '
+	create_file_in_repo false "text" ""        "CRLF_LF" "CRLF_LF" ""    =
    "CRLF_LF" &&
+	create_file_in_repo true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""        &&
+	create_file_in_repo input "text" ""        "CRLF_LF" "CRLF_LF" ""    =
    "CRLF_LF"
+'
+
+test_expect_success 'add files attr=3D-text' '
+	create_file_in_repo false "-text" ""       ""        ""        ""    =
    "" &&
+	create_file_in_repo true  "-text" ""       ""        ""        ""    =
    "" &&
+	create_file_in_repo input "-text" ""       ""        ""        ""    =
    ""
+'
+
+test_expect_success 'add files attr=3Dlf' '
+	create_file_in_repo false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF" &&
+	create_file_in_repo true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF" &&
+	create_file_in_repo input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF"
+'
=20
-	create_file_in_repo false "text" &&
-	create_file_in_repo true  "text" &&
-	create_file_in_repo input "text" &&
+test_expect_success 'add files attr=3Dcrlf' '
+	create_file_in_repo false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
+	create_file_in_repo true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
+	create_file_in_repo input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
+'
=20
-	create_file_in_repo false "-text" &&
-	create_file_in_repo true  "-text" &&
-	create_file_in_repo input "-text" &&
+test_expect_success 'create files cleanup' '
 	rm -f *.txt &&
 	git reset --hard
 '
--=20
1.9.1.dirty
