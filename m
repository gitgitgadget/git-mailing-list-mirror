Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA89202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 14:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934330AbdKGOqp (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 09:46:45 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5326 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933972AbdKGOqn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 09:46:43 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id C59Fe5gyYpb8rC59FepxWU; Tue, 07 Nov 2017 14:46:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510066002;
        bh=wxAlB+4BmiVOqTHlUkMHO1q3yikP+U5JOQu8hPc9lzc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UABBE0lLFbuFcJZGerM/Ap5eAvJVFpHI3Pq4F17lv2hLoZZcM2oBz8ifx/denmQ8V
         yQGVEqFO8x/PbZl3/b71j2hL9PTz8gzqn0BUJk4fkrSFH3umPC3ZeuyhdhT3hDGRTv
         eCBX/zQprLZYc9cAsL7K7nXnnnjGfu240PRMo1MY=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=HWEGUTuIDwarB2gwtasA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 6/8] sequencer: simplify adding Signed-off-by: trailer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-7-phillip.wood@talktalk.net>
 <xmqq375qg071.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b205b5ac-782b-1bf2-793d-fec0b7e29ebd@talktalk.net>
Date:   Tue, 7 Nov 2017 14:46:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq375qg071.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCF73lZgkHT3aGxbIl6eYc9RYsDkU6KY+3r6uGxgyfI1Q8cAdOFTX1uKLIXpInqBWFY5W8Jx33J0DaazFCpudorY6HOuJDtClccKAdySf0G9EC7ft4im
 OU03DFvevfREw2Bi+MFM/g4BkvFKYyUDOsTgjRPU/M07YZfFkJ8irQ/QAn8wDwLIAC57PacQw0SNYUxAa8VJGE60YepAk+0k/CdKulGV0knjK2m9kXTaAMy+
 JXVxnHaEtw6MrgdSx5iZI7vEDg3bsxKgQSHdyeRuTfT0kBC2KiaAtN2aAzgOqmY/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 04:52, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index ae24405c23d021ed7916e5e2d9df6de27f867a2e..3e4c3bbb265db58df22cfcb5a321fb74d822327e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -477,9 +477,6 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>>  			_(action_name(opts)));
>>  	rollback_lock_file(&index_lock);
>>  
>> -	if (opts->signoff)
>> -		append_signoff(msgbuf, 0, 0);
>> -
>>  	if (!clean)
>>  		append_conflicts_hint(msgbuf);
>>  
> 
> This function is called from only one place,  do_pick_commit(), and
> then the message returned from here in msgbuf is written to
> merge_msg(), even when the merge conflicted.
> 
> And when the merge conflicts, sequencer would stop and gives the
> control back to you---the MERGE_MSG file would have had the sign-off
> when you conclude the conflict resolution.
> 
> With the new code, we instead add the sign-off before calling the
> function to compensate for the above change, so MERGE_MSG file would
> have the sign-off as before, when the sequencer stops.
> 
>> @@ -657,8 +654,6 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>>  		argv_array_push(&cmd.args, "--amend");
>>  	if (opts->gpg_sign)
>>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>> -	if (opts->signoff)
>> -		argv_array_push(&cmd.args, "-s");
>>  	if (defmsg)
>>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>>  	if ((flags & CLEANUP_MSG))
> 
> This has two callers.  
> 
> The caller in do_pick_commit() is a bit curious; as we saw already,
> the message file should already have the sign-off and then we used
> to give another "-s" here.  Were we depending on "-s" to become
> no-op when the last sign-off is by the same person, I wonder?  In
> any case, the removal of "-s" from here won't hurt that caller.

That was more or less the conclusion I came to as well, though if the
user specifies a merge strategy other than recursive, then we were
relying on the "-s" passed to 'git commit' to add the sign-off. Now we
add the sign-off to the message ourselves in that case.

> The other caller is commit_staged_changes() which is called when
> doing "rebase -i continue".  I am not quite sure where the contents
> stored in the file rebase_path_message() comes from.  The function
> error_failed_squash() moves SQUASH_MSG to it and then makes a copy
> of it to MERGE_MSG, but that should only be relevant for squashed
> commit and no other cases, so...?

The interactive version of rebase does not support '--signoff' so this
is moot at the moment. I think that for conflicts with pick/edit/reword
then the sign-off is added to MERGE_MSG  and that file is then picked up
by 'git commit'. For squash/fixup then the sign-off should have already
been added to the commit whose message is used for the first message in
SQUASH_MSG, but that will not be at the end of the message where we
expect Signed-off-by: to be. I'd need to check properly but I suspect we
also end up with a Signed-off-by: added at the end of SQUASH_MSG as well.

> 
> I need to block a bit more time to read the relevant code to comment
> on this step, especially on this removal.
> 
> Thanks for working on this, anyway.

Thanks for looking at these patches and your comments on them, I'll get
on with making the changes you and Johannes have suggested and wait to
hear from you about this one.

Best Wishes

Phillip
> 
>> @@ -1347,6 +1342,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>>  		}
>>  	}
>>  
>> +	if (opts->signoff)
>> +		append_signoff(&msgbuf, 0, 0);
>> +
>>  	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
>>  		res = -1;
>>  	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {

