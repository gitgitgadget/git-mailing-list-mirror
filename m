Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB50156F3F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264434; cv=none; b=MppSKUNKEsXmVloLo8ndWT9Qba2hjduavTnaS00xhTMdfAyNlrXlkhxf3aj5ZJeYCimfXLGYZrt09H4CB7n6ly+Y+lEpOQitWkXaTJAzOSdvAsmVMhuklKIYXe4SpCW/hOiNqNVeHS15HCCq5mDjEy/cfuPU2bWXtqHqqkRl0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264434; c=relaxed/simple;
	bh=PlqP6KW/lsbq9Gu8nZe96Sh2nJf7yuvsbhqDJagK6LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOEWIWxsVf/OUT87uzWUKqKN+CFxsUHzEZde/zCOje7NgKTaleIzJXP/zcwAceE3ZG+leB74hbAUcs0A2/G7giO7UY4vGmYxH89PpzTGPByDWHHVjA9J3HSgjrlx7btla+583dtlvPzAf3A5KUDucy0j82JMbhd30rKQ4rF2vxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IM0wO1MR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IM0wO1MR"
Received: (qmail 10164 invoked by uid 109); 22 Nov 2024 08:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PlqP6KW/lsbq9Gu8nZe96Sh2nJf7yuvsbhqDJagK6LU=; b=IM0wO1MRrqZ8ZhO+C17FmYcVD1OC+xz3VvtbDF5D3MkU7NkI09HoacHdoOvDgmOnGAxons8glPf4sIPWQIqBW4nC4ck/mh9qYFwJ0eEKCUlheGFwE36PG+TWMsfiZTcvsGz2iuSxDrpBIdqLZDdfh484YBn3eT7XkiVtLLoAOJeAKi5Sjpa4Mli857+1wkCv6y8iVWalSc2eN/uriZvwqlQ4UQ8ig7Ki+789dcT8z5aEwZykxtcq+WPO5bzW+iio5e59qXIuuACdak686fhF+eymLP2GBtw0dhJ3mMg05j0vmR/FRIYOVK+io1FrkOEI/DcdYL4NG9RMFghNP5ipIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Nov 2024 08:33:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1780 invoked by uid 111); 22 Nov 2024 08:33:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2024 03:33:55 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Nov 2024 03:33:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
Message-ID: <20241122083350.GD1179306@coredump.intra.peff.net>
References: <cover.1731518931.git.me@ttaylorr.com>
 <cover.1731591708.git.me@ttaylorr.com>
 <d73b8fe2d63c8ad08ad0c4ffeffb5ee2509b2d50.1731591708.git.me@ttaylorr.com>
 <xmqqjzcvand6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzcvand6.fsf@gitster.g>

On Fri, Nov 22, 2024 at 01:44:37PM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > This regression comes from ca0fd69e37 (pack-objects: prepare
> > `write_reused_pack_verbatim()` for multi-pack reuse, 2023-12-14), which
> > incorrectly assumed that there would be no gaps in reusable regions of
> > non-preferred packs.
> 
> I was reviewing the past release notes from this year, and saw this
> snippet in the 2.44 release notes:
> 
>  * Streaming spans of packfile data used to be done only from a
>    single, primary, pack in a repository with multiple packfiles.  It
>    has been extended to allow reuse from other packfiles, too.
> 
> Essentially this two-patch series the change completely so we only
> reuse pack data from the primary pack?

No. There are really three levels in increasing order of cost:

  1. we directly copy out the bytes from the start of a pack completely,
     up until the first object that is not needed to be sent

  2. from there we process objects one by one, with a few checks and
     adjustments to make sure they can be copied verbatim (like ofs
     delta adjustment to account for earlier missing objects)

  3. we add the objects to the big object_list struct, they become
     candidates for delta compression, etc

We call the first two generically "pack reuse". And this two-patch
series is fixing a case where we were doing (1), but needed to do (2).

So I think the changelog entry still applies (there are other cases
where we might jump from 1 to 2 as well, like if the output needs to
convert to REF_DELTA).

-Peff
