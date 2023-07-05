Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C14EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGEGKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGEGKv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:10:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727210C3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:10:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B0B8183C4D;
        Wed,  5 Jul 2023 02:10:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yGv65o9XYMUiI0D/jfv+G3KyJ0eVu2YZ76kiAb
        ET/xc=; b=Tr9NiF96GI4JISuZGqLrJo/kdl2mHZirx3IwlQGb5TCsrTlNEBzfxC
        8O/j0Kvke/D8944zbhzQ/lQtD1xTO2uOIUbH0uxqppA0J5p2DzZ8nho3X8bz2dgE
        k6yqzxOkFth6VE1wG3Lo5MUnsT/wh/0NAtfPSnqEH9c9cWa0JCXjQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71F7C183C4C;
        Wed,  5 Jul 2023 02:10:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCF50183C4B;
        Wed,  5 Jul 2023 02:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>,
        git@vger.kernel.org, Steve Kemp <steve@steve.org.uk>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
References: <20230701205703.1172505-1-jan@kloetzke.net>
        <20230702125611.GA1036686@coredump.intra.peff.net>
Date:   Tue, 04 Jul 2023 23:10:47 -0700
In-Reply-To: <20230702125611.GA1036686@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 2 Jul 2023 08:56:11 -0400")
Message-ID: <xmqqmt0a3n2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFCB4E68-1AFA-11EE-BF9F-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That seems reasonable to me. It is changing the definition of
> --points-at slightly, but I think in a way that should be less
> surprising to users (i.e., we can consider the old behavior a bug).

OK.

> The
> existing documentation is sufficiently vague about "points" that I don't
> think it needs to be updated (though arguably we could improve that
> here, too).

True, too.

Having said that, as we lack a primitive exposed to the user script
to only peel one level of a tag, it makes me wonder how much of this
is a practical issue.  Is a tag that points at another tag mere
curiosity and subject of mental gymnastics, or is it a useful
construct with real world use case?  If the latter, isn't it more
like "a tag to a tag _could_ be made useful if we also supported X
and Y and Z" where X could be "There should be a syntax like
A^{commit} that lets us peel only one level of tag"?

> Note that most other tag-peeling in Git (like the peeled values returned
> by upload-pack) errs in the opposite direction: they peel completely,
> and don't show the intermediate values.

Exactly.  While allowing to feed the intermediate level as the
argument to "points at" does sound like a good idea on surface, I am
skeptical about the practical value it brings---if we cannot do this
without any additional overhead (of course if there are tags to tags
in the repository, I am perfectly fine to pay the cost of
dereferencing the chain, but I am more worried about regressing the
performance in repositories without tags to tags), I am not sure if
it is worth it.

> My biggest question would be whether this introduces any performance
> penalty for the more common cases (lightweight tags and single-level
> annotated tags). The answer is "no", I think; we are already paying the
> cost to parse every object to find out if it's a tag, and your new loop
> only does an extra parse if we see a tag-of-tag. Good.

OK.

>   Let me go off on a tangent here, since I'm looking at the performance
>   of this function. The current code is already rather pessimal here, as
>   we could probably avoid parsing non-tags entirely. Some strategies
>   there are:
>
>     1. We could check the object type via oid_object_info() before
>        parsing. This carries a small penalty (two lookups) for tags but
>        a big win (avoiding loading the object contents) for non-tags.
>
>        An easy way to do this is to replace the parse_object() with
>        parse_object_with_flags(PARSE_OBJECT_SKIP_HASH_CHECK), which
>        tries to avoid loading object contents (especially using the
>        commit-graph for commits, which presumably covers most non-tag
>        refs).
>
>     2. We could be using the peel_iterated_oid() interface (this is the
>        peel_ref() thing mentioned in the comment you touched, but it has
>        since been renamed). But it does the "peel all the way" thing
>        mentioned above (both because of its interface, but also because
>        that's what the packed-refs peel lines store).
>
>        So to do that we'd either have to enhance the packed-refs store
>        (which would not be too hard to do in a backwards-compatible
>        way), or switch --points-at to only match either the direct ref
>        value or the fully-peeled value.
>
>   I don't think either of those is something your patch needs to deal
>   with. It is not making these kinds of optimizations any harder (it is
>   the existing "peel only once" behavior that does so). I mostly wanted
>   to get it written down while we are all looking at this function.

My preference would be to see these optimization done first and then
add this new loop on top of it.  That way, we can measure more
easily what kind of additional overhead, if any, we are paying by
adding the loop.

Thanks.
