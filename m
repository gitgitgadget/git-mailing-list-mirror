Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296E231827
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633829; cv=none; b=d8EyWM/Xk+1lNZfs12gvhNq737GHZi6EYkNlwA3Jsv30m+JUdYNqQ3hT6KAwC2LxFK/u7LDl1Ak35oqOabXCqfCG083B1FxjN8r5SYkggL+xD80dak4rbgDzSpWtkB8kHqQOsrqln0+uaVNtPdhJSUw9ZZo+wN5tfYTlSWro9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633829; c=relaxed/simple;
	bh=0ImgyeEk/+XfLchX0Zr6v9J14bmCeHvUOLxmDuWSGiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF+HfER90je3dyur3cAGAriRX9nVU+pzuhAZLixSgFblaEXIwaIAe1mnddJZBb7spr7LTrxxeSXlKDufFoDizRjb2HqvzXcA8mtQ1dqmjefvdRNtew1t32hs0EP4v/B7Fs1N5Mqx+Sc7hzJ7Acojbj6TaBrOl7L0IeKK1oZkJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DsAIzHNl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DsAIzHNl"
Received: (qmail 52240 invoked by uid 106); 28 Jun 2026 08:03:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0ImgyeEk/+XfLchX0Zr6v9J14bmCeHvUOLxmDuWSGiw=; b=DsAIzHNlgiMrY5zppuhsSX7q79E23zOAEZsECAN6/zyMNnf7w2XAhY7SIU71PZqmvSHGuYcCIOf1LZz0tcYIR4/MnSvYvJUiLFylbON6v2/B6DV2aIHvq+zRC3FKVNxwwLFvPO55xcySLL9fiURxzVfWRviy7j5VhNDWy9jhpXU9L8yBLG63pt1qZrGwylOWdfJ+KOnHgZfGyhMGnDq5In3hCI0Sf7QQQyyx8T+ZJNBB/8Hqqp/9hg7pJoeLjcXYkZb8EK8EymtV143qMa6R750o4DhbkqHZiU7csm0ud0gMWbJHYAhP3EEhdlojQLxbGwgt1LVRYiCByy4DEO1AYA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 08:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111261 invoked by uid 111); 28 Jun 2026 08:03:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 04:03:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 04:03:45 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t5551: put many-tags case into its own repo
Message-ID: <20260628080345.GB107826@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260628075716.GA3525066@coredump.intra.peff.net>

Most of the t5551 http fetch tests use a handful of refs. But there are
a few test cases which check our handling of large numbers of refs.
These tests use the same server-side repo, so all subsequent tests end
up having to consider those extra refs, too.

The result is that the test script is a bit slower than it needs to be.
In a normal run, moving the "2,000 tags" test into its own repo drops my
runtime for the whole script from ~2.7s to ~1.9s.

This is a modest gain, but when we add the "--long" flag it gets much
bigger. There we trigger a test (marked with EXPENSIVE) that adds
100,000 tags, and the script runtime jumps to ~95s. But if we use the
same "many tags" repo for that, our runtime drops to just ~37s.

This is a pretty easy win to drop the cost of the script. It may even be
a larger gain on a heavily loaded system, since one of the main costs
here is unpacked refs, which are heavy on system time and I/O costs.

It's possible we are reducing test coverage, since all of those other
tests were inadvertently using large ref advertisements (and thus could
have uncovered some unexpected interaction). But that seems somewhat
unlikely; the tests targeted at the large number of refs are doing
roughly similar things to the other tests.

Note that the real performance culprit is the 100k-tag --long test, not
the 2k-tag one. So we could just let the 100k one use its own repo, and
keep the 2k tags in the main repo. But since these two tests are
somewhat interlinked, it's easier to just move them both (and it does
provide a small gain even for the 2000-tag test). I also notice that the
2000-tag test is gated on the CMDLINE_LIMIT prereq, and without that the
later EXPENSIVE test will fail (since we won't have a too-many-refs
clone). Nobody seems to have noticed or complained after many years, and
I left it alone for this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e236e526f0..cd851f24b8 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -397,15 +397,16 @@ create_tags () {
 }
 
 test_expect_success 'create 2,000 tags in the repo' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 	(
-		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 		create_tags 1 2000
 	)
 '
 
 test_expect_success CMDLINE_LIMIT \
 	'clone the 2,000 tag repo to check OS command line overflow' '
-	run_with_limited_cmdline git clone $HTTPD_URL/smart/repo.git too-many-refs &&
+	run_with_limited_cmdline git clone $HTTPD_URL/smart/many-tags.git too-many-refs &&
 	(
 		cd too-many-refs &&
 		git for-each-ref refs/tags >actual &&
@@ -483,12 +484,12 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 	test_when_finished "rm -f tags" &&
 	(
-		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 		create_tags 2001 50000
 	) &&
 	git -C too-many-refs fetch -q --tags &&
 	(
-		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 		create_tags 50001 100000
 	) &&
 	git -C too-many-refs fetch -q --tags &&
-- 
2.55.0.rc2.353.gf769b6597e

