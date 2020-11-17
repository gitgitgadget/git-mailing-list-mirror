Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83759C5519F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF5221FB
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 11:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgKQLNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:13:06 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:51022 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 06:13:05 -0500
Received: from client3368.fritz.box (i5C745F5E.versanet.de [92.116.95.94])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 41D933C02B8;
        Tue, 17 Nov 2020 12:13:03 +0100 (CET)
Subject: Re: [PATCH v2 1/1] git-gui: Auto-rescan on activate
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, mlevedahl@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
References: <fe2f24e8-52f2-81fe-0ebd-ecd90b1acfb4@haller-berlin.de>
 <20201103161631.89971-1-stefan@haller-berlin.de>
 <20201103161631.89971-2-stefan@haller-berlin.de>
 <14be00ae-c2b6-87eb-2f4b-964a6df7b230@haller-berlin.de>
 <20201117073618.fjbi4ranmh5x3uxk@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <4a37f6ce-276f-1c7e-1252-085a6f28c95b@haller-berlin.de>
Date:   Tue, 17 Nov 2020 12:13:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117073618.fjbi4ranmh5x3uxk@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.11.20 8:36, Pratyush Yadav wrote:
> Hi Stefan,
> 
> On 14/11/20 08:14PM, Stefan Haller wrote:
>> On 03.11.20 17:16, Stefan Haller wrote:
>>> Do an automatic rescan whenever the git-gui window receives focus. Most other
>>> GUI tools do this, and it's very convenient; no more pressing F5 manually.
>>>
>>> People who don't like this behavior can turn it off in the Options dialog.
>>
>> Ping - any thoughts? I have been running with this patch for a few weeks
>> now, and I already don't want to miss it any more.
> 
> I have been staring at your patch for the last few days with indecision. 
> I have finally made up my mind. I do not think it is a good idea to hurt 
> the experience of a significant population of our users without at least 
> telling them how they can fix it.
> 
> The config option is not very visible at all. Experience has told me 
> that people don't often go looking around in the options menu to find a 
> fix for their problem. So we need to do a better job of educating them 
> why they might be experiencing slowdowns and how they can avoid them.
> 
> Let's take inspiration from git status. When the local branch diverges 
> from the upstream branch, git status shows you how many commits your 
> branch is ahead and how many commits behind upstream. This can be an 
> expensive operation if the divergence point is far behind. In those 
> cases, git status prints something like:
> 
>   It took 30.00 seconds to calculate the branch ahead/behind values.
>   You can use '--no-ahead-behind' to avoid this.
> 
> This made me aware this option existed and that I can use it to avoid 
> slowdowns.
> 
> We should do something similar for the auto rescan. Measure how long it 
> takes to finish the rescan and if it takes longer than X seconds then 
> tell the user that they can use this option to disable this. If they 
> don't mind the delay they can keep on using it.
> 
> I am working on a patch to add this. Will send it in a day or two.

Sounds good to me. While I personally don't think such a check is
necessary in this case, I also have nothing against it if you find it
important.

It just needs to be possible to disable that check itself, too. I
certainly wouldn't want to be bothered by it, even if the rescan should
take longer than whatever threshold you decide on. So if you put up a
dialog to inform the user, the dialog should ideally have a "Don't show
again" option.


>> Cc:-ing a few people who were involved in the discussion on Pratyush's
>> similar patch last summer. [0]
>>
>>
>> [0] <https://lore.kernel.org/git/20190728151726.9188-1-
>>      me@yadavpratyush.com/>
>>
>>
>>>
>>> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
>>> ---
>>>  git-gui.sh     | 5 +++++
>>>  lib/option.tcl | 1 +
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/git-gui.sh b/git-gui.sh
>>> index 867b8ce..14735a3 100755
>>> --- a/git-gui.sh
>>> +++ b/git-gui.sh
>>> @@ -906,6 +906,7 @@ set font_descs {
>>>  }
>>>  set default_config(gui.stageuntracked) ask
>>>  set default_config(gui.displayuntracked) true
>>> +set default_config(gui.autorescan) true
>>>
>>>  ######################################################################
>>>  ##
>>> @@ -4007,6 +4008,10 @@ bind .   <Alt-Key-2> {focus_widget $::ui_index}
>>>  bind .   <Alt-Key-3> {focus $::ui_diff}
>>>  bind .   <Alt-Key-4> {focus $::ui_comm}
>>>
>>> +if {[is_config_true gui.autorescan]} {
>>> +	bind .   <FocusIn>  { if {"%W" eq "."} do_rescan }
>>> +}
>>> +
>>>  set file_lists_last_clicked($ui_index) {}
>>>  set file_lists_last_clicked($ui_workdir) {}
>>>
>>> diff --git a/lib/option.tcl b/lib/option.tcl
>>> index e43971b..9e83db7 100644
>>> --- a/lib/option.tcl
>>> +++ b/lib/option.tcl
>>> @@ -145,6 +145,7 @@ proc do_options {} {
>>>  		{b merge.diffstat {mc "Show Diffstat After Merge"}}
>>>  		{t merge.tool {mc "Use Merge Tool"}}
>>>
>>> +		{b gui.autorescan  {mc "Auto-Rescan On Activate"}}
>>>  		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
>>>  		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
>>>  		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
>>> --
>>> 2.29.2
>>>
> 
