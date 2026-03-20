Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A08F48
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967480; cv=none; b=mUZMleZdJY/9iXorWbagedCmT9GUX0iHlMpSmDAS+eCebuxCYnrgkXlGoDkDNE5j8mCPtDyo3eTsSeRIyuL6dUATkrt4BFMF/wmVyqttnq8FUqsgxSkxJGdak5maz/rIP2fMJs4MPG2Lm7qLSPxo6UpnUK+JnGOKmDbgDW39nPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967480; c=relaxed/simple;
	bh=Lf6G/8rzt88FAzrMJjFIuz1cbAU4GQ4jnDYN2c73nIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6XgOl7n07KBrOtwb54jGaMYmLa7ar9l0FoR1AamOpWQhBoH/2DzTs096nRnoMNEWFB9xiG+Zz3FWRdvHrmSilRqs7lLr4QY9A6J1WJy7E+6KX96QDxI1xYhMNHUv/pdMfvIDQampXkfcI0iV+k7pX+B3RkzZYI1chm7xvkyVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GAC3PESL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GAC3PESL"
Received: (qmail 62449 invoked by uid 106); 20 Mar 2026 00:44:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Lf6G/8rzt88FAzrMJjFIuz1cbAU4GQ4jnDYN2c73nIA=; b=GAC3PESLURkry9gg+uEO/RXJu2vsmJp5PEVpAl37qNTK1+klr4sd+b86F4KY2W7OPAqJ67td1a2PCo39tpNsPaDR60ssCPzupeIRcPAnldOxMBoYKkq1vILsyHutzzGV1/DScSsWmJwA/XnWU3YEwH48yfrFWrsZVO0o8fCWDV2bbfsOhkN57bXY0nrWdLvPaiFGBC0k+1Wl3jHMexHudONCFy3xCn+BbshAt1DisN4UTCQKLE32nc/OlNohvYMxqfMwxkeCVR2C79MiJhPBjo6lT8AYqqcH+s2GqN4/331W9lNIWfpwpy/QKJyR/XmQfglS2NVT8tQCFdlIUFtBcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:44:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91649 invoked by uid 111); 20 Mar 2026 00:44:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:44:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:44:36 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 5/8] diff-highlight: use test_decode_color in tests
Message-ID: <20260320004436.GE3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

The diff-highlight tests use raw color bytes when comparing expected and
actual output. Let's use test_decode_color, which is our usual technique
in other tests. It makes reading test output diffs a bit easier, since
you're not relying on your terminal to interpret the result (or worse,
interpreting characters yourself via "cat -A").

This will also make it easier to add tests with new colors/attributes,
without having to pre-define the byte sequences ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 .../diff-highlight/t/t9400-diff-highlight.sh  | 37 +++++++++----------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 42d331c6cd..ba80cda7c8 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -7,9 +7,6 @@ TEST_OUTPUT_DIRECTORY=$(pwd)
 TEST_DIRECTORY="$CURR_DIR"/../../../t
 DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
 
-CW="$(printf "\033[7m")"	# white
-CR="$(printf "\033[27m")"	# reset
-
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY"/test-lib.sh
@@ -42,9 +39,9 @@ dh_test () {
 	} >/dev/null &&
 
 	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
-	test_strip_patch_header <diff.hi >diff.act
+	test_strip_patch_header <diff.hi | test_decode_color >diff.act
 	"$DIFF_HIGHLIGHT" <commit.raw >commit.hi &&
-	test_strip_patch_header <commit.hi >commit.act &&
+	test_strip_patch_header <commit.hi | test_decode_color >commit.act &&
 	test_cmp patch.exp diff.act &&
 	test_cmp patch.exp commit.act
 }
@@ -126,8 +123,8 @@ test_expect_success 'diff-highlight highlights the beginning of a line' '
 	dh_test a b <<-EOF
 		@@ -1,3 +1,3 @@
 		 aaa
-		-${CW}b${CR}bb
-		+${CW}0${CR}bb
+		-<REVERSE>b<NOREVERSE>bb
+		+<REVERSE>0<NOREVERSE>bb
 		 ccc
 	EOF
 '
@@ -148,8 +145,8 @@ test_expect_success 'diff-highlight highlights the end of a line' '
 	dh_test a b <<-EOF
 		@@ -1,3 +1,3 @@
 		 aaa
-		-bb${CW}b${CR}
-		+bb${CW}0${CR}
+		-bb<REVERSE>b<NOREVERSE>
+		+bb<REVERSE>0<NOREVERSE>
 		 ccc
 	EOF
 '
@@ -170,8 +167,8 @@ test_expect_success 'diff-highlight highlights the middle of a line' '
 	dh_test a b <<-EOF
 		@@ -1,3 +1,3 @@
 		 aaa
-		-b${CW}b${CR}b
-		+b${CW}0${CR}b
+		-b<REVERSE>b<NOREVERSE>b
+		+b<REVERSE>0<NOREVERSE>b
 		 ccc
 	EOF
 '
@@ -213,8 +210,8 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 	dh_test a b <<-EOF
 		@@ -1,3 +1,3 @@
 		 aaa
-		-b${CW}b${CR}b
-		+b${CW}0${CR}b
+		-b<REVERSE>b<NOREVERSE>b
+		+b<REVERSE>0<NOREVERSE>b
 		+ccc
 	EOF
 '
@@ -232,8 +229,8 @@ test_expect_success 'diff-highlight treats multibyte utf-8 as a unit' '
 	echo "unic${o_stroke}de" >b &&
 	dh_test a b <<-EOF
 		@@ -1 +1 @@
-		-unic${CW}${o_accent}${CR}de
-		+unic${CW}${o_stroke}${CR}de
+		-unic<REVERSE>${o_accent}<NOREVERSE>de
+		+unic<REVERSE>${o_stroke}<NOREVERSE>de
 	EOF
 '
 
@@ -250,8 +247,8 @@ test_expect_failure 'diff-highlight treats combining code points as a unit' '
 	echo "unico${combine_circum}de" >b &&
 	dh_test a b <<-EOF
 		@@ -1 +1 @@
-		-unic${CW}o${combine_accent}${CR}de
-		+unic${CW}o${combine_circum}${CR}de
+		-unic<REVERSE>o${combine_accent}<NOREVERSE>de
+		+unic<REVERSE>o${combine_circum}<NOREVERSE>de
 	EOF
 '
 
@@ -333,12 +330,12 @@ test_expect_success 'diff-highlight handles --graph with leading dash' '
 	+++ b/file
 	@@ -1,3 +1,3 @@
 	 before
-	-the ${CW}old${CR} line
-	+the ${CW}new${CR} line
+	-the <REVERSE>old<NOREVERSE> line
+	+the <REVERSE>new<NOREVERSE> line
 	 -leading dash
 	EOF
 	git log --graph -p -1 | "$DIFF_HIGHLIGHT" >actual.raw &&
-	trim_graph <actual.raw | sed -n "/^---/,\$p" >actual &&
+	trim_graph <actual.raw | sed -n "/^---/,\$p" | test_decode_color >actual &&
 	test_cmp expect actual
 '
 
-- 
2.53.0.945.ge67b727e8d

