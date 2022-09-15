Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5121ECAAD8
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 02:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIOC50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 22:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIOC5V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 22:57:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCE90C53
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 19:57:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A19ED1AB79B;
        Wed, 14 Sep 2022 22:57:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HO+PTgPRs7tTdHu1m2u4wWDVPqvInSEJ9KmnaPKSXn8=; b=pACa
        eVSbjc60QF/yBNrUF94grP//rtenoRSMtA258mvemJ2PsuXLtIOkLNzezp7o/Cns
        FlXCCk+33Fl70fFnff1NLJBhln9hQ/7INMWi6Vy9XtlpIlbd8CyicG3nO7zPxsrx
        Arrr4WUOYrfGM/+rJVF9zlL735DYOBRcTSeWCIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A2001AB799;
        Wed, 14 Sep 2022 22:57:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85D221AB796;
        Wed, 14 Sep 2022 22:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
        <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
Date:   Wed, 14 Sep 2022 19:57:11 -0700
Message-ID: <xmqqh719pcoo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18E8F2AA-34A2-11ED-B780-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ... I think all those other commands probably deserve a mode where they
> restrict output to the view associated with the user's cone.  I've
> brought that up before[1].  I was skeptical of making it the default,
> because it'd probably take a long time to implement it everywhere.
> Slowly changing defaults of all commands over many git releases seems
> like a poor strategy, but I'm afraid that's what it looks like we are
> doing here.
>
> I'm also worried that slowly changing the defaults without a
> high-level plan will lead to users struggling to figure out what
> flag(s) to pass.  Are we going to be stuck in a situation where users
> have to remember that for a dense search, they use one flag for `grep
> --cached`, a different one for  `grep [REVISION]`, no flag is needed
> for `diff [REVISION]`, but yet a different flag is needed for `git
> log`?

In short, the default should be "everywhere in tree, regardless of
the current sparse-checkout settings", with commands opting into
implementing "limit only to sparse-checkout settings" as an option,
at least initially, with an eye to possibly flip the default later
when all commands support that position but not before?

I think that is a reasonable position to take.  I lean towards the
default of limiting the operations to inside sparse cone(s) for all
subcommands when all subcommands learn to be capable to do so, but I
also agree that using that default for only for subcommands that
have learned to do, which will happen over time, would be way too
confusing for our users.

By the way, I briefly wondered if "limit to sparse-checkout setting"
can be done by introducing a fake "attribute" and using the "attr"
pathspec magic, but it may probably be a bad match, and separate
option would be more appropriate.

>> Change the default behavior of 'git grep' to focus on the files within
>> the sparse-checkout definition. To enable the previous behavior, add a
>> '--sparse' option to 'git grep' that triggers the old behavior that
>> inspects paths outside of the sparse-checkout definition when paired
>> with the '--cached' option.
>
> I still think the flag name of `--sparse` is totally backwards and
> highly confusing for the described behavior.

Yeah, regardless of which between "--sparse" and "--no-sparse"
should be the default, I am in 100% agreement that "--sparse"
meaning "affect things both inside and outside the sparse cones" is
totally backwards.

How strongly ingrained is this UI mistake?  I have a feeling that
this may be something we still can undo and redo relatively easily,
i.e. "--sparse" may be that "limit to sparse-checkout setting"
option, not "--no-sparse".
