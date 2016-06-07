From: tboegi@web.de
Subject: [PATCH v2 1/3] convert: unify the "auto" handling of CRLF
Date: Tue,  7 Jun 2016 17:20:48 +0200
Message-ID: <1465312848-4830-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 17:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAIjU-0005Nw-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 17:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbcFGPPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 11:15:53 -0400
Received: from mout.web.de ([212.227.17.12]:54549 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456AbcFGPOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 11:14:14 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MDgDS-1bFEw12Kb8-00H3pI; Tue, 07 Jun 2016 17:14:11
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:YSccz/1tWXNOkBJJi9kQgt2hM5vAaA71CDUELLyvh1wX1dnvGKK
 WyVX91L23nqRR5vcM+OTb8YP38fMX/d5APIT3AdN9x4rnM9/kNslizi6SZaUHT/H2n6+o0z
 iAM1BMado7HuYMgmTHiFIwIQSPQEo9C6QbHY/g+HcfTgC3CVoTk5PKsKYmTXmUzgF3QKXx5
 uwdWKMCatl9Lsiw1qZdPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1cq+ium6SAw=:LhKrNOcV70yfFJx+xf9GwQ
 ow7tl0VBm4Tls+QIYV49to1/0rD8V73yXnAz880SaUT+87gxYyUstoRqkblqAVgtbZplXHO91
 BT4JQVxeRFuvLcyFXDWrfIyQHCVMOJA/CR6wfkUG/xsgU4bMObCsYSTukSU0ZRbmzMNgymVJA
 NW1SrRLb/y0KJkF4MFdoiAsrHg9gRxhtUhEzvOeLHNQDQCYIa836PO9WlhqDHoFa+ovoe2KdA
 b/2zCnthmOZnjX6THqZjUQvbmb9P86Od2g5ejPFKn7iobM9cg5Kw7ULJzjFYJX9HkDCF+UFcS
 7zP0AMwrjjqCn0UoLRIiDPbzZ8UoGlDEwC7482uqHQk3rPXaoHVWFYEoQ55DeUdgTD5VjYFJS
 tczoAEyzqyAKX5/m+LLLGg7Mkj5mBG5pcrjc4+JSGUYLC7PfbivKuB2Ck3zzVEHIQuooyzQY1
 n4Uw2RuVAL88LL/rY02/EgcFkJqPNerDcH0XbABwyZm0yd4CxJURF6A1rMNbUQ0HqX6eF2wxZ
 lMclCbN3I6qpZ1mCkTDEKS3DMFMldepEdRs/QbrNuAEN5LPwMUSwGyys8kdf8ZWcSXRAnIQeM
 zuGUS7W+ry/Otsq5ZjgBJV2kRvG/SxGBSyPEiyVQIs0ZUVcIrScpC4E/UqEvRtr23r9B/yC3d
 9z8qJZGaPseSw3vY+EcbtLV+Qv6PxGnj7P1slJPf6L9MsgpC5nABdHw7Z5WsHSbUmRgXV7E87
 hTnQBLPdQAmc7guUrFixWkTjfRVrbL2PSjXbl46KukRPKk/eBevQVOvau77qMf91LkwC6yFD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296692>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Before this change,
$ echo "* text=3Dauto" >.gitattributes
$ echo "* eol=3Dcrlf" >>.gitattributes

would have the same effect as
$ echo "* text" >.gitattributes
$ git config core.eol crlf

Since the 'eol' attribute had higher priority than 'text=3Dauto', this =
may
corrupt binary files and is not what most users expect to happen.

Make the 'eol' attribute to obey 'text=3Dauto', and now
$ echo "* text=3Dauto" >.gitattributes
$ echo "* eol=3Dcrlf" >>.gitattributes
behaves the same as
$ echo "* text=3Dauto" >.gitattributes
$ git config core.eol crlf

In other words,
$ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
has the same effect as
$ git config core.autocrlf true

and
$ echo "* text=3Dauto eol=3Dlf" >.gitattributes
has the same effect as
$ git config core.autocrlf input

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt        | 12 +++++-------
 Documentation/gitattributes.txt | 15 +++++++++------
 convert.c                       | 42 +++++++++++++++++++++------------=
--------
 convert.h                       |  3 ++-
 t/t0025-crlf-auto.sh            |  4 ++--
 t/t0027-auto-crlf.sh            | 32 +++++++++++++++----------------
 t/t6038-merge-text-auto.sh      | 23 ++++++++++++++--------
 7 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53f00db..208b5de 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -405,13 +405,11 @@ file with mixed line endings would be reported by=
 the `core.safecrlf`
 mechanism.
=20
 core.autocrlf::
-	Setting this variable to "true" is almost the same as setting
-	the `text` attribute to "auto" on all files except that text
-	files are not guaranteed to be normalized: files that contain
-	`CRLF` in the repository will not be touched.  Use this
-	setting if you want to have `CRLF` line endings in your
-	working directory even though the repository does not have
-	normalized line endings.  This variable can be set to 'input',
+	Setting this variable to "true" is the same as setting
+	the `text` attribute to "auto" on all files and core.eol to "crlf".
+	Set to true if you want to have `CRLF` line endings in your
+	working directory and the repository has LF line endings.
+	This variable can be set to 'input',
 	in which case no output conversion is performed.
=20
 core.symlinks::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index e3b1de8..d7a124b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -115,6 +115,7 @@ text file is normalized, its line endings are conve=
rted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
 `core.eol` configuration variable for all text files.
+Note that `core.autocrlf` overrides `core.eol`
=20
 Set::
=20
@@ -130,8 +131,9 @@ Unset::
 Set to string value "auto"::
=20
 	When `text` is set to "auto", the path is marked for automatic
-	end-of-line normalization.  If Git decides that the content is
-	text, its line endings are normalized to LF on checkin.
+	end-of-line conversion.  If Git decides that the content is
+	text, its line endings are converted to LF on checkin.
+	When the file has been commited with CRLF, no conversion is done.
=20
 Unspecified::
=20
@@ -146,7 +148,7 @@ unspecified.
 ^^^^^
=20
 This attribute sets a specific line-ending style to be used in the
-working directory.  It enables end-of-line normalization without any
+working directory.  It enables end-of-line conversion without any
 content checks, effectively setting the `text` attribute.
=20
 Set to string value "crlf"::
@@ -186,9 +188,10 @@ the working directory, and prevent .jpg files from=
 being normalized
 regardless of their content.
=20
 ------------------------
+*               text=3Dauto
 *.txt		text
-*.vcproj	eol=3Dcrlf
-*.sh		eol=3Dlf
+*.vcproj	text eol=3Dcrlf
+*.sh		text eol=3Dlf
 *.jpg		-text
 ------------------------
=20
@@ -198,7 +201,7 @@ normalization in Git.
=20
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working with, you can set the
-config variable "core.autocrlf" without changing any attributes.
+config variable "core.autocrlf" without using any attributes.
=20
 ------------------------
 [core]
diff --git a/convert.c b/convert.c
index b1614bf..67d69b5 100644
--- a/convert.c
+++ b/convert.c
@@ -176,7 +176,9 @@ static enum eol output_eol(enum crlf_action crlf_ac=
tion)
 		return EOL_LF;
 	case CRLF_UNDEFINED:
 	case CRLF_AUTO_CRLF:
+		return EOL_CRLF;
 	case CRLF_AUTO_INPUT:
+		return EOL_LF;
 	case CRLF_TEXT:
 	case CRLF_AUTO:
 		/* fall through */
@@ -254,17 +256,15 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
 			return 0;
-
-		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
-			/*
-			 * If the file in the index has any CR in it, do not convert.
-			 * This is the new safer autocrlf handling.
-			 */
-			if (has_cr_in_index(path))
-				return 0;
-		}
+		/*
+		 * If the file in the index has any CR in it, do not convert.
+		 * This is the new safer autocrlf handling.
+		 */
+		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
+			checksafe =3D SAFE_CRLF_FALSE;
+		else if (has_cr_in_index(path))
+			return 0;
 	}
-
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
=20
 	/* Optimization: No CRLF? Nothing to convert, regardless. */
@@ -320,12 +320,10 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
 		return 0;
=20
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
-		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
-			/* If we have any CR or CRLF line endings, we do not touch it */
-			/* This is the new safer autocrlf-handling */
-			if (stats.lonecr || stats.crlf )
-				return 0;
-		}
+		/* If we have any CR or CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats.lonecr || stats.crlf )
+			return 0;
=20
 		if (convert_is_binary(len, &stats))
 			return 0;
@@ -786,7 +784,11 @@ static void convert_attrs(struct conv_attrs *ca, c=
onst char *path)
 		ca->drv =3D git_path_check_convert(ccheck + 2);
 		if (ca->crlf_action !=3D CRLF_BINARY) {
 			enum eol eol_attr =3D git_path_check_eol(ccheck + 3);
-			if (eol_attr =3D=3D EOL_LF)
+			if (ca->crlf_action =3D=3D CRLF_AUTO && eol_attr =3D=3D EOL_LF)
+				ca->crlf_action =3D CRLF_AUTO_INPUT;
+			else if (ca->crlf_action =3D=3D CRLF_AUTO && eol_attr =3D=3D EOL_CR=
LF)
+				ca->crlf_action =3D CRLF_AUTO_CRLF;
+			else if (eol_attr =3D=3D EOL_LF)
 				ca->crlf_action =3D CRLF_TEXT_INPUT;
 			else if (eol_attr =3D=3D EOL_CRLF)
 				ca->crlf_action =3D CRLF_TEXT_CRLF;
@@ -845,9 +847,9 @@ const char *get_convert_attr_ascii(const char *path=
)
 	case CRLF_AUTO:
 		return "text=3Dauto";
 	case CRLF_AUTO_CRLF:
-		return "text=3Dauto eol=3Dcrlf"; /* This is not supported yet */
+		return "text=3Dauto eol=3Dcrlf";
 	case CRLF_AUTO_INPUT:
-		return "text=3Dauto eol=3Dlf"; /* This is not supported yet */
+		return "text=3Dauto eol=3Dlf";
 	}
 	return "";
 }
@@ -949,7 +951,7 @@ int renormalize_buffer(const char *path, const char=
 *src, size_t len, struct str
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_FALSE);
+	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZ=
E);
 }
=20
 /*****************************************************************
diff --git a/convert.h b/convert.h
index ccf436b..81b6cdf 100644
--- a/convert.h
+++ b/convert.h
@@ -7,7 +7,8 @@
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
 	SAFE_CRLF_FAIL =3D 1,
-	SAFE_CRLF_WARN =3D 2
+	SAFE_CRLF_WARN =3D 2,
+	SAFE_CRLF_RENORMALIZE =3D 4
 };
=20
 extern enum safe_crlf safe_crlf;
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..d0bee08 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -114,7 +114,7 @@ test_expect_success 'autocrlf=3Dtrue does not norma=
lize CRLF files' '
 	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'text=3Dauto, autocrlf=3Dtrue _does_ normalize CRL=
=46 files' '
+test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize C=
RLF files' '
=20
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
@@ -126,7 +126,7 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue _=
does_ normalize CRLF files' '
 	LFonlydiff=3D$(git diff LFonly) &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
 	LFwithNULdiff=3D$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -n "$CRLFonlydiff" -a -z "$LFwithNULdiff"
+	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize b=
inary files' '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 9372589..8367d0b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -175,8 +175,8 @@ attr_ascii () {
 	text,lf)   echo "text eol=3Dlf" ;;
 	text,crlf) echo "text eol=3Dcrlf" ;;
 	auto,)     echo "text=3Dauto" ;;
-	auto,lf)   echo "text eol=3Dlf" ;;
-	auto,crlf) echo "text eol=3Dcrlf" ;;
+	auto,lf)   echo "text=3Dauto eol=3Dlf" ;;
+	auto,crlf) echo "text=3Dauto eol=3Dcrlf" ;;
 	lf,)       echo "text eol=3Dlf" ;;
 	crlf,)     echo "text eol=3Dcrlf" ;;
 	,) echo "" ;;
@@ -397,10 +397,9 @@ commit_chk_wrnNNO ""      ""      false   ""      =
  ""        ""          ""
 commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""      =
    ""          ""
 commit_chk_wrnNNO ""      ""      input   ""        ""        ""      =
    ""          ""
=20
-commit_chk_wrnNNO "auto"  ""      false   "$WILC"   "$WICL"   "$WAMIX"=
    ""          ""
-commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        LF_CRLF =
    ""          ""
-commit_chk_wrnNNO "auto"  ""      input   ""        CRLF_LF   CRLF_LF =
    ""          ""
-
+commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""      =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""      =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""      =
    ""          ""
 for crlf in true false input
 do
 	commit_chk_wrnNNO -text ""      $crlf   ""        ""        ""       =
   ""          ""
@@ -408,8 +407,8 @@ do
 	commit_chk_wrnNNO -text crlf    $crlf   ""        ""        ""       =
   ""          ""
 	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF  =
    ""         CRLF_LF
 	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF  =
   LF_CRLF     ""
-	commit_chk_wrnNNO auto  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
-	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
+	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""        =
  ""          ""
+	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""        =
  ""          ""
 	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
 	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
 done
@@ -454,9 +453,9 @@ do
 	check_in_repo_NNO -text ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO -text lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO -text crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
-	check_in_repo_NNO auto  ""     $crlf   LF  LF    LF           LF_mix_=
CR  CRLF_nul
-	check_in_repo_NNO auto  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
-	check_in_repo_NNO auto  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO auto  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO auto  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO auto  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO text  ""     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
 	check_in_repo_NNO text  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
 	check_in_repo_NNO text  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
@@ -493,7 +492,8 @@ fi
 export CRLF_MIX_LF_CR MIX NL
=20
 # Same handling with and without ident
-for id in "" ident
+#for id in "" ident
+for id in ""
 do
 	for ceol in lf crlf native
 	do
@@ -509,7 +509,7 @@ do
 			checkout_files text  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
 			# currently the same as text, eol=3DXXX
 			checkout_files auto  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
-			checkout_files auto  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
+			checkout_files auto  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
 		done
=20
 		# core.autocrlf false, different core.eol
@@ -517,7 +517,7 @@ do
 		# core.autocrlf true
 		checkout_files   ""    "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
 		# text: core.autocrlf =3D true overrides core.eol
-		checkout_files   auto  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46         LF_mix_CR    LF_nul
+		checkout_files   auto  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
 		checkout_files   text  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46         CRLF_mix_CR  CRLF_nul
 		# text: core.autocrlf =3D input overrides core.eol
 		checkout_files   text  "$id" ""     input   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
@@ -531,8 +531,8 @@ do
 	checkout_files     text  "$id" ""     false   ""       $NL   CRLF  $M=
IX_CRLF_LF $MIX_LF_CR   $LFNUL
 	checkout_files     text  "$id" ""     false   native   $NL   CRLF  $M=
IX_CRLF_LF $MIX_LF_CR   $LFNUL
 	# auto: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
-	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  $M=
IX_CRLF_LF LF_mix_CR    LF_nul
-	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  $M=
IX_CRLF_LF LF_mix_CR    LF_nul
+	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
 done
=20
 # Should be the last test case: remove some files from the worktree
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 85c10b0..33b77ee 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -16,6 +16,13 @@ test_description=3D'CRLF merge conflict across text=3D=
auto change
=20
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=3D-b
=20
+compare_files () {
+	tr '\015\000' QN <"$1" >"$1".expect &&
+	tr '\015\000' QN <"$2" >"$2".actual &&
+	test_cmp "$1".expect "$2".actual &&
+	rm "$1".expect "$2".actual
+}
+
 test_expect_success setup '
 	git config core.autocrlf false &&
=20
@@ -30,7 +37,7 @@ test_expect_success setup '
 	git branch side &&
=20
 	echo "* text=3Dauto" >.gitattributes &&
-	touch file &&
+	echo first line >file &&
 	git add .gitattributes file &&
 	test_tick &&
 	git commit -m "normalize file" &&
@@ -81,7 +88,7 @@ test_expect_success 'Merge after setting text=3Dauto'=
 '
 	rm -f .gitattributes &&
 	git reset --hard a &&
 	git merge b &&
-	test_cmp expected file
+	compare_files expected file
 '
=20
 test_expect_success 'Merge addition of text=3Dauto' '
@@ -99,7 +106,7 @@ test_expect_success 'Merge addition of text=3Dauto' =
'
 	rm -f .gitattributes &&
 	git reset --hard b &&
 	git merge a &&
-	test_cmp expected file
+	compare_files  expected file
 '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
@@ -121,7 +128,7 @@ test_expect_success 'Detect CRLF/LF conflict after =
setting text=3Dauto' '
 	git reset --hard a &&
 	test_must_fail git merge b &&
 	fuzz_conflict file >file.fuzzy &&
-	test_cmp expected file.fuzzy
+	compare_files expected file.fuzzy
 '
=20
 test_expect_success 'Detect LF/CRLF conflict from addition of text=3Da=
uto' '
@@ -143,7 +150,7 @@ test_expect_success 'Detect LF/CRLF conflict from a=
ddition of text=3Dauto' '
 	git reset --hard b &&
 	test_must_fail git merge a &&
 	fuzz_conflict file >file.fuzzy &&
-	test_cmp expected file.fuzzy
+	compare_files expected file.fuzzy
 '
=20
 test_expect_failure 'checkout -m after setting text=3Dauto' '
@@ -158,7 +165,7 @@ test_expect_failure 'checkout -m after setting text=
=3Dauto' '
 	git reset --hard initial &&
 	git checkout a -- . &&
 	git checkout -m b &&
-	test_cmp expected file
+	compare_files expected file
 '
=20
 test_expect_failure 'checkout -m addition of text=3Dauto' '
@@ -173,7 +180,7 @@ test_expect_failure 'checkout -m addition of text=3D=
auto' '
 	git reset --hard initial &&
 	git checkout b -- . &&
 	git checkout -m a &&
-	test_cmp expected file
+	compare_files expected file
 '
=20
 test_expect_failure 'cherry-pick patch from after text=3Dauto was adde=
d' '
@@ -187,7 +194,7 @@ test_expect_failure 'cherry-pick patch from after t=
ext=3Dauto was added' '
 	git reset --hard b &&
 	test_must_fail git cherry-pick a >err 2>&1 &&
 	grep "[Nn]othing added" err &&
-	test_cmp expected file
+	compare_files expected file
 '
=20
 test_expect_success 'Test delete/normalize conflict' '
--=20
2.0.0.rc1.6318.g0c2c796
