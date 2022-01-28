Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B7C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiA1RwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:52:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55257 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbiA1RwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 12:52:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7765D17E087;
        Fri, 28 Jan 2022 12:52:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zspS9uOH3yCjOusinq7OwBndsg0Ubt/kBGPopm
        hOUN8=; b=jplu61IcxadzSymMonqUmdeK9UaDQWFQKVSuZ1m6Et79S78Fde4JF2
        bOZ5PC0+MRC66z4z383OJ70kvXF2PY162aX/BI3Yfx/Ubwr4f21AWwKzpOcMXeVn
        XQys+GAodJAAEEgAymQNANM68zdMvVzFhO/L/wacviGqf7fGO7q2M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F95E17E086;
        Fri, 28 Jan 2022 12:52:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E080017E085;
        Fri, 28 Jan 2022 12:52:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3] receive-pack: check if client is alive before
 completing the push
References: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
        <20220127215553.1386024-1-robin.jarry@6wind.com>
Date:   Fri, 28 Jan 2022 09:52:12 -0800
In-Reply-To: <20220127215553.1386024-1-robin.jarry@6wind.com> (Robin Jarry's
        message of "Thu, 27 Jan 2022 22:55:53 +0100")
Message-ID: <xmqq4k5nychf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0669C288-8063-11EC-B113-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry <robin.jarry@6wind.com> writes:

> Abort the push operation (i.e. do not migrate the objects from temporary
> to permanent storage) if the client has disconnected while the
> pre-receive hook was running.
>
> This reduces the risk of inconsistencies on network errors or if the
> user hits ctrl-c while the pre-receive hook is running.
>
> Send a keepalive packet (empty) on sideband 2 (the one to report
> progress). If the client has exited, receive-pack will be killed via
> SIGPIPE and the push will be aborted. This only works when sideband*
> capabilities are advertised by the client.

If they have already exited but the fact hasn't reached us over the
network, the write() will succeed to deposit the packet in the send
buffer.  So I am not sure how much this would actually help, but it
should be safe to send an unsolicited keepalive as long as the other
side is expecting to hear from us.  When either report_status or
report_status_v2 capabilities is in effect, we will make a report()
or report_v2() call later, so we should be safe.

> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> ---
> v2 -> v3:
>     I had missed Documentation/technical/pack-protocol.txt. Using
>     sideband 2 to send the keepalive packet works.
>
>  builtin/receive-pack.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9f4a0b816cf9..8b0d56897c9f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1971,6 +1971,15 @@ static void execute_commands(struct command *commands,
>  		return;
>  	}
>  
> +	/*
> +	 * Send a keepalive packet on sideband 2 (progress info) to ensure that
> +	 * the client has not disconnected while pre-receive was running.
> +	 */

I suspect that any keepalive, unless it expects an active "yes, I am
still alive" response from the other side, is too weak to "ensure".

I guess "to notice a client that has disconnected (e.g. killed with
^C)" is more appropriate.

> +	if (use_sideband) {
> +		static const char buf[] = "0005\2";
> +		write_or_die(1, buf, sizeof(buf) - 1);
> +	}

Observing how execute_commands() and helper functions report an
error to the callers higher in the call chain, and ask them to abort
the remainder of the operation, I am not sure if write_or_die() is
appropriate.

    Side note: inside copy_to_sideband(), which runs in async, it is
    a different matter (i.e. the main process on our side is not
    what gets killed by that _or_die() part of the call), but this
    one kills the main process.

The convention around this code path seems to be to fill explanation
of error in cmd->error_string and return to the caller.  In this
case, the error_strings may not reach the pusher via report() or
report_v2() as they may have disconnected, but calling the report()
functions is not the only thing the caller will want to do after
calling us, so giving it a chance to clean up may be a better
design, e.g.

	if (write_in_full(...) < 0) {
		for (cmd = commands; cmd; cmd = cmd->next)
	        	cmd->error_string = "pusher went away";
		return;
	}

Yes, the current code will not actually use the error string in any
useful way in this particular case, since report() or report_v2()
will have nobody listening to them.  But being consistent will help
maintaining the caller, as it can later be extended to use it
locally (e.g. log the request and its outcome, check which cmd has
succeeded and failed using the NULL-ness of cmd->error_string, etc.)
