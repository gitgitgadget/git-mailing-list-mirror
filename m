Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214DF20899
	for <e@80x24.org>; Thu, 27 Jul 2017 14:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbdG0Omm (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 10:42:42 -0400
Received: from avasout06.plus.net ([212.159.14.18]:47611 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdG0Omk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 10:42:40 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id pqid1v00218PUFB01qie54; Thu, 27 Jul 2017 15:42:38 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=0n9SDgdC9JeOFVCe_ZUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] credential-cache: interpret an ECONNRESET as on EOF
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Devin Lehmacher <lehmacdj@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
 <20170727141723.q7eeeajrdkwext5z@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6574cd23-5d95-c23c-8179-755798472a9d@ramsayjones.plus.com>
Date:   Thu, 27 Jul 2017 15:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170727141723.q7eeeajrdkwext5z@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/07/17 15:17, Jeff King wrote:
> On Thu, Jul 27, 2017 at 02:08:40AM +0100, Ramsay Jones wrote:
> 
>> In order to suppress the fatal exit in this case, check the read error
>> for an ECONNRESET and return as if no data was read from the daemon.
>> This effectively converts an ECONNRESET into an EOF.
> 
> Yeah, I think this is a perfectly reasonable thing to do.
> 
> I'm not sure if we'd _ever_ see ECONNRESET on Linux. The only time I've
> seen it on Linux (and I coincidentally fixed a bug just like this a week
> or two ago, so it's fresh in my mind): if read() would return EOF but
> there's outstanding data from a previous write, you get ECONNRESET.
> Which is obviously going to be totally racy, since "outstanding" across
> a TCP connection involves more than just the local kernel.
> 
> That shouldn't happen in this 'exit' case. But even if it does, there's
> really nothing the client should do differently anyway. We're waiting
> for the other side to exit, and they did. Hooray.
> 
> Though your change:
> 
>> diff --git a/credential-cache.c b/credential-cache.c
>> index 91550bfb0..1cccc3a0b 100644
>> --- a/credential-cache.c
>> +++ b/credential-cache.c
>> @@ -25,7 +25,7 @@ static int send_request(const char *socket, const struct strbuf *out)
>>  		int r;
>>  
>>  		r = read_in_full(fd, in, sizeof(in));
>> -		if (r == 0)
>> +		if (r == 0 || (r < 0 && errno == ECONNRESET))
>>  			break;
>>  		if (r < 0)
>>  			die_errno("read error from cache daemon");
> 
> ...is in the generic send_request(). Which means that it hits all of the
> commands. So if we were to send a credential and the server
> crashed midway through reading it, we'd get ECONNRESET. And instead of
> reporting an error, we'd quietly assume the server had no response. But
> again, I don't think that's really different than the EOF behavior. The
> server could read our whole request and then crash, and we'd mistakenly
> think it had nothing to say.

yep, I did think about adding a FLAG_EXIT (or somesuch) and passing
it down through the call stack to send_request() so that I could do
the check only for the 'exit' command. I decided against it in the
end, obviously! ;-)

> So I don't think this really changes the robustness much. If we did want
> to address those cases, we'd require actual end-of-record framing in the
> protocol. But I don't think it's worth caring too much about (this is,
> after all, a local and internal socket between two relatively simple
> programs).

Adding the framing to the protocol was actually my first (very fleeting)
idea. However, I didn't want to get into the 'supporting old/new client
and server combos' problem.

> Which is all a verbose way of saying that your patch looks good to me.
> Thanks for digging up the root cause of the test failures.

Thanks!

ATB,
Ramsay Jones

