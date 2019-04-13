Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A2220248
	for <e@80x24.org>; Sat, 13 Apr 2019 01:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDMBvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 21:51:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:57088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726964AbfDMBvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 21:51:04 -0400
Received: (qmail 22093 invoked by uid 109); 13 Apr 2019 01:51:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 01:51:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11594 invoked by uid 111); 13 Apr 2019 01:51:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Apr 2019 21:51:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2019 21:51:02 -0400
Date:   Fri, 12 Apr 2019 21:51:02 -0400
From:   Jeff King <peff@peff.net>
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190413015102.GC2040@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 04:04:40PM -0700, Rohit Ashiwal via GitGitGadget wrote:

> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> 
> As we already link to the zlib library, we can perform the compression
> without even requiring gzip on the host machine.

Very cool. It's nice to drop a dependency, and this should be a bit more
efficient, too.

> diff --git a/archive-tar.c b/archive-tar.c
> index ba37dad27c..5979ed14b7 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -466,18 +466,34 @@ static int write_tar_filter_archive(const struct archiver *ar,
>  	filter.use_shell = 1;
>  	filter.in = -1;
>  
> -	if (start_command(&filter) < 0)
> -		die_errno(_("unable to start '%s' filter"), argv[0]);
> -	close(1);
> -	if (dup2(filter.in, 1) < 0)
> -		die_errno(_("unable to redirect descriptor"));
> -	close(filter.in);
> +	if (!strcmp("gzip -cn", ar->data)) {

I wondered how you were going to kick this in, since users can define
arbitrary filters. I think it's kind of neat to automagically convert
"gzip -cn" (which also happens to be the default). But I think we should
mention that in the Documentation, in case somebody tries to use a
custom version of gzip and wonders why it isn't kicking in.

Likewise, it might make sense in the tests to put a poison gzip in the
$PATH so that we can be sure we're using our internal code, and not just
calling out to gzip (on platforms that have it, of course).

The alternative is that we could use a special token like ":zlib" or
something to indicate that the internal implementation should be used
(and then tweak the baked-in default, too). That might be less
surprising for users, but most people would still get the benefit since
they'd be using the default config.

> +		char outmode[4] = "wb\0";

This looks sufficiently magical that it might merit a comment. I had to
look in the zlib header file to learn that this is just a normal
stdio-style mode. But we can't just do:

  gzip = gzdopen(fd, "wb");

because we want to (maybe) append a compression level. It's also
slightly confusing that it explicitly includes a NUL, but later:

> +		if (args->compression_level >= 0 && args->compression_level <= 9)
> +			outmode[2] = '0' + args->compression_level;

we may overwrite that and assume that outmode[3] is also a NUL. Which it
is, because of how C initialization works. But that means we also do not
need the "\0" in the initializer.

Dropping that may make it slightly less jarring (any time I see a
backslash escape in an initializer, I assume I'm in for some binary
trickery, but this turns out to be much more mundane).

I'd also consider just using a strbuf:

  struct strbuf outmode = STRBUF_INIT;

  strbuf_addstr(&outmode, "wb");
  if (args->compression_level >= 0 && args->compression_level <= 9)
	strbuf_addch(&outmode, '0' + args->compression_level);

That's overkill in a sense, but it saves us having to deal with
manually-counted offsets, and this code is only run once per program
invocation, so the efficiency shouldn't matter.

> +		gzip = gzdopen(fileno(stdout), outmode);
> +		if (!gzip)
> +			die(_("Could not gzdopen stdout"));

Is there a way to get a more specific error from zlib? I'm less
concerned about gzdopen here (which should never fail), and more about
the writing and closing steps. I don't see anything good for gzdopen(),
but...

> +	if (gzip) {
> +		if (gzclose(gzip) != Z_OK)
> +			die(_("gzclose failed"));

...according to zlib.h, here the returned int is meaningful. And if
Z_ERRNO, we should probably use die_errno() to give a better message.

> [...]

That was a lot of little nits, but the overall shape of the patch looks
good to me (and I think the goal is obviously good). Thanks for working
on it.

-Peff
