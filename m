Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA4C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A218164FC9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCJT4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:56:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50465 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhCJT4V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:56:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A42F6ABCA0;
        Wed, 10 Mar 2021 14:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WfiIBMlMGWXB0W6UQhXyW8zE/Ok=; b=u+MLuW
        lGEJsbccYm4Xu6Q5GFq+/Pzoqa1CxbAp3oT9Hf0bHmvjj29ELAukkS7bcXM3UtkH
        ErEGCQyHwrRHwZQ1Wpf0COJ3wy7Qd/haoxNphFCkPx8MSLQrh9BgnF9N4eS/pF6T
        sHHZkT2dn8IznXC7iHpf9o/RBnDaryZ9Bg1yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O48dX4VNUy+aQoeqS5xnLCp8FmtMwXoI
        4mQl3Cp1cyuTVXg5u3nduZHMQiONMe6gOKAA9n8JRpdx1qRnypVYYPCgWXMxRS5R
        RhJn6X4+95mEmagVXb23mt25UeOkepg9RrRJo3kwCe9H4oky7s6CgrprjmuH4ZQP
        i1yMzBe/0Lk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A7C0ABC9F;
        Wed, 10 Mar 2021 14:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 299FDABC9E;
        Wed, 10 Mar 2021 14:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqqwnugywax.fsf@gitster.c.googlers.com>
        <20210310165716.2014235-1-jonathantanmy@google.com>
        <xmqqa6rakgj3.fsf@gitster.g>
Date:   Wed, 10 Mar 2021 11:56:19 -0800
In-Reply-To: <xmqqa6rakgj3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Mar 2021 10:30:40 -0800")
Message-ID: <xmqq5z1ykckc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEE29828-81DA-11EB-A477-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I already said that I think 2aec3bc4 (fetch-pack: do not mix
> --pack_header and packfile uri, 2021-03-04) is OK as a short-term
> fix for the upcoming release, but it does not change the fact that
> it is piling technical debt on top of existing technical debt.
>
> And that is why I am reacting against your earlier mention of
> "filering out" rather strongly.  The approach continues the "keep
> the single args array in the belief that two must be mostly the
> same", which I view as a misguided starting point that must be
> rethought.

Another way to think about the codepath is this.

Can the bulk of get_pack() that deals with a single incoming
packfile (from the part that makes the decision to use either
index-pack or unpack-objects and chooses what options to pass to the
command, to the part that actually calls run_command() and feeds the
packdata to the command) be made into a helper function that handles
one packdata stream and nothing else?  Such a helper would most
likely take as its parameters

 - a stream to read the packdata from (for in-stream packfile that
   is handled by get_pack(), we already have it available)

 - fetch_pack_args and other options that are meant to affect the
   operation of fetch-pack, among which are two bits that are of
   interest in this topic: if we want to run fsck-objects and if the
   entire fetch-pack is dealing with more than one packfile
   (currently, the only source of need to process multiple packfiles
   is packfile URI mechanism, but that does not have to stay that
   way).

Then get_pack() can move a lot of code out of it to this helper and
just call it.  The processing the other packfile obtained by the
packfile URI mechanism out of band can open the packstream and call
the helper the same way.  When packfile URI mechanism is in use, both
invocations of the helper would get "you are not alone so fsck may
hit missing objects" bit, if fsck-objects are asked for.

That would avoid the "duplicated logic" and still allow the code to
choose the best disposition of the incoming packdata per packfile.

In an extreme case, it is not hard to imagine that somebody prepares
a very small base packfile and feed it via packfile URI mechanism,
but have accumulated so many objects that are not yet rolled into an
updated base packfile---cloning from such a repository may result in
running unpack-objects for the packfile that came out of band, while
processing the in-stream packfile with index-pack.

Hmm?


