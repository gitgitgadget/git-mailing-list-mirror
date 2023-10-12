Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5DECDB465
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 00:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjJLAQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 20:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLAQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 20:16:41 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3790
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 17:16:38 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697069797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rS+4T7mM/tZ2JPYybEKTSbuq8u5HZ9s/8RLbEpyCmuE=;
        b=B9xG+ZHIGQuOID9Ay/UBfHtTHTnLYmFjaVi4+VLG5/zXbiVb1jXyf2DKxzRFYOFOSiWfHg
        0i830Hlgw1AFFB2ykMzO4MDsgw1E2oU9RxfglBKTmWn88xObgR/sl4GPbD+7FAtXtGvGw+
        mVtMYzMFn0CIPJo9NXpezeoxND76oEkdJWWRj9U1ky9bMO5/eBc5ug699fvxlmrZj45CVm
        SkFUQnBHSr7dov01SdF+aqLOWGB/Rp7jbgfOJHy3MBLuidhaX4qwd5dwHl1w0d4bBNZdgt
        XGmVQsb5IM8gS+ZsN6IWIZVm+45kDT3X8YDseyG6ANsd2H+6//+Ewqy6G5jjuQ==
Date:   Thu, 12 Oct 2023 02:16:36 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christoph Anton Mitterer <calestyo@scientia.org>,
        git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <20231012000416.GA520855@coredump.intra.peff.net>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
Message-ID: <e1023bd04f9f45b25caf254a7c2885fd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 02:04, Jeff King wrote:
> On Wed, Oct 11, 2023 at 03:23:20PM -0700, Junio C Hamano wrote:
> 
>> Christoph Anton Mitterer <calestyo@scientia.org> writes:
>> 
>> > But I still don't get from that why X would be needed?
>> >
>> > My less manpage documents it as:
>> >> -X or --no‐init
>> >>     Disables sending the termcap initialization and deinitialization
>> >>     strings to the terminal.  This is sometimes desirable if the
>> >>     deinitialization string does something unnecessary, like clearing
>> >>     the screen.
>> >
>> > Is it to avoid clearing the screen?
>> 
>> I think that was the reason we added it back in 2005.  In any case,
>> asking "why" is not a useful use of anybody's time, because it is
>> very unlikely to change in the official version we ship, and because
>> it is so easy for any individual who does not like it to drop by
>> exporting the $LESS environment variable.
> 
> I agree it is probably not worth changing now, but I think the history
> here is a little interesting.
> 
> Yes, I think "X" was added because less would clear the screen after
> exiting, and with "F" this meant you'd see nothing. Here's a thread 
> from
> the same time period discussing it:
> 
> 
> https://lore.kernel.org/git/cc723f590610210623sbee2075i5f2fd441cceb84ae@mail.gmail.com/
> 
> But I also think this was a pretty well-known annoyance with "less" 
> back
> then.
> 
> However, I can't seem to reproduce it now! Digging into the history and
> the changelog, this note is in "changes between less versions 487 and
> 530":
> 
>   Don't output terminal init sequence if using -F and file fits on one
>   screen.
> 
> So it seems like the problem has been fixed inside less for recent
> versions. And in theory we _could_ drop "-X" if it is causing problems.
> That version of less is ~5 years old. It does seem a little premature 
> to
> assume everybody has it. And as you say, if there are people who really
> care about their LESS options, it is easy for them to override it.

Thanks for this detailed analysis!

It's important to keep in mind that removing "-X" and leaving "-F" would 
introduce an inconsistency in the displaying of outputs, by having the 
long outputs disappear after exiting the pager manually, and by having 
the short outputs remain displayed after the pager exits on its own.

On the other hand, removing both "-X" and "-F" would make people even 
more annoyed by requiring them to exit the pager manually even for short 
outputs.

Quite frankly, "-FRX" is a just fine set of defaults.
