Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A9C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D10261076
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhKKRfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:35:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59909 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRfV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:35:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A6E2F0E06;
        Thu, 11 Nov 2021 12:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yfPpYRukz1jOg98Z4R4ZRuFRzHEFujWOqptDh5
        os7cI=; b=t2AwOeEj5WIx11y0gOPp6rQQUEDpERPIrbQQkO6oqiME+mUxaiUR+M
        VYYEVM/oYaL+piq4jZqy2F2XNLTa/JTw7foD2bRRIUJd4P5lGktc9DldfUpjhphj
        OV1SqvaEN06iPtINPQPaM9aBSZ7L2fp27s3/ncO2y8+VZPqEobxmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EA7EF0E03;
        Thu, 11 Nov 2021 12:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 937F4F0DFF;
        Thu, 11 Nov 2021 12:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
References: <xmqq4k8kzuz2.fsf@gitster.g>
        <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
Date:   Thu, 11 Nov 2021 09:32:29 -0800
In-Reply-To: <YY0HbQJEWbOwuuFj@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 11 Nov 2021 07:07:09 -0500")
Message-ID: <xmqqwnlemwcy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E1C23A-4315-11EC-8A82-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 09, 2021 at 04:59:29PM -0800, Junio C Hamano wrote:
>
>>  * The revision traversal API has been optimized by taking advantage
>>    of the commit-graph, when available, to determine if a commit is
>>    reachable from any of the existing refs.
>
> I was thinking a bit about this change, specifically f45022dc2f
> (connected: do not sort input revisions, 2021-08-09). At the time, Junio
> said[1]:
>
>   Sorting of positive side is done to help both performance and
>   correctness in regular use of the traversal machinery, especially
>   when reachability bitmap is not in effect, but on the negative side
>   I do not think there is any downside to omit sorting offhand.  The
>   only case that may get affected is when the revision.c::SLOP kicks
>   in to deal with oddball commits with incorrect committer timestamps,
>   but then the result of the sorting isn't to be trusted anyway, so...
>
> But wouldn't failure to sort the commits actually _create_ such an
> "oddball commits" scenario, because we'd see the UNINTERESTING commits
> in an arbitrary order, especially with respect to the interesting ones?

You're right.

> So indeed, we get confused by the unsorted input and give the wrong
> answer. We should look at and propagate UNINTERESTING marks from day-9,
> etc on down to day-1, but we don't.
>
> Now in this case, we're sending too much output, which is OK for the
> purposes of the connectivity check. It will just walk day-1 and its
> tree unnecessarily, which is a performance loss but not incorrect.

The primary use of the traversal in check_connected() is when we
have new refs we haven't seen, and they go to the positive end of
the traversal, which will end in the refs we do have (there may be
tons).  The idea is that when one or more of the new refs are truly
"new" in the sense that one or more the objects necessary to connect
them to our refs do not exist, not even in the "not reachable but
not yet pruned" state, this traversal will hit a missing object and
will error out.  So, it is alarming that "day-1" is shown without
painted uninteresting via any of the negative [day-4..day-9]
commits.  Which means, if we are checking if we need to initiate a
real fetch to connect day-1 and day-10 to our DAG, when we think we
have [day-4..day-9] and everything behind them, we stopped traversal
before seeing all the "objects necessary to connect them to our
refs".  If day-2 were missing in our repository, we would have
noticed if we did traversal from sorted tips, but the unsorted
traversal happily misses it.

Not that noticing that day-2 is missing from our repository does not
help much in *this* particular case, though.  It is likely that a
common negotiation would say "I have [day-4..day-9], and want day-1
and day-10", that is reponded with "OK, I know enough, here is
day-10 and its tree/blob that would be missing from a healthy clone
with everything behind day-9", and it won't include day-2 (nor
day-1).  So in this particular example, it would not matter if the
new unsorted traversal is subtly broken (I think the extent of the
damage is similar to making the SLOP problem deliberately worse),
but I am not sure if there are other failure modes that would yield
outright incorrect result.

> My intuition is that this is _probably_ the only type of incorrect
> answer we'd give (i.e., that we'd never go the other way, omitting an
> object we should have included) because nobody would ever set the
> UNINTERESTING flag unnecessarily, and everybody_uninteresting() does do
> a full scan looking for any positive tips.
>
> Still, I didn't see this subtlety mentioned in the earlier discussion,
> and it's a bit alarming not to understand all of the possible
> implications. I'm not sure if it rises to the level of something we want
> to consider more or address before the release. Sorry to only come up
> with this at the -rc2 stage, but I figure now is better than right after
> the release. ;)
>
> -Peff
>
> [1] https://lore.kernel.org/git/xmqqa6lzwu31.fsf@gitster.g/

We probably should revert this step as it can affect correctness in
a big way, but I wonder if the other steps in the same series, or
other topic that came later, rely on it.

At the very least, I think this may be prudent during -rc period,
but on the other hand, I do not know offhand what would later
pursuade us to reinstate it and convince us that it is a safe thing
to do.

 connected.c | 1 -
 1 file changed, 1 deletion(-)

diff --git c/connected.c w/connected.c
index cf68e37a97..35bd4a2638 100644
--- c/connected.c
+++ w/connected.c
@@ -107,7 +107,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
-	strvec_push(&rev_list.args, "--unsorted-input");
 
 	rev_list.git_cmd = 1;
 	rev_list.env = opt->env;
