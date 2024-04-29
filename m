Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AE14A98
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380161; cv=none; b=R5FGseC9xLWgpxFGSYnP/YmkyXLydSYWZyehMyTzIrVUug7I0MoOhvRhoSffGl3x/AaR24iwEopuezum/r3jBcMmnRiKFOhbrKzQ8BqSCTu5tVWvlYDPrnfMPXc6sxomzEXWb/aubuUeVGeXf1Nlv9xtrVODPqaA8vkRThZxVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380161; c=relaxed/simple;
	bh=mtdEi8t8Um/vzE9niKb0/AMJ2oeaG2O0OyYN82rUE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOAJKlACOQq9twRsh8s4jvVDRRZJ/cP4arSFY177O6vSjUOTCtvx9iDQJd+iyJ47QfJ4bgFEopafQJiASQNG6bpbrkSTF8mePD3A0592WZQjtgJDjp0PAkzw1v6mbyWOSfy+Jlnp8KaRQNpyr5wZXi9yJG6Z3/Wp081nIMfUYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20320 invoked by uid 109); 29 Apr 2024 08:42:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:42:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27084 invoked by uid 111); 29 Apr 2024 08:42:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:42:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:42:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/8] tightening ref handling outside of refs/
Message-ID: <20240429084238.GA242085@coredump.intra.peff.net>
References: <20240429081512.GA4130242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429081512.GA4130242@coredump.intra.peff.net>

On Mon, Apr 29, 2024 at 04:15:13AM -0400, Jeff King wrote:

>   [1/8]: t0600: don't create ref outside of refs/
>   [2/8]: t5619: use fully qualified refname for branch

You can probably guess that I found these test cleanups only after
writing the rest of the series and seeing them fail. :)

It turns out there is one more spot that is run only with reftables (so
CI caught it, but my local testing did not):

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 178791e086..c6dbd2b5c4 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -343,11 +343,11 @@ test_expect_success 'ref transaction: env var disables compaction' '
 	for i in $(test_seq $iterations)
 	do
 		GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
-		git -C repo update-ref branch-$i HEAD || return 1
+		git -C repo update-ref refs/heads/branch-$i HEAD || return 1
 	done &&
 	test_line_count = $expected repo/.git/reftable/tables.list &&
 
-	git -C repo update-ref foo HEAD &&
+	git -C repo update-ref refs/heads/foo HEAD &&
 	test_line_count -lt $expected repo/.git/reftable/tables.list
 '
 

I'll wait for comments before re-rolling, but I'll make sure that gets
added in.

-Peff
