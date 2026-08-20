Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDB1C5D72
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212434; cv=none; b=evvsBFbAyWF5xZ+687zUXhgqvS+zkJO4Cqrl8JUu3UgAdmp+Efn8DpUZjQqOFnzYp8/16cjf0Fz59W49gvmmnIBqLv7C7GioyR2CXb2hpFZqPXg++/zHYznxmR6FF/AmsV45aSKpFaJG+dVSVllxyq/C3sRQBpHOLIu8aLDb2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212434; c=relaxed/simple;
	bh=3yrkeW/qyy3Vv21+C8fBCUlCZ2XjAxC2uCjp+bgepgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQaTxzj7YiUgSJoGr4RufbUrR+6Ua70nW4NqZ69TbNfzc/6NgtfOQgn1eSMzc+twyJOc9eKHKKDEd1a/Wfzi4uycwjRD6GmHY9ekfMIcNoB4E7HQ0wLQoor7bVgyV+kecPFJLziXSwti1yfGTczW6Fi8yVRzGm1YQ8M3VGzgekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=T+OtjnNs; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="T+OtjnNs"
Received: (qmail 82168 invoked by uid 106); 20 Aug 2026 07:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3yrkeW/qyy3Vv21+C8fBCUlCZ2XjAxC2uCjp+bgepgQ=; b=T+OtjnNsBuCl0f7Da6cP3XHO5p8gtNWj6kFeL5r9maZcG54C2hei2pph+Nivo6jLFXk2Yh+vjwBcL3xeWnTnDuHW2IpYfr6MTTNKCgL4fACx7u6QykJDrcva76wqnLQV9ih5lRfJazxWQjI5Wjsmy03mfzazPTPAEnu0ptwxNx9AuLt2qmi3Hs5pr1/CLC9UM7/NWfSD8TwBJQ2FLzw2qos1iP9czvOoTe3naYg0srxUUTTdKYRyKPuOkgvzjT15YHtFdYBXvCj75Dw8yv66qk8T4+LPNjH18MIDlDH0FkZ50e7ixZgs6OSthoqhOAvwVG2snNTSBEK+k3YNZiai5w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Aug 2026 07:53:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57998 invoked by uid 111); 20 Aug 2026 07:53:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2026 03:53:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Aug 2026 03:53:42 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] reftable/stack: avoid reloading the stack when
 already locked
Message-ID: <20260820075342.GA2761530@coredump.intra.peff.net>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>

On Wed, Aug 19, 2026 at 03:19:39PM +0200, Karthik Nayak wrote:

> Benchmarking with a fixed, non-symbolic target OID shows a modest but
> consistent ~1-2% improvement in clock time for `update-ref` across ref
> counts ranging from 2,000 to 100,000.

Interesting. I get ~25% speedup with this patch, doing this:

  git init --ref-format=reftable
  cp -a .git/reftable reftable.orig
  seq -f "create refs/tags/foo-%g $blob" 50000 >input
  hyperfine -p 'rm -rf .git/reftable; cp -a reftable.orig .git/reftable' \
           -L v old,new \
	   './git.{v} update-ref --stdin <input'

(where git.old and git.new are builds before and after your series).
With 50,000 refs I get:

  Benchmark 1: ./git.old update-ref --stdin <input
    Time (mean ± σ):     125.8 ms ±   4.4 ms    [User: 91.2 ms, System: 34.5 ms]
    Range (min … max):   121.0 ms … 135.2 ms    21 runs
  
  Benchmark 2: ./git.new update-ref --stdin <input
    Time (mean ± σ):     100.4 ms ±   3.1 ms    [User: 90.9 ms, System: 9.4 ms]
    Range (min … max):    95.0 ms … 106.0 ms    29 runs
  
  Summary
    ./git.new update-ref --stdin <input ran
      1.25 ± 0.06 times faster than ./git.old update-ref --stdin <input

And it seems to scale down linearly. With 10,000 it's:

  Benchmark 1: ./git.old update-ref --stdin <input
    Time (mean ± σ):      24.2 ms ±   1.4 ms    [User: 17.1 ms, System: 7.1 ms]
    Range (min … max):    22.6 ms …  32.8 ms    83 runs
  
  Benchmark 2: ./git.new update-ref --stdin <input
    Time (mean ± σ):      19.2 ms ±   1.0 ms    [User: 16.9 ms, System: 2.4 ms]
    Range (min … max):    17.9 ms …  25.8 ms    135 runs
  
  Summary
    ./git.new update-ref --stdin <input ran
      1.26 ± 0.10 times faster than ./git.old update-ref --stdin <input

So 1/5 as much work took 1/5 as much time, but we still saved 25% of the
relative time with the patch.

I'm a little curious why we such get different numbers, but it may not
be worth digging too deep. Avoiding unnecessary syscalls seems worth it
to me regardless, as they can sometimes be more expensive you expect
(say, on a networked filesystem).

-Peff
