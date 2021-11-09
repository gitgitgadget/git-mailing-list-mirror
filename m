Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02980C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92BF6112D
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbhKIVld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:41:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63305 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbhKIVlc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 16:41:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 654B6155AF3;
        Tue,  9 Nov 2021 16:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hXAbHLMXyPRBYHW170/s+45gdJih3nJfYPBlX/su3bU=; b=cNoY
        +7qWyg6qE+zPCa9RQi+ZN3EQB0vMX7TifrKeHYjyUHHlHwbIoWVEa4PJoVGs00xv
        SfX3LBZMvkb9VPhyaWG5zH5uByuGO6lE/k61dn+avbjz0/FEqf79BLTxaPcrGPQM
        SZSU2R4lGFfNjmBDpMML5pdNmmM+6N9pkXVEOpY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DE43155AF2;
        Tue,  9 Nov 2021 16:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1203155AF0;
        Tue,  9 Nov 2021 16:38:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
        <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
        <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
        <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
        <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
Date:   Tue, 09 Nov 2021 13:38:42 -0800
Message-ID: <xmqqtugl102l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 698F855C-41A5-11EC-8A5C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> We can also have some DEVOPTS knob so we'll prune out files found if
>> a
>> $(shell)-out to "git status" tells us they're untracked. I wouldn't mind
>> that (and could implement it) if it was optional.
>> Also note that you've got some of this already, e.g. we'll pick up
>> *.h
>> files via a glob for "make TAGS", the dependency graph etc.
>
> I'd be happier using 'git ls-files' with a glob if we need to move
> away from listing the files explicitly rather than having to pass some 
> exclude list when running make. Having seen your comments below about
> ls-files/find I had a look at the Makefile and they always seem to be 
> used together as "git ls-files ... || find ...". Doing that would mean
> we wouldn't try to build any untracked files but still find everything 
> in a tarball.

I've been quiet on this topic because honestly I do not find the
pros-and-cons favourable for more use of wildcards [*].  Tools like
git (especially .gitignore) and Makefile are to help users to be
safely sloppy by ensuring that random crufts the users may create in
the working tree for their convenience are not picked up by default
unless the project to consciously expresses the desire to use them.

Allowing to be sloppy while maintaining Makefile feels like a false
economy, and having to paper it over by adding exceptions and
forcing developers to learn such ad-hoc rules even more so.

    Side note: TAGS generation and some other minor things may use
    $(wildcard) and can throw tokens in cruft files in the output,
    which is not ideal, but the damage is local.  We cannot treat
    that the same as building binaries and tarballs.

If we could use "git ls-files" consistently, that may make it
somewhat safer; you'd at least need to "git add" a new file before
it gets into the picture.  But it would be impossible, because we
need to be able to bootstrap Git from a tarball extract.

>>>> We could make this simpler still for the Makefile by moving
>>>> "unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewise
>>>> for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
>>>> need the "$(filter-out)" for LIB_OBJS. I don't think that's worth it,
>>>> e.g. due to "git log -- <path>" on the files now needing a "--follow".

And it is not quite clear to me why we want to even more pile
workaround like this on top.  This also is to paper over the mistake
of being sloppy and using $(wildcard), which makes it unable to
distinguish, among the ones that match a pattern, between FOO_OBJS
and BAR_OBJS, no?  Moving files around in the working tree to group
related things together is a good thing, and it has been a good move
to separate built-ins and library-ish parts into different
directories.  But the above does not sound like it.

Other than "these source files may or may not be compiled
depending", what trait do files in conditional-src/ share, other
than "dividing them into a separate category makes it simpler to
write Makefile using $(wildcard)"?  I do not think of a good one.

The only time I found that the large list of files in Makefile was
problematic was *NOT* when multiple topics added, renamed or removed
the files (it is pretty much bog standard merge conflicts that do
not happen very often to begin with).  It is when this kind of
"large scale refactoring" for the sake of refactoring happens.

> I'm not so worried about those other targets, but being able to
> reliably build and test git with some cruft lying around is useful
> though. I'm still not entirely sure what the motivation for this
> change is (adding new files is not that common) but I think using the
> established "git ls-files || find" pattern would be a good way of
> globbing without picking up rubbish if there is a compelling reason to
> drop the lists.

Yes.
