Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C344C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3180961AAB
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353738AbhJARE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:04:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58599 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhJARE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 13:04:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37506D1874;
        Fri,  1 Oct 2021 13:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lumlXZV8sLX8JrR9iSq61Wadx672E1UzYcPr/G
        43tto=; b=YzCMAndlNRc3TmESvZjcN2jAI9067cegiKPNl7EXNLlSQLK5akvZ/r
        L9sAN5dCKdd58FoUyI+mG7T+fpz8ZNhTqGYe3RGoq31BVtPtaz4x8qUuTWOQs7QJ
        kUntNW7U4+QU9EGt1BHRwyTbjze5LKPW6GdqmC5ORp0l+EJKgBm6o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E7D8D1873;
        Fri,  1 Oct 2021 13:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82765D1872;
        Fri,  1 Oct 2021 13:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Neeraj Singh <nksingh85@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
        <20210929184339.GA19712@neerajsi-x1.localdomain>
        <YVVyUkwYNfkEqNfU@coredump.intra.peff.net>
        <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
Date:   Fri, 01 Oct 2021 10:02:41 -0700
In-Reply-To: <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 1 Oct 2021 00:50:14 -0700")
Message-ID: <xmqq7dew8yq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 642C9CE8-22D9-11EC-979D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Said another way, I don't think anything should be writing a critical
> file that needs to be durable when we're in the middle of a
> "read-only" process like git-log.  The only things written should be
> temporary stuff, like the automatic remerge calculation from
> merge-ort, the textconv cache optimization stuff, or perhaps future
> gitattributes transformation caching.  All that stuff can safely be
> blown away at the completion of each merge.

The textconv cache can be populated/written during "git log -p" into
the object store to persist.  With or without "--remerge-diff", we
can make design decision to either 

 - use temporary object store to discard everything we create at the
   end in one-go, or

 - write them into the object store to let later gc to handle the
   crufts.

The former will disable persistent write access to the cache.  It
still allows accesses the cached data during the same process,
though.  We so far deemed that textconv cache, when the user enables
it, is valuable enough to make persistent.  Perhaps remerge-diff's
tentative merge result may fall into the same category?  Some folks
may want to cache, others may not.

If we were to use the same notes-cache mechanism, we record the tree
object (perhaps the object name) as the cached value for the merge
commit in question.  Hopefully most of the merges are clean merges,
and "caching" the results of the recreation of the merge would cost
almost nothing.  We need objects to record the fact that "this merge
has cached result" in the notes-cache, but the tree object that
represents the cached result is already in the history the merge
belongs to.

