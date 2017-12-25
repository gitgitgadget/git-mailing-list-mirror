Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5499E1F404
	for <e@80x24.org>; Mon, 25 Dec 2017 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbdLYK3A (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 05:29:00 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:56594 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdLYK27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 05:28:59 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3z4wMC2xnKz5tl9;
        Mon, 25 Dec 2017 11:28:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E777F41E2;
        Mon, 25 Dec 2017 11:28:54 +0100 (CET)
Subject: Re: Improved error handling (Was: [PATCH 1/2] sequencer: factor out
 rewrite_file())
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Schar?= =?UTF-8?Q?fe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <20171104183643.akaazwswysphzuoq@ruderich.org>
 <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
 <20171106161315.dmftp6ktk6bu7cah@ruderich.org>
 <20171117223345.s3ihubgda3qdb2j6@sigill.intra.peff.net>
 <c50ac174-15bd-60bc-490c-d231e3eb501d@kdbg.org>
 <20171224145427.GG23648@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <16262419-3ce9-13e2-6dbc-2ffcad8327f6@kdbg.org>
Date:   Mon, 25 Dec 2017 11:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171224145427.GG23648@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.2017 um 15:54 schrieb Jeff King:
> On Sat, Nov 18, 2017 at 10:01:45AM +0100, Johannes Sixt wrote:
> 
>>> Yeah, I have mixed feelings on that. I think it does make the control
>>> flow less clear. At the same time, what I found was that handlers like
>>> die/ignore/warn were the thing that gave the most reduction in
>>> complexity in the callers.
>>
>> Would you not consider switching over to C++? With exceptions, you get the
>> error context without cluttering the API. (Did I mention that
>> librarification would become a breeze? Do not die in library routines: not a
>> problem anymore, just catch the exception. die_on_error parameters? Not
>> needed anymore. Not to mention that resource leaks would be much, MUCH
>> simpler to treat.)
> 
> I threw this email on my todo pile since I was traveling when it came,
> but I think it deserves a response (albeit quite late).
> 
> It's been a long while since I've done any serious C++, but I did really
> like the RAII pattern coupled with exceptions. That said, I think it's
> dangerous to do it half-way, and especially to retrofit an existing code
> base. It introduces a whole new control-flow pattern that is invisible
> to the existing code, so you're going to get leaks and variables in
> unexpected states whenever you see an exception.
> 
> I also suspect there'd be a fair bit of in converting the existing code
> to something that actually compiles as C++.

I think I mentioned that I had a version that passed the test suite. 
It's not pure C++ as it required -fpermissive due to the many implicit 
void*-to-pointer-to-object conversions (which are disallowed in C++). 
And, yes, a fair bit of conversion was required on top of that. ;)

> So if we were starting the project from scratch and thinking about using
> C++ with RAII and exceptions, sure, that's something I'd entertain[1]
> (and maybe even Linus has softened on his opinion of C++ these days ;) ).
> But at this point, it doesn't seem like the tradeoff for switching is
> there.

Fair enough. I do agree that the tradeoff is not there, in particular, 
when the major players are more fluent in C than in modern C++.

There is just my usual rant: Why do we have look for resource leaks 
during review when we could have leak-free code by design? (But Dscho 
scored a point[*] some time ago: "For every fool-proof system invented, 
somebody invents a better fool.")

[*] 
https://public-inbox.org/git/alpine.DEB.2.20.1704281334060.3480@virtualbox/
