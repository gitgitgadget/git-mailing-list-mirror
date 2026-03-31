Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11D39BFF0
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001400; cv=none; b=ubzFGJpuKgUeOCFgBbSLB6pwPzih6P19nF5MzaKiqifkrr1d6rxso705I+OW6clCo2El1yYHFG4FD9erlDkclzTT8fuPr/8ODp5l4/e7UsLlHXicXQC+EwWvkoDwo/Zzf3OMBsxr2r2L3nGbk6t/iC0G8I1yspMGoNB3Db5ylDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001400; c=relaxed/simple;
	bh=KBYW1caBY56fFZVYJjzE/C1xZAGa976PSW26Fd/3MbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMtv9hTNLkbMWozfsHbBwrqnQuhycOaNmOtMbGb1EfzIhjUefri1rhZEFBQxTY8fpy8a6PvlvizydoUoWdJROnK7iZ/c3IAj1gbffE5icGduOnYzTQmCzX/tiuTloDFpyUNGWtDhnxAyMgISnkY++2UE0LmzSwKfL4OiSUipHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XiPQQwPg; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XiPQQwPg"
Received: (qmail 206752 invoked by uid 106); 31 Mar 2026 23:56:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KBYW1caBY56fFZVYJjzE/C1xZAGa976PSW26Fd/3MbY=; b=XiPQQwPgN1XM6bpyqeSByfNM6oveGrNgFxGDqTt+4QoaqTGwVfjRf96TJCfIqBLzfC+djDTlgIbwjNCTriblbSZ/X/zZ/3ME5lmEzembKmuumKncJQRyZnzFa+fKSc3if824tqDd+i88N3XaT05PjGNZRRPU2EwifHvXO2gDyp1TUkBN01sTihkmrf4tACACPi4oJkHa0y0opOA/TjXbSWOfPwMGAZ4RDqn8wL5tvBNnnM1qyN1HOyw4MQYFfGEEHkI3pZw3CP96LuRSDKcZnTux/iZYgHHMvAgj9WC3mfE9Q+YN2Pc9cffo6Caf+cOSm0u3QmTrUPKZ1LmE6X4ORQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326695 invoked by uid 111); 31 Mar 2026 23:56:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:56:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:56:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 07/12] pseudo-merge: fix disk reads from
 find_pseudo_merge()
Message-ID: <20260331235637.GA2328851@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331234622.GG2328529@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331234622.GG2328529@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:46:23PM -0400, Jeff King wrote:

> So I think there is something wrong or missing from the test setup, and
> this bears further investigation. Sadly the answer to the second part
> ("does it work now") is still "no idea". I _think_ this takes us in a
> positive direction, but my goal here is mainly to quiet the compiler
> warning. Further bug-hunting on this experimental feature can be done
> separately.

If this is the wrong direction or if we just want to keep things minimal
in this patch series, the absolute smallest fix is probably to cast away
the constness explicitly in find_pseudo_merge(), along with a comment
that the fix is almost certainly wrong. ;)

-Peff
