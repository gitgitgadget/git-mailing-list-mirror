Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D26C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F72C61156
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbhKIVNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:13:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55415 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbhKIVNS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 16:13:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D3FD1556AC;
        Tue,  9 Nov 2021 16:10:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p2Zbc3jt2uM7HFnWRPmv9EHTE4n+sYpXFM5plS
        u1zZM=; b=CUATntGfJ+EcAU6JD1sehrwYH0ukddmZheq7Iqu1FTOyOjhQIIFNRb
        TMSF+8au9fi2y4Nm+NI4FM7My9aDuDIs17PNjWOZuExR3+dHug88HxJtesxQ9/FC
        cHCE4YAKzmJlGhVFC/qPVEzfvMSiS+oUWZ5AJWpdfye1aXhRiGW1g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 862A41556AB;
        Tue,  9 Nov 2021 16:10:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1457C1556AA;
        Tue,  9 Nov 2021 16:10:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Jarry <robin@jarry.cc>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jan Smets <jan.smets@nokia.com>,
        Stephen Morton <stephen.morton@nokia.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] receive-pack: ignore SIGPIPE while reporting status
 to client
References: <20211104133546.1967308-1-robin.jarry@6wind.com>
        <20211106220358.144886-1-robin@jarry.cc>
Date:   Tue, 09 Nov 2021 13:10:26 -0800
In-Reply-To: <20211106220358.144886-1-robin@jarry.cc> (Robin Jarry's message
        of "Sat, 6 Nov 2021 23:03:59 +0100")
Message-ID: <xmqqzgqd11dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76D772B4-41A1-11EC-82BB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry <robin@jarry.cc> writes:

> When a remote client exits while the pre-receive hook is running,
> receive-pack is not killed by SIGPIPE because the signal is ignored.
> This is a side effect of commit ec7dbd145bd8 (receive-pack: allow hooks
> to ignore its standard input stream, 2014-09-12).
>
> The pre-receive hook itself is not interrupted and does not receive any
> error since its stdout is a pipe which is read in an async thread and
> output back to the client socket in a side band channel.
>
> After the pre-receive has exited the SIGPIPE default handler is restored
> and if the hook did not report any error, objects are migrated from
> temporary to permanent storage.

All of the above talks about the pre-receive hook, but it is unclear
how that is relevant to this change.  The first paragraph says
"... is not killed", and if that was a bad thing (in other words, it
should be killed but is not, and that is a bug worth fixing), and if
this patch changes the behaviour, then that paragraph is worth
saying.  Similarly for the other two.

> Before running the post-receive hook, status info is reported back to
> the client. Since the client has died, receive-pack is killed by SIGPIPE
> and post-receive is never executed.

In other words, regardless of what happens (or does not happen) to
the pre-receive hook, which may not even exist, if "git push" dies
before the post-receive hook runs, this paragraph applies, no?  

What I am getting at is that this can (and should) be the first
paragraph of the description without losing clarity.

> Ignore SIGPIPE before reporting status to the client to increase the
> chances of post-receive running if pre-receive was successful. This does
> not guarantee 100% consistency but it should resist early disconnection
> by the client.

OK.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 49b846d96052..5fe7992028d4 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2564,12 +2564,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		use_keepalive = KEEPALIVE_ALWAYS;
>  		execute_commands(commands, unpack_status, &si,
>  				 &push_options);
> +		sigchain_push(SIGPIPE, SIG_IGN);
>  		if (pack_lockfile)
>  			unlink_or_warn(pack_lockfile);

Shouldn't we start ignoring SIGPIPE here, not before we try to
unlink the lockfile?

>  		if (report_status_v2)
>  			report_v2(commands, unpack_status);
>  		else if (report_status)
>  			report(commands, unpack_status);
> +		sigchain_pop(SIGPIPE);

In other words, push/pop pair should surround the part that reports
the status, as the proposed commit log message said.

>  		run_receive_hook(commands, "post-receive", 1,
>  				 &push_options);
>  		run_update_post_hook(commands);

Other than these, looks good to me.

Thanks.
