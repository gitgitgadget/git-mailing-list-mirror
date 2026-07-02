Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36AA30B51A
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026978; cv=none; b=qeCkI0RWmE/crXFO/o9YfX3waguy1+6szKtlC4Ci7YdG4xYV5QIg014Xm/I9yQGWvHbqzOzQY0y2D33tUin+HcM7KHTLFSXkKLlCr6hoRKpqomJt1FhQm0Pth2UMydD1gNy1lqDFRXi4Tu6ss+wtkzmKMXIivNHz4TedH0ApKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026978; c=relaxed/simple;
	bh=CBQWGLt4Uhmank+ChbyE7VwwjWtj9iZK5IDmRbeUPhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT1P/yvBB1n221F3q+MMaYGxWoxIryVN8BJ35mZLk5jqBkB6u2JUTDvKjUTFfUtJeOMEwMXMZgCXEAGoOSa6UbqcsxrH9XiMgnNsJ/LQ6/etqHcTj1SODIpqAxjMM3EAXYkVUBUmaPEeAGay9VQYzfKyr+GO97J7FgSs4JIOrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aZ9ovg5d; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aZ9ovg5d"
Received: (qmail 88812 invoked by uid 106); 2 Jul 2026 21:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CBQWGLt4Uhmank+ChbyE7VwwjWtj9iZK5IDmRbeUPhE=; b=aZ9ovg5dgJYZ7jaTNb3oIlWHixw5lFVq6Ak1AInaYHURdgQF7CvuC4kCKF3DS+B2GqAYok3+BVywYKlSqwzs4rT2lOrBGU7c1ccAIne6cYdNyYTQt7PnJpAi59l9bm9sBAa6xrPDPp1Hx0p5h3UdtcCP5T9atpWhaZCHMLEw/htuhmlGPRW0v4111O36y/Osflur4eojGPHfOOV/dETAZHBtqhyXm7+pgsgh+NMTdjPSS7Ty+lS87j5IHXidSr56mt6Ob6RODUWYk1mhpk1BO5jWSTWfVjWi3LNmPQYnIkiITTnYcDBDUyTlEo8X5KJiRqalDfgEjpEKhbbtwFTf+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 21:16:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 187861 invoked by uid 111); 2 Jul 2026 21:16:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 17:16:15 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 17:16:14 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/9] t4141: fix inefficient use of dd(1)
Message-ID: <20260702211614.GB2051171@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>

On Thu, Jul 02, 2026 at 02:00:56PM +0200, Patrick Steinhardt wrote:

> This test setup is extremely expensive, as `test_copy_bytes` is
> implemented via `dd ibs=1 count="$1"`, which copies data one byte at a
> time. So as we write 1GB of data, we end up doing 1 billion reads and
> writes. This naturally takes a while: it takes 6 minutes on my system,
> and around 40 minutes in some CI jobs!
> 
> We can do much better though, as genzeros already knows to handle an
> optional limit of how much data it is supposed to write, which allows us
> to remove the call to `test_copy_bytes`. Furthermore, it has already
> been optimized to generate the data fast.

Seems like a good fix for this case, where we can skip the extra process
entirely.

It feels like test_copy_bytes should be able to do much better in
general. The obvious thing to reach for is "head -c", but the function
was originally added because that wasn't portable. The "-c" option is
not in POSIX, though the original comment claims IRIX was the problem,
so I wonder if "head -c" is de facto portable these days.

I'd use perl of course. ;) The history here is somewhat amusing. We
originally did use dd, but that changed in 4de0bbd898 (t9300: use perl
"head -c" clone in place of "dd bs=1 count=16000" kluge, 2010-12-13)
because dd was slow. The code moved to test-lib.sh in 48860819e8 (t9300:
factor out portable "head -c" replacement, 2016-06-30), where I rejected
the dd solution because it was slow. And then the perl turned back into
dd in 01486b5de8 (t: adapt `test_copy_bytes()` to not use Perl,
2025-04-03), becoming slow again.

Chesterton's fence at work?

-Peff
