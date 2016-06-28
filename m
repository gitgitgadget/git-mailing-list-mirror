Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382E61FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 07:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbcF1Hxe (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 03:53:34 -0400
Received: from mout.web.de ([212.227.15.3]:50027 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbcF1Hxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 03:53:33 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MP2Sl-1bEFC92t5L-006M9l; Tue, 28 Jun 2016 09:53:30
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/3] convert: unify the "auto" handling of CRLF
Date:	Tue, 28 Jun 2016 10:01:13 +0200
Message-Id: <1467100873-2725-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:o+zPVV+T5LiCbPmJg+8z5PYfeUfxclwxpOBemGjbzJdeYPHzRcB
 F37er3/mPd0h/897U90e7+uDarpNAP0B5T5KoUJ7lGHwVv37wmtE3BLylgDYgA3HZLWx5Xi
 UgOew9aiQ1FE9tBJrcWU8TWU60+wyuIK3SS/GjZ6aIBy0kES04Oz9BxtPZHah+3k8FhHhgV
 cqfn5ZUa0+aHhMG0fOVXA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:hmr2KEgN24E=:Io9TNoJmLnU97F28vWHvJQ
 tbuXENJ2NRtO1cU+FzAQuVX2xSLy4J0vuumMoj1PWnWfosT8WcRAKDSjeLWloWsJ/LwZuhfni
 +cj03yJzZvYIslHOWGZ7gdglyQv9Aa8Lc1pcHEaVFeF0+adxNt1s7PPTRSgLN8WCeMUYZh/M8
 2uW7LoP23FjnJrbrXJhg+Ls5+hYeukOa8ueTJYUQjQidfN8sfwdSZlZqZPzSrqT9xNJop3UVj
 BQvmAyW0WjBT9A50b8JCJ/1jFNQtj0FAmrASMUvsmgk93wtz9yTAi74VfrXcjdH2EBLRtOsp2
 GqSGovYCetw1gppkzKv5or/hNs5gzjBogt6Rn+htX0yKGcN5NeCOdctjLti07NH/ik+uk3ddM
 w24NcKkFuoAHBg3L9uAFCjn3gg6loQuwtmLoL3K1mV+fUdm/49Xqzy3qUyhGq//fgHp1wQ9Zf
 9jlMmXPo2LrDy+II6pzucemXjBngjHJ9cuor2z/MYpB8M7pFnN9A+nFZK+d5jjBCkoP5qHpDF
 /sdPFFtiR9wgwPgKJ2eKZHLTyBGo37w1JhdcCVJOK5nw9+mOxGhyckyYY7BeZSNugQfv5sYc/
 xCjXWRwAx/Wy2PAd8+v11OdRGOoQ83KT0GX5C+IzPHTYVZLOJgcRZkUSbeC1fpAQ18D3qc53M
 YQz71bdluV5thh/AgiueswEq2CWqjziiDGbTyqdLzHzA0FxW6vx2EARUzaYbtxmKrC+4A6W+n
 douWWzjHGKrsIXV8926JkWTW98PBUc9PbzJFmQ7H7EonKH8c3Noq9giWQE5kXL8fxCE2g8ZnJ
 nl446g1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Before this change,
$ echo "* text=auto" >.gitattributes
$ echo "* eol=crlf" >>.gitattributes

would have the same effect as
$ echo "* text" >.gitattributes
$ git config core.eol crlf

Since the 'eol' attribute had higher priority than 'text=auto', this may
corrupt binary files and is not what most users expect to happen.

Make the 'eol' attribute to obey 'text=auto' and now
$ echo "* text=auto" >.gitattributes
$ echo "* eol=crlf" >>.gitattributes
behaves the same as
$ echo "* text=auto" >.gitattributes
$ git config core.eol crlf

In other words,
$ echo "* text=auto eol=crlf" >.gitattributes
has the same effect as
$ git config core.autocrlf true

and
$ echo "* text=auto eol=lf" >.gitattributes
has the same effect as
$ git config core.autocrlf input

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/config.txt        | 12 +++++-------
 Documentation/gitattributes.txt | 15 +++++++++------
 convert.c                       | 42 +++++++++++++++++++++--------------------
 convert.h                       |  3 ++-
 t/t0025-crlf-auto.sh            |  4 ++--
 t/t0027-auto-crlf.sh            | 29 ++++++++++++++--------------
 t/t6038-merge-text-auto.sh      | 23 ++++++++++++++--------
 7 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4a27ad4..62ade8b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,13 +389,11 @@ file with mixed line endings would be reported by the `core.safecrlf`
 mechanism.
 
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
 
 core.symlinks::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..d7a124b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -115,6 +115,7 @@ text file is normalized, its line endings are converted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
 `core.eol` configuration variable for all text files.
+Note that `core.autocrlf` overrides `core.eol`
 
 Set::
 
@@ -130,8 +131,9 @@ Unset::
 Set to string value "auto"::
 
 	When `text` is set to "auto", the path is marked for automatic
-	end-of-line normalization.  If Git decides that the content is
-	text, its line endings are normalized to LF on checkin.
+	end-of-line conversion.  If Git decides that the content is
+	text, its line endings are converted to LF on checkin.
+	When the file has been commited with CRLF, no conversion is done.
 
 Unspecified::
 
@@ -146,7 +148,7 @@ unspecified.
 ^^^^^
 
 This attribute sets a specific line-ending style to be used in the
-working directory.  It enables end-of-line normalization without any
+working directory.  It enables end-of-line conversion without any
 content checks, effectively setting the `text` attribute.
 
 Set to string value "crlf"::
@@ -186,9 +188,10 @@ the working directory, and prevent .jpg files from being normalized
 regardless of their content.
 
 ------------------------
+*               text=auto
 *.txt		text
-*.vcproj	eol=crlf
-*.sh		eol=lf
+*.vcproj	text eol=crlf
+*.sh		text eol=lf
 *.jpg		-text
 ------------------------
 
@@ -198,7 +201,7 @@ normalization in Git.
 
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working with, you can set the
-config variable "core.autocrlf" without changing any attributes.
+config variable "core.autocrlf" without using any attributes.
 
 ------------------------
 [core]
diff --git a/convert.c b/convert.c
index b1614bf..67d69b5 100644
--- a/convert.c
+++ b/convert.c
@@ -176,7 +176,9 @@ static enum eol output_eol(enum crlf_action crlf_action)
 		return EOL_LF;
 	case CRLF_UNDEFINED:
 	case CRLF_AUTO_CRLF:
+		return EOL_CRLF;
 	case CRLF_AUTO_INPUT:
+		return EOL_LF;
 	case CRLF_TEXT:
 	case CRLF_AUTO:
 		/* fall through */
@@ -254,17 +256,15 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
 			return 0;
-
-		if (crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
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
+		if (checksafe == SAFE_CRLF_RENORMALIZE)
+			checksafe = SAFE_CRLF_FALSE;
+		else if (has_cr_in_index(path))
+			return 0;
 	}
-
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
 
 	/* Optimization: No CRLF? Nothing to convert, regardless. */
@@ -320,12 +320,10 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 		return 0;
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
-		if (crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
-			/* If we have any CR or CRLF line endings, we do not touch it */
-			/* This is the new safer autocrlf-handling */
-			if (stats.lonecr || stats.crlf )
-				return 0;
-		}
+		/* If we have any CR or CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats.lonecr || stats.crlf )
+			return 0;
 
 		if (convert_is_binary(len, &stats))
 			return 0;
@@ -786,7 +784,11 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		ca->drv = git_path_check_convert(ccheck + 2);
 		if (ca->crlf_action != CRLF_BINARY) {
 			enum eol eol_attr = git_path_check_eol(ccheck + 3);
-			if (eol_attr == EOL_LF)
+			if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
+				ca->crlf_action = CRLF_AUTO_INPUT;
+			else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_CRLF)
+				ca->crlf_action = CRLF_AUTO_CRLF;
+			else if (eol_attr == EOL_LF)
 				ca->crlf_action = CRLF_TEXT_INPUT;
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
@@ -845,9 +847,9 @@ const char *get_convert_attr_ascii(const char *path)
 	case CRLF_AUTO:
 		return "text=auto";
 	case CRLF_AUTO_CRLF:
-		return "text=auto eol=crlf"; /* This is not supported yet */
+		return "text=auto eol=crlf";
 	case CRLF_AUTO_INPUT:
-		return "text=auto eol=lf"; /* This is not supported yet */
+		return "text=auto eol=lf";
 	}
 	return "";
 }
@@ -949,7 +951,7 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_FALSE);
+	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index ccf436b..82871a1 100644
--- a/convert.h
+++ b/convert.h
@@ -7,7 +7,8 @@
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2
+	SAFE_CRLF_WARN = 2,
+	SAFE_CRLF_RENORMALIZE = 3
 };
 
 extern enum safe_crlf safe_crlf;
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..d0bee08 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -114,7 +114,7 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
 
-test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
+test_expect_success 'text=auto, autocrlf=true does not normalize CRLF files' '
 
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
@@ -126,7 +126,7 @@ test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
 	LFonlydiff=$(git diff LFonly) &&
 	CRLFonlydiff=$(git diff CRLFonly) &&
 	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -n "$CRLFonlydiff" -a -z "$LFwithNULdiff"
+	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
 
 test_expect_success 'text=auto, autocrlf=true does not normalize binary files' '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 9372589..2860d2d 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -175,8 +175,8 @@ attr_ascii () {
 	text,lf)   echo "text eol=lf" ;;
 	text,crlf) echo "text eol=crlf" ;;
 	auto,)     echo "text=auto" ;;
-	auto,lf)   echo "text eol=lf" ;;
-	auto,crlf) echo "text eol=crlf" ;;
+	auto,lf)   echo "text=auto eol=lf" ;;
+	auto,crlf) echo "text=auto eol=crlf" ;;
 	lf,)       echo "text eol=lf" ;;
 	crlf,)     echo "text eol=crlf" ;;
 	,) echo "" ;;
@@ -397,10 +397,9 @@ commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""
 commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
 commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
 
-commit_chk_wrnNNO "auto"  ""      false   "$WILC"   "$WICL"   "$WAMIX"    ""          ""
-commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        LF_CRLF     ""          ""
-commit_chk_wrnNNO "auto"  ""      input   ""        CRLF_LF   CRLF_LF     ""          ""
-
+commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""          ""          ""
+commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
+commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""
 for crlf in true false input
 do
 	commit_chk_wrnNNO -text ""      $crlf   ""        ""        ""          ""          ""
@@ -408,8 +407,8 @@ do
 	commit_chk_wrnNNO -text crlf    $crlf   ""        ""        ""          ""          ""
 	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF      ""         CRLF_LF
 	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
-	commit_chk_wrnNNO auto  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
-	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
+	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""          ""          ""
+	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""          ""          ""
 	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
 	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 done
@@ -454,9 +453,9 @@ do
 	check_in_repo_NNO -text ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
 	check_in_repo_NNO -text lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
 	check_in_repo_NNO -text crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO auto  ""     $crlf   LF  LF    LF           LF_mix_CR  CRLF_nul
-	check_in_repo_NNO auto  lf     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
-	check_in_repo_NNO auto  crlf   $crlf   LF  LF    LF           LF_mix_CR  LF_nul
+	check_in_repo_NNO auto  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_NNO auto  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_NNO auto  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
 	check_in_repo_NNO text  ""     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
 	check_in_repo_NNO text  lf     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
 	check_in_repo_NNO text  crlf   $crlf   LF  LF    LF           LF_mix_CR  LF_nul
@@ -509,7 +508,7 @@ do
 			checkout_files text  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 			# currently the same as text, eol=XXX
 			checkout_files auto  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
-			checkout_files auto  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
+			checkout_files auto  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 		done
 
 		# core.autocrlf false, different core.eol
@@ -517,7 +516,7 @@ do
 		# core.autocrlf true
 		checkout_files   ""    "$id" ""     true    "$ceol"  CRLF  CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 		# text: core.autocrlf = true overrides core.eol
-		checkout_files   auto  "$id" ""     true    "$ceol"  CRLF  CRLF  CRLF         LF_mix_CR    LF_nul
+		checkout_files   auto  "$id" ""     true    "$ceol"  CRLF  CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 		checkout_files   text  "$id" ""     true    "$ceol"  CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 		# text: core.autocrlf = input overrides core.eol
 		checkout_files   text  "$id" ""     input   "$ceol"  LF    CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
@@ -531,8 +530,8 @@ do
 	checkout_files     text  "$id" ""     false   ""       $NL   CRLF  $MIX_CRLF_LF $MIX_LF_CR   $LFNUL
 	checkout_files     text  "$id" ""     false   native   $NL   CRLF  $MIX_CRLF_LF $MIX_LF_CR   $LFNUL
 	# auto: core.autocrlf=false and core.eol unset(or native) uses native eol
-	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  $MIX_CRLF_LF LF_mix_CR    LF_nul
-	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  $MIX_CRLF_LF LF_mix_CR    LF_nul
+	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 done
 
 # Should be the last test case: remove some files from the worktree
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 85c10b0..33b77ee 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -16,6 +16,13 @@ test_description='CRLF merge conflict across text=auto change
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
 
+compare_files () {
+	tr '\015\000' QN <"$1" >"$1".expect &&
+	tr '\015\000' QN <"$2" >"$2".actual &&
+	test_cmp "$1".expect "$2".actual &&
+	rm "$1".expect "$2".actual
+}
+
 test_expect_success setup '
 	git config core.autocrlf false &&
 
@@ -30,7 +37,7 @@ test_expect_success setup '
 	git branch side &&
 
 	echo "* text=auto" >.gitattributes &&
-	touch file &&
+	echo first line >file &&
 	git add .gitattributes file &&
 	test_tick &&
 	git commit -m "normalize file" &&
@@ -81,7 +88,7 @@ test_expect_success 'Merge after setting text=auto' '
 	rm -f .gitattributes &&
 	git reset --hard a &&
 	git merge b &&
-	test_cmp expected file
+	compare_files expected file
 '
 
 test_expect_success 'Merge addition of text=auto' '
@@ -99,7 +106,7 @@ test_expect_success 'Merge addition of text=auto' '
 	rm -f .gitattributes &&
 	git reset --hard b &&
 	git merge a &&
-	test_cmp expected file
+	compare_files  expected file
 '
 
 test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
@@ -121,7 +128,7 @@ test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
 	git reset --hard a &&
 	test_must_fail git merge b &&
 	fuzz_conflict file >file.fuzzy &&
-	test_cmp expected file.fuzzy
+	compare_files expected file.fuzzy
 '
 
 test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
@@ -143,7 +150,7 @@ test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
 	git reset --hard b &&
 	test_must_fail git merge a &&
 	fuzz_conflict file >file.fuzzy &&
-	test_cmp expected file.fuzzy
+	compare_files expected file.fuzzy
 '
 
 test_expect_failure 'checkout -m after setting text=auto' '
@@ -158,7 +165,7 @@ test_expect_failure 'checkout -m after setting text=auto' '
 	git reset --hard initial &&
 	git checkout a -- . &&
 	git checkout -m b &&
-	test_cmp expected file
+	compare_files expected file
 '
 
 test_expect_failure 'checkout -m addition of text=auto' '
@@ -173,7 +180,7 @@ test_expect_failure 'checkout -m addition of text=auto' '
 	git reset --hard initial &&
 	git checkout b -- . &&
 	git checkout -m a &&
-	test_cmp expected file
+	compare_files expected file
 '
 
 test_expect_failure 'cherry-pick patch from after text=auto was added' '
@@ -187,7 +194,7 @@ test_expect_failure 'cherry-pick patch from after text=auto was added' '
 	git reset --hard b &&
 	test_must_fail git cherry-pick a >err 2>&1 &&
 	grep "[Nn]othing added" err &&
-	test_cmp expected file
+	compare_files expected file
 '
 
 test_expect_success 'Test delete/normalize conflict' '
-- 
2.0.0.rc1.6318.g0c2c796

