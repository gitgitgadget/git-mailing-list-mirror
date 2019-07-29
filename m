Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36121F462
	for <e@80x24.org>; Mon, 29 Jul 2019 08:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfG2Iof (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 04:44:35 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33783 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfG2Iof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 04:44:35 -0400
X-Originating-IP: 157.49.185.144
Received: from [192.168.43.207] (unknown [157.49.185.144])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CEB02240008;
        Mon, 29 Jul 2019 08:44:30 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
 <xmqqef29l94s.fsf@gitster-ct.c.googlers.com>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <beebae61-6858-b866-f388-7aa7cc5aa9b1@yadavpratyush.com>
Date:   Mon, 29 Jul 2019 14:14:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqef29l94s.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/19 10:39 AM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> These are probably pretty cheap on all but the largest repositories. I
>> was worried we were enumerating all refs or all history or something
>> like that.
>>
>>> ui_do_rescan changes the focus to the first diff. It is executed when you
>>> press F5 or choose Rescan from the menu. do_rescan does not do that.
>>>
>>> Resetting to first diff on focus change will get annoying when you are in
>>> the middle of looking at some other file. do_rescan just updates the
>>> software state without changing what file you are looking at or where in
>>> that file you are looking at.
>>
>> Yeah, this definitely seems like the right move.
> 
> "Right move" in the sense that it would try not to change what is
> being shown too much.  Rescan will still not be without cost, so it
> will be annoying if it happens when the user did not make any
> change.
> 
> And it is annoying even more, if the user did make change in another
> window.  You may make a change perhaps from the command line, write
> a short e-mail about it to let others know in your MUA, and then
> switch the focus back to git-gui to continue working.  Refreshing
> upon git-gui getting focus is no better than manually pressing F5 or
> whatever at that point.  It is too late at that point for spending
> extra cycles without being asked without getting annoying to the user.

On my system with a not-so-fast hard disk, it takes under 10ms to do a 
rescan (4 to 7ms usually). Using it for some time, I never felt any 
latency or lag. Maybe it will cause problems on other systems, but I'd 
like to hear from more people about it.

Also, why is it no better than manually refreshing? Manually refreshing 
gets annoying real quick (and that's why I sent this change in the first 
place). Not having to hit refresh every time you make any change is 
pretty sweet.

Yes it maybe doesn't matter as much when you open git-gui _after_ you're 
done making changes, and now only have to write the commit message. But 
if you keep it open while you are editing code, and then when you are 
done, you switch to it to commit, auto refresh is a great quality of 
life improvement.

Again, on my system at least, there is no noticeable latency when 
switching focus. How about making rescan on focus optional? The user can 
disable it if they feel like it is getting in their way.

> 
> The right time to spend cycles (in the background) in the above
> sample sequence is immediately after you made a change and switch to
> your MUA---while you are typing a few paragraphs, you would not mind
> git-gui spending seconds to repaint.

FYI, we are not just repainting, we are also syncing the repo state with 
the in-memory state when doing a rescan.

> 
> So probably a more productive use of our time, if we were to futz
> with git-gui, would be to figure out how git-gui can have an
> background idle process that notices a change in the repository and
> refreshes but only when you are *not* interacting with it (if it
> does things while you are interacting with it, it would become
> annoying and distracting), I would guess.  Just when you come back
> is the worst, and the most annoying, time to auto-refresh.
> 

So maybe something like inotify? tcl-inotify [0] (a tcl extension) can 
be used for it I suppose, though I haven't looked into it much yet.

My idea with this change was to keep it as minimal as possible. Doing a 
rescan on focus seems like a good compromise to me. I can look into 
inotify, but I'm not too aware of the performance impact it can have.

Also, do you know how editors like Atom or VSCode refresh when there is 
a change to the tree? I've seen them auto-update the GUI when you make 
any changes from outside of them.

I will look into tcl-inotify if there is a consensus that it is the 
better way to go about this. It seems like a significant time 
investment, and I'd rather not spend a lot of time doing something that 
would get rejected instantly.

[0] http://tcl-inotify.sourceforge.net/

-- 
Regards,
Pratyush Yadav
