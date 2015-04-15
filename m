From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 2/3] t0027: Adapt check_warning() to MINGW
Date: Wed, 15 Apr 2015 19:00:47 +0200
Message-ID: <552E993F.6030201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 19:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQgN-0007wo-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbbDORAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 13:00:51 -0400
Received: from mout.web.de ([212.227.17.11]:51382 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803AbbDORAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:00:49 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lu4q2-1ZOkWH3Mdq-011OYn; Wed, 15 Apr 2015 19:00:47
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:YYkA2uCLB6xkYc1uxKB3iDoaZuFDvuHpVYxFQE11/7ryGSrTqDL
 hS1ofU9qp2m0UzwspN8onN4LF2q3a6ojR00l6H1npe+gJPOd8O1EC1TMAGbi4QWSmhjHmGd
 sGTWYpgIxb2gmuE2/RcM2SDrDHBNc54pHiQIZwK/LOjCsI1qIv15hecwI7+/7LRWWM0k4fD
 3un4btxM/svkFByH5K9xg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267219>

When running under MINGW, the native line ending is CRLF and not LF.
Adjust the check of the warnings with macros:
  WLC:  LF become CRLF on non-MINGW
  WCL:  CRLF become LF on non-MINGW
  WMIX: Mixed line endings: either CRLF->LF or LF->CRLF

Improve the information given by check_warning():
Use test_cmp to show which warning is missing (or should'n t be there)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 5858397..59dfe02 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -57,15 +57,13 @@ create_gitattributes () {
=20
 check_warning () {
 	case "$1" in
-	LF_CRLF) grep "LF will be replaced by CRLF" $2;;
-	CRLF_LF) grep "CRLF will be replaced by LF" $2;;
-	'')
-		>expect
-		grep "will be replaced by" $2 >actual
-		test_cmp expect actual
-		;;
-	*) false ;;
+	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
+	CRLF_LF) echo "warning: CRLF will be replaced by LF" >"$2".expect ;;
+	'')	                                                 >"$2".expect ;;
+	*) echo >&2 "Illegal 1": "$1" ; return false ;;
 	esac
+	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" >"$=
2".actual
+	test_cmp "$2".expect "$2".actual
 }
=20
 commit_check_warn () {
@@ -169,6 +167,17 @@ test_expect_success 'setup master' '
 warn_LF_CRLF=3D"LF will be replaced by CRLF"
 warn_CRLF_LF=3D"CRLF will be replaced by LF"
=20
+if test_have_prereq MINGW
+then
+WLC=3DLF_CRLF
+WCL=3D
+WMIX=3DLF_CRLF
+else
+WLC=3D
+WCL=3DCRLF_LF
+WMIX=3DCRLF_LF
+fi
+
 test_expect_success 'commit files empty attr' '
 	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
 	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
@@ -176,13 +185,13 @@ test_expect_success 'commit files empty attr' '
 '
=20
 test_expect_success 'commit files attr=3Dauto' '
-	commit_check_warn false "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  "" &&
+	commit_check_warn false "auto" "$WLC"    "$WCL"    "$WMIX"   ""      =
  "" &&
 	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
 	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
 '
=20
 test_expect_success 'commit files attr=3Dtext' '
-	commit_check_warn false "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF" &&
+	commit_check_warn false "text" "$WLC"    "$WCL"    "$WMIX"   "$WLC"  =
  "$WCL" &&
 	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        &&
 	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF"
 '
--=20
2.2.0.rc1.790.ge19fcd2
