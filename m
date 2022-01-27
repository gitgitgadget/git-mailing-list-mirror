Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E9BC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 04:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiA0Egh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 23:36:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64739 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiA0Egf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 23:36:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29E9917B4BB;
        Wed, 26 Jan 2022 23:36:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5DTxFbLqUp60kfuAvuA3gQR5SgA6nP0lSLTmTqY6wak=; b=NlAu
        E8t/GylgxUWRBILUzOaWJnpqaAzoBDsn5+dzP2R1wj0u8lNr2XVVMTbjD2azT7Xr
        eanL4iQWeSg6GM14T/dXAGjr/AJS1RDmJGns4gcqKttC0XsYwSaIj0v7i90FrBsk
        WTer6C/tcxEoZAm0ELBBHB9Oh5iqFoAEmTJjeFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2198817B4B8;
        Wed, 26 Jan 2022 23:36:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D0C217B4B7;
        Wed, 26 Jan 2022 23:36:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive
 when client exits
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
        <20220126214438.3066132-1-robin.jarry@6wind.com>
Date:   Wed, 26 Jan 2022 20:36:31 -0800
Message-ID: <xmqqv8y54wxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F1695E-7F2A-11EC-810A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry <robin.jarry@6wind.com> writes:

> When hitting ctrl-c on the client while a remote pre-receive hook is
> running, receive-pack is not killed by SIGPIPE because the signal is
> ignored. This is a side effect of commit ec7dbd145bd8 (receive-pack:
> allow hooks to ignore its standard input stream).

I somehow feel that it is unrealistic to expect the command to be
killed via SIGPIPE because there is no guarantee that the command
has that many bytes to send out to to get the signal in the first
place.  Such an expectation is simply wrong, isn't it?

> This can be confusing for most people and may even be considered a bug.

So, there is not much I see is confusing, and I expect "most people"
would not get confused or consider it a bug.  Killing a local
process may or may not have any immediate effect on what happens on
the other side of the connection.

On the other hand, the SIGPIPE death by a poorly written pre-receive
hook was a source of real confusion.  The pushing end cannot do
anything about it to fix if the hook disconnected before reading all
of the proposed updates.

> Add a new receive.strictPreReceiveImpl config option to *not* ignore

I guess that the receiving end must know if its hook is loosely written
or not, so having a knob to revert to the older mode of operation
may probably be OK.

Do not abbreviate "Implementation" in the name of a configuration
variable, if that is the word you meant, by the way.  We try to
spell things out for clarity.

Also, "strict implementation" is way too vague.  What you want to
say here is that the hook will not stop reading its input in the
middle, causing the feeder to be killed by SIGPIPE, and from other
aspects its implementation may not be strict at all.

A name that goes well with a statement "This hook reads all of its
input" would work much better.

Should this cover only one hook, or should we introduce just one
configuration to say "all hooks that read from their standard input
stream are clean and will read their input to the end"?  Or do we
need to have N different variables for each of N hooks that may stop
reading from their standard input in the middle (not necessarily
limited to the receive-pack command)?  I think there are a handful
other hooks that take input from their standard input stream and I
am not sure if pre-receive should be singled out like this.

If this Boolean "This hook reads all of its input to the end" is to
be added per hook, I suspect that the namespace of the configuration
variable should be coordinated with the other effort to "define" hooks
in the configuration file(s) in the first place.  Emily, do you have
a suggestion?

> +static volatile pid_t hook_pid;
> +
> +static void kill_hook(int signum)
> +{
> +	if (hook_pid != 0) {
> +		kill(hook_pid, signum);
> +		waitpid(hook_pid, NULL, 0);
> +		hook_pid = 0;

Is it safe to kill(2) from within a signal handler?

Why does this patch do anything more than a partial reversion of
ec7dbd14 (receive-pack: allow hooks to ignore its standard input
stream, 2014-09-12), i.e. "if the configuration says do not be
lenient to hooks that do not consume their input, do not ignore
sigpipe at all".

> +	}
> +	sigchain_pop(signum);
> +	raise(signum);
> +}
> +
>  struct receive_hook_feed_state {
>  	struct command *cmd;
>  	struct ref_push_report *report;
> @@ -858,7 +877,11 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
>  		return code;
>  	}
>  
> -	sigchain_push(SIGPIPE, SIG_IGN);
> +	hook_pid = proc.pid;
> +	if (strict_pre_receive_impl && strcmp(hook_name, "pre-receive") == 0)
> +		sigchain_push(SIGPIPE, kill_hook);
> +	else
> +		sigchain_push(SIGPIPE, SIG_IGN);
>  
>  	while (1) {
>  		const char *buf;
> @@ -872,6 +895,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
>  	if (use_sideband)
>  		finish_async(&muxer);
>  
> +	hook_pid = 0;
>  	sigchain_pop(SIGPIPE);
>  
>  	return finish_command(&proc);
