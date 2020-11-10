Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B18C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7890420781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgKJVww (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:52:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:53600 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKJVww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:52:52 -0500
Received: (qmail 9558 invoked by uid 109); 10 Nov 2020 21:52:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 21:52:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6372 invoked by uid 111); 10 Nov 2020 21:52:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 16:52:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 16:52:50 -0500
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 2/2] receive-pack: gently write messages to
 proc-receive
Message-ID: <20201110215250.GB3263091@coredump.intra.peff.net>
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
 <20201110120135.42025-2-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110120135.42025-2-zhiyou.jx@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 08:01:35PM +0800, Jiang Xin wrote:

> Johannes found a flaky hang in `t5411/test-0013-bad-protocol.sh` in the
> osx-clang job of the CI/PR builds, and ran into an issue when using
> the `--stress` option with the following error messages:
> 
>     fatal: unable to write flush packet: Broken pipe
>     send-pack: unexpected disconnect while reading sideband packet
>     fatal: the remote end hung up unexpectedly
> 
> In this test case, the "proc-receive" hook sends an error message and
> dies earlier. While "receive-pack" on the other side of the pipe
> should forward the error message of the "proc-receive" hook to the
> client side, but it fails to do so. This is because "receive-pack"
> uses `packet_write_fmt()` and `packet_flush()` to write pkt-line
> message to "proc-receive" hook, and these functions die immediately
> when pipe is broken. Using "gently" forms for these functions will get
> more predicable output.

The changes to use gently() in the code looked good to me, and I think
you got all of the relevant spots.

I was surprised by a few bits:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index bb9909c52e..697a4e8802 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -974,9 +974,10 @@ static int read_proc_receive_report(struct packet_reader *reader,
>  	struct command *cmd;
>  	struct command *hint = NULL;
>  	struct ref_push_report *report = NULL;
> -	int new_report = 0;
>  	int code = 0;
> +	int new_report = 0;

This is just noise in the diff, I think. It does not matter either way.

> @@ -984,8 +985,14 @@ static int read_proc_receive_report(struct packet_reader *reader,
>  		const char *refname;
>  		char *p;
>  
> -		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
> +		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
> +			if (!response) {
> +				strbuf_addstr(errmsg, "no response from proc-receive hook");
> +				return -1;
> +			}
>  			break;
> +		}
> +		response++;

This extra check seems orthogonal to the rest of the commit. It does
seem like it might be a reasonable thing to check, but I wondered:

  - if the hook has nothing to report, wouldn't it just send a flush
    packet? Does that break protocol or not?

  - if not, then I guess we're expecting a response for every ref we
    mentioned (and presumably we would not trigger the hook at all if
    there are no refs). But in that case, shouldn't we be checking that
    we counted up the number of responses we expected? But we already do
    that, by annotating the items in the commands list that didn't get
    RUN_PROC_RECEIVE_RETURNED set.

So at best, it seems like this check is redundant (and at worst it may
complain unnecessarily about a corner case).

> @@ -1100,7 +1107,7 @@ static int run_proc_receive_hook(struct command *commands,
>  	struct strbuf cap = STRBUF_INIT;
>  	struct strbuf errmsg = STRBUF_INIT;
>  	int hook_use_push_options = 0;
> -	int version = 0;
> +	int version = -1;
> [...]
> -	if (version != 1) {
> +	if (version == -1) {
> +		strbuf_addstr(&errmsg, "fail to negotiate version with proc-receive hook");
> +		code = -1;
> +		goto cleanup;
> +	} else if (version != 1) {
>  		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
>  			    version);

Likewise this seems orthogonal to the main point of the patch. Though it
seems like a good idea in general to check when the other side doesn't
report a version (assuming it is a protocol breakage not to report the
version, and we're not simply supposed to default).

-Peff
