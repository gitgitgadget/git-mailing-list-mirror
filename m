Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AFB11F462
	for <e@80x24.org>; Sun, 28 Jul 2019 22:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfG1WKl (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 18:10:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52905 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfG1WKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 18:10:41 -0400
X-Originating-IP: 157.49.182.108
Received: from [192.168.43.207] (unknown [157.49.182.108])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D523A20006;
        Sun, 28 Jul 2019 22:10:36 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
Date:   Mon, 29 Jul 2019 03:40:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728213634.GB162590@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On 29/07/19 3:06 AM, brian m. carlson wrote:
> On 2019-07-28 at 15:17:26, Pratyush Yadav wrote:
>> If any changes are made to the tree while git-gui is open, the user has
>> to manually rescan to see those changes in the gui. With this change, a
>> rescan will be performed whenever the window comes in focus, removing
>> the need for manual rescans in most cases. A manual rescan will still be
>> needed when something makes changes to the tree while git-gui is still
>> in focus.
> 
> I don't use git-gui, so I have no opinion on this change either way, but
> I do have some questions.
> 
> What exactly is involved in a rescan? Is it potentially expensive? If
> so, it might be better to leave it explicit, since people can
> accidentally give focus to the wrong window (bad click, focus follows
> mouse, etc.).
> 

The function is not documented, and I only started spelunking the code a 
couple days back, so I'll try to answer with what I know. It might not 
be the full picture.

Running git-gui --trace, these commands are executed during a rescan:

/usr/lib/git-core/git-rev-parse --verify HEAD
/usr/lib/git-core/git-update-index -q --unmerged --ignore-missing --refresh

Since I'm not too familiar with the details of these, I'll let you be 
the judge on how expensive these operations are. But I'll add that 
rescans are pretty fast on my relatively slow hard disk.

> Is there ever a situation in which someone might want to see the old
> state? For example, would a rescan change the active commit shown?
> Someone might be looking at a particular commit message or object ID for
> the current commit; would this interfere with that?

At least in my workflow, there is no such situation. I use git-gui to 
look at uncommitted changes, and stage and commit them. To look at older 
commits, I use gitk. And from what I understand, git-gui is not designed 
to browse old commits. In the options menu, it simply opens gitk if you 
click "Visualise master's history". There is no history browsing in 
git-gui itself.

Yes, a rescan will remove the old commit and will show the latest 
changes. This includes the old diff that was there before it was 
committed or removed from outside of git-gui. So this change will 
certainly interfere with the old state.

> 
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 6de74ce639..8ca2033dc8 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -3849,6 +3849,7 @@ if {[is_enabled transport]} {
>>   }
>>   
>>   bind .   <Key-F5>     ui_do_rescan
>> +bind .   <FocusIn>    do_rescan
> 
> What's the difference between these two? Why are we using do_rescan
> instead of ui_do_rescan?
> 

ui_do_rescan changes the focus to the first diff. It is executed when 
you press F5 or choose Rescan from the menu. do_rescan does not do that.

Resetting to first diff on focus change will get annoying when you are 
in the middle of looking at some other file. do_rescan just updates the 
software state without changing what file you are looking at or where in 
that file you are looking at.

>>   bind .   <$M1B-Key-r> ui_do_rescan
>>   bind .   <$M1B-Key-R> ui_do_rescan
>>   bind .   <$M1B-Key-s> do_signoff
> 
> The answers to a lot of these questions can go in your commit message to
> help reviewers and future readers understand your change better.
> 

I'm never too sure what I should put in the commit message, so I took 
the conservative route. I'll add more details in the v2 patch.

-- 
Regards,
Pratyush Yadav
