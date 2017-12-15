Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385FA1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932072AbdLOPIP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:08:15 -0500
Received: from siwi.pair.com ([209.68.5.199]:21912 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756619AbdLOPIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:08:15 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7AD65844E5;
        Fri, 15 Dec 2017 10:08:14 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 207D7844E4;
        Fri, 15 Dec 2017 10:08:14 -0500 (EST)
Subject: Re: Question about the ahead-behind computation and status
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Jameson Miller <jameson.miller81@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
 <20171215100835.GC3567@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <88175f57-082d-ad61-c2dd-53ae50540460@jeffhostetler.com>
Date:   Fri, 15 Dec 2017 10:08:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171215100835.GC3567@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/15/2017 5:08 AM, Jeff King wrote:
> On Thu, Dec 14, 2017 at 04:49:31PM -0500, Jeff Hostetler wrote:
> 
>> I don't want to jump into the graph algorithm at this time,
>> but was wondering about adding a --no-ahead-behind flag (or
>> something similar or a config setting) that would disable
>> the a/b computation during status.
>>
>> For status V2 output, we could omit the "# branch.ab x y"
>> line.  For normal status output, change the prose a/b
>> message to say something like "are [not] up to date".
> 
> Is it actually "status --porcelain=v2" that you care about here? Or is
> it normal "git status"?

My primary concern is for porcelain V2 because Visual Studio
uses --branch with V2 to get the other branch details with
one process rather than two on inotify events.

Fixing/Helping normal "git status" would be nice for interactive
users.

  
> Do you care about seeing the branch at all? I.e., would "--no-branch" be
> a viable option (though I notice it seems to be a silent noop with the
> long-form, which should probably be fixed).

VS does not use the a/b counts at all, so it is just overhead.
VS does use some of the other branch fields, so it would be nice
to still have them.

It would be nice to minimize changes to the user experience.
Not printing anything about the a/b in the normal/short/long forms
might give the user a false sense of security.  I was thinking if
we changed the message to be "you are [not] up to date", they would
still know they needed to push.

As it is, at this scale, having the message give an exact count
just isn't that useful -- who cares if you are 150,000 or 149,000
behind.

Maybe we could do something like GCC and just give up at 100
and print "you are 100+ ...".

  
> If you really do want to see all branch details but just skip the
> ahead/behind, then yeah, I'd agree that adding an option to do so makes
> sense. Is "status" the only command that needs it? I think we do it
> unconditionally with "git checkout", too.

ok. thanks. i'll look at doing that.

Yeah, "checkout" and "branch -vv" could use it too.  I haven't looked
yet to see anywhere else we might want it, but these can wait.


>> [*] Sadly, the local repo was only about 20 days out of
>>      date (including the Thanksgiving holidays)....
> 
> Taking 20 seconds to traverse 20 days worth of history sounds pretty
> awful. How many commits is it?

150,000 commits, give or take.  The graph is many thousands of lanes
wide because of the merges and that isn't helping.

(But I should give you folks lots of credit -- it *only* took 20
seconds to find, unzip and decode 150,000 commit objects and walk
the commit graph.)

For a true solution, I think we want to wait for client-side
generation numbers before we spend any time looking at the
algorithm.

Thanks,
Jeff


