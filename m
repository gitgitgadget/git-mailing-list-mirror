Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620417083A
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271958; cv=none; b=Y77edX7Vby5d7a4GosaI1MGjsTBS9X7L/WATaEQEbTISolz91N3fxqRVzgxT7xORAlMJ8TWIqlwiQu0D3gaTYEJGUzEcxUGz9aAs+yu7RUi7NeC+SZxkPz4HaFtA/j6W8TkdkcSJJbeq5FXIr9Wc01z1CvgZckNlthkj7zEdzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271958; c=relaxed/simple;
	bh=PMXp6dY7SMA6H7AdhNmyKzqVP81QanI4iruiYBdba3I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD8lTj1u0ZLmiHbBo1cSmc1e24/1b7LCt2gGJ0CcX6HNe4V/njKfWC8q1F1/m6MLSQqVaz/RpFAuB9oRogD+Mt46V+1ZCY5QtJ6Tzp0g4OIjEHbx3sPqkSyTRRIInZri2UDh44C3LqCj96msUoedinCh9UqAT2q3MQ36/barGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6920 invoked by uid 109); 9 May 2024 16:25:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:25:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31164 invoked by uid 111); 9 May 2024 16:25:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:25:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:25:44 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <20240509162544.GC1708042@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509162219.GA1707955@coredump.intra.peff.net>

Our osx-gcc job explicitly asks to install gcc-13. But since the GitHub
runner image already comes with gcc-13 installed, this is mostly doing
nothing (or in some cases it may install an incremental update over the
runner image). But worse, it recently started causing errors like:

    ==> Fetching gcc@13
    ==> Downloading https://ghcr.io/v2/homebrew/core/gcc/13/blobs/sha256:fb2403d97e2ce67eb441b54557cfb61980830f3ba26d4c5a1fe5ecd0c9730d1a
    ==> Pouring gcc@13--13.2.0.ventura.bottle.tar.gz
    Error: The `brew link` step did not complete successfully
    The formula built, but is not symlinked into /usr/local
    Could not symlink bin/c++-13
    Target /usr/local/bin/c++-13
    is a symlink belonging to gcc. You can unlink it:
      brew unlink gcc

which cause the whole CI job to bail.

I didn't track down the root cause, but I suspect it may be related to
homebrew recently switching the "gcc" default to gcc-14. And it may even
be fixed when a new runner image is released. But if we don't need to
run brew at all, it's one less thing for us to worry about.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't think this was due to anything on our side. I tried to re-run
versions of git.git which had previously passed and ran into the same
issue.

I'd like to report that this let me get a successful CI run, but I'm
running into the thing where osx jobs seem to randomly hang sometimes
and hit the 6-hour timeout. But I did confirm that this lets us get to
the actual build/test, and not barf while installing dependencies.

 .github/workflows/main.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5f92a50271..13cc0fe807 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -285,7 +285,6 @@ jobs:
             pool: macos-13
           - jobname: osx-gcc
             cc: gcc-13
-            cc_package: gcc-13
             pool: macos-13
           - jobname: linux-gcc-default
             cc: gcc
-- 
2.45.0.414.g4009e73179
