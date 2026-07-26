Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3AD1F09A5
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055554; cv=none; b=djrUseCUMrwvDhiUAfSLIJRqQmhOdjWj9aAdkkf15VmXczt9DHQxPeccFOt/x9X37Cw01t/2uc0972wJJkABr765H3rx243GkskUSiwIzji95bikQXkQtBP/ZdgCFO6G2MPR4nddRcTqnt/24r9JmGs2J/k0AUj1a7LgqhCq+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055554; c=relaxed/simple;
	bh=+8a/z/R31BkFn+7M/L752QkHAAr1VEVY0kncauWaxvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLJ9plFGQkzSOjvcDFB92czJ4rFbNAvtcZK8MHUzcPpC7VB9AWjQ7FOTrANGSEsWof3YvUBUWfsMUnhEjkDFbF1HIlEHuFtn4JdGjg19pwQppX9SADfQIXdBbdPmToUUdxy7xbjZUS0kUpoTPWie4/8mt4YpNjRFr8PNaO/yj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OMRvPSqy; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OMRvPSqy"
Received: (qmail 56983 invoked by uid 106); 26 Jul 2026 08:45:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+8a/z/R31BkFn+7M/L752QkHAAr1VEVY0kncauWaxvk=; b=OMRvPSqyH4pAsHHagTTx34Pyv4/ZW4q1IlMAzUmtwv9y8BTGqfJ+elH/eCIE14FQN9paS1HmBSTssTOzOxFLekyky92oLAUXrDvumLzm4zagcxgbGv4uUSAeIinwcWyqpROidSWof0oG2icZIbsyF6ZNhqHrLghih5QWR73t8toVyzcG3DxlEUZmccWej7HJv8H7N2gVicBwAiunsq4wjOgKkI7r/kj7DaGVwBQMhC/1fbrwkkbiZV8vWMGJqXL0Sg268cvtoyx4lmnH/edab1bdIeMCMlPhCx9kNqm/Mnr3jGTOOtvQGi39ElYArSbEdnVvX3vayqCeLOaSGqb52w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:45:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57952 invoked by uid 111); 26 Jul 2026 08:45:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:45:55 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:45:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 0/2] diff-lib relative-path cleanups
Message-ID: <20260726084550.GC2366012@coredump.intra.peff.net>
References: <20260715060523.GA517940@coredump.intra.peff.net>
 <xmqqjyqwp9jh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjyqwp9jh.fsf@gitster.g>

On Wed, Jul 15, 2026 at 08:17:06AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > A diff using --relative ignores entries outside the current directory.
> > This results in a segfault when we try to process an unmerged entry
> > that's outside of our prefix, since we end up with a NULL diff_filepair
> > and use it without checking that it's valid.
> > ...
> > +cc Junio, as you may have some wisdom on that further exploration.
> 
> Will take a look at the history myself, but I would probably not
> have much wisdom on a change from 2011.  I often do not even
> remember what I ate for breakfast yesterday ;-).

I have the same problem. ;)

Looks like you reviewed the patch in question already. Here's what I
uncovered by digging into the history. I don't think it should have any
functional difference (and even the "avoid unnecessary work" in patch 2
is probably not very much work in practice), but it might be worth
doing.

This would go on top (even though patch 2 makes the original fix here
unnecessary, I'd rather have both in place).

  [1/2]: diff-lib: drop stale comment about advancing o->pos
  [2/2]: diff-lib: skip paths outside prefix in oneway_diff()

 diff-lib.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-Peff
