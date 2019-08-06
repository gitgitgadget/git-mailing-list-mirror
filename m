Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4751F731
	for <e@80x24.org>; Tue,  6 Aug 2019 19:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfHFTE6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 15:04:58 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36707 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFTE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 15:04:58 -0400
X-Originating-IP: 157.45.34.62
Received: from localhost.localdomain (unknown [157.45.34.62])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0759AE0008;
        Tue,  6 Aug 2019 19:04:54 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190804143919.10732-1-me@yadavpratyush.com>
 <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
 <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
Date:   Wed, 7 Aug 2019 00:34:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/6/19 11:52 PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
>> If there are no comments/objections with this patch, can it be merged
>> please?
> 
> It usually works the other way around (no comments by default means
> no interests), but sadly, a larger problem with this area is that
> there currently is nobody who is actively working on maintaining the
> 'git-gui' project, which is a separate project that our tree merely
> pulls from time to time.  So we need to find a volunteer to run that
> project, send the patch in that direction and get it merged, and
> then finally we can pull from them X-<.

I'm not too optimistic on finding someone to run this project. I asked 
on the list who the maintainer is [0], and no one came up. The repo at 
[1] also seems abandoned.

So if I fork the project, will you pull from my fork? If yes, what 
exactly would I have to do? Make a set of changes and then ask on the 
list for you to pull from my fork?

I am a relatively inexperienced programmer, and it feels like a kinda 
big responsibility that I'm not sure I am ready for. But maybe you can 
look at the changes from a high level POV before pulling, so there is 
someone sanity checking my changes.

[0] 
https://public-inbox.org/git/35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com/
[1] https://repo.or.cz/w/git-gui.git/

> 
>>
>> On 8/4/19 8:09 PM, Pratyush Yadav wrote:
>>> If the toplevel window for the window being destroyed is the main window
>>> (aka "."), then simply destroying it means the cleanup tasks are not
>>> executed like saving the commit message buffer, saving window state,
>>> etc. All this is handled by do_quit so, call it instead of directly
>>> destroying the main window. For other toplevel windows, the old behavior
>>> remains.
>>>
>>> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
>>> ---
>>>    git-gui/git-gui.sh | 19 +++++++++++++++++--
>>>    1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>>> index 6de74ce639..6ec562d5da 100755
>>> --- a/git-gui/git-gui.sh
>>> +++ b/git-gui/git-gui.sh
>>> @@ -3030,8 +3030,23 @@ unset doc_path doc_url
>>>    wm protocol . WM_DELETE_WINDOW do_quit
>>>    bind all <$M1B-Key-q> do_quit
>>>    bind all <$M1B-Key-Q> do_quit
>>> -bind all <$M1B-Key-w> {destroy [winfo toplevel %W]}
>>> -bind all <$M1B-Key-W> {destroy [winfo toplevel %W]}
>>> +
>>> +set m1b_w_script {
>>> +	set toplvl_win [winfo toplevel %W]
>>> +
>>> +	# If we are destroying the main window, we should call do_quit to take
>>> +	# care of cleanup before exiting the program.
>>> +	if {$toplvl_win eq "."} {
>>> +		do_quit
>>> +	} else {
>>> +		destroy $toplvl_win
>>> +	}
>>> +}
>>> +
>>> +bind all <$M1B-Key-w> $m1b_w_script
>>> +bind all <$M1B-Key-W> $m1b_w_script
>>> +
>>> +unset m1b_w_script
>>>      set subcommand_args {}
>>>    proc usage {} {
>>>


-- 
Regards,
Pratyush Yadav
