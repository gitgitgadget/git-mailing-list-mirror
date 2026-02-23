Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11A3EBF0F
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830741; cv=none; b=A7vCV69olspcJhXXwgWwmKBxZVSlexn6Rdzugw8jty6DM4n2hG0aya97pqAd11NH/7bLzmuS34OpNbqUeUyroGXOAgU7P5kkAcX2fsT4FT7O7mOuRVaYgJiAf3C8Nxe1Rma0tZJAz1IwZuw/5ZhxBjhCzd91lu5Nunno+i7oLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830741; c=relaxed/simple;
	bh=iFKGRi2qdAuYEhHPEQcPRSQo2UC9OcnNHYvH7TsZiIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHVaSfTfnoPyEhXhO0SmKjXFGASeCWFAig7mSav7BJ8lpYOVxPcjhcuEoeW3gh0oJlQU0B4J+pgXNhMaBGiVcUkVYmN5h35EcdfY2PyvMMiDbKykviKSLYO3FMqnEfWTrfKukwtyvDjlkOCM7xcTTQIeV1iSAaY8ET80NNRZVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=abaj4J/E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="abaj4J/E"
Received: (qmail 46650 invoked by uid 109); 23 Feb 2026 07:12:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iFKGRi2qdAuYEhHPEQcPRSQo2UC9OcnNHYvH7TsZiIY=; b=abaj4J/Ev2t5fm7W/gw2BT208MoczPnBwZEoee68oA0bGHHxQmkvYIYOSJwnnzCtCn7v4aO9oatai9CuMy+hmXjMd52xMuPshfUZlTqaWc8cr8vh/98m+0CwCJ2T6dklVlJN138d2wG1kJTNlVPeVa1hrt8p3izKhemgOVsFWgT0CX1a0caRojVqhr9v5Ooo3gtl8bfEONtt0NKI4Z5Tinxmi4JM/Bmodnde8IWvU0xXemTWhOuTdYROm5Qk+aJw2TEOqhAzEPD/oCbcS77rnqltrLMDwUTdi0rI6bcPGjs34noovsy+X4l35GYTpcbI6siWliQN/1MjZE6VD87thA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 07:12:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 93014 invoked by uid 111); 23 Feb 2026 07:12:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 02:12:20 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 02:12:15 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <20260223071215.GA136463@coredump.intra.peff.net>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <xmqqv7fopflu.fsf@gitster.g>
 <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>

On Sun, Feb 22, 2026 at 11:07:41PM +0000, brian m. carlson wrote:

> I noticed that the code here seems to have come in with the 2.53 cycle,
> so we may want to cherry-pick it to `maint` at some point if it seems
> like the problem occurs often.  From what I can tell, it only occurs
> when one explicitly invokes `git fsck`[0] and not on transfer, so it
> shouldn't cause a DoS against server implementations.
> 
> Of course, we should wait for Patrick, who authored this code, to chime
> in and lend his expertise here.  I must admit I'm not very familiar with
> this area, although I had recently seen the MRU code when working on
> pack index v3 (and then I thought, "is this actually the problem?").

The problem seems to bisect to c31bad4f7d (packfile: track packs via the
MRU list exclusively, 2025-10-30), which is not terribly surprising, as
it was one of the known risks of collapsing the two lists into one.

Your solution is using the tool provided by that commit for its edge
case:

    Note that there is one important edge case: `for_each_packed_object()`
    uses the MRU list to iterate through packs, and then it lists each
    object in those packs. This would have the effect that we now sort the
    current pack towards the front, thus modifying the list of packfiles we
    are iterating over, with the consequence that we'll see an infinite
    loop. This edge case is worked around by introducing a new field that
    allows us to skip updating the MRU.

So in that sense it is the right thing. But it really makes me wonder if
we are going back to keeping two lists (one MRU and one in some stable
order). Or at the very least providing _some_ iteration method that is
guaranteed to be stable (whether a linked list or a function), so that
iterating code is not subject to this subtle dependency by default.

Having to identify each potential spot and set a "btw, don't switch the
pack list order!" flag seems error-prone. And also loses efficiency when
you are iterating a pack and accessing objects in it (since we can't
push that pack to the front of the MRU then, even though we'd expect
there to be high locality with our iteration).

-Peff
