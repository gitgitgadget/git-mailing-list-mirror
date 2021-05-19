Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AFC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C960611BD
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:05:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52230 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:05:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6707D1C07;
        Wed, 19 May 2021 18:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OaBXWkKHtaZzpn+ZpemYff2G7I1PIqfjoj3V64
        5O3ns=; b=pdFlXOpg4J0xkwc4p7/KFhKfUtN0uZ/Ua25Iqd/SCWdR7QuphyW5H6
        89bXqd47GhA9VQJMw7MmZ0NPm5pwhymKmZB6KB1mrI5OHvOXRncMMqTPZJZDTHEJ
        Mm97pxu1RiIZcurwOPvIqYzrQBHPYU4Ujyc/Z3DJRgJ2VXlOqhVVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9947FD1C06;
        Wed, 19 May 2021 18:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19911D1C05;
        Wed, 19 May 2021 18:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] simple-ipc: correct ifdefs when NO_PTHREADS is defined
References: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
        <xmqqk0nv1rc4.fsf@gitster.g>
        <79bf42e7-3923-a901-53eb-1aac13c53e6b@jeffhostetler.com>
Date:   Thu, 20 May 2021 07:03:43 +0900
In-Reply-To: <79bf42e7-3923-a901-53eb-1aac13c53e6b@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 19 May 2021 10:29:39 -0400")
Message-ID: <xmqqh7iyxtxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13F14986-B8EE-11EB-A9E2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>>   #ifdef NO_UNIX_SOCKETS
>>>   #error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
>>>   #endif
>>>   +#ifdef NO_PTHREADS
>>> +#error compat/simple-ipc/ipc-unix-socket.c requires pthreads
>>> +#endif
>>> +
>> Do we want to duplicate the requirement here and risk them drifting
>> apart?
>>  ...
> Would it be better to just have something like the following at the
> top of the source files and leave the details to the Makefile:
>
>
> #ifndef SUPPORTS_SIMPLE_IPC
> /*
>  * This source file should only be included when Simple IPC
>  * is supported.  See the top-level Makefile.
>  */
> #error SUPPORTS_SIMPLE_IPC not defined
> #endif

Yeah, that is a much better message, with even less duplication,
than what I sent.

I do not think #ifndef/#error/#endif adds much value, though.  After
all, the Makefile does not even tell us to feed this file to the
compiler when the C preprocessor macro is not defined, so presumably
whoever hits the #error knows s/he is doing something not supported,
and the point of the new message is to help those who we failed by
leaving the rest of the source file unbuildable even when we defined
the C preprocessor macro in the Makefile (like the mistaken
dependency on pthreads that we missed).

Thanks.
