Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9D8C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbjHaPqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHaPqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 11:46:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954631A3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 08:46:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E21E91D50E;
        Thu, 31 Aug 2023 11:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=aOaD/FZMtT1k6XhABzoa4HLzGZO1S1PDsN/ce9
        gBoA8=; b=FfHphMASOAF2O1Zc/qnK2XngUar1Als9418+8M0+C9b98FxbPKpnw2
        aG6ikTJFQex4RDyOJtEMzN8apImUuvEhNB+MOdoylzWtW/86Ed0qu2jDyRHqfuxd
        hsTLPivv3SKGFVI9xOnJhRG3U+7JlAanAZeENOKZXCS0VK9k8ZKi8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB74F1D50D;
        Thu, 31 Aug 2023 11:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64B7C1D508;
        Thu, 31 Aug 2023 11:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/8] merge: make xopts a strvec
In-Reply-To: <20230831071230.GA3197647@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:12:30 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071230.GA3197647@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 08:46:25 -0700
Message-ID: <xmqqcyz3z032.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B56B386-4815-11EE-9E0F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "xopts" variable uses a custom array with ALLOC_GROW(). Using a
> strvec simplifies things a bit. We need fewer variables, and we can also
> ditch our custom parseopt callback in favor of OPT_STRVEC().
>
> As a bonus, this means that "--no-strategy-option", which was previously
> a silent noop, now does something useful: like other list-like options,
> it will clear the list of -X options seen so far.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess you could argue this is a backwards-incompatible change, but the
> existing behavior of --no-strategy-option is so dumb that I can't
> believe somebody would prefer it (plus revert/cherry-pick already use
> OPT_STRVEC for their matching "-X").
>
> I didn't bother adding a test since we're just re-using OPT_STRVEC code
> that is used elsewhere.

I do not think of any useful way to have "--no-strategy-option" on
the command line (either as an early part of an alias or in a
script) that does nothing (it's not like the command requires at
least one -X option on the command line), either.  Just like
fb60b9f3 (sequencer: use struct strvec to store merge strategy
options, 2023-04-10), which met no complaints about a possible
fallout by the behaviour change, I do not think that this change
even deserves an entry in the backward compatibility notes.

We did not have strvec, let alone OPT_STRVEC(), back when the -Xopts
was invented around the Git 1.7.0 cycle.  The loss of custom xopts
code is very nice.

Thanks.
