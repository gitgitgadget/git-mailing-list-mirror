Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E49C433DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42CA22482
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XXNZP5HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgGTS6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:58:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51685 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgGTS6g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:58:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6F4379C82;
        Mon, 20 Jul 2020 14:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=PfXuMVFZSEVfVRv/KfRsohmCYxU=; b=XXNZP5
        HNdh0qa5WCoB2yLg/l53Ih+HPECJvL9L9hjDzcjszUXADQxnA/Zkh796F497FTOy
        5GbUhyQcwAlyn98oZ/vBiEeaHN9V6Yw4z8MSPptRobHHdTGR+6pjeBd0df/0ihXG
        zHjHS/ZyfE2CSP+58BTKHoKwemeA+yyVqfp7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AcVMCd6FLkEM5+DgOs7sHIdR18EZMhNG
        KlclfNPaSs1Kune/pqi9VmwVyUaCkkhsr0b47Jg39VjomQXQvhhyvE8LRWNxYAKF
        uAemd0iBgRyLimVmjAZT2wbFxndsFeNrVfmZpBvadmMkRKld79carWWKCOFHY3Tn
        MtfXNWhrmyE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D33A79C81;
        Mon, 20 Jul 2020 14:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BAC079C80;
        Mon, 20 Jul 2020 14:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 11/12] Fix error-prone fill_directory() API; make it only return matches
In-Reply-To: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
        (Elijah Newren's message of "Mon, 20 Jul 2020 08:25:20 -0700")
References: <87lfjg6mkn.fsf@linux-m68k.org>
        <20200719123919.1802-1-martin.agren@gmail.com>
        <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Mon, 20 Jul 2020 11:58:33 -0700
Message-ID: <xmqq365m9fom.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02BF4856-CABB-11EA-915E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Looking at the commit in question (95c11ecc73), there must have been
>> some reason that it injected the pathspec check between the
>> "path_excluded" and the "path_untracked" cases.  The diff below
>> basically undoes that split, so I have a feeling I'm missing something.
>
> Awesome, thanks Andreas for the bisected report and Martin for finding
> and fixing the bug.  As for the reason that the old patch injected the
> pathspec check between the path_excluded and the path_untracked cases,
> that appears to me to just be "I'm good at making boneheaded
> mistakes".  Your changes here are the right fix.  As a separate
> optimization, we could maybe make simplify_away() a bit more involved
> and have it exclude a few more paths so that fewer make it to this
> final check, but that's just optimization work that is separate from
> your fix here.
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

This is in 2.27-rc0, so it is not ultra-urgent to fix it at the tip
of the current development track, but let's make sure we have a fix
with a proper log messasge in a mergeable state (meaning "have
already been cooked in 'next' for a week or two) early in the next
cycle.

Thank you, Andreas, Martin and Elijah, as always.
