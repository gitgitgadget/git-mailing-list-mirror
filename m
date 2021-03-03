Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE7C15501
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAAC64EDF
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382111AbhCDAYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59234 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhCCWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 17:54:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64A2011000B;
        Wed,  3 Mar 2021 17:53:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=98WyYO7ITDt6cVFoEHwRQXJviqg=; b=fM7rXu
        qaNwupmPp28EDa50jmCe1ub2KUOFdi3ASRvQzXL1jd0I9DuKKfHelD0TZIcKNIsF
        JXZw7c2ef20WGR8e6G3ffJ7hkMEU/9EnLGLFF9f1yPcglgXPgCcUWyfNsdciFJ64
        IQ4SvFOCBpFkkJMEnjxx6lj8cj+V3ikBIjoyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=greZ087de6pJ2AJ9EAbiHPpJDzMKorBw
        66G26u+5Lwae3z5WNUq33PeQAOCNaltmG/gMCguUmMP5Xo9pGW6kchm+Rab2GrTz
        gNPh+ut8aciZr1iC8aW7p89N2cUuuVcXlSt/k+MTdZTybwz0mCKcg+UjlzavE2fs
        DCmF3DKmSYw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C4A311000A;
        Wed,  3 Mar 2021 17:53:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5F27110009;
        Wed,  3 Mar 2021 17:53:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 14:53:23 -0800
In-Reply-To: <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 17 Feb 2021
        21:48:45 +0000")
Message-ID: <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 434A97DA-7C73-11EB-9EC2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Calls to `chdir()` are dangerous in a multi-threaded context.  If
> `unix_stream_listen()` or `unix_stream_connect()` is given a socket
> pathname that is too long to fit in a `sockaddr_un` structure, it will
> `chdir()` to the parent directory of the requested socket pathname,
> create the socket using a relative pathname, and then `chdir()` back.
> This is not thread-safe.
>
> Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when this
> flag is set.

While it is clear that this will not affect any existing callers, I
am not sure if this is a good direction to go in the longer term.

I have to wonder if somebody actually relies on this "feature",
though.  As long as ENAMETOOLONG is passed back to the caller so
that it can react to it, any caller that knows it is safe to chdir()
at the point of calling "send_request()" should be able to chdir()
itself and come back (or fork a child that chdirs and opens a unix
domain socket there, and then send the file descriptor back to the
parent process).

Thanks.
