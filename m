Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D41CC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE62613A9
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbhDLVqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:46:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62663 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhDLVqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:46:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59C98C7505;
        Mon, 12 Apr 2021 17:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LhPE3r+VdeXyrCtJ0t+k2enlT4E=; b=cmRhih
        oiuFrkmhCpYvrLW5g+lNknBlflYT9ZJ85gBpvQfQWH8PEV3lTUpmXzFfBxxI5KnI
        4t7Cos8voTFZdkEgD1R6I+O1DzDllFTCyHDZioZDXU1Afp0A1Mu/9wTCVxRkdTFQ
        u91SCI94Z1rDpiCjVU5EZ1lXhyKV4zQ3ov6tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XFHgOHesaBpXzKGR2amLud/U6mgspKPm
        ZYJVAwHpqWHFqyHAOvshdDF/rVDDBKRakFr6n5ttgiqSwJooFPTIOvGDPF8N6Noq
        XYwDYSWXPUPgFuXkoO90aX6NHzgya2mYPz6uEZTtqpxBtk5R3sL5mNPTgIdGDjnI
        ItDqaYRNDr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A781C7504;
        Mon, 12 Apr 2021 17:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 962D8C7503;
        Mon, 12 Apr 2021 17:45:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: print errno for read_raw_ref if GIT_TRACE_REFS is
 set
References: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 14:45:47 -0700
In-Reply-To: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 12 Apr 2021 19:32:34
        +0000")
Message-ID: <xmqq4kgbb2ic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 719E53B8-9BD8-11EB-94E3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/refs/debug.c b/refs/debug.c
> index 922e64fa6ad9..576bf98e74ae 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -244,6 +244,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  	int res = 0;
>  
>  	oidcpy(oid, &null_oid);
> +	errno = 0;
>  	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
>  					    type);
>  
> @@ -251,7 +252,9 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
>  			refname, oid_to_hex(oid), referent->buf, *type, res);
>  	} else {
> -		trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
> +		trace_printf_key(&trace_refs,
> +				 "read_raw_ref: %s: %d (errno %d)\n", refname,
> +				 res, errno);
>  	}

OK.  Between trace_printf_key() and the return of the call to
read_raw_ref() method of the ref backend is only an "if (res == 0)"
condition and I do not see anything that might clobber errno.

I do wonder if we want strerror(errno) instead of the number, but I
can go either way (it's just a trace output).

Thanks, will queue.
