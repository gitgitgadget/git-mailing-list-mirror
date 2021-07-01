Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC2C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045AD613C0
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhGARpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:45:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59613 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGARpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 13:45:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E20B2139E80;
        Thu,  1 Jul 2021 13:42:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INMKXrJGHV3qye/Rmym1481NKXEjeUwJNZmI2a
        JEbX0=; b=ZM6fJ4EHRSNPr93OwPeFDRyn53O9pAALbjZY8xonuKvhXqGxzmjRxW
        o26N98wjqfpzlNQvGjMRDIdjqpeqVWLIfYdckg7M/gxyb82UC/sTXNZULPSf6LPm
        3Cd/1uB+8EA8Zn0C13MkenYLZV8PrdfVDijOpJRHFRT+HBLvi4TAM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA765139E7F;
        Thu,  1 Jul 2021 13:42:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31056139E7E;
        Thu,  1 Jul 2021 13:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] mingw: handle absolute paths in expand_user_path()
References: <pull.66.git.gitgitgadget@gmail.com>
        <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 10:42:39 -0700
In-Reply-To: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 01 Jul 2021 16:03:05
        +0000")
Message-ID: <xmqq1r8irkvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBE2A88A-DA93-11EB-946D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In Git for Windows, we ran with a patch "in production" for quite a while
> where paths starting with a slash (i.e. looking like Unix paths, not like
> Windows paths) were interpreted as being relative to the runtime prefix,
> when expanded via expand_user_path().
>
> This was sent to the Git mailing list as a discussion starter, and it was
> pointed out that this is neither portable nor unambiguous.
>
> After the dust settled, I thought about the presented ideas for a while
> (quite a while...), and ended up with the following: any path starting with
> <RUNTIME-PREFIX>/ is expanded. This is ambiguous because it could be a valid
> path. But then, it is unlikely, and if someone really wants to specify such
> a path, it is easy to slap a ./ in front and they're done.

I just went back to briefly scan the discussion in late 2018.

I think the rough consensus back then was that 

 * It indeed is a problem that there is no syntax for users of
   "relocatable Git" to use to point at things that come as part of
   the "relocatable Git" package.

 * A change to expand_user_path() would be too broad, it makes sense
   for this feature to be in git_config_pathname();

 * We need to get the syntax right.

As to the last item, there were a handful of choices raised:

 - Use "~~"--the downside is that this is not extensible.  Use
   "~runtime-prefix/" would be a better choice (the likelyhood of
   <RUNTIME-PREFIX>, $RUNTIME_PREFIX, and any other random choice
   happens to be used as a valid directory name is just as slim as
   the likelyhood of "runtime-prefix" used as a valid username).

 - "$RUNTIME_PREFIX" to make it read like a variable---the downside
   was that it looked TOO MUCH like a variable and risked user
   confusion (e.g. it may be upsetting that "$HOME/.gitconfig" is
   not expanded like "~/.gitconfig" is).

 - %(RUNTIME-PREFIX) to make it similar to how Git replaces various
   tokens that are understood only in the context of Git.

 - <RUNTIME-PREFIX>---the downside is that this is an unnecessary
   new syntax we do not have to introduce.  If <RUNTIME-PREFIX> is
   unlikely to be used as a valid directory name, %(RUNTIME-PREFIX)
   is just as unlikely.

There might have been other ideas floated back then.  I have to say
that the one you chose in this round is the least favourite of mine,
and if you consulted me privately before redoing this round, I would
probably have said %(RUNTIME_PREFIX) would make the most sense among
the candidates.

Thanks.
