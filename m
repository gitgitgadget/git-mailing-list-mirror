Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16978C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6BC610EA
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 16:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355111AbhJAQid (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 12:38:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50382 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhJAQi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 12:38:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FEC1162A0D;
        Fri,  1 Oct 2021 12:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3EP8ZOygjD4AW3rfe4J2nc7RxpQbB8szbYOWMq
        VI43g=; b=bHq+oSGuiRHpcHXAOnxG0vw2mi+jz8kutmepagOGV342FiDgRHF8h7
        HbXyD6pRChfkI6dwGVFerC9YzCPvBjD6Sg/Lb6999JQEr8KE6+Klm4ZUkujKCD9g
        UYWgWBn9FrkmJFnvvugbEPVDO7T3k7zXV6ZILlZSNlqOAMPEVi85U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AD80162A0C;
        Fri,  1 Oct 2021 12:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A9CE162A08;
        Fri,  1 Oct 2021 12:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
        <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
        <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
        <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
        <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
        <xmqqbl49bzfy.fsf@gitster.g>
        <CABPp-BGgytcH5kBF_xuukz=FfEi0-076AsvCsW=1otycAOMbdQ@mail.gmail.com>
Date:   Fri, 01 Oct 2021 09:36:36 -0700
In-Reply-To: <CABPp-BGgytcH5kBF_xuukz=FfEi0-076AsvCsW=1otycAOMbdQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 30 Sep 2021 20:59:46 -0700")
Message-ID: <xmqqczoo8zxn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF437A42-22D5-11EC-846B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Sep 30, 2021 at 1:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jeff King <peff@peff.net> writes:
>>
>> >   - is it possible for the merge code to ever write an object? I kind of
>> >     wonder if we'd ever do any cache-able transformations as part of a
>> >     content-level merge. I don't think we do now, though.
>>
>> How is virtual merge base, result of an inner merge that recursively
>> merging two merge bases, fed to an outer merge as the ancestor?
>> Isn't it written as a tree object by the inner merge as a tree with
>> full of blob objects, so the outer merge does not have to treat a
>> merge base tree that is virtual any specially from a sole merge
>> base?
>
> Yes.  And that's not unique to the inner merges; it also writes new
> blob and tree objects for the outer merge, and then passes the
> resulting toplevel tree id out as the result.

I think Peff's question was "other than what is contained in the
merge result, are there objects we create during the merge process
that we may want to keep?"  And my inner merge example was objects
that do not appear in the merge result, but they are discardable,
so it wasn't a good example.

A tentative merge to recreate what the manual resolver would have
seen while showing remerge-diff needs to be recorded somewhere
before the diff gets shown, but after showing the diff, we can lose
them unless we need them for some other reason (e.g. they already
existed, another process happened to have created the same blob
while we are running remerge-diff, etc.).  So in that sense, the
objects that represent the result of the outermost merge is also
discardable.

The question is if there are other things similar to the textconv
cache, where we need to create during the operation and may keep the
result for later use.  The closest thing I can think of is the
rename cache we've talked about from time to time without actually
adding one ;-).

I guess using cached textconv result, without putting newly
discovered textconv result back to the cache, would be the best we
can do?

The blobs (hence their textconv results) involved in showing a merge
M with --remerge-diff are the ones in the trees of M^@ (all parents)
and $(git merge-base $(git rev-parse M^@)), and they may have been
created when running "git show" on or when letting "git log -p"
pass, these commits, so it is not like we are disabling the cache
entirely, and allowing read-only access may still have value.

Thanks.

