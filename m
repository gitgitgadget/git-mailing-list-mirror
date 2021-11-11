Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC7C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81E361002
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhKKU0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:26:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:57662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231754AbhKKUZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 15:25:59 -0500
Received: (qmail 1421 invoked by uid 109); 11 Nov 2021 20:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Nov 2021 20:23:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1591 invoked by uid 111); 11 Nov 2021 20:23:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Nov 2021 15:23:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Nov 2021 15:23:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YY17rBFIdDl+H47I@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
 <xmqqwnlemwcy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnlemwcy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 09:32:29AM -0800, Junio C Hamano wrote:

> > Now in this case, we're sending too much output, which is OK for the
> > purposes of the connectivity check. It will just walk day-1 and its
> > tree unnecessarily, which is a performance loss but not incorrect.
> 
> The primary use of the traversal in check_connected() is when we
> have new refs we haven't seen, and they go to the positive end of
> the traversal, which will end in the refs we do have (there may be
> tons).  The idea is that when one or more of the new refs are truly
> "new" in the sense that one or more the objects necessary to connect
> them to our refs do not exist, not even in the "not reachable but
> not yet pruned" state, this traversal will hit a missing object and
> will error out.  So, it is alarming that "day-1" is shown without
> painted uninteresting via any of the negative [day-4..day-9]
> commits.  Which means, if we are checking if we need to initiate a
> real fetch to connect day-1 and day-10 to our DAG, when we think we
> have [day-4..day-9] and everything behind them, we stopped traversal
> before seeing all the "objects necessary to connect them to our
> refs".  If day-2 were missing in our repository, we would have
> noticed if we did traversal from sorted tips, but the unsorted
> traversal happily misses it.

Yes, but if day-2 were missing in our repository, then we are already
corrupt. And in most cases we would not notice adding a new ref that is
also corrupt (e.g., imagine adding _just_ day-10 which is a descendent
of day-2, but we stop traversal at day-9 when we see that we already
have it reachable).

So I don't think it is actually changing the check_connected() outcome.
I couldn't come up with a case where we should be checking a commit and
don't. Only the other way around.

> Not that noticing that day-2 is missing from our repository does not
> help much in *this* particular case, though.  It is likely that a
> common negotiation would say "I have [day-4..day-9], and want day-1
> and day-10", that is reponded with "OK, I know enough, here is
> day-10 and its tree/blob that would be missing from a healthy clone
> with everything behind day-9", and it won't include day-2 (nor
> day-1).  So in this particular example, it would not matter if the
> new unsorted traversal is subtly broken (I think the extent of the
> damage is similar to making the SLOP problem deliberately worse),
> but I am not sure if there are other failure modes that would yield
> outright incorrect result.

Yes, I think that framing is right: it is making SLOP much worse. We
could similarly have had bogus timestamps in those commits which would
cause the same outcome. So in that sense it is nothing new. On the other
hand, I wonder how often it will cause extra traversal work (keeping in
mind that this commit traversal is just the first stage; after we find
the commits, then we talk all of their trees, which is the more
expensive part).

For the case of adding new commits directly on top of another branch, I
think there would be no change. But any time you have to walk down to a
common fork point (e.g., imagine I made a new branch forked from an old
bit of history), we may fail to find that. I haven't quite constructed
an example, but I have a feeling we could end up walking over
arbitrarily long segments of history.

> We probably should revert this step as it can affect correctness in
> a big way, but I wonder if the other steps in the same series, or
> other topic that came later, rely on it.

I looked them over, and I think this is pretty independent (with the
exception of the refactoring of the no_walk/unsorted flags, but
obviously that had to come first).

> At the very least, I think this may be prudent during -rc period,
> but on the other hand, I do not know offhand what would later
> pursuade us to reinstate it and convince us that it is a safe thing
> to do.
> [...]
> diff --git c/connected.c w/connected.c
> index cf68e37a97..35bd4a2638 100644
> --- c/connected.c
> +++ w/connected.c
> @@ -107,7 +107,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  	if (opt->progress)
>  		strvec_pushf(&rev_list.args, "--progress=%s",
>  			     _("Checking connectivity"));
> -	strvec_push(&rev_list.args, "--unsorted-input");
>  
>  	rev_list.git_cmd = 1;
>  	rev_list.env = opt->env;

This seems like a pretty safe and minimal backing-out for the -rc
period. We would still ship with "--unsorted-input" as an option (and
mentioned in the docs), though. If we're worried that it might be a dead
end and we don't want to support it, we could revert f45022dc2f
(connected: do not sort input revisions, 2021-08-09) entirely. That
carries a little more risk of accidentally breaking something during the
revert, but from my reading of the patch it should be pretty safe.

I'd be curious to hear Patrick's thoughts on the whole thing.

-Peff
