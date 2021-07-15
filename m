Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB0EC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19954613C4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbhGOUUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:20:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57085 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbhGOUU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 16:20:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9965013C113;
        Thu, 15 Jul 2021 16:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qZfB75EKmDrs83JLcBuE10tKHWNe0iu7D7IxJi
        VPwBc=; b=q9lXw7AuimyeU5kauWf6Tf3tfhWIiOIqwXALZMhFutn1ur25ccoDDx
        fGGbn/fJV2b8Xq7OMAPyGqHss/y8C95lELHQtNwjx7mP7sL+A20bjAmDC85btxKd
        JWvUI5/ehhHcs16VHKRAEq77+vHKKUApX76mhJWNvaR98DzZQdK14=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92E5E13C112;
        Thu, 15 Jul 2021 16:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8B1713C107;
        Thu, 15 Jul 2021 16:17:28 -0400 (EDT)
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
Date:   Thu, 15 Jul 2021 13:17:27 -0700
In-Reply-To: <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 15 Jul 2021 12:04:38 -0700")
Message-ID: <xmqqlf67s560.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD8F8E3A-E5A9-11EB-B55B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> But first let me check if I understand you correctly:  I think you're
> suggesting that
>   * if --ff-only is given along with any --rebase[=*] flags, then we
> silently ignore the --rebase[=*] flags.
>   * if --no-ff is given along with any --rebase flag other than
> --rebase=false, then we silently ignore --no-ff.
>
> Let me ask the same two questions as for the config:  Does it benefit
> the users to allow them to specify both flags?  Does it hurt some
> users, especially if undocumented that one of the flags will be
> ignored?

I see downsides if you make them "incompatible" and cause the
combination to error out, but otherwise no.  I can imagine those who
regularly use pull.rebase=yes in the configuration to say --ff-only
for a single-shot, for example.  We can view it as either (1)
command line --ff-only overriding configured pull.rebase, or (2)
ff-only made the choice of pull.rebase irrelevant---the end result
is the same (as long as you do not say "no, that's incompatible" and
error out).

> I thought this was the biggest hole in my proposal: there is both a
> git merge --no-ff and a git rebase --no-ff, and they avoid
> fast-forwards in different ways with different results.

When you say "git rebase --no-ff upstream", you are telling the
machinery that even if your current work is direct descendant of the
upstream, you want your commits freshly rebuilt.  But in the context
of "pull", you being descendant of the other side is called "already
up to date", not even "fast forward" (the ancestry relationship
between you and the other side is the other way around).  Does the
"rebase --no-ff" even kick in in the context of "pull --no-ff"?
