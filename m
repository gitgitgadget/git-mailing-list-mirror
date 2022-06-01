Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0632C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 17:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356256AbiFARJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356253AbiFARJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 13:09:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2002994EB
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 10:09:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9790011C3B5;
        Wed,  1 Jun 2022 13:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=usWtUL632qgRrIf4UxMkIn3qzh4isvLASgXzef
        ls+CU=; b=dbDLRyQFzNqPfOwCag/PINfvLzgHD/JCKC5nE/9fSdv0bUTmdEIaWl
        iVFrqfZH7SCYk3kn055VxBEfQ2JUkmw7FRIsueCOA3qktBJ/VlAayxEQ6PG7I92w
        my+BxoBZsev61lH5ZcrGuvJ3tYAi/xxfLjdI1KDQtTCD2s0b+5PsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D20C11C3B4;
        Wed,  1 Jun 2022 13:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8875C11C3B3;
        Wed,  1 Jun 2022 13:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 1/2] run-command: add an "ungroup" option to
 run_process_parallel()
References: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
        <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
        <patch-v4-1.2-f1170b02553-20220531T173005Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206011630400.349@tvgsbejvaqbjf.bet>
Date:   Wed, 01 Jun 2022 10:09:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206011630400.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 1 Jun 2022 18:49:58 +0200 (CEST)")
Message-ID: <xmqqczfstioj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89242986-E1CD-11EC-90C6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/run-command.c b/run-command.c
>> index a8501e38ceb..324e9548469 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1471,6 +1471,7 @@ enum child_state {
>>  	GIT_CP_WAIT_CLEANUP,
>>  };
>>
>> +int run_processes_parallel_ungroup;
>
> This global variable seems to exist solely to avoid extending the
> signature of `run_processes_parallel_tr2()`. Let's not do that.

It may make the change even noisier, though.

>> @@ -1537,7 +1539,7 @@ static void pp_init(struct parallel_processes *pp,
>>  		    get_next_task_fn get_next_task,
>>  		    start_failure_fn start_failure,
>>  		    task_finished_fn task_finished,
>> -		    void *data)
>> +		    void *data, const int ungroup)
>>  {
>>  	int i;

Marking incoming parameter as const is probably a misfeature in C,
but doing so with file-scope static would not hurt too much, so if
this series needs no further reroll, I'd let it pass.


>>  	for (i = 0; i < n; i++) {
>>  		strbuf_init(&pp->children[i].err, 0);
>>  		child_process_init(&pp->children[i].process);
>> +		if (!pp->pfd)
>
> It would be more logical to test for `pp->ungroup` than for `!pp->pfd`.
> In other instances below, the patch uses `if (ungroup)` instead. Let's not
> flip-flop between those two conditions, but the latter consistently.

I'd be somewhat sympathetic to the aversion to "flip-flop", but I
strongly disagree with you here.

"ungroup" does not have to stay to be the only reason why we do not
allocate the pp->pfd[] array, and what we care here is "if we are
polling for events, then do this initialization to the array", not
"if ungroup -> we must not have the pfd[] array -> so let's skip
it".  We do not have to add more code that depends on that two step
inference when we do not need to.

>> @@ -1606,6 +1614,7 @@ static void pp_cleanup(struct parallel_processes *pp)
>>   */
>>  static int pp_start_one(struct parallel_processes *pp)
>>  {
>> +	const int ungroup = pp->ungroup;
>
> It costs readers a couple of moments when they stumble over code that is
> inconsistent with the existing code. In this instance, I find very little
> value in the `const` qualifier. Actually, this entire line is probably not
> worth having because `pp->ungroup` is just 4 characters longer than
> `ungroup`.
>
> This same comment applies to another hunk below, too.
>
> Things like this do take focus away from reviewing the interesting part of
> the contribution, which in particular in the case of a regression fix that
> many are waiting for is something to avoid.

OK.

Thanks.
