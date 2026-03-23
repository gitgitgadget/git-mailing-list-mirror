Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E273D76
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245728; cv=none; b=DIk7vePg48l72BjRQFWvyaET5Pe6pCKP39MrNBkJH/NLSxb0Cu93evJNWeVJ4nb9ZbmZCGaQqUiW+F4SAdB4S0zCGZIoEGdvRZyrOQnftcVy4AI1iN6S0PvFP0yLzNbPKOROaKUGS11lQNzlE9N0QnjjW8iv1OfUz+viwoyKP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245728; c=relaxed/simple;
	bh=mtePkSS0PkPEr5PF+CUG1kVZqkiVqW5zjCRbyxeeUow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JndMZsgc6bZKlk8hS5SogxNlcYW4AL/YkMK6cIXfeUZOEEby6RV9DLkURcrcY9kq5c/s3m4XiA/1Qi+5Su/4b+mxsi+SG6m3E+U4xQ0oHdR7JQzhwI+C1QEktfAuk+RbgSkpzIC6Br7Xr82mD2mL6EnU8KpiHvxpF82QrtCr5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QkPVd38L; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QkPVd38L"
Received: (qmail 110179 invoked by uid 106); 23 Mar 2026 06:02:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mtePkSS0PkPEr5PF+CUG1kVZqkiVqW5zjCRbyxeeUow=; b=QkPVd38Lj6tnt/hFt4HmiFjX9+MDXrB8k1KmGNbHqVCB0NqQO+0ANbFuRmOnUoRXTXyooJudDenjB4DuFstVplyYk6sI0En1tq+rG3nm4LonuFCoatDXe7EIiXG0P2IguRsRQbAOUSFNStAudmnKK4TYmv9URHM5BzBVBq3KEYcgVurHmeOL/bPoakj2k4GPLyv+Ib8YeV4Zi3Ty6HzW1YtGepY/d66HDPNW7Gs0lHn1gr76PlHIYSZI8ml6TzQVj3kG5C6wGyS9nZ2/cZYkKPklr+/LAuz86dLs6lRFN/SDaDR7Dt5k4Qtvdcmo7+2GBGuYcKIl5tHT0b3oYtXk3A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146989 invoked by uid 111); 23 Mar 2026 06:02:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 3/8] diff-highlight: check diff-highlight exit status in
 tests
Message-ID: <20260323060205.GC10482@coredump.intra.peff.net>
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

When testing diff-highlight, we pipe the output through a sanitizing
function. This loses the exit status of diff-highlight itself, which
could mean we are missing cases where it crashes or exits unexpectedly.
Use an extra tempfile to avoid the pipe.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 2a9b68cf3b..7ebff8b18f 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -41,8 +41,10 @@ dh_test () {
 		git show >commit.raw
 	} >/dev/null &&
 
-	"$DIFF_HIGHLIGHT" <diff.raw | test_strip_patch_header >diff.act &&
-	"$DIFF_HIGHLIGHT" <commit.raw | test_strip_patch_header >commit.act &&
+	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
+	test_strip_patch_header <diff.hi >diff.act &&
+	"$DIFF_HIGHLIGHT" <commit.raw >commit.hi &&
+	test_strip_patch_header <commit.hi >commit.act &&
 	test_cmp patch.exp diff.act &&
 	test_cmp patch.exp commit.act
 }
-- 
2.53.0.1051.ga14e96f895

