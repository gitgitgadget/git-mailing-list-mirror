Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44DD1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 12:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754970AbcLNMx1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 07:53:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:56312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754744AbcLNMx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 07:53:26 -0500
Received: (qmail 25593 invoked by uid 109); 14 Dec 2016 12:53:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 12:53:25 +0000
Received: (qmail 24554 invoked by uid 111); 14 Dec 2016 12:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 07:54:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 07:53:23 -0500
Date:   Wed, 14 Dec 2016 07:53:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 28/34] run_command_opt(): optionally hide stderr when
 the command succeeds
Message-ID: <20161214125322.o3naglvyuzgk2pri@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de>
 <2637bed1-c36f-32f6-b255-ea32da76d792@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2637bed1-c36f-32f6-b255-ea32da76d792@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 09:34:20AM +0100, Johannes Sixt wrote:

> I wanted to see what it would look like if we make it the caller's
> responsibility to throw away stderr. The patch is below, as fixup
> of patch 29/34. The change is gross, but the end result is not that
> bad, though not really a delightful read, either, mostly due to the
> strange cleanup semantics of the start_command/finish_command combo,
> so... I dunno.

I don't have a strong opinion on the patches under discussion, but here
are a few pointers on the run-command interface:

> +	struct child_process cmd = CHILD_PROCESS_INIT;
> [...]
>  		env = read_author_script();
>  		if (!env) {

The child_process struct comes with its own internal env array. So you
can do:

  read_author_script(&cmd.env_array);
  if (!cmd.env_array.argc)
	...

and then you don't have to worry about free-ing env, as it happens
automatically as part of the child cleanup (I suspect the refactoring
may also reduce some of the confusing memory handling in
read_author_script()).

> +	if (cmd.stdout_to_stderr) {
> +		/* hide stderr on success */
> +		cmd.err = -1;
> +		rc = -1;
> +		if (start_command(&cmd) < 0)
> +			goto cleanup;
> +
> +		if (strbuf_read(&errout, cmd.err, 0) < 0) {
> +			close(cmd.err);
> +			finish_command(&cmd); /* throw away exit code */
> +			goto cleanup;
> +		}
> +
> +		close(cmd.err);
> +		rc = finish_command(&cmd);
> +		if (rc)
> +			fputs(errout.buf, stderr);
> +	} else {
> +		rc = run_command(&cmd);
> +	}

We have a helper function for capturing output, so I think you can write
this as:

  if (cmd.err == -1) {
        struct strbuf errout = STRBUF_INIT;
        int rc = pipe_command(&cmd,
		              NULL, 0, /* stdin */
                              NULL, 0, /* stdout */
                              &errout, 0);
        if (rc)
                fputs(errout.buf, stderr);
        strbuf_release(&errout);
  } else
        rc = run_command(&cmd);

and drop the cleanup goto entirely (if you do the "env" thing above, you
could even drop "rc" and just return directly from each branch of the
conditional).

> -	rc = run_command_v_opt_cd_env(array.argv, opt, NULL,
> -			(const char *const *)env);
> -	argv_array_clear(&array);
> +cleanup:
> +	child_process_clear(&cmd);
> +	strbuf_release(&errout);
>  	free(env);

Even if you do keep the goto here, I think this child_process_clear() is
unnecessary. It should be done automatically either by finish_command(),
or by start_command() when it returns an error.

-Peff
