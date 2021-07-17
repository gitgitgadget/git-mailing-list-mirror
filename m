Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C7C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2F61176
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhGQVZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 17:25:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQVZe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 17:25:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3205D14F272;
        Sat, 17 Jul 2021 17:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OnstYQHjxOJxedDq68aNSbgsPhOLfSJOzLJg8M
        O+c8g=; b=sFrH4OkPOGeiQ6xMX1vhA1Szkzf3ExR40Wn6QrmgeSigZFDmAU3e0K
        f1MaU62BhyTlv2nqjO+Vw/3cAZCSXw99BZX7/cEavdQW3oDGd02Oc1XjilXitUmh
        TUDAoxUYki2KO1CBIcvcx8lOFY7xQQ9LwxZSxq7MjHszJKlLTHZik=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2997714F271;
        Sat, 17 Jul 2021 17:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7025F14F26C;
        Sat, 17 Jul 2021 17:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: When are you going to stop ignoring pull.mode?
References: <60f1daa896f69_330208b1@natae.notmuch>
        <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
Date:   Sat, 17 Jul 2021 14:22:32 -0700
In-Reply-To: <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com> (Matthias
        Baumgarten's message of "Sat, 17 Jul 2021 12:22:28 +0200")
Message-ID: <xmqqwnpooctj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A4A7EB2-E745-11EB-9AE4-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:

>>>     pull.ff  pull.rebase  commandline            action
>>> ...
>>>       *          *        --ff-only              fast-forward only[1]
>>> ...
> What about
>
>          *       !false      --ff-only              ???

This is covered by an earlier entry ("*" stands for "any value"), I
think; it should fast-forward or fail.  The reasoning goes like
this:

The user configures pull.rebase to some kind of rebase; it could be
just true (the traditional flattening rebase), or the one that
preserves the shape of the history, or even the interactive one.
With the configuration, what the user declares is: 

    I may have my own development on top of the result of my last
    integration with the upstream I did when I ran "git pull" the
    last time, and when the upstream has more commits, the way I
    want my local work to integrate with their work is to replay my
    work on top of theirs (as opposed to "merging their work into my
    history").

But by passing "--ff-only" from the command line, the user tells us
this:

    This time only, I want fast-forward update and nothing else.  I
    do not remember doing any of my own development on top of their
    history, and I expect that this update from the upstream would
    fast-forward.  If that is not the case, please error out, as I
    need to inspect the situation further and I do not want to see
    conflicts in unexpected commits I thought I did not have.

So the "action" would be

 - If their history is a descendant of ours, that means that on top
   of their history previously observed by us, we haven't added any
   development of our own.  We just move to the tip of their history
   and we are done.

   This is not so surprising anyway.  If we are doing any kind of
   rebasing, what happens is to start from the tip of their history
   and then commits from our own development are replayed on top of
   that.  When their history is a descendant of ours, we end up
   doing just fast-forward, as there is nothing to replay on top.

 - Otherwise, because the user expects the command to fail if their
   history is not a descendant of ours, we fail.

And "fast-forward only" in Elijah's table is a concise way to say
that.

I concentrated on "if the configuration is set to do some kind of
rebase" case, as that was your question, but the above reasoning
applies equally to the case where pull.rebase is not specified or
set to false, i.e. the user tells us to merge.
