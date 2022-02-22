Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C54C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiBVQGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiBVQGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:06:38 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD7164D0B
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:06:12 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nMXg2-0007GX-FI;
        Tue, 22 Feb 2022 16:06:11 +0000
Message-ID: <c04eba64-0357-cfdd-2ffe-3905ce4f4cb9@iee.email>
Date:   Tue, 22 Feb 2022 16:06:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] rebase: help user when dying with preserve-merges`
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
 <220222.86czje7w4i.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220222.86czje7w4i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/02/2022 15:32, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Feb 22 2022, Philip Oakley via GitGitGadget wrote:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Git will die if a "rebase --preserve-merges" is in progress.
>> Users cannot --quit, --abort or --continue the rebase.
>>
>> This sceario can occur if the user updates their Git, or switches
>> to another newer version, after starting a preserve-merges rebase,
>> commonly via the pull setting.
>>
>> One trigger is an unexpectedly difficult to resolve conflict, as
>> reported on the `git-users` group.
>> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>>
>> Tell the user the cause, i.e. the existence of the directory.
>> The problem must be resolved manually, `git rebase --<option>`
>> commands will die, or the user must downgrade. Also, note that
>> the deleted options are no longer shown in the documentation.
> I can go and read the linked thread for the answer, but:
>
>>  		if (is_directory(buf.buf)) {
>> -			die("`rebase -p` is no longer supported");
>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>> +			"You still have a `.git/rebase-merge/rewritten` directory, \n"
>> +			"indicating a `rebase preserve-merge` is still in progress.\n");
>>  		} else {
>>  			strbuf_reset(&buf);
>>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
> As much of an improvement this is, I'd be no closer to knowing what I
> should do at this point.
>
> Should I "rm -rf" that directory, downgrade my version of git if I'd
> like to recover my work (as the message alludes to).
>
> In either case I'd think that this is getting a bit past the length
> where we'd have just a die() v.s. splitting it into a die()/advise()
> pair. I.e. to have the advise() carry some bullet-point list about X/Y/Z
> solutions, with the die() being a brief ~"we did because xyz dir is
> still here".
>
>
Hi Ævar,

Exactly. This is a slightly special, but real, case. The previous
message was essentially totally opaque to users. An "If I were you I
wouldn't start from here" response is somewhat true, so we simply tell
the user how they got to receive the fatal message. They can then take
any of the options they choose.

Ultimately the user downgraded and managed to use "rebase --continue",
as advised by Git, without the response "fatal:" to complete their old
preserve-merges rebase.

They'll hit a similar fault in short order because when they next `pull`
they'll be slipped into trying the preserve-merge rebase again - that's
the 2/2 patch, making sure they know why.

Philip
