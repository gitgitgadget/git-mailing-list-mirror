Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809FA202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbdJUCi0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:38:26 -0400
Received: from lang.hm ([66.167.227.134]:52661 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752922AbdJUCiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:38:25 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v9L2c0AU008285;
        Fri, 20 Oct 2017 19:38:00 -0700
Date:   Fri, 20 Oct 2017 19:38:00 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        David Lang <david@lang.hm>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: hot to get file sizes in git log output
In-Reply-To: <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1710201929210.5973@qynat-yncgbc>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc> <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com> <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net>
 <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2017, Eric Sunshine wrote:

>>> I'm not exactly sure what you mean by size, but if you want to show
>>> how many lines were added and removed by a given commit for each file,
>>> you can use the "--stat" option to produce a diffstat. The "size" of
>>> the files in each commit isn't very meaningful to the commit itself,
>>> but a stat of how much was removed might be more accurate to what
>>> you're looking for.
>>
>> That's a good suggestion, and hopefully could help David answer his
>> original question.
>>
>> I took the request to mean "walk through history, and for each file that
>> a commit touches, show its size". Which is a bit harder to do, and I
>> think you need to script a little:
>
> David's mention of "a particular file", suggests to me that something
> "bad" happened to one file, and he wants to know in which commit that
> "badness" happened. If so, then it sounds like a job for git-bisect.

In this case, I have git store a copy of the state file for chromium (and do a 
similar thing for firefox), so that if something bad happens and it crashes and 
looses all 200-400 tabs in a way that it's recovery doesn't work, I can go back 
to a prior version.

This is done by having the following crontab entries, along with smudge filters 
that change the one-line json to pretty printed json before the commit.

0 * * * * dlang cd /home/dlang/.config/chromium/Default; git add *Session *Tabs Bookmarks History ; git commit -mupdate > /dev/null 2>&1

0 0 3 * * dlang cd /home/dlang/.config/chromium/Default; git gc --aggressive > /dev/null 2>&1

0 * * * * dlang cd /home/dlang/.mozilla/firefox/bux6mwl1.default/sessionstore-backups; git add *.js ; git commit -mupdate > /dev/null 2>&1

0 0 3 * * dlang cd /home/dlang/.mozilla/firefox/bux6mwl1.default/sessionstore-backups; git gc --aggressive > /dev/null 2>&1

This has saved me many times in the past. But this time I didn't recognize when 
the problem happened because instead of a crash, it just closed all the tabs 
except the one that was open. Once I realized all my other tabs were gone, I 
didn't have time to mess with it for a few days. So the problem could have 
happened anytime in the last week or two.

I'm sure that when this happened, the files shrunk drastically (from several 
hundred tabs to a dozen or so will be very obvious).

But I don't have any specific line I can look at, the lines that are there 
change pretty regularly, and/or would not have changed at the transition.

git whatchanged shows commits like:

commit fb7e54c12ddc7c87c4862806d583f5c6abf3e731
Author: David Lang <david@lang.hm>
Date:   Fri Oct 20 11:00:01 2017 -0700

     update

:100644 100644 1a842ca... 290e9dd... M  Default/Bookmarks
:100644 100644 1cd745c... 388a455... M  Default/Current Session
:100644 100644 51074ad... c4dce40... M  Default/Current Tabs

If there was a way to add file size to this output, it would be perfect for what 
I'm needing.

David Lang
