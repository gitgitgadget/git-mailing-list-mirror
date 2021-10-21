Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6379EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4930B60E78
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhJUSta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:49:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53426 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUSt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:49:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 446C3EBCA3;
        Thu, 21 Oct 2021 14:47:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AWADTVVP+XocIDDcxI8Pd3Wnue9pCSae2Fl/DH
        bc3X8=; b=JgEEnCPvHzrnDApvP75a5ZbiLJPnJR0mpmrC9zvlxwzGotGoh1Gf0X
        N9BbXcuccmv8rShfuYVi2GrBVvmt6gggf21TmUPIrm5Z1sc5CtqefQAVw9uFOIKr
        +LTpcK1HEYhtLP3W6LrfCnjVWpLKYXKsFtc+t+7FNmMWevTrxhCQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C889EBCA2;
        Thu, 21 Oct 2021 14:47:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FA50EBCA1;
        Thu, 21 Oct 2021 14:47:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 05/11] builtin/repack.c: avoid leaking child arguments
References: <cover.1634787555.git.me@ttaylorr.com>
        <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
        <67b553b7-4e69-9906-b237-9c44cf8aaf44@gmail.com>
Date:   Thu, 21 Oct 2021 11:47:11 -0700
In-Reply-To: <67b553b7-4e69-9906-b237-9c44cf8aaf44@gmail.com> (Derrick
        Stolee's message of "Thu, 21 Oct 2021 09:32:16 -0400")
Message-ID: <xmqqh7dakyfk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DB7D11E-329F-11EC-81B0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  	struct child_process cmd = CHILD_PROCESS_INIT;
>>  	FILE *out;
>>  	struct strbuf line = STRBUF_INIT;
>> +	int ret = 0;
>
> nit: "ret" is short for "return" which makes me think "this will
> be used as 'return ret;'" but we don't do that. Instead, we use
> it as the _result_ of an inner call:

Yup, my reading hiccupped there, too.

>
>> -	if (finish_command(&cmd))
>> +	ret = finish_command(&cmd);
>> +
>> +cleanup:
>> +	child_process_clear(&cmd);
>> +
>> +	if (ret)
>>  		die(_("could not finish pack-objects to repack promisor objects"));
>
> For that reason, I would rename this to "res" or "result".

Yeah, if we are introducing a new variable, result is a good name.
