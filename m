Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819633D812A
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361138; cv=none; b=Vuxbh6pLOQXbo+93uAydJp2dS0/BO2Oq1gpS0DG+YhRAEdfR1I3OxjMDafIslEPgY5ruB+9TlRFINyTbRUdxa5dTdErHNEAwtx/47cRnDccYcjN8TFFhHzpUptdKXwrMJcv8ovTBW7Q32Z4Cowc5g5XnRktbj86vToJNO9Proqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361138; c=relaxed/simple;
	bh=wuRYECUrQId0k/nCwp3Rl6QH6XNjmYu+pQ32ZtsS+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7SiZlox8j7mmmdg0LA3SRBnYYjPU1+O2/x+bHt6BbQHXP5vD8Rvl0UPVG4FaqOSl3uy812aIo3jtMN8kZ59UIaUUCzaUxCg5e1EOWDV7/REYFVm8TjRumWsvRSqM11wx330I4+zKTrrpPcFDg0FRSyY2A/9DGFey4zwXwcfFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cGjfHpKl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cGjfHpKl"
Received: (qmail 34991 invoked by uid 106); 7 Oct 2026 08:18:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wuRYECUrQId0k/nCwp3Rl6QH6XNjmYu+pQ32ZtsS+Uo=; b=cGjfHpKl6ro3sL2HgoBOPwobK7UxT10aFHuMDs2r+pNSxFrLfWQVNrbByDkXgQrNzFCh6JyX1RTYO/N9sLgXGyLWcKdTcGprQqMVfQZ2hvNmeJ86zSzgXrEd3lRHK2StEO/MzSgXHX4pV5Y+uRZ6dbjx5l2RFL5TENi6z77ieuQtifb0tt0Bzh+MGqnjMMQS7jgauRPPw3iw8d8taivMTz4vfcjTIt2+5p7Nf69V2hoig+oIKMSNxrYvtsqJTxu4YxhTmZaMOPNcvnZd507bsOlwxEr+A6IiW04My9t2WPqW9H45wqAFfaLUzMCafJdyDEiOXTrsPnb8KwJdFEZ5Jw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2026 08:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140146 invoked by uid 111); 7 Oct 2026 08:18:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2026 04:18:49 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Oct 2026 04:18:44 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base
 cache entries
Message-ID: <20261007081844.GA606386@coredump.intra.peff.net>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
 <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
 <20261002222335.GC833115@coredump.intra.peff.net>
 <asM2YoImN8bHLHj8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asM2YoImN8bHLHj8@pks.im>

On Mon, Oct 05, 2026 at 07:32:18AM +0200, Patrick Steinhardt wrote:

> > At its core this is a user-after-free bug, isn't it? If so, I think it
> > would be fine to say that ASan will reliably find it (and we don't even
> > really need to demonstrate the complex case where the packed_git has the
> > same address; all bets are off once we access the freed pointer).
> [...]
> 
> We only use the value of `p`, but never dereference it. In fact, when
> I enable ASan I cannot reproduce the bug at all anymore because it will
> hand out unique addresses.

Ah, I get it now. It is a little funny to key the hash on the in-core
pointer we happen to have, but it does provide a certain uniqueness. I
suspect that doing this would be mostly correct:

diff --git a/packfile.c b/packfile.c
index 7cb9ff5ffb..f69e2535fc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1192,7 +1192,7 @@ get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 				   const struct delta_base_cache_key *b)
 {
-	return a->p == b->p && a->base_offset == b->base_offset;
+	return !strcmp(a->p->name, b->p->name) && a->base_offset == b->base_offset;
 }
 
 static int delta_base_cache_hash_cmp(const void *cmp_data UNUSED,

and would trigger the use-after-free, but:

  1. It introduces weird semantic questions, like: what if you freed and
     then reopened a pack of the same name and it didn't have the same
     contents?

  2. It's more expensive.

  3. Changing the bug from "hard to detect hash equality mismatch" to
     "undefined behavior" is not really much of an improvement. ;)

So I think just fixing the bug is good, along with accepting that it
only triggered in certain specific cases and testing that. And your
patch looks like the obviously correct fix.

-Peff
