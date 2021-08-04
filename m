Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EDC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1882360EFD
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhHDV2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:28:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55150 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhHDV2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:28:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08FC313214F;
        Wed,  4 Aug 2021 17:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bfer3VadJ+Io2YSl3/JXL1HQTbc9wKgb282XhN
        gKFyQ=; b=ubMEh58Oqi3pjmHN2ttlYv+dEPSOkK/Q4q515k0aJS0dSxlQNrieDM
        mfZdZ5cvvEWNT5q8qXQucNqoFgk5/ja8F/7pqj97cNRbhAxmZIET4/PH2POIgtgm
        XfnbBZvtiXBL4FSzw3uo8oEFfUaCkHhZv6C11wgAgJ2apLu7r/SiE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 015F913214E;
        Wed,  4 Aug 2021 17:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4807C13214D;
        Wed,  4 Aug 2021 17:28:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] sequencer: warn on skipping previously seen commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
Date:   Wed, 04 Aug 2021 14:28:22 -0700
In-Reply-To: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 4 Aug 2021 13:53:45 -0700")
Message-ID: <xmqqsfzonbm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E63E225C-F56A-11EB-9775-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Silently skipping commits when rebasing with --no-reapply-cherry-picks
> (currently the default behavior) can cause user confusion. Issue a
> warning in this case so that users are aware of what's happening.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>
> We've had some complaints at $JOB where users were confused when
> rebasing branches that contained commits that were previously
> cherry-picked into their master branch. How do folks feel about adding a
> warning in this case?

I'd unconditionally in support if this were done under --verbose
option, but it becomes iffy if this is done unconditionally.

This is because I do not expect everybody will stay to be ignorant
of the behaviour of the tool they use every day, and I'd fear that
we'd start hearing "yeah, I know the command would skip to avoid
duplicated changes, why waste lines to tell me that?" complaints.

Having said that, I _hope_ that in a project with good hygiene, such
a multiple cherry-picking would not be so common and an exception,
and if my _hope_ proves to be true, then I am OK with giving this
warning unconditionally.  The user may know what the command does
when it sees a duplicated change, but the warning becomes about the
presence of such duplicated changes, which would be a rare event
that is worth notifying about.

>  		is_empty = is_original_commit_empty(commit);
> -		if (!is_empty && (commit->object.flags & PATCHSAME))
> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			warning(_("skipped previously seen commit %s"),

I am debating myself if s/seen/applied/ should be suggested here.

The existing text in the manual page says "a patch already accepted
upstream with a different commit message or timestamp will be
skipped", and "accepted" is a verb that would apply only in a
certain workflow, which is OK in the manual page that give more
context, but not here.  But 'seen' feels a bit too weak to me.

> +	if (skipped_commit)
> +		warning(_("use --reapply-cherry-picks to include skipped commits"));

I'd be hesitant to endorse doing this kind of "here is how to use
this command" unconditionally.  Perhaps under --verbose, or hide it
under "advise.*".

Thanks.
