Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2128C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A756128D
	for <git@archiver.kernel.org>; Wed, 26 May 2021 22:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhEZW4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 18:56:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57768 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEZW4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 18:56:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EBEBCBB44;
        Wed, 26 May 2021 18:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rncuD6OqUwcIz2StIEndGgjxQs1zxD9ilg6wUo
        rFROQ=; b=XtGjGT981u7sl+AlvTm9FhASfVYlVVZ7zIt7PJbkPSGgFlazS0Aksr
        LvCoyUWKVxf2/QuBM4eIsd4gOrRmgiSt86IQ4TNKA3Dtwa9AZM5rIx16xtLIecst
        0ET/Hm3gzcY5XU1yJChdiPEHin0zE35Q/Fa9iRgJejFh7n7uKaeDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 953A5CBB43;
        Wed, 26 May 2021 18:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1680CCBB42;
        Wed, 26 May 2021 18:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
References: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
        <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com>
        <45c23ea3-0e21-7654-3d2a-5597e159f847@gmail.com>
        <CABPp-BF_JkDjXnWnLsYFj0ywpp-r-O7RaqMKFCtQWe8yeJB8Xw@mail.gmail.com>
Date:   Thu, 27 May 2021 07:54:43 +0900
In-Reply-To: <CABPp-BF_JkDjXnWnLsYFj0ywpp-r-O7RaqMKFCtQWe8yeJB8Xw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 26 May 2021 09:07:59 -0700")
Message-ID: <xmqqeedtayx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CBA05E0-BE75-11EB-94FC-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>   * Can we rely on the extension being written and populated? (does it
> get populated by all relevant codepaths in git?)

The only place record_resolve_undo() gets called is in the deep guts
of in-core index manipulation where a conflicted entry is removed
(either because the resolution decided was to remove the path, or
the resolution is about to add the final contents for the path at
the stage #0), so yes, as long as you are manipulating the in-core
index using our API, you should be recording the action.  Otherwise
we have a bug, as "--unresolve" has to work correctly all the time.

>   * Even if all codepaths in git will populate it, might the lack of
> this extension (or its lack of entries) imply that the user used some
> other tool (jgit, something in libgit2, etc.) rather than that there
> were no conflicts?

It is possible that third-party tools are buggy and corrupt the
on-disk index that way.

>   * Can we rely on this for all types of conflicts?  For all merge
> backends?  Are there conflict types that don't result in a higher
> stage entry being recorded in the index?

Interesting thought.  I am not confident that the recent "directory
rename" stuff does not break the undo information along that line.

But at least, the idea is that resolve-undo should be able to
reproduce the state immediately after any mergy operation stopped
due to conflicts by resurrecting the higher stage entries.

But I do not think "we had a conflict" is so black and white to
begin with.  If you have a rerere record and rerere.autoupdate
enabled (not recommended), does it mean you didn't have a conflict
when rerere kicks in and you did not have to touch anything to
resolve it this time, or was there a conflict but it was
auto-reoslved?  I think the "unresolve" mechanism should still
record the higher stage entries that gets created first before
rerere.autoupdate removes them, which matches the latter
interpretation that I happen to agree with.

For that matter, if both sides have made changes to the same file
nearby, it is more coherent if we declare that there is a conflict
whether the changes "overlap", as the definition of overlapping is
fuzzy and depending on the inter-hunk context used during the mergy
operation, what humans would consider "close but not overlapping"
gets flagged as a "close enough to warrant manual inspection"
conflict (and you can think of rerere as a way to automate that
'manual inspection' step reusing the prior resolution).

So I'd vote for "No conflicts remain, but you haven't committed",
which would be the most sensible way to phrase the situation.
