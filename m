Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E8C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E226136F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhHWSAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:00:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52606 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHWSAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:00:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AE38E7BB4;
        Mon, 23 Aug 2021 13:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qg1I4PvFv7HDzD2eXhOtn7xzktXuTDWOdHCysf
        ZLS50=; b=PSTYNBdQfpmftHKHLADO8i/AomBpK3iWSsk55XAiWa881uFtmzWPCP
        dOcUgVNs32+kA9AkrFrZ8fa0gp6qsy2LXXLmVqqYTEFzFOK7VYShy5TSeM/myQrw
        g6H7zZWc2aJktIbwDsX03Yqk7E5JsXNCECAlwYXCG3/e63886Ptuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 736D9E7BB3;
        Mon, 23 Aug 2021 13:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0156FE7BB1;
        Mon, 23 Aug 2021 13:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rafael Santiago <voidbrainvoid@tutanota.com>,
        Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Give support for hooks based on platform
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
        <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
        <Mheyv1D--3-2@tutanota.com>
        <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net>
        <YSPLnWshLsWlXwUn@coredump.intra.peff.net>
Date:   Mon, 23 Aug 2021 10:59:28 -0700
In-Reply-To: <YSPLnWshLsWlXwUn@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 23 Aug 2021 12:23:57 -0400")
Message-ID: <xmqqfsv0qby7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC7A4360-043B-11EC-9F6E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Aug 22, 2021 at 10:07:41PM +0000, brian m. carlson wrote:
>
>> > The point is that in many cases a dependency with a script language is
>> > created only to make the hook actions portable from a platform to
>> > other, but what this script in its essence does is a thing that could
>> > be done with basic tools delivered with the current operating system.
>> 
>> Then, in general, it can be done in a shell script containing an if-then
>> statement per platform using the native tools, so I'm not seeing the
>> particular reason that this series is necessary if the hooks being
>> executed aren't binaries.  All systems on which Git runs must contain a
>> POSIX-compatible shell.
>
> This is my gut feeling, too (whether users know it or not, even on
> Windows most programs specified by config are being run by the shell).
>
> However, I do think there is room for Git to make this case a bit
> easier: conditional config includes. Once we are able to specify hooks
> via config (which is being worked on elsewhere), then we ought to be
> able to implement an includeIf like:
>
>   [includeIf "uname_s:linux"]
>   path = linux-hooks.config
>   [includeIf "uname_s:windows"]
>   path = windows-hooks.config
>
> The advantage being that this could apply to _all_ config, and not just
> hooks.

Heh, it seems great minds think alike.
