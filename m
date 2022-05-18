Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A989C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 17:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiERR6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiERR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 13:58:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F62D8A31D
        for <git@vger.kernel.org>; Wed, 18 May 2022 10:57:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB22111062B;
        Wed, 18 May 2022 13:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XSbHKwQpCdbD7M8HPah80Z79FJG79Z67wcbXvY
        h0iQM=; b=w4rBGIGJ1pgtPJ9f7QXvKQIp3+te67RkXWG+XXaCTqD/Wh9EtGGzI5
        KRPb5TMZKQq1HlnwKU1mF91T1elTLQPTs23wROhZVeGOF5euXji7URjtWuKPx3aN
        Pzdo7vEJ1RYh/yJ9asveouGCb6L80fix/pZHxSHNSDTx2anxKnTb8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C32D311062A;
        Wed, 18 May 2022 13:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35F33110628;
        Wed, 18 May 2022 13:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 04/15] test-dir-iterator: consistently return
 EXIT_FAILURE or EXIT_SUCCESS
References: <20220509175159.2948802-1-kioplato@gmail.com>
        <20220509175159.2948802-5-kioplato@gmail.com>
        <xmqq35hictaa.fsf@gitster.g> <20220518141321.uynaxzaoivlthi7b@compass>
Date:   Wed, 18 May 2022 10:57:54 -0700
In-Reply-To: <20220518141321.uynaxzaoivlthi7b@compass> (Plato Kiorpelidis's
        message of "Wed, 18 May 2022 17:13:21 +0300")
Message-ID: <xmqq7d6iwwnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BE1AE2A-D6D4-11EC-8ECC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plato Kiorpelidis <kioplato@gmail.com> writes:

>> And less portable for the invoking process of "git".  The invoking
>> process used to be able to depend ou getting WEXITSTATUS() from our
>> exit status to obtain "1" when we exited with 1; if we start exiting
>> with EXIT_FAILURE, there is no guarantee what non-zero value is used.
>> 
>> So, I am not sure if this is a good direction to go in.
>
> From what I understand, this is a point about why EXIT_FAILURE and EXIT_SUCCESS
> are a bad idea in Git's case in general; not specifically in test-tool's case.
> The test-tool doesn't use child processes, therefore it doesn't use the macro
> WEXITSTATUS. As a result, supposedly, we could use EXIT_FAILURE and EXIT_SUCCESS
> constants in this case. However, we don't want to use them in order to stay
> consistent throughtout Git's implementation. Is my understanding correct?

Yes, it is a bad idea for any tool (not limited to Git) whose
documentation does not say "on failure, it exits with non-zero exit
status", but signals what kind of failure with different non-zero
exit status values.  Perhaps the calling test scripts of test-tool
may only care about exit status being (or not being) zero, so we
could use EXIT_FAILURE vs EXIT_SUCCESS, as long as EXIT_FAILURE does
not exit with a value that confuses test_must_fail, but by design,
the code that uses EXIT_FAILURE cannot guarantee that---the whole
point of EXIT_FAILURE macro is to hide which exact value is used.
You are correct to assume that we'd want to avoid using EXIT_FAILURE
in test-tool because we do not want to tempt people to
copy-and-paste.

Thanks.
