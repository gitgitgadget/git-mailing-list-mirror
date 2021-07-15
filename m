Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B64CC636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8EF61167
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbhGOUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:02:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54434 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbhGOUBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 16:01:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A110F138035;
        Thu, 15 Jul 2021 15:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vv4D9inLCwoaBNMX5GoM1IaRz/fQ9igtzKHfLn
        m3pKY=; b=Cb3PEIZxmleMIvG5EsBzDHNtOZXVRAJCzqDEe/Puc/QN2H6obZ/glM
        P2OJ18sq5DcuNT96Sjougz3qQgRla9OyEzY2FqHTcX1gO0UNatYLfipZQXOJR6Mu
        yYVEVF+dEPX35yLdR2gFoCHcEZbezAu5I0wU7LnLdAlt/G5brFViQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 994B0138034;
        Thu, 15 Jul 2021 15:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDCB113802C;
        Thu, 15 Jul 2021 15:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
        <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
        <xmqq7dhrtrc2.fsf@gitster.g>
        <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
Date:   Thu, 15 Jul 2021 12:58:39 -0700
In-Reply-To: <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 15 Jul 2021 12:04:38 -0700")
Message-ID: <xmqqpmvjs61c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D3BBE88-E5A7-11EB-A100-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Let me ask two questions:
>
> 1. When is it beneficial for users to set both pull.ff and pull.rebase?
> 2. Is it harmful to users for us to allow both to be set when we will
> just ignore one?
>
> I believe the answer to (1) is "never", and the answer to (2) is "yes".

I agree (1) never gives you anything, even though it does not hurt,
and (2) is "meh".

> For the second question in particular, I can think of two example cases:
>
> 2a) Users start with pull.ff=only, perhaps suggested by someone else
> and left in their config for a long time.  When users hit a case that
> can't fast-forward and they either ask for help or find a post on
> stack overflow that suggests setting pull.rebase=true, they do so and
> then get no warning that the setting they just added is being ignored.

Well, overriding "only fast-forward is allowed" with "instead of
merge, you can rebase" is a nonsense suggestion in the first place,
no?  Why does Git suddenly become responsible for such a misguided
suggestion?

> 2b) Perhaps users start with pull.rebase=true (suggested by a
> colleague and forgot about it as they are more of a tester than a
> developer and thus usually only see fast-forwards).  Then at some
> point they need to function as an integrator, and they read the docs
> and determine that pull.ff=false should do what they want to create
> merge commits.

Again, "I want to pee in the snow" is not what you need to act as an
integrator.  I do not see how relevant this example is, either.  You
are just reacting to a wrong suggestion.

> But then they get shocked that they've rebased public
> commits (and perhaps also pushed them out) when they wanted merges.
> Our docs have pretty clearly stated that pull.ff=false and --no-ff
> create merges.

That is something we need to and can fix.  The "pee in the snow
commit can be created by passing --no-ff" was written back when the
designed audiences of "pull" were primarily those who merge (think
of "pull --rebase" as afterthought).  IOW, to the minds of those who
originally wrote --no-ff feature (and its doc), "pull --rebase" was
not in the picture.

