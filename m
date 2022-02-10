Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3440C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 06:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiBJG2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 01:28:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiBJG2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 01:28:19 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5626B67
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 22:28:20 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9D94192EDA;
        Thu, 10 Feb 2022 01:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ELPbE9UVlJEkflSaIx5Wtwl2D5hN1xlkCVbLLn
        gy49s=; b=oY3b7eIjk3OvTFl8jO95BpCHbYe8de4wCRjU34QUQut9ACFaq/Dj2A
        BAdoRZbhKSmQxpoI2a22xVUHiSJm9Os68G6vwu3OKSZXSF1NrPWx/ZTlEWp2r+29
        JbChFJLB0DQxh4+B2f8oydKyyWo8O6nQKuqWlClJX6GL5K0cm0eOk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D283C192ED9;
        Thu, 10 Feb 2022 01:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 36944192ED8;
        Thu, 10 Feb 2022 01:28:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] xdiff: refactor a function
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <8655bb0348d7344ae85c8d521fb1ec7a5f4188d2.1644404356.git.gitgitgadget@gmail.com>
        <xmqqmtiz9aro.fsf@gitster.g>
Date:   Wed, 09 Feb 2022 22:28:16 -0800
In-Reply-To: <xmqqmtiz9aro.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        09 Feb 2022 10:04:43 -0800")
Message-ID: <xmqq8rujxmkf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A201F3E2-8A3A-11EC-8504-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>>  		xmparam_t const *xmp, mmbuffer_t *result)
>>  {
>> -	xdchange_t *xscr1, *xscr2;
>> -	xdfenv_t xe1, xe2;
>> -	int status;
>> +	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
>> +	xdfenv_t xe1 = { 0 }, xe2 = { 0 };
>> +	int status = -1;
>>  	xpparam_t const *xpp = &xmp->xpp;
>>  
>>  	result->ptr = NULL;
>>  	result->size = 0;
>>  
>> -	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
>> -		return -1;
>> -	}
>> -	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
>> -		xdl_free_env(&xe1);
>> -		return -1;
>> -	}
>
> OK, xdl_do_diff() calls xdl_free_env(xe) before an error return (I
> didn't check if patience and histogram also do so correctly), so the
> original was not leaking xe1 or xe2.

After I wrote the above, I took a brief look at patience and histogram,
and it does not seem to release resources held by "env" when it signals
a failure by returning a negative value.  So it seems that the original
used with patience or histogram were leaking env when it failed, and
this patch plugs that small leak.

If that is indeed the case, please note it in the proposed log
message.

Thanks.
