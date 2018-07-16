Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA06A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbeGPXzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:55:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:48944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728947AbeGPXzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:55:43 -0400
Received: (qmail 22433 invoked by uid 109); 16 Jul 2018 23:25:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 23:25:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17402 invoked by uid 111); 16 Jul 2018 23:26:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 19:26:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 19:26:03 -0400
Date:   Mon, 16 Jul 2018 19:26:03 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716232603.GB13570@sigill.intra.peff.net>
References: <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
 <20180716224337.GB12482@sigill.intra.peff.net>
 <20180716225639.GK11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716225639.GK11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 03:56:39PM -0700, Jonathan Nieder wrote:

> The calling command in the motivating example is Android's "repo" tool:
> 
>             bare_git.gc('--auto')
> 
> from https://gerrit-review.googlesource.com/c/git-repo/+/10598/.  I
> think it's reasonable that it expects a status code of 0 in the normal
> case.  So life is less simple than I hoped.

IMHO it should ignore the return code, since that's what Git does
itself. And at any rate, you'd miss errors from daemonized gc's (at
least until the _next_ one runs and propagates the error code).

> Interesting!  It looks like that thread anticipated the problems we've
> seen here.  Three years without having to have fixed it is a good run,
> I suppose.
> 
> The discussion of stopping there appears to be primarily about
> stopping in the error case, not rate-limiting in the success or
> warning case.

I think the two are essentially the same. The point is that we cannot
make further progress by re-running the gc again, so we should not.

Amusingly, the warning we're talking about is the exact reason that the
logging in that thread was added.  329e6e8794 (gc: save log from
daemonized gc --auto and print it next time, 2015-09-19) says:

  The latest in this set is, as the result of daemonizing, stderr is
  closed and all warnings are lost. This warning at the end of cmd_gc()
  is particularly important because it tells the user how to avoid "gc
  --auto" running repeatedly. Because stderr is closed, the user does
  not know, naturally they complain about 'gc --auto' wasting CPU.

> -- >8 --
> Subject: gc: exit with status 128 on failure
> 
> A value of -1 returned from cmd_gc gets propagated to exit(),
> resulting in an exit status of 255.  Use die instead for a clearer
> error message and a controlled exit.

I agree it's better to not pass -1 to exit(). But I thought the original
motivation was the fact that we were returning non-zero in this case at
all?  (And I thought you and I both agreed with that motivation).

So is this meant to be a preparatory fix until somebody is interested in
fixing that?

> -static int gc_before_repack(void)
> +static void gc_before_repack(void)
>  {
>  	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
> -		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
> +		die(FAILED_RUN, pack_refs_cmd.argv[0]);
>  
>  	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
> -		return error(FAILED_RUN, reflog.argv[0]);
> +		die(FAILED_RUN, reflog.argv[0]);

Dscho is going to yell at you about replacing error returns with die().  ;)

I wonder if it would be simpler to just reinterpret the "-1" into "128"
in cmd_gc(). I thought we had talked about having run_builtin() do that
at one point, but I don't think we ever did. I dunno. I'm fine with it
either way.

-Peff
