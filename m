Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC5C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E0E610E6
	for <git@archiver.kernel.org>; Wed,  5 May 2021 02:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhEECFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 22:05:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51144 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhEECFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 22:05:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C090512717C;
        Tue,  4 May 2021 22:04:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wJPSOmwt2h2uhi41OGMGXB6cZLMK5YnmYy5CUs
        o8kGc=; b=tlVyIYOiQ6QRt4ivRxTcenCJUlj6/obrkno+O4ji/PIJmtvNrHffP5
        DyVYiW4kt6d/Zrj9OkiBMhy+ZEyUxMEDDcxYqJu93c6PQX1C/JAuId4ZGtEpbWv0
        pNuA0sDAgMZXOSgi3Kl6prQfKsuqHqeRC5hTSNtfEra8XADRKAscU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B992212717B;
        Tue,  4 May 2021 22:04:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0BD2312717A;
        Tue,  4 May 2021 22:04:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
References: <20210411095538.34129-1-mirucam@gmail.com>
        <20210411095538.34129-4-mirucam@gmail.com>
        <3771bfc2-e4a4-3c5d-bcf5-673b403358ca@ahunt.org>
Date:   Wed, 05 May 2021 11:04:04 +0900
In-Reply-To: <3771bfc2-e4a4-3c5d-bcf5-673b403358ca@ahunt.org> (Andrzej Hunt's
        message of "Tue, 4 May 2021 19:26:01 +0200")
Message-ID: <xmqqzgxa3pij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BE467B6-AD46-11EB-A993-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Hunt <andrzej@ahunt.org> writes:

>> +	struct strbuf command = STRBUF_INIT;
>> +	struct strvec args = STRVEC_INIT;
>> +	struct strvec run_args = STRVEC_INIT;
>> + ...
>> +	run_args.v[0] = xstrdup(command.buf);
>> +	run_args.nr = 1;
>
> AFAIUI manipulating the strvec directly like this means that we will
> violate the promise that strvec.v is always NULL-terminated. It's 
> probably safer to call 'strvec_push(run_args, command.buf)' instead of
> manipulating v and nr?

True.

> Violating the NULL-termination promise a problem because... (continued
> below)
>
>> +
>> +	while (1) {
>> +		strvec_clear(&args);
>> +		exit = 1;
>> +
>> +		printf(_("running %s"), command.buf);
>> +		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
>
> run_command_v_opt() implicitly expects a NULL-terminated list of
> strings. It's not documented in run_command_v_opt()'s comments,
> however run_command_v_opt() does explain that it's a wrapper around 
> start_command(), which uses child_process, and child_process.argv is
> documented to require a NULL-terminated list.
>
> If argv is not NULL-terminated, we hit a buffer overflow read  in
> prepare_shell_cmd(), which can be reproduced by running something
> like:
>
>   make CC=clang-11 SANITIZE=address COPTS="-Og -g" GIT_TEST_OPTS=-v
>   T=t6030-bisect-porcelain.sh test
>
> which results in ASAN reporting this error:
> ...

Thanks for a careful explanation.

