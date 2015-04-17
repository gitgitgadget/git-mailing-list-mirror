From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 2/2]  t0027: Support NATIVE_CRLF
Date: Fri, 17 Apr 2015 17:44:05 +0200
Message-ID: <55312A45.8060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 17:44:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj8RD-0008Lo-FR
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 17:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933752AbbDQPoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 11:44:10 -0400
Received: from mout.web.de ([212.227.15.4]:64595 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933375AbbDQPoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 11:44:07 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LbroC-1ZAk1i06y4-00jF1m; Fri, 17 Apr 2015 17:44:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:gm7Obf3B1w/5sPixo4bC3a6PIn5qbpFdMom3I0c36wh2lWmcaZY
 s8s4ab447570Co4KoFXYmS+RvtVJPHDWFa/3nbIfIeKUrBUdVwZV4GLBJLKt5DEWjNBxoAq
 r1/jGMvImNNpFYUj369WdVbi5GdX2hpHiRidWCiRtzmWi830GHEgcmX3E4MTGJShP8fO+Wd
 vkogtwEpIWdNt8ZydeHNw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267363>

Without this patch, t0027 expects the native end-of-lines to be a singl=
e
line feed character. On Windows, however, we set it to a carriage retur=
n
character followed by a line feed character. Thus, we have to modify
t0027 to expect different warnings depending on the end-of-line markers=
=2E

Adjust the check of the warnings and use these macros:
  WILC:  Warn if LF becomes CRLF
  WICL:  Warn if CRLF becomes LF
  WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF

Improve the information given by check_warning():
Use test_cmp to show which warning is missing (or should'n t be there)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 5858397..8975b97 100755
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
@@ -169,6 +167,18 @@ test_expect_success 'setup master' '
 warn_LF_CRLF=3D"LF will be replaced by CRLF"
 warn_CRLF_LF=3D"CRLF will be replaced by LF"
=20
+#WILC means "Warn if (this OS) converts LF into CRLF"
+if test_have_prereq NATIVE_CRLF
+then
+WILC=3DLF_CRLF
+WICL=3D
+WAMIX=3DLF_CRLF
+else
+WILC=3D
+WICL=3DCRLF_LF
+WAMIX=3DCRLF_LF
+fi
+
 test_expect_success 'commit files empty attr' '
 	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
 	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
@@ -176,13 +186,13 @@ test_expect_success 'commit files empty attr' '
 '
=20
 test_expect_success 'commit files attr=3Dauto' '
-	commit_check_warn false "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  "" &&
+	commit_check_warn false "auto" "$WILC"  "$WICL"    "$WAMIX"  ""      =
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
+	commit_check_warn false "text" "$WILC"  "$WICL"    "$WAMIX"  "$WILC" =
 "$WICL" &&
 	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        &&
 	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF"
 '
--=20
2.2.0.rc1.790.ge19fcd2
