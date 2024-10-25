Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3118C018
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838662; cv=none; b=rYm+omiNC0ORIlRLSCv+0RWT4LPTd4bwjhD7ISr7eCakxUItYn4gHqdd28h6YMdUumx1A9mJ7zi7YlAruUVjPr/MJBgVFj8pLj8KSHky+GWvfRUipQMKLgqYGKxXBI4S8zOPJp0c8w2RVVT84CylUchvIIChKpKQXUCdFFZofsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838662; c=relaxed/simple;
	bh=o2UyIdAUBub57pZkWLND8v82A42J//dvEbDU212UCvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3xgpNWzv9DBhocmjX1ryNduTjysDylHFli9xP8fHkpKvbo6ut+shk+OWbxiZ6D5RuLnm4zlWyA6u4at7f/7XIdcFMyfn/qt84AARoBQB07wPaihoMZUwKbD5J8mKyD8LmgDvoB/6Z4PvSrId3KukJeciREEQqxdFsxhihHVFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cGDbBSYg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cGDbBSYg"
Received: (qmail 366 invoked by uid 109); 25 Oct 2024 06:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=o2UyIdAUBub57pZkWLND8v82A42J//dvEbDU212UCvo=; b=cGDbBSYg2V5xr/xmNe/1yfhyMu9n61eb6mM90nqNgHmGXRt4OPHqkNyNNI/wQLBMzdje6B1eg970uDE1DG22wfyspkS09soPn0hddmPX34gGxt7dDdztyKD3TLRO0cOGpqPvRodm3/+qWIBKrjoe1G5oOgGOT1yq+RZ2SiYnBk0EZkka0mkIopDf0t93qNfFqb38notDXlLPXneVKRjDy6FmMr8O13sM88vRcD0TUy8aI6h/P2eImvUsTgU8rYRE3DkE4UNWNIWpiZrLdvip1/5IKrgrjUSCPn7bZVYgsyxtiO9T86GAJIUGpZw5L6CCcwHaiF2EVsytINkGchG10A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 06:44:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12672 invoked by uid 111); 25 Oct 2024 06:44:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 02:44:18 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 02:44:17 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 02/11] t5550: count fetches in "previously-fetched .idx" test
Message-ID: <20241025064417.GB2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

We have a test in t5550 that looks at index fetching over dumb http. It
creates two branches, each of which is completely stored in its own
pack, then fetches the branches independently. What should (and does)
happen is that the first fetch grabs both .idx files and one .pack file,
and then the fetch of the second branch re-uses the previously
downloaded .idx files (fetching none) and grabs the now-required .pack
file.

Since the next few patches will be touching this area of the code, let's
beef up the test a little by checking that we're downloading the
expected items at each step.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5550-http-fetch-dumb.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 58189c9f7d..3968b82260 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -307,6 +307,14 @@ test_expect_success 'fetch notices corrupt idx' '
 	)
 '
 
+# usage: count_fetches <nr> <extension> <trace_file>
+count_fetches () {
+	# ignore grep exit code; it may return non-zero if we are expecting no
+	# matches
+	grep "GET .*objects/pack/pack-[a-z0-9]*.$2" "$3" >trace.count
+	test_line_count = "$1" trace.count
+}
+
 test_expect_success 'fetch can handle previously-fetched .idx files' '
 	git checkout --orphan branch1 &&
 	echo base >file &&
@@ -321,8 +329,14 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 	git push "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git branch2 &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git repack -d &&
 	git --bare init clone_packed_branches.git &&
-	git --git-dir=clone_packed_branches.git fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch1:branch1 &&
-	git --git-dir=clone_packed_branches.git fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch2:branch2
+	GIT_TRACE_CURL=$PWD/one.trace git --git-dir=clone_packed_branches.git \
+		fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch1:branch1 &&
+	count_fetches 2 idx one.trace &&
+	count_fetches 1 pack one.trace &&
+	GIT_TRACE_CURL=$PWD/two.trace git --git-dir=clone_packed_branches.git \
+		fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch2:branch2 &&
+	count_fetches 0 idx two.trace &&
+	count_fetches 1 pack two.trace
 '
 
 test_expect_success 'did not use upload-pack service' '
-- 
2.47.0.363.g6e72b256be

