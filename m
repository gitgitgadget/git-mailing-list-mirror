Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B1C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiHBPEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHBPEo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:04:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C923145
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:04:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C1E212936C;
        Tue,  2 Aug 2022 11:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z/wOnjZhrKphVZV4PAYcck8Y/vy9wnEXC+e6Ix
        lkqWI=; b=vPEuj7KAKbYdpUGcNbQVRUO0SlVTjszX8OyVuPtQxq5EIC+2O3R1UZ
        qFmuCPl2rxliu0p1vhxz/rQDaGf8qs/K1xeM/MwGgzD7mzSM43qFOudzg8fV0/gu
        +4ViQY3XcUTgksO/TJNVO8jY4Po6W2N43RQnkGnSdB/1dlOYwHZ7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 240A812936B;
        Tue,  2 Aug 2022 11:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EA4C12936A;
        Tue,  2 Aug 2022 11:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] pipe_command(): mark stdin descriptor as non-blocking
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
Date:   Tue, 02 Aug 2022 08:04:39 -0700
In-Reply-To: <YuikU//9OrdpKQcE@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 2 Aug 2022 00:13:07 -0400")
Message-ID: <xmqqbkt2k7p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6ED5CCCE-1274-11ED-9335-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our pipe_command() helper lets you both write to and read from a child
> process on its stdin/stdout. It's supposed to work without deadlocks
> because we use poll() to check when descriptors are ready for reading or
> writing. But there's a bug: if both the data to be written and the data
> to be read back exceed the pipe buffer, we'll deadlock.
> ...
> If you set add.interactive.useBuiltin to false, the problem goes away,
> because now we're not using pipe_command() anymore (instead, that part
> happens in perl). But this isn't a bug in the interactive code at all.
> It's the underlying pipe_command() code which is broken, and has been
> all along.
> ...
> The obvious fix is to put the descriptor into non-blocking mode, and
> indeed, that makes the problem go away. Callers shouldn't need to
> care, because they never see the descriptor (they hand us a buffer to
> feed into it).

Thanks for a very well reasoned and explained patch.

>   - more importantly, I'm not sure of the portability implications of
>     the fix. This is our first use of O_NONBLOCK outside of the
>     compat/simple-ipc unix-socket code. Do we need to abstract this
>     behind a compat/ layer for Windows?

Yup.  A very good question to ask for the platform maintainer.

>  run-command.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 14f17830f5..45bffb4b11 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1418,6 +1418,14 @@ static int pump_io(struct io_pump *slots, int nr)
>  	return 0;
>  }
>  
> +static int make_nonblock(int fd)
> +{
> +	int flags = fcntl(fd, F_GETFL);
> +	if (flags < 0)
> +		return -1;
> +	flags |= O_NONBLOCK;
> +	return fcntl(fd, F_SETFL, flags);
> +}
>  
>  int pipe_command(struct child_process *cmd,
>  		 const char *in, size_t in_len,
> @@ -1438,6 +1446,15 @@ int pipe_command(struct child_process *cmd,
>  		return -1;
>  
>  	if (in) {
> +		if (make_nonblock(cmd->in) < 0) {
> +			error_errno("unable to make pipe non-blocking");
> +			close(cmd->in);
> +			if (out)
> +				close(cmd->out);
> +			if (err)
> +				close(cmd->err);
> +			return -1;
> +		}
>  		io[nr].fd = cmd->in;
>  		io[nr].type = POLLOUT;
>  		io[nr].u.out.buf = in;
