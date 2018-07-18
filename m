Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB2E1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 09:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeGRKWc (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 06:22:32 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:13880 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbeGRKWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 06:22:32 -0400
Received: from [192.168.2.240] ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id fj1TfuBihdJAefj1TfFuDO; Wed, 18 Jul 2018 10:45:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1531907128;
        bh=HeMl5iYmgSUnMuqLI8avItQ6ylm+gMzg6pzyoF7jClE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G1n1j2fU1eIpYcXPKtvkSKX6sh+Pog6HIXjw9aswSFNi5brP43ocYP72qjFc91DDU
         +4WulJSOpialR8vvzxRqghcloIghjNX9H8A5dBIl6UxBJg0gmNLgq2UQMh2TIOnlel
         JytZo4v0TX9KQV4z/3etkdtnB0iHogtFGeasC8F8=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=IkcTkHD0fZMA:10 a=cETuxoCwAAAA:8
 a=Yf_Si4lgLqXbaDExjwgA:9 a=QEXdDO2ut3YA:10 a=tb6VMGFFq-HsUJGUQiVL:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script
 properly
To:     Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>
Cc:     git@vger.kernel.org
References: <86a7qwpt9g.knu@iDaemons.org>
 <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
Date:   Wed, 18 Jul 2018 10:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH/RYr5CtD3gFc5aRdKJYrDfgP5cpU1G1ZAGb6JEKs644gNdm8jd0M3bn2NOwJ6aegyfCd7Pxr1aOlEsS01zPhiAdsSMoZAKVSNsuSBX0CisXRjauX6o
 DoSEvqxQlm4c71UJruv8HG/3o6g0WmObDeh1e5ZCeL5R8OvaVQ0SZsAH26+B9a1jzd3gMS3PwVPSnpji+DRrn6ag6Jz79+Iv1nwZ9Si9C0VH6vaAo3dOUKQT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 12/07/18 18:22, Junio C Hamano wrote:
> 
> "Akinori MUSHA" <knu@iDaemons.org> writes:
> 
>> It looks like write_author_script() intends to write out a file in
>> Bourne shell syntax, but it doesn't put a closing single quote on the
>> last line.
> 
> s/closing single quote/& and the terminating newline/?
> 
>>
>> This patch makes .git/rebase-merge/author-script actually parsable by
>> sh(1) by adding a single quote and a linefeed to terminate the line
>> properly.
> 
> Sounds good.
> 
> I wonder why this breakage was left unnoticed for a long time,
> though.  It's not like writing and reading the author-script from C
> code was done first in the "rebase -i" and friends that are users of
> the sequencer machinery 

The only consumer of a faulty author script written by the sequencer is 
read_env_script() in sequencer.c which doesn't worry about checking that 
quotes are paired. The shell versions of rebase use the code in 
git-sh-setup.sh to create the author script which does write valid posix 
shell.

> (I think we had code to do so in "git am"
> that was rewritten in C first).

The code in builtin/am.c doesn't try to write valid posix shell (if one 
assumes it is the only consumer of the author script then it doesn't 
need to) which results in simpler code, but external scripts cannot 
safely eval it anymore.

>  Do we have a similar issue over
> there as well?  If not, perhaps if we reused the existing code that
> was not broken, we wouldn't have seen this breakage on the sequencer
> side?

Best Wishes

Phillip

> Thanks.
> 
>>
>> Signed-off-by: Akinori MUSHA <knu@idaemons.org>
>> ---
>>   sequencer.c                   |  1 +
>>   t/t3404-rebase-interactive.sh | 13 +++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 4034c0461..5f32b6df1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -651,6 +651,7 @@ static int write_author_script(const char *message)
>>   			strbuf_addch(&buf, *(message++));
>>   		else
>>   			strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> +	strbuf_addstr(&buf, "'\n");
>>   	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
>>   	strbuf_release(&buf);
>>   	return res;
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 352a52e59..345b103eb 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -75,6 +75,19 @@ test_expect_success 'rebase --keep-empty' '
>>   	test_line_count = 6 actual
>>   '
>>   
>> +test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
>> +	test_when_finished "git rebase --abort ||:" &&
>> +	git checkout master &&
>> +	set_fake_editor &&
>> +	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>> +	test -f .git/rebase-merge/author-script &&
>> +	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
>> +	eval "$(cat .git/rebase-merge/author-script)" &&
>> +	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
>> +	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
>> +	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
>> +'
>> +
>>   test_expect_success 'rebase -i with the exec command' '
>>   	git checkout master &&
>>   	(
>> -- 
>> 2.18.0

