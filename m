Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F35C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39EE64FB1
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCJSbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:31:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56701 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCJSaq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 13:30:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21FDA11894A;
        Wed, 10 Mar 2021 13:30:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnEUezra4S3tIN6rGeGLZvJuzAY=; b=rkaw2V
        gISen/3zVfBXrU1smIEKC/jajCpoZvs/xaWsO2GT4ET9nI6pxUR3SOudhSxTM2oa
        8HtEbyKtPB3+YgiE4VgsYLFn/lrTR00avbpBxlr2Ly8sk07NVrtV+wzrFemorEg9
        83Pk58bha9AkJbHSlpyZ3QMT0onSvz38DqUkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A4i3CxLqoYuVM+2gwuvYXSK3skFjAyX7
        pmLrlkCjxHlFWjNjojkyR7CfxszXdDF9hc7zC2tOHNiQK1xm3+El6c4EZA40TQpO
        55hc3u3ayepCTaL0y7PPnxHw4+ZeMpUxqXn3i5FoB4/P8RVZPO25DhTN5yzuCIGf
        FeQoLVTdVYo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AC63118949;
        Wed, 10 Mar 2021 13:30:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41817118948;
        Wed, 10 Mar 2021 13:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqqwnugywax.fsf@gitster.c.googlers.com>
        <20210310165716.2014235-1-jonathantanmy@google.com>
Date:   Wed, 10 Mar 2021 10:30:40 -0800
In-Reply-To: <20210310165716.2014235-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 10 Mar 2021 08:57:16 -0800")
Message-ID: <xmqqa6rakgj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B874A342-81CE-11EB-B191-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> You mentioned --fix-thin (5) and --promisor (8). Why do you think that
> none of these should be given to the "index-pack" that processes the
> packfiles given by URI?

Actually, --fix-thin is probably even worse than that.

As the code processes the in-stream packdata before processing or
even downloading the pregenerated URI packfile, the objects
necessary to fix a "thin" in-stream packdata are likely to be
unavailable (it is exactly the same problem as the one that made us
to delay the fsckobjects done in index-pack when URI packfile is
involved, isn't it?).  Even if the client asks --thin, the server
side shouldn't produce a thin pack for in-stream packdata, no?

> Perhaps it could be argued that these extra
> packfiles don't need --fix-thin (but I would say that I think servers
> should be allowed to serve thin packfiles through URI too), 

I agree that URI packfile could be thin; after all, the server end
chooses, based on what the client claims to have, which pregenerated
packfile to hand out, so it is perfectly fine to hand out a
pregenerated packfile that is thin if the client asks for a thin
pack and says it has base objects missing from that packfile.  And
because it is (assumed to be) pregenerated, we can make a requirement
that no URI packfile should depend on objects that are created later
that that (which means it won't depend on in-stream packdata).

But we cannot process a thin in-stream packdata, if we are to
process it first, right?

> but I think
> that --promisor is necessary (so that a server could, for example,
> offload all trees and commits to a packfile in a CDN, and offload all
> blobs to a separate packfile in a CDN).

Yes, both packfiles conceptually are given by that same server who
promises to be always available to feed us everything we'd need
later, so both packfiles should be marked to have come from the same
promisor.  So this is one example that happens to be sharable
between the two.

But I do not see it as an indication that the two packs inherently
must be processed with the same options.

> Looking at this list, I think that all the arguments (except 9, which
> has been fixed) are necessary (or at least useful) for indexing a
> packfile given by URI.

I have to say that this is focusing too much on the current need by
going through how the current code handles two packs.  Of course, if
we start from "two must be the same" viewpoint, and restrict what
the code can do by "guarding" bits that require the two to be
different out based on "if (index_pack_args)", then the resulting
code would invoke two index-pack the same way.

I am more worried about the longer term code health, so "currently
mostly the same" does not make a convincing argument for the future
why the two must be processed the same way.

>> Also, because this loop copies everything in cmd.args, if our
>> in-stream packdata is small, cmd.args.v[0] would be "unpack-objects",
>> and we end up asking the command to explode the (presumably large
>> enough to be worth pre-generating and serving via CDN) packfile that
>> is given via the packfile URI mechanism.
>
> I specifically guard against this through the "if (do_keep ||
> args->from_promisor || index_pack_args || fsck_objects) {" line (which
> is a complicated line, unfortunately).

I am aware of that line that forbids the in-stream packdata from
getting unpacked into loose objects.  But unless we were told to
keep the resulting pack, or run fsck-objects via the index-pack, I
do not see an inherent reason why the "most recent leftover bits
that are not in the pregenerated pack offloaded to CDN" objects must
be kept in a separate packfile, especially if the number of objects
in it is smaller than the unpack limit threshold.  In other words,
I view that "guard" as one of the things that blinds us into thinking
that the two packs should be handled the same way.  It is the other
way around---the guard is there only because the code wanted to handle
the two packs the same way.

When cloning from a server that offers bulk of old history in a URI
packfile and an in-stream packfile, shouldn't the result be like
cloning from the server back when it had only the objects in the URI
packfile, and then fetching from it again when it acquired objects
that came in the in-stream packfile?  The objects that come during
the second fetch would be left loose if there aren't that many, so
that the third and subsequent fetches and local activity can
accumulate enough loose objects to be packed into a single new pack,
avoiding accumulation of too many tiny packs.  And the "guard"
breaks that only because this codepath wants to reuse cmd.args that
is unrelated to populate index_pack_args.  Isn't that an artificial
limitation that we may want to eventually fix?

When we want to fix that, the "options are mostly the same when we
use the index-pack command for both packdata, so let's copy the
entire command line" would come back and haunt us.  The person who
is doing the fix may be somebody other than you, so it may not
matter to you today, but it will hurt somebody tomorrow.

I already said that I think 2aec3bc4 (fetch-pack: do not mix
--pack_header and packfile uri, 2021-03-04) is OK as a short-term
fix for the upcoming release, but it does not change the fact that
it is piling technical debt on top of existing technical debt.

And that is why I am reacting against your earlier mention of
"filering out" rather strongly.  The approach continues the "keep
the single args array in the belief that two must be mostly the
same", which I view as a misguided starting point that must be
rethought.

Thanks.

