Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC5C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20E064F70
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCDUgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:36:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61720 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhCDUfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:35:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99052118A1C;
        Thu,  4 Mar 2021 15:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gjCojF/jK6v+Y1z8SuDoOSFN01w=; b=AQkidW
        +7HSTV+eoiCn2zYdTjm01U8djbOGukJLuy0BrbQ8bgjXEJkG5ctEn/XyAaoDpApx
        h+1UTt4QWDKdoM1hgJTfUa6JRWbJQdPp7rAdXUpoPn8ceh97Pp9oFIZu8uvqkE7v
        w0PS1nCcklJ2kEdX9ahhkSZtlTIKyws+UJ5lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tTEzF+fEdFan4n9Dsq8rjgGene3eAN4/
        hgV9T3J9c64e0jb1ZytQGen3/xC34PMt8MEWOrZdsCums3qwBz4518lfZrm22qjd
        q9rCQ282T3oeCWTJve3yWNtpNuO/Q5dSsh1OOXMVwXcNPN6JpzfJplayReaOIUAO
        Hya4C9ont3k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90EE9118A1B;
        Thu,  4 Mar 2021 15:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB72C118A19;
        Thu,  4 Mar 2021 15:34:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
        <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
        <YED1DmLWd+ciySNa@coredump.intra.peff.net>
Date:   Thu, 04 Mar 2021 12:34:54 -0800
In-Reply-To: <YED1DmLWd+ciySNa@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 4 Mar 2021 09:56:14 -0500")
Message-ID: <xmqqa6riejyp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14B00552-7D29-11EB-8DB1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The feature is definitely useful; I think I did 1eb10f4091 (unix-socket:
> handle long socket pathnames, 2012-01-09) in response to a real problem.
>
> Certainly callers could handle the error themselves. The reason I pushed
> it down into the socket code was to avoid having to implement in
> multiple callers. There are only two, but we'd have needed it in both
> sides (credential-cache--daemon as the listener, and credential-cache as
> the client).
>
> Ironically, the listening side now does a permanent chdir() to the
> socket directory anyway, since 6e61449051 (credential-cache--daemon:
> change to the socket dir on startup, 2016-02-23). So we could just do
> that first, and then feed the basename to the socket code.
>
> The client side would still need to handle it, though. It could probably
> also chdir to the socket directory without any real downside (once
> started, I don't think the helper program needs to access the filesystem
> at all outside of the socket).
>
> So I dunno. I'd be OK to just rip the feature out in favor of doing
> those chdir()s. But that seems like a non-zero amount of work versus
> leaving, and the existing code has the benefit that if another caller
> shows up, it could benefit from the feature.

I am OK to keep the series as-is, and leave it to a possible future
work to remove the need for chdir even for long paths and not having
to return an error with ENAMETOOLONG; when such an update happens,
the "fail if need to chdir" feature this patch is adding will become
a no-op.

