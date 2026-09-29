Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DF38D3F7
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714520; cv=none; b=SMybSGQaTaK8aSI+5MVRCf7H0BTnxX2yjXr3vvduOPrPAO86ebkBLBZ2qUCKBnkS/NwMVONBeQPrH7yoooJ+43G3CKeqRvkCTYIjYpoIezw5ioQQoC7N0Z/Da905mzfG2cyo/xfu+2FPs5r6NVi7Hn07sT/yPggdK6w/wkffJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714520; c=relaxed/simple;
	bh=bMYwlIbYrdqGGhFTTckiSXR78WcT3d7rC8KRBe2s1b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX6p0WTXvtoQ9LC7ElyB+sltPiJKQbHCjArKj2+rVfimdPoG3Go37ZEIHZJ66YcKCK4ewxb+XbJaMxf47BGtWxbDQJUJm3kpag4GgFiynBkF5f7u78xmV36TEwnCqQptK3zxhHKe9e9k6pDk3i3Aw0vmtUTCh4ZZSVK9lrF5uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EmcrtYXu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EmcrtYXu"
Received: (qmail 1399 invoked by uid 106); 29 Sep 2026 20:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bMYwlIbYrdqGGhFTTckiSXR78WcT3d7rC8KRBe2s1b4=; b=EmcrtYXuhkbYkzb+SqXRO2Czuehb+ORMWXbOdEUdDt5AEgF+E2QbevPEaqAXAJujVL1zzeE9u01QEU1rDZjMOLVQ2Brb8dLCaJ+Ykvv0RWrl2epixEPKtCZnsTv/Bjm3n1kpnxzSe+t7rNRKvnKgwHjE/nfEn0iwIL1Xi0jGtaJR4a9HVd3Qbxd9QXU5fZ6RQQOXGzPMqUeB4Ua9v2S3Iw/Y+Mz4BGvGXjO4ibjQrRg+LIEqOop6b5EMfdVtmpmhOXwlsp6aTGq7EKabR8j2CzIrD2dEM8tskH+0gJ8mWBV+0XczBQMwCvNlF62A6r/w1L346e9CJtUhxL89pI8YmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 20:41:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3659 invoked by uid 111); 29 Sep 2026 20:41:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 16:41:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 16:41:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ll: use read_mmfile() to read external merge
 results
Message-ID: <20260929204157.GA1733321@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065442.GD1697497@coredump.intra.peff.net>
 <xmqqzewzg8w0.fsf@gitster.g>
 <20260929201134.GA1713437@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929201134.GA1713437@coredump.intra.peff.net>

On Tue, Sep 29, 2026 at 04:11:34PM -0400, Jeff King wrote:

> I had imagined just fixing this in ll_ext_merge(), like:
> [...]
> which reduces the weirdness coming out of that function. But it wouldn't
> help with other drivers (which may or may not have similar problems? I'd
> guess not, since they are all operating internally).

So here are patches to do that, including a cleaned-up version of the
reproduction I posted.

I think ll_ext_merge() is the only driver that has this weird error
case, so it should be sufficient. Your patch would protect a potential
future driver, but I'd be surprised if we had one that introduced the
same NULL-but-not-an-error behavior.

  [6/5]: merge-ll: handle external driver status before reading result
  [7/5]: merge-ll: report an error when reading external merge results fails

 merge-ll.c        | 14 ++++++-------
 t/t4200-rerere.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)

-Peff
