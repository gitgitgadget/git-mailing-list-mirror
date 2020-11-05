Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA961C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A43720936
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mxEw34RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgKETOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:14:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52924 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKETOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 14:14:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 781407BEF2;
        Thu,  5 Nov 2020 14:14:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EThBApCHsOVwkSelsMmVODozMUI=; b=mxEw34
        RTkoamlnBnVxosv9tpZwNsHSVqu6+/MjNE7tMh8CSC3rwVpB4a/1O6GEYWbFI3fK
        mKN2v0EIRc/R5NE1HGgA3K6u2yPWMFY4m8Vdi64MmGA4tVmOueDKAiYMP4rnpnmj
        6/n5Kgsm7WR8M8tJt3UQXD/pEMYOa90GQFD/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eHPRDRys6OXuozbP0DjDooF1i/EY2qGm
        ZUkY1hBCQ7zuAZslNw7RxT65c+RF2/WSCKTumYCm8tZ8KBisnm73h+F+6GpOq/BX
        xGSyBEUAW3z4LIAOm0LHtO0XGQoZhBxN+yAnBtGjGMIZHwJ97uoQVt8a8QnOU1nX
        SMv7W4+9B6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70B267BEF1;
        Thu,  5 Nov 2020 14:14:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED58E7BEF0;
        Thu,  5 Nov 2020 14:14:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [RFC PATCH] t5411: fix broken pipe write error on proc-receive
References: <CANYiYbFcXN_ARmZ70GQkrQ=uFaf7YPObYcopEOFseON6TQzNpQ@mail.gmail.com>
        <20201105152329.12736-1-worldhello.net@gmail.com>
Date:   Thu, 05 Nov 2020 11:14:17 -0800
In-Reply-To: <20201105152329.12736-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 5 Nov 2020 10:23:29 -0500")
Message-ID: <xmqqk0uzk452.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19E6A8DC-1F9B-11EB-AAA8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Johannes found a flaky hang in t5411 in the osx-clang job of the CI/PR
> builds, and ran into this issue using `--stress` option with the
> following errror messages:

s/errror/error/;

>     fatal: unable to write flush packet: Broken pipe
>     send-pack: unexpected disconnect while reading sideband packet
>     fatal: the remote end hung up unexpectedly
>
> In this test case, the "proc-receive" hook sends an error message and
> dies earlier. While "receive-pack" on the other side of the pipe

Micronit.  "dies first" may be easier to read.

> should forward the error message of the "proc-receive" hook to the
> client side, but there is no such error message in output. It seems
> that the expected error message is overridden by the broken pipe error
> message. The broken pipe error is because "receive-pack" sends other
> commands to the "proc-receive" hook, but the hook dies earlier.

The way the exchange designed to happen in a successfull case is
that receive-pack process feeds the commands over the pipe, and
after feeding all commands start reading response?  Even if the
hooks were forbidden from (1) disconnect before reading the commands
and/or (2) speaking before receive-pack finishes feeding the
commands, since they are end-user-supplied random scripts,
receive-pack needs to be prepared to deal with misbehaving hooks.

> To fix this issue, these changes are made:
>
> 1. In "receive-pack", close the input stream for the "proc-receive" hook
>    before reading result from "proc-receive".

This is necessary because...?  Until/unless we close our end, the
hook would not know we finished talking to them, so it is a good
discipline to close our end of the pipe, but it is unclear to me how
this causes the broken pipe failure, i.e. write by receive-pack into
a pipe connected to the hook that has already died.

> 2. The test helper for "proc-receive" consumes the input stream before
>    it die earlier.

"before it dies."

This is merely a workaround in the hook used for testing.  End-user
hook that misbehaves can still disconnect without reading anything,
and receive-pack needs to be prepared for such a case, no?

Is it irrelevant because this is only about forcing a flakey test
that fails in two different ways to fail in a predictable way?

Thanks.

> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  builtin/receive-pack.c            | 4 +++-
>  t/helper/test-proc-receive.c      | 8 +++++---
>  t/t5411/test-0013-bad-protocol.sh | 3 +--
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index bb9909c52e..6bd402897c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1172,6 +1172,7 @@ static int run_proc_receive_hook(struct command *commands,
>  	if (version != 1) {
>  		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
>  			    version);
> +		close(proc.in);
>  		code = -1;
>  		goto cleanup;
>  	}
> @@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct command *commands,
>  		packet_flush(proc.in);
>  	}
>  
> +	close(proc.in);
> +
>  	/* Read result from proc-receive */
>  	code = read_proc_receive_report(&reader, commands, &errmsg);
>  
>  cleanup:
> -	close(proc.in);
>  	close(proc.out);
>  	if (use_sideband)
>  		finish_async(&muxer);
> diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
> index 42164d9898..132c74db52 100644
> --- a/t/helper/test-proc-receive.c
> +++ b/t/helper/test-proc-receive.c
> @@ -79,9 +79,11 @@ static void proc_receive_read_commands(struct packet_reader *reader,
>  		    *p++ != ' ' ||
>  		    parse_oid_hex(p, &new_oid, &p) ||
>  		    *p++ != ' ' ||
> -		    die_readline)
> +		    die_readline) {
> +			while (packet_reader_read(reader) != PACKET_READ_EOF);

Have the empty statement on its own line, i.e.

			while (condition)
				; /* do nothing */

>  			die("protocol error: expected 'old new ref', got '%s'",
> -			    reader->line);
> +				die_readline? "<call with --die-readline>": reader->line);

SP around both sides of "?" and ":", and if that makes the line too
long, consider wrapping the line, i.e.

				die_readline
				? "<call with --die-readline>"
				: reader->line);

> +		}
>  		refname = p;
>  		FLEX_ALLOC_STR(cmd, ref_name, refname);
>  		oidcpy(&cmd->old_oid, &old_oid);
> @@ -136,7 +138,7 @@ int cmd__proc_receive(int argc, const char **argv)
>  		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
>  	packet_reader_init(&reader, 0, NULL, 0,
>  			   PACKET_READ_CHOMP_NEWLINE |
> -			   PACKET_READ_DIE_ON_ERR_PACKET);
> +			   PACKET_READ_GENTLE_ON_EOF);
>  
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  	proc_receive_verison(&reader);
> diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
> index c5fe4cb37b..ee75515430 100644
> --- a/t/t5411/test-0013-bad-protocol.sh
> +++ b/t/t5411/test-0013-bad-protocol.sh
> @@ -91,8 +91,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)
>  		HEAD:refs/for/master/topic \
>  		>out 2>&1 &&
>  	make_user_friendly_and_stable_output <out >actual &&
> -
> -	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
> +	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<call with --die-readline>\"" actual &&
>  
>  	git -C "$upstream" show-ref >out &&
>  	make_user_friendly_and_stable_output <out >actual &&
