Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF68C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiGSUac (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGSUaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:30:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300D41D11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:30:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CCCD126C54;
        Tue, 19 Jul 2022 16:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R04OKEQwSrsKC6tx+6Efnn/MH5XNNtDSSD9vFf
        J4vqw=; b=SagMBYG5TyDH5eWQEUsHvQxh/yrqKghgAEFIsyyNu1aNm+P37pO6/W
        2wHdAXTZcu6RjilFAwgow+nB5oYwrWy1p7+rLRBu1hhZghjHIdlrqbVn1Gp7B/wy
        Qab6M6n9UDSl+uRh+RCxTen+gMuGjp+jMU5Rk7OG8Zt0DRT8EdOcQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34CE6126C53;
        Tue, 19 Jul 2022 16:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F336126C52;
        Tue, 19 Jul 2022 16:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
References: <20220712231935.2979727-1-calvinwan@google.com>
        <20220718214349.3379328-1-calvinwan@google.com>
        <xmqqsfmxd17s.fsf@gitster.g>
        <CAFySSZDoNX_5mxdKaT8JWkpYxBFxivQc_p2q_4bQk6YsT8QeZA@mail.gmail.com>
Date:   Tue, 19 Jul 2022 13:30:26 -0700
In-Reply-To: <CAFySSZDoNX_5mxdKaT8JWkpYxBFxivQc_p2q_4bQk6YsT8QeZA@mail.gmail.com>
        (Calvin Wan's message of "Tue, 19 Jul 2022 12:07:02 -0700")
Message-ID: <xmqq8rooalr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A021E67E-07A1-11ED-9CE4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> These work on the result of calling find_first_merges(), but is it
>> possible that we are asked to call this function more than once
>> because we see conflicted submodule updates at two or more paths?
>
> This does get called multiple times if we see conflicted submodule
> updates at two or more paths.
>
>> I may be misreading the code, but find_first_merges(), either the
>> version we see in this file, or the one in merge-recursive.c, or its
>> original introduced in 68d03e4a (Implement automatic fast-forward
>> merge for submodules, 2010-07-07), look safe to be called twice.  It
>> runs the get_revision() machinery, smudging the object flags while
>> walking the history, but I do not see any code that cleans up these
>> flags for the second traversal.
>
> I don't quite understand which flags need to be cleaned up for the
> second traversal.

UNINTERESTING, TREESAME, ADDED, SEEN, SHOWN are among the flags used
by the object walk (if MyFirstObjectWalk does not talk about them,
it probably should), and they need to be cleared before you prepare
a new "struct rev_info" and throw it at setup_revisions(),
prepare_revision_walk(), and start calling get_revision().

submodule.c::collect_changed_submodules() has its own revision walk,
but it calls reset_revision_walk() to clear these flags from all
objects in the superproject (i.e. the_repository).

I _think_ the reason why this never turned out to be a problem in
practice is because we do not run this helper twice for the same
submodule.  Even though we may smudge many objects from a submodule
with an object walk without clearing their flags, as long as we
run the next object walk in a different submodule whose object flags
are still unsmudged, it would be OK.

