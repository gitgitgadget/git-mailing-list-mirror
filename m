Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D370D20136
	for <e@80x24.org>; Thu, 16 Feb 2017 10:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbdBPKKZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 05:10:25 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38351 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbdBPKKX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 05:10:23 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3vPBjl5hwKz3hldm;
        Thu, 16 Feb 2017 11:10:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3vPBjl58mhzvkW8;
        Thu, 16 Feb 2017 11:10:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id s2Kwt6Jyrq3i; Thu, 16 Feb 2017 11:10:18 +0100 (CET)
X-Auth-Info: hQoqLoB1eUt77eXGCGhjPfflTOKXSignpfCMSPx64mDvu4XxAHJAiMotW6bFX4lm
Received: from igel.home (ppp-88-217-3-149.dynamic.mnet-online.de [88.217.3.149])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Feb 2017 11:10:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 232212C1AA3; Thu, 16 Feb 2017 11:10:18 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?J=C3=A1chym_Barv=C3=ADn?= =?utf-8?Q?ek?= 
        <jachymb@gmail.com>, git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
        <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
        <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
        <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
        <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
        <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
        <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
        <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
X-Yow:  Should I start with the time I SWITCHED personalities with a BEATNIK
 hair stylist or my failure to refer five TEENAGERS to a good OCULIST?
Date:   Thu, 16 Feb 2017 11:10:18 +0100
In-Reply-To: <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 18:18:33 -0500")
Message-ID: <87tw7uv439.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 15 2017, Jeff King <peff@peff.net> wrote:

> On Wed, Feb 15, 2017 at 02:50:19PM -0800, Junio C Hamano wrote:
>
>> > That works, but the fact that we need a comment is a good sign that it's
>> > kind of gross. It's too bad stdio does not specify the return of fclose
>> > to report an error in the close _or_ any previous error. I guess we
>> > could wrap it with our own function.
>> 
>> Sure.  I am happy to add something like this:
>> 
>> 	/*
>> 	 * closes a FILE *, returns 0 if closing and all the
>> 	 * previous stdio operations on fp were successful,
>> 	 * otherwise non-zero.
>> 	 */
>> 	int xfclose(FILE *fp)
>> 	{
>> 		return ferror(fp) | fclose(fp);
>> 	}
>
> Yes, that's exactly what I had in mind (might be worth calling out the
> bitwise-OR, though, just to make it clear it's not a typo).

Since the order of evaluation is unspecified, it would be better to
force sequencing ferror before fclose.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
