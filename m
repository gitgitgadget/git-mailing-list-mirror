Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCDCC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 07:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9802860E0C
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 07:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhDQHXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 03:23:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59636 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhDQHXP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 03:23:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7629CC18A;
        Sat, 17 Apr 2021 03:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nYz0YJ4IAoACvWI4ntRksOnH/Qc=; b=XbnQuv
        t+pBERYsD1Kp008//ih4Wo6hIOHDV7BvUvOlMuCrZjCIW2t0JDxigcJ4Xxl1lKND
        yVth9FCVfzsH7EgvZAaYHWixbe2yKdMh0R4ZyRdQeERgj+8WT26weN36tiHt1j2a
        7bwxrT9aZttMUd2O2mPWDvmq8e5jjDoQ7QM7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bS3ofBVfrKcZXGc0DCVoscnN8gXyUwS6
        QKku2sIzisU3l5DsRVt+dp2edYtTsf1NIqXcQxF0K1Q4gt/sxfQZfq8ehWPrmm90
        6Hn8aJzIj/eMOez4Z1WQc9OF+3I3Tq0WXIKYgOIcEzytw/63O66zMtSzKz4W0gDE
        bJ5YxMp7FAI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE5ECCC189;
        Sat, 17 Apr 2021 03:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AF48CC188;
        Sat, 17 Apr 2021 03:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Subject: Re: [PATCH] git-rev-list: add --exclude-path-first-parent flag
References: <20210417001525.19960-1-jerry@skydio.com>
        <xmqqzgxxivrb.fsf@gitster.g>
        <CAMKO5Cutas2BM_CTHTJs_O9NSp2Vyn-bK0jV0K758eq5M6-Oag@mail.gmail.com>
Date:   Sat, 17 Apr 2021 00:22:47 -0700
In-Reply-To: <CAMKO5Cutas2BM_CTHTJs_O9NSp2Vyn-bK0jV0K758eq5M6-Oag@mail.gmail.com>
        (Jerry Zhang's message of "Fri, 16 Apr 2021 18:07:18 -0700")
Message-ID: <xmqqczutiddk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B63603D6-9F4D-11EB-8617-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> On Fri, Apr 16, 2021 at 5:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jerry Zhang <jerry@skydio.com> writes:
>>
>> > Add the --exclude-path-first-parent flag,
>> > which works similarly to --first-parent,
>> > but affects only the graph traversal for
>> > the set of commits being excluded.
>> >
>> >    -A-------E-HEAD
>> >      \     /
>> >       B-C-D
>> >
>> > In this example, the goal is to return the
>> > set {B, C, D} which represents a working
>> > branch that has been merged into main branch
>> > E. `git rev-list D ^E` will end up returning
>> > no commits since the exclude path eliminates
>> > D and its ancestors.
>> > `git rev-list --exclude-path-first-parent D ^E`
>> > however will return {B, C, D} as desired.
>>
>> It is not clera why you want to have this, instead of doing a more
>> obvious "D..E^".  Even better is "E^..E", which is often what you
>> want when viewing a history like my 'seen' that is a straight-line
>> into which tips of branches are merged.
> My motivation is to find the point at which a release branch forked off from
> a main branch, even though the release branch could have been merged
> into the main branch multiple times since it was forked off.
>
> If we add another merge from release to main, it will be more clear
> that those give different results:
>
>         -A-----E-F-main
>           \   / /
>            B-C-D-release
>
> `git rev-list --exclude-path-first-parent release ^main` returns {B, C, D}.
> I've added commit F to show that we don't necessarily have info on E,
> there could be many commits between it and the tip of main.

OK, you meant to deal with repeated merges into integration branch.

So the idea is to just name the end point merge, say F (you also
could name D as the starting point, but see below), and 

 - initially mark its first parent as UNINTERESTING (i.e. E), and
   other parents as INTERESTING (i.e. D).

 - run the revision traversal machinery, but when propagating the
   UNINTERESTING bit, give it only to the first parent.  The second
   and later parents won't become UNINTERESTING.

 - stop after we exhaust INTERESTING commits.

It would probably work for your idealized topology, but I do not
know what happens when there are criss-cross merges.  In the revised
picture, you are merging down from the B-C-D chain into the
mainline, but once the B-C-D chain becomes longer and diverges too
much from the mainline, it becomes tempting to break the "merge only
in one direction" discipline and merge back from the mainline, to
"catch up", and such a merge will have the history of B-C-D line of
development as its first parent.  Would that screw up the selection
of which line of development is uninteresting?

>> > Add the --exclude-path-first-parent flag,
>> > which works similarly to --first-parent,
>> > but affects only the graph traversal for
>> > the set of commits being excluded.
>> >
>> >    -A-------E-HEAD
>> >      \     /
>> >       B-C-D

In any case, it was totally unclear from the proposed log messsage,
and the overlong option name that does not say much did not help me
guess what you wanted to do with it.  Specifically, it is not clear
what "exclude" means (we do not usually use the word in the context
of revision traversal), and when we talk about "path" in the context
of revision traversal, we almost always mean the paths to the files,
i.e. pathspec that limits and simplifies the shape of the history.
Also, it claims that it works similarly to --first-parent, but what
you are doing is to propagate UNINTERESTING bit on the first-parent
chain, which ends up showing the side branch (i.e. B-C-D chain),
without showing the commits on the first-parent chain (A and E).

What are the words that convey the idea behind this operation
clearly at the conceptual level?  Let's think aloud to see if we can
come up with a better name.

 * first parents are unintertesting

 * show commits on side branch(es)

 * follow side branch.

I think that is closer to the problem you are solving, if I
understand what you wrote above correctly.

Perhaps --show-side-branch or --follow-side-branch?  I dunno.
