Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF2C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 00:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8686A61C72
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 00:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhF2API (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 20:15:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63644 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhF2API (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 20:15:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BB75155504;
        Mon, 28 Jun 2021 20:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=i+Xiw1lCJiza6XtRmuVJg07aDgVwGk9i7s2s4F5DbR4=; b=Qfyg
        7SAtakwZW+8qr6cT+XFDVipytdVCLemvaIwSdJUzbZHMnWLiE9mpIQd8A/0cMWkF
        6ePP7ltCPc+lWUD8Wx4lpNs5QaAO8PGKEZ+NC6/G2WAzOOMouEhjCbuy5V1UmkFt
        chvwaS+EiFcXLXf+8nhfZ/CJ+jL72SXYvJjThjo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13E8D155503;
        Mon, 28 Jun 2021 20:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46871155501;
        Mon, 28 Jun 2021 20:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: do not unnecessarily set COLUMNS on Windows
References: <pull.982.git.1623701952823.gitgitgadget@gmail.com>
        <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com>
        <xmqqv96dmduh.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2106171342270.57@tvgsbejvaqbjf.bet>
Date:   Mon, 28 Jun 2021 17:12:37 -0700
Message-ID: <xmqq4kdh5y16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6FE391E-D86E-11EB-ADF7-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 17 Jun 2021, Junio C Hamano wrote:
>
>> I think treating this as "less" specific band-aid is OK, but I do
>> not think tying this to Windows is a good design choice.
>>
>> The guiding principle for this change is more like "if we do not
>> know and cannot learn the true value, internally assuming 80-columns
>> as a last resort fallback may be OK, but do not export it for
>> consumption for other people---they cannot tell if COLUMNS=80 they
>> see us export is because we actually measured the terminal width and
>> know it to be 80, or we just punted and used a fallback default", I
>> think, and there is nothing Windows-specific in there, no?
>>
>> In other words, if we use something like the attached as a "less
>> specific band-aid" for now (i.e. direct replacement of your patch to
>> fix the specific 'less' problem), and then later clean it up by
>> actually returning -1 (or -80) from term_columns() as "we do not
>> know" (or "we do not know---use the negation of this value as
>> default"), we can help not just this paticular caller you touched,
>> but all other callers of term_columns(), to make a more intelligent
>> decision in the future if they wanted to.  The root of the issue I
>> think is because term_columns() does not give callers to tell if its
>> returned value is merely a guess.
>
> That approach should also work. Do you want me to take custody of your
> patch and issue a v3? If yes, I will mark you as co-author because the
> patch is not really only mine any longer.

Surely.  The fewer conditionally compiled codepaths based on
platforms we have, the easier it becomes to reason about the code, I
would think.

>>  pager.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git c/pager.c w/pager.c
>> index 3d37dd7ada..52f27a6765 100644
>> --- c/pager.c
>> +++ w/pager.c
>> @@ -11,6 +11,10 @@
>>  static struct child_process pager_process = CHILD_PROCESS_INIT;
>>  static const char *pager_program;
>>
>> +/* Is the value coming back from term_columns() just a guess? */
>> +static int term_columns_guessed;
>> +
>> +
>>  static void close_pager_fds(void)
>>  {
>>  	/* signal EOF to pager */
>> @@ -114,7 +118,8 @@ void setup_pager(void)
>>  	{
>>  		char buf[64];
>>  		xsnprintf(buf, sizeof(buf), "%d", term_columns());
>> -		setenv("COLUMNS", buf, 0);
>> +		if (!term_columns_guessed)
>> +			setenv("COLUMNS", buf, 0);
>>  	}
>>
>>  	setenv("GIT_PAGER_IN_USE", "true", 1);
>> @@ -158,15 +163,20 @@ int term_columns(void)
>>  		return term_columns_at_startup;
>>
>>  	term_columns_at_startup = 80;
>> +	term_columns_guessed = 1;
>>
>>  	col_string = getenv("COLUMNS");
>> -	if (col_string && (n_cols = atoi(col_string)) > 0)
>> +	if (col_string && (n_cols = atoi(col_string)) > 0) {
>>  		term_columns_at_startup = n_cols;
>> +		term_columns_guessed = 0;
>> +	}
>>  #ifdef TIOCGWINSZ
>>  	else {
>>  		struct winsize ws;
>> -		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
>> +		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
>>  			term_columns_at_startup = ws.ws_col;
>> +			term_columns_guessed = 0;
>> +		}
>>  	}
>>  #endif
>>
>>
