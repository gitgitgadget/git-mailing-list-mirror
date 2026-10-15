Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954748EBD0
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046524; cv=none; b=hERcw3N5Gz8JNVHMyStHOb2H88sgkStTaV5C/V1D27PR8rsTiejlPkmvoxvk9vC3HvBUWwx9JYGbZlW2l34ei14aXxuORMgHuPSXPU3cDfFUZZfnuqI/Utby8eS2hpijH22FTmndtBN4zIhqKCo/FJYqHmBuavwhA24fhgsJWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046524; c=relaxed/simple;
	bh=jZJlkkH8yO9h54iJ6W10m1jDJM43foet15dbVyUXjQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM5qgBPK10n5h4w41gEK42YleB1I2YETz8RdLV7s6Z7ICzhRjOhXkAHkMFIMAxEoy4cAuf5ALmsmME1RZX8H6fzuyXYuvGkV6MkVgUluk0apGSXs8is5lVAMEJ6+m7oQmcTgPkdxdyOcSVpwMKiYQGehWxnJUmu1kmBrg8UJjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M2eWQlae; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M2eWQlae"
Received: (qmail 75193 invoked by uid 106); 15 Oct 2026 06:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jZJlkkH8yO9h54iJ6W10m1jDJM43foet15dbVyUXjQ4=; b=M2eWQlaebXJwl8iXs6/lSz7+yIETI0IGqSIYd3pgV00PDZwWgT+2IRIlXC+zGQ8UBCe69NZ6ujRFb9uIK9J38aqQ3J6rMO9/y2CkSMDbk91D4E3RSJ9kQ4F+LLe4fzRfYlLhfsPmcyItiTg08+v4PHKHGbvRE33EPOh2SSAFNbp1jeglv4/YlmNWudJsuMHV5zEZQ8qewmsXPmZgwmOJM4J4Fzvcb8bU2J9MJUK/+7Qh3M17vAmX9ogPOyi52sp3xZzMfN+5kG//EPLPGIxg1tPBORYlExQwINVdhGaJISuLQDyBVLANzuvnZLph0tlmhKshzWJVtT7F5X32OEFoIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2026 06:41:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48376 invoked by uid 111); 15 Oct 2026 06:42:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2026 02:42:02 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Oct 2026 02:41:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Igor Wiedler <iwiedler@gitlab.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] connected: do not walk alternate refs in deepening
 fetches
Message-ID: <20261015064158.GA1979109@coredump.intra.peff.net>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
 <xmqqcxtcte5m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxtcte5m.fsf@gitster.g>

On Wed, Oct 14, 2026 at 09:55:49AM -0700, Junio C Hamano wrote:

> > That only works because "--alternate-refs" comes after "--not".
> > cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
> > 2018-07-02) drops "--not --all" for deepening fetches, since those
> > need to verify the whole chain up to the new shallow boundary rather
> > than stopping at refs we already had. For such fetches we therefore
> > run
> >
> >   git --shallow-file ... rev-list --objects --stdin --quiet --alternate-refs
> 
> Ouch!  Thanks for spotting the 8-year-old mistake.  It shows how
> rare the deepening fetches together with the use of alternate refs
> in real life?

Thanks for cc-ing me. I looked at Igor's v1 patch, and it's exactly the
solution I would have expected. It should have been written that way in
39b44ba771 (check_everything_connected: assume alternate ref tips are
valid, 2019-07-01), because the intent was "treat alternate ref tips
just like we treat our own existing ref tips". So wherever we use
"--all", we should use "--alternate-refs", and since --all was moved
into that non-deepening conditional, --alternate-refs should go there,
too.

BTW, if you are curious why 39b44ba771 made such an obvious mistake, it
is exactly because it predated that move! The original patch was written
in 2014 and used internally at GitHub. I rebased it forward to send to
the list in 2019, but I don't even think I got a textual conflict at all
(because the movement of "--not" and "--all" were a few lines away).

So it was a very subtle semantic conflict between the two patches. But
because the rebase rewrote history to put mine on top, it looks like I
just did it wrong from the start. ;)

> But stepping back a bit, doesn't the same argument apply even when
> we are a fully populated repository and making a non-deepening
> fetch?  We can trust "--not --all" to make the traversal to stop at
> tips of our local refs and can be assured that all history behind
> the tips we are fetching will still be connected, but a traversal
> that stops at the tip of a shallow repository will break our
> repository, and in a worse form than the shallow repository we are
> borrowing from, because operations in that repository are guarded by
> its shallow boundaries that we usually do not see, but operations in
> our repository do not have the same shallow boundaries in effect.

It took me a few reads to parse this, but I think you are saying: it is
a problem if we are a non-shallow repository trying to use a shallow
alternate for verification?

That sounds likely, though this is the first time I have looked at
cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
2018-07-02) and the surrounding issues. As I understand the issue, it is
really "are the refs we are going to use to verify coming from a shallow
repo which might not have all objects". But I'm not sure how that
interacts with opt->is_deepening_fetch (and why it isn't just checking
if we are in a shallow repo).

> I do agree that for the purpose of "see if this traversal barfs with
> missing objects to see if the updated tips have all the objects
> behind it", listing the alternate refs behind "--not" is the right
> thing to do and it is broken to have "--alternate-refs" without
> having "--not" like the current code does.  But I am not convinced
> that disabling --alternate-refs only when you are deepening is not
> solving the problems of using alternate-refs introduces.  Shouldn't
> the fix be more like two (or more) steps, i.e.,
> 
>  * [1/2] for check_connected(), use the attached patch instead.

OK, so this moves the "--not" out so that we always do it. It's ignored
in the case that we are deepening and don't have any alternates, but it
shouldn't hurt anything.

>  * [2/2] update odb_for_each_alternate_ref() so that it ignores any
>    and all refs from shallow repositories.

Yeah, this seems reasonable. Alternates don't necessarily even have a
full repo, but in that case they wouldn't have any refs, either (IIRC we
do some magic to guess at the containing repo of the alternate).

-Peff
