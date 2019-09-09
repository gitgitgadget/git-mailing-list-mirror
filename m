Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623681F463
	for <e@80x24.org>; Mon,  9 Sep 2019 21:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfIIVGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 17:06:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53920 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfIIVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 17:06:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40D7C2C81A;
        Mon,  9 Sep 2019 17:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yr32320HXunj27/We7dFqDdTefo=; b=uDKQae
        zu+6hHFAQ6D2l3fGtnzjBW3JulZhi+Pm0AQl50OkLkrS83zqcJt/If7BYwFqzOhU
        qRl99Kn6wNmHmxuqelRT//O53sXuvN47sOep9iJNIgOJlypSNJzajL0lvQFgMT5u
        6uw+/f8KN0Tccti1wKprCRhSPQC119o20eirI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gjeeeJv65tMwTUUU61gKyqcQOsRVwSBU
        8cMnQ6A8B5+rk+wAApM9BXzWGUOw23RXM4Uh/aFDEwp/gv0Xy8qTmh6aJbMYKliI
        W6VoJX2NkC9uydK0DzyOziclRdVFGpDeodOkSOWe3QiVWW7sjLpiVZOjXUXagajP
        Oboj0kUQAKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 387A62C819;
        Mon,  9 Sep 2019 17:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BEA72C815;
        Mon,  9 Sep 2019 17:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 17/16] t3427: accelerate this test by using fast-export and fast-import
References: <pull.294.v2.git.gitgitgadget@gmail.com>
        <20190904214048.29331-1-newren@gmail.com>
        <nycvar.QRO.7.76.6.1909092229040.5377@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Sep 2019 14:06:30 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909092229040.5377@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 9 Sep 2019 22:29:30 +0200
        (CEST)")
Message-ID: <xmqqa7bdi3hl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2AAE54A-D345-11E9-9E81-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Elijah,
>
> On Wed, 4 Sep 2019, Elijah Newren wrote:
>
>> fast-export and fast-import can easily handle the simple rewrite that
>> was being done by filter-branch, and should be faster on systems with a
>> slow fork.  Measuring the overall time taken for all of t3427 (not just
>> the difference between filter-branch and fast-export/fast-import) shows
>> a speedup of about 5% on Linux and 11% on Mac.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> This patch is meant to be added onto the end of js/rebase-r-strategy; an
>> earlier version of this patch conflicted js/rebase-r-strategy so now I'm
>> basing on top of that series.  The speedup is also less impressive now
>> that there is only one filter-branch invocation being replaced instead of
>> a handful.  Still a nice speedup, though.
>
> ACK!
>
> Thanks,
> Dscho

Thanks, both.  This indeed is a good update.

>
>>
>>  t/t3427-rebase-subtree.sh | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
>> index 39e348de16..bec48e6a1f 100755
>> --- a/t/t3427-rebase-subtree.sh
>> +++ b/t/t3427-rebase-subtree.sh
>> @@ -59,7 +59,10 @@ test_expect_success 'setup' '
>>  	test_commit files_subtree/master5 &&
>>
>>  	git checkout -b to-rebase &&
>> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
>> +	git fast-export --no-data HEAD -- files_subtree/ |
>> +		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
>> +		git fast-import --force --quiet &&
>> +	git reset --hard &&
>>  	git commit -m "Empty commit" --allow-empty
>>  '
>>
>> --
>> 2.22.0.19.ga495766805
>>
>>
