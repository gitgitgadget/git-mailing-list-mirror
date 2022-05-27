Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10903C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbiE0M6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiE0M6b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:58:31 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF21344E5
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:58:30 -0700 (PDT)
Received: from [90.198.244.89] (helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuZXw-0004ju-F1;
        Fri, 27 May 2022 13:58:29 +0100
Message-ID: <c7667b0b-d18c-e2e4-0a9e-45367ee8ac0e@iee.email>
Date:   Fri, 27 May 2022 13:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] rebase: help users when dying with `preserve-merges`
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
 <220526.867d687hd5.gmgdl@evledraar.gmail.com>
 <00229772-f075-0b0c-7810-7debf6b971bc@iee.email> <xmqq1qwgxbys.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq1qwgxbys.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/05/2022 21:42, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>>> Make the `rebase --abort` option available to allow users to remove
>>>> traces of any preserve-merges rebase, even if they had upgraded
>>>> during a rebase.
> This patch does not make it "available", though.

Yes it does. Sorry if the terminology or explanation was poor (here we 
are looking at the commit message, not the user facing message?).

Currently, if the user has an in-progress rebase with preserve-merges, 
and now using the latest Git, they will reach the fatal die(), even if 
they try any of the git status suggestions of --abort, --continue, etc.  
Essentially, it's a 'you shouldn't be here', lets stop right now, go 
straight to jail condition. We do want to permit the `rebase --abort` 
command option.

I can swap around the && condition so that it's clearer that we check 
the user isn't requesting an --abort before checking the internal 
directory and then dying.
> 	Suggest using `--abort` to get out of the situation after a
> 	failed preserve-rebase and remove traces of ...
>
> perhaps?
>
> I do think the suggestion is worth doing if a user ever gets into
> the situation, but how likely does it happen?  A user has to start
> "rebase -p" with older Git,

.. hit a conflict, seeks help. Helper bring a personal portable Git with 
latest version - Oops.

Or Helper, says "Oh, your version is old, upgrade, and that'll fix it", 
again Oops.

> wait until Git gets updated to a future
> version of Git that includes this change, and then say "rebase -p
> --continue"?
You don't need the -p there ;-)

For this change, the "git rebase --continue" will still die() with the 
fatal: message. We do not have a way to continue. However..

After this change, the "git rebase --abort" will properly clear and 
clean the repo/status so that the user can then choose what to do.

>
>>>>   	} else if (is_directory(merge_dir())) {
>>>>   		strbuf_reset(&buf);
>>>>   		strbuf_addf(&buf, "%s/rewritten", merge_dir());
>>>> -		if (is_directory(buf.buf)) {
>>>> -			die("`rebase -p` is no longer supported");
>>>> +		if (is_directory(buf.buf) && !(action == ACTION_ABORT)) {
>>>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>>>> +			"Use `git rebase --abort` to terminate current rebase.\n"
>>>> +			"Or downgrade to v2.33, or earlier, to complete the rebase.\n");
>>>>   		} else {
>>>>   			strbuf_reset(&buf);
>>>>   			strbuf_addf(&buf, "%s/interactive", merge_dir());
>>> Existing issue: No _(), shouldn't we add it?
>> This `strbuf_addf` is forming a path for internal use. It just happens
>> to look like legible English ;-)
> I do not think Ævar meant "%s/interactive"; the enhanced message
> above that you inherited from the original "no longer supported"
> that was not marked for translation.
Ok.
>
>>> I wonder if we should use die_message() + advise() in these cases,
>>> i.e. stick to why we died in die_message() and have the advise() make
>>> suggestions, as e4921d877ab (tracking branches: add advice to ambiguous
>>> refspec error, 2022-04-01) does.
>> Ah, maybe it's my message.. that needs translating.
> Yup.
Ok, I'd add a separate patch for that.

> This whole '-p' business will go away in a few releases down, so a
> longer message give to the existing die() should be sufficient and
> there is no need for the choice between "yes, I am still weaning
> myself off of rebase -p and want to keep seeing the advice" and
> "thanks, I saw the message often enough, you no longer need to tell
> me how to get out", I would think.
I think it will take a long while for all the users, tools providers and 
distros to get beyond 2.33, so while each user may be weaned quickly, 
the generic problem is likely to continue to linger.


I hope to re-roll later next week. In general it's mainly tweaks and 
finesse.

Philip


