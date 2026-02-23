Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5C34E777
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838871; cv=none; b=R0vZcDcdrFyfiEbGIfMcfs/9gKo6kL9Evf6tt3qo/dCL0AiEmpBJKz+BhuAQv4G5Qu8f87h3PWHbpSOuCAz1aF38fKfMxEM1bifW7U1RqFLp6pni+73G/9K0mG1jPWa26U5uCii5pBt/JPjeT3LAFlyzYuAX3gII3YxwmDPVD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838871; c=relaxed/simple;
	bh=j4UTKZS5Iff0eSquV0ZnXpuldhyVfi2JT5ThlI/q/JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXht1D6n3T7p7yjk8efVXUdhqaAnySaqW+OHywZZ+D/ZYOnsdNnY4kCrBJBAKNBI6NnMgpzcJhyQ/3Z6WbArAuKodSIc1wrhBbfoNNrkHx0+YaPj/78n59Zh7Ulr/g9wXgQHpY65LaWDHYshRbKz8RdfUDuXYyoO02MWC78E9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JKCFxsRa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JKCFxsRa"
Received: (qmail 49458 invoked by uid 109); 23 Feb 2026 09:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=j4UTKZS5Iff0eSquV0ZnXpuldhyVfi2JT5ThlI/q/JQ=; b=JKCFxsRaelORjym1NtPTLfZBUpobHN7WQ1iBLvAsVl4+uSKVTP5iDu1zk6S4NIUtFU+XXW5sNdXNkLf51T7mzXiX0c2qXD7y3e/b/Mfmgf59JbB6QO7ffAmglnGX43/ayonn3zewGmZKTnNOOgypbsuBH3ApC5bMFRkIBeIKEAM4n/Zai+iwRudhLzs4MffZBRlVgDNzJalUkS9aDljYczsACZuvJxO+DQuCm9hJ9O2qzO1fMewyIBVc4W4QUWi4scfgT1MXpy+65KnSQKlNlk12tO7PzC8EJr0YRcm1/SI5XUK0ggC0c3T1BHrf5J0XxozTdeAqdU3BNGOLdd0zTQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 09:27:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96216 invoked by uid 111); 23 Feb 2026 09:27:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 04:27:54 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 04:27:49 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <20260223092749.GA209358@coredump.intra.peff.net>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <aZwTPfmyrFp-QAPq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZwTPfmyrFp-QAPq@pks.im>

On Mon, Feb 23, 2026 at 09:43:41AM +0100, Patrick Steinhardt wrote:

> This is because ultimately the root cause seems to be a bit more
> complex: we don't only care about there being multiple packfiles. We
> also care about "core.bigFileThreshold".
> 
> Typically, we don't execute `find_pack_entry()` at all when verifying
> packfiles as we iterate through objects in packfile order. We thus don't
> have to look up objects via their object ID, but instead we do so by
> using their packfile offset. And this mechanism will not end up in
> `find_pack_entry()`, and thus we wouldn't update the MRU.
> 
> But there's an exception: when the size of the object that is to be
> checked exceeds "core.bigFileThreshold" we won't read it directly, but
> we'll instead use `stream_object_signature()`, which eventually ends up
> calling `odb_read_stream_open()`. And that of course _will_ call
> `find_pack_entry()`, as we're now in the mode where we search by object
> ID, not by offset. And consequently, we'll update the MRU in this call
> path.

Good find.

> With that knowledge it's kind of easy to reproduce the issue: we simply
> need two packfiles, and each of them must contain at least one blob that
> is larger than "core.bigFileThreshold".
> 
> Now I agree that the below proposed fix would be a good change to make
> the code more solid while we still have `repo_for_each_pack()` (I plan
> to eventually get rid of it). But arguably, the above logic is kind of
> broken regardless of this: we are asked to verify objects in the current
> pack, but we may end up verifying the object via a different pack. So if
> the same object were to exist in multiple packs, we might end up only
> verifying one of its instances.

Yeah, that was my immediate response after reading your analysis above
(that fsck should not be doing find_pack_entry() in the first place
here).

-Peff
