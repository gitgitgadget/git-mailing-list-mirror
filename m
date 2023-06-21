Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F658EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 16:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFUQx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFUQx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 12:53:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF2A2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 09:53:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF0FA278D4;
        Wed, 21 Jun 2023 12:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cArFPAXCwoslNfqU1XNwJqQsl5wxfKDuxv9UGGTbO0s=; b=Exqn
        90h4KSBaTOb+jHBV9JCuy/oKf3PkUFjZHFfzOEKdtzDB48rihxHPM1inG24ua1oq
        PV68mt5B5QemLpfjWQ6uhAB6utvHIxAeDXsXKqZ+rcUVqdd27HbyT0BfahTk46/f
        AHvlyoH7RDiFR/L3PzqEUqVd08DioI/C2lr4WPw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4B31278D3;
        Wed, 21 Jun 2023 12:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8708D278D2;
        Wed, 21 Jun 2023 12:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-7-christian.couder@gmail.com>
        <xmqqmt10s0cw.fsf@gitster.g>
        <CAP8UFD3864uUjb0vR+B7xETJTFJoWdEqA5Gdyr42Lg3t8Auk=Q@mail.gmail.com>
Date:   Wed, 21 Jun 2023 09:53:50 -0700
Message-ID: <xmqqy1kchi3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 331A4500-1054-11EE-AB47-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It might indicate that we prefer to be safe, do things in different
> steps and not provide an easy way for users to shoot their own foot.
> For example it seems pretty safe to do things like this:
>
>   1) put all the objects we think should be on the promisor remote in
> a separate packfile
>   2) start checking that each object in that packfile is available on
> the promisor remote
>   3) if an object in that packfile isn't on the promisor remote, try
> to send it there
>   4) if we couldn't send the object, error out
>   5) if we haven't errored out after checking all the objects in the
> packfile, it means all these objects are now available from the
> promisor remote and we can safely delete the packfile

I may be missing something, but to me, the above sound more like a
tail wagging the dog.

Instead of saying "while repacking, we'll create the new pack with
the objects that we suspect that we cannot re-fetch from the
promisor (allowing false positives for safety), and store the rest
in a backup pack (that can immediately be discarded)", the above
says "while repacking, we'll create the new pack with objects that
match the filter, and store the rest to another pack".  But because
the object selection criteria used in the latter is not something
with practical/useful meaning, in other words, it does not exactly
match what we want, we fill the gaps between what we want (i.e. sift
the objects into "refetchable" and "other" bins) and what we
happened to have implemented (i.e. sift the objects into "match
filter" and "other" bints) by sending the objects that we _should_
have included in the new pack (i.e. "not refetchable") to the
promisor to make them refetchable.

I do not know what to think about that.  I do not think there is
even a way to guarantee that the push done for 3) will always be
taken and still leave the resulting promisor usable (e.g.  we can
make them connected by coming up with a random new ref to point
these "we are sending these only because we failed to include them
in the set of objects we should consider local" objects, but then
how would we avoid bloating the refs at the promisor remote side
(which now has become a "dumping ground", rather than holding the
objects needed for histories that project participants care about).

As an argument to salvage this series as (one of the possible
ingredients to) a solution to "slim down a bloated lazy clone"
problem, it sounds a bit weak.

Thanks.
