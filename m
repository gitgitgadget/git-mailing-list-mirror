Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F327E1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 15:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIJUjh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 16:39:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:44862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727411AbeIJUjg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 16:39:36 -0400
Received: (qmail 10944 invoked by uid 109); 10 Sep 2018 15:44:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 15:44:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8412 invoked by uid 111); 10 Sep 2018 15:45:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 11:45:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 11:44:54 -0400
Date:   Mon, 10 Sep 2018 11:44:54 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3701-add-interactive: tighten the check of trace output
Message-ID: <20180910154453.GA15270@sigill.intra.peff.net>
References: <20180910140714.19617-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910140714.19617-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 04:07:14PM +0200, SZEDER Gábor wrote:

> The test 'add -p does not expand argument lists' in
> 't3701-add-interactive.sh', added in 7288e12cce (add--interactive: do
> not expand pathspecs with ls-files, 2017-03-14), checks the GIT_TRACE
> of 'git add -p' to ensure that the name of a tracked file wasn't
> passed around as argument to any of the commands executed as a result
> of undesired pathspec expansion.  This check is done with 'grep' using
> the filename on its own as the pattern, which is too loose a pattern,
> and would match any occurrences of the filename in the trace output,
> not just those as command arguments.  E.g. if a developer were to
> litter the index handling code with trace_printf()s printing, among
> other things, the name of the just processed cache entry, then that
> pattern would mistakenly match these as well, and would fail the test.

Is this a real thing we're running into? I'd have thought that anybody
adding index-specific tracing would do it as GIT_TRACE_INDEX.  It's
unfortunate that "trace commands and processes" is just GIT_TRACE, and not
GIT_TRACE_RUN or similar. But that's mostly historical. I wouldn't
expect people to add other subsystems to it.

Not that I'm totally opposed to your patch, but it's a little sad that
we have to match the specific text used in GIT_TRACE now (and if they
ever changed we won't even notice, but rather the test will just become
a silent noop).

I think it would be nice if we could move towards something like:

  - move current GIT_TRACE messages to use GIT_TRACE_COMMAND or similar

  - abolish trace_printf() without a specific subsystem key

  - do one of:

    - keep GIT_TRACE as a historical synonym for GIT_TRACE_COMMAND; that
      keeps things working as they are now

    - have GIT_TRACE enable _all_ tracing; that's a change in behavior,
      but arguably a more useful thing to have going forward (e.g., when
      you're not sure which traces are even available)

And then a test like this would just use GIT_TRACE_COMMAND.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 609fbfdc31..65dfbc033a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -540,7 +540,7 @@ test_expect_success 'add -p does not expand argument lists' '
>  	# update it, but we want to be sure that our "." pathspec
>  	# was not expanded into the argument list of any command.
>  	# So look only for "not-changed".
> -	! grep not-changed trace.out
> +	! grep -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out

I had a vague recollection that we preferred "egrep" to "grep -E" due to
portability. But digging in the history, I could only find "fgrep" over
"grep -F". And we seem to have plenty of "grep -E" invocations already.

-Peff
