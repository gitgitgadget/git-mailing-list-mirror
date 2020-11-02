Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B253C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CB020786
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKBT31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:29:27 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:46852 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBT31 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:29:27 -0500
Received: from client3368.fritz.box (i5C7473CB.versanet.de [92.116.115.203])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 878CE3C451B;
        Mon,  2 Nov 2020 20:29:24 +0100 (CET)
Subject: Re: [PATCH 1/2] git-gui: Delay rescan until idle time
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <20201101170505.71246-2-stefan@haller-berlin.de>
 <20201102154550.2tvvsswokscg42ba@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <def489e0-c888-8a2b-e49c-598034f683e7@haller-berlin.de>
Date:   Mon, 2 Nov 2020 20:29:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102154550.2tvvsswokscg42ba@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.11.20 16:45, Pratyush Yadav wrote:
> Hi Stefan,
> 
> On 01/11/20 06:05PM, Stefan Haller wrote:
>> This is to ensure that a rescan is only performed once, even if it is
>> requested multiple times during one event. We don't need this yet, because
>> we only ever call do_rescan once per event so far; this is going to change
>> with the next commit, when we also call it from FocusIn.
> 
> I don't understand what this is trying to achieve. The calls to 
> do_rescan below only happen when the user explicitly does something, 
> like stage/unstage selected lines. Why would that event coincide with 
> the FocusIn event?
> 
> If you mean to account for a situation where the rescan for 
> "Apply/Reverse Line" is executed before the rescan from FocusIn 
> finishes, then in that case the procedure rescan already accounts for it 
> by checking $rescan_active and the index lock.

I'm aware that the rescan runs asynchronously, but I wasn't worried
about the case where it's triggered concurrently while another one is
running already; I was worried about the case where a rescan (e.g.
coming from "Apply/Reverse Line") was so fast that it was already
finished by the time the FocusIn comes. But I guess I misunderstood Tk's
threading model, and this can never happen.

So it does indeed seem that the existing $rescan_active logic is enough
to prevent unnecessary rescans; I'll drop this commit.

> Have you noticed multiple rescans in parallel? If yes then we might want 
> to look at why the check is not working.
>  
>> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
>> ---
>>  git-gui.sh | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index 867b8ce..8864c14 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -2376,8 +2376,21 @@ proc do_quit {{rc {1}}} {
>>  	destroy .
>>  }
>>  
>> +# Not to be called directly; use schedule_rescan instead
>>  proc do_rescan {} {
>> +	global rescan_id
>> +
>>  	rescan ui_ready
>> +	unset rescan_id
> 
> Not sure if you're aware of it already, but it is worth mentioning that 
> rescan is asynchronous. The procedure call will return before the rescan 
> in actually complete. See the `fileevent` calls in rescan and 
> rescan_stage2.
> 
> So in this case, rescan_id will be unset before the rescan is actually 
> done. This can be the right or wrong thing depending on what you want to 
> accomplish, which I'm not clear on.
> 
>> +}
>> +
>> +proc schedule_rescan {} {
>> +	global rescan_id
>> +
>> +	if {[info exists rescan_id]} {
>> +		after cancel $rescan_id
>> +	}
>> +	set rescan_id [after idle do_rescan]
>>  }
>>  
>>  proc ui_do_rescan {} {
>> @@ -3683,7 +3696,7 @@ set ui_diff_applyhunk [$ctxm index last]
>>  lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
>>  $ctxm add command \
>>  	-label [mc "Apply/Reverse Line"] \
>> -	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
>> +	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; schedule_rescan}
>>  set ui_diff_applyline [$ctxm index last]
>>  lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
>>  $ctxm add separator
>> @@ -3694,12 +3707,12 @@ set ui_diff_reverthunk [$ctxm index last]
>>  lappend diff_actions [list $ctxm entryconf $ui_diff_reverthunk -state]
>>  $ctxm add command \
>>  	-label [mc "Revert Line"] \
>> -	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
>> +	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; schedule_rescan}
>>  set ui_diff_revertline [$ctxm index last]
>>  lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
>>  $ctxm add command \
>>  	-label [mc "Undo Last Revert"] \
>> -	-command {undo_last_revert; do_rescan}
>> +	-command {undo_last_revert; schedule_rescan}
>>  set ui_diff_undorevert [$ctxm index last]
>>  lappend diff_actions [list $ctxm entryconf $ui_diff_undorevert -state]
>>  $ctxm add separator
>> @@ -4171,7 +4184,7 @@ after 1 {
>>  	if {[is_enabled initialamend]} {
>>  		force_amend
>>  	} else {
>> -		do_rescan
>> +		schedule_rescan
>>  	}
>>  
>>  	if {[is_enabled nocommitmsg]} {
>> -- 
>> 2.29.2
>>
> 
