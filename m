Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07305420867
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455049; cv=none; b=VQZpcN08rYnC+FHChp2fM3qxdKu1RtfCea/ZNh4x5+Dq22td92ioxMJ/EoreiL1ikmFZIT/KO2QzZ/sAR88bUKHVM1AkcmQEEfmxlhTvc2PJzmZuNDgWN/kYFf14FSnhr9cw2qbl7z8WOU2pDzwmYbsB/zae0KXaopDLdri9Ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455049; c=relaxed/simple;
	bh=2F85rW2xgls2Dpl4zKBkaV9cnTahR72KkSNsswveyvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF7ligLv/V2obBF667aT6GiWODnqeF4S3Vj+3vuiy9N7TQeCqrDinOFCHBGolc1nNN0nr7je9RVXp0w5OrxahYmaTuIMRCwUkdckPDfFnc3iUm0p6l99UKQnjMSOGQuk15nmDZEL8ljLtMKGvYlpIfGzJJ+QstCC8L8kQIOqRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ta8s9brO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ta8s9brO"
Received: (qmail 22789 invoked by uid 106); 7 Jul 2026 20:10:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2F85rW2xgls2Dpl4zKBkaV9cnTahR72KkSNsswveyvo=; b=Ta8s9brO6/hzhc6nunNvqqYusnFTpfi3B9JFeQByTJgQqcm7J6Xh4ajYL0U8vBRbfXxQjDYOvG6HMBF4YXriQgJvHR/laUIkfbiYUQZ/t/w22CySHX+tPkRAUw8V3LXSxckc61mWNePTJOTWwGn5rTIvbF1MLhPJitDLL3EUdDr8xNE9sz78J55TZYPO0X8Nf9uWWC16U5BHtHlf9Bic/OMVKescthIupiJNra4pNpF5SzEtsClynHW/EUMFfbIRwZto8/sL7dn9SXvUQcgm8OGuqMQF5Ih9elt0uG0ag4OfLf/m4kkOdDwic1lRGfR1qrZnwI6i1UVmPgatKR+XHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 20:10:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34170 invoked by uid 111); 7 Jul 2026 20:10:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 16:10:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 16:10:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 7/7] hash: check ctx->active flag in all wrapper functions
Message-ID: <20260707201046.GB11780@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050952.GG1288294@coredump.intra.peff.net>
 <xmqqcxwy7oal.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxwy7oal.fsf@gitster.g>

On Tue, Jul 07, 2026 at 09:33:06AM -0700, Junio C Hamano wrote:

> Among the four we see here, I agree that calling _clone and _update
> on an already discarded or finalized context should be caught as an
> error. As I alluded to earlier, though, I am not sure about
> _final. The asymmetry in a design that allows _discard after _final
> but not _final after _final disturbs me slightly, but perhaps that
> is only because my morning caffeine has not yet kicked in. 

There was more discussion in the earlier thread:

  https://lore.kernel.org/git/20260706000105.GA2301945@coredump.intra.peff.net/

But basically the asymmetry comes from the fact that the finalize is
trying to _do_ something, whereas discard is just, well, discarding.

So what should:

  git_hash_discard(&ctx);
  git_hash_finalize(result, &ctx);

put into result? It is probably one of:

  1. the null hash

  2. the hash you get from init() + no updates + final()

  3. nothing, BUG() instead

It seems nice at first that (1) or (2) won't cause the program to crash,
but ultimately they are probably the sign of a bug in the program. So
complaining loudly via BUG() is probably our best bet. We could always
loosen it later if somebody actually adds code where another behavior
makes sense (we know there are not such paths now, as they'd segfault
under openssl's heap-based backend).

-Peff
