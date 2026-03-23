Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB22AD03
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245733; cv=none; b=bO6oxHtcu9XCuKwJ0Pns0sbXM8oVOv5O24UMGuYdEpSMiP1Spe/yweMJIOYGqvs+7dqeyRh5nUyA95TOyLqsUOUFvR6eB5OUdL5jOtV+sfXkbc4+si7I4NFHVye6/iq/MSnQd4s0HVS2q9AmJpg4ACaIHQaH+jWoYOhvDerxo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245733; c=relaxed/simple;
	bh=787OuNCI0K185o8JFrqJBru8fVWYOaLc/UfZTbCLtaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozPIjPxK/fX4EokVNgQHYDkg/gZMzNx+9v0nbNGrdj0NjRKdRUCppk2rXVRAWiyhurLgfJYxrnoiM99t9F+P5BkpEB7qPvfKXvcq4Tz651MXysbypUugdTHFqXyaNKTK9PWsjWxi7xPA5z9qJz7WoWia8S/kDPLur6TxE6Vr+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Du+8g0gz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Du+8g0gz"
Received: (qmail 110198 invoked by uid 106); 23 Mar 2026 06:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=787OuNCI0K185o8JFrqJBru8fVWYOaLc/UfZTbCLtaY=; b=Du+8g0gznZNhf5csPmgxWb3EKpV20rpyS4M/kZhQdHeS+r7Do1dK5dN5kU3OguqGZejkc4mQHoud7fsOyuQng+jcg+XCcZBrU15O4YCzp8G6Qx0xm+47bmlQNePk0Motn6qNBa8BEK9XfKoJhMVKNM2vkjPBj11dcb+gKL3YNKffWV9dyYlRuH3nYL3xMt6oW0j1nKDa9Gl+0gXblBzmRJV3cspeBHCldPyeKZvrA4m0VabNho2kAL4eW7ND5Ocz+mzeDEJrx6LtfvIOwTegrHqp3kJa0l93hBFdbxWgSDkEWF/zOsYAx7z3LP73TYKp8b6RLd+MYg3PgWR4RvqEYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146999 invoked by uid 111); 23 Mar 2026 06:02:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:11 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:10 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 5/8] diff-highlight: use test_decode_color in tests
Message-ID: <20260323060210.GE10482@coredump.intra.peff.net>
References: <20260323060139.GA10215@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net>

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
index 7ebff8b18f..4f3d55a26e 100755
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
-	test_strip_patch_header <diff.hi >diff.act &&
+	test_strip_patch_header <diff.hi | test_decode_color >diff.act &&
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
2.53.0.1051.ga14e96f895

