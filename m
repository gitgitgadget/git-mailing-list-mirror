Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632781FD09
	for <e@80x24.org>; Sun, 28 May 2017 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750824AbdE1TV4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 15:21:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:59077 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdE1TVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 15:21:55 -0400
Received: (qmail 17410 invoked by uid 109); 28 May 2017 19:21:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 May 2017 19:21:52 +0000
Received: (qmail 10945 invoked by uid 111); 28 May 2017 19:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 May 2017 15:22:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 May 2017 15:21:50 -0400
Date:   Sun, 28 May 2017 15:21:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
Message-ID: <20170528192149.dgzibu334n5ja57e@sigill.intra.peff.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
 <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 08:51:07PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> > Implement all git stash functionality as a builtin command
> >
> > Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> > ---
> 
> General note on this that I missed in my first E-Mail, you have ~20
> calls to argv_array_init() but none to argv_array_clear(). So you're
> leaking memory, and it obscures potential other issues with valgrind.

I haven't looked carefully at the patches, but note that the argv array
in a child_process is handled automatically by start/finish_command.

So:

> @@ -1107,9 +1111,9 @@ static int list_stash(int argc, const char
> **argv, const char *prefix)
>         argv_array_pushv(&args, argv);
>         argv_array_push(&args, ref_stash);
>         if (cmd_log(args.argc, args.argv, prefix))
> -               return 1;
> -
> -       return 0;
> +               ret = 1;
> +       argv_array_clear(&args);
> +       return ret;
>  }

This one does need a clear, because it's calling an internal function.
But...

> @@ -741,13 +740,18 @@ static int do_push_stash(const char *prefix,
> const char *message,
>                         argv_array_push(&cp.args, "--");
>                         argv_array_pushv(&cp.args, argv);
>                         pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
> +                       argv_array_clear(&cp.args);

This one does not, because the array will have been cleared by calling
pipe_command (because it does the start/finish block itself; and yes,
before you go checking, start_command() clears it even when it returns
error).

> +                       child_process_clear(&cp);

This should not be necessary for the same reason.

> -                       cp2.git_cmd = 1;
> -                       argv_array_push(&cp2.args, "checkout-index");
> -                       argv_array_push(&cp2.args, "-z");
> -                       argv_array_push(&cp2.args, "--force");
> -                       argv_array_push(&cp2.args, "--stdin");
> -                       pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL, 0);
> +                       child_process_init(&cp);
> +                       cp.git_cmd = 1;
> +                       argv_array_push(&cp.args, "checkout-index");
> +                       argv_array_push(&cp.args, "-z");
> +                       argv_array_push(&cp.args, "--force");
> +                       argv_array_push(&cp.args, "--stdin");
> +                       pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
> +                       argv_array_clear(&cp.args);
> +                       child_process_clear(&cp);

And ditto here.

I'd also encourage using CHILD_PROCESS_INIT and ARGV_ARRAY_INIT constant
initializers instead of their function-call counterparts, as that
matches our usual style.

-Peff
