Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683FC1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 04:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKEHw (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 23:07:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:44122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726754AbfKKEHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 23:07:51 -0500
Received: (qmail 14899 invoked by uid 109); 11 Nov 2019 04:07:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 04:07:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1511 invoked by uid 111); 11 Nov 2019 04:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 23:11:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 23:07:50 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] bundle-create: progress output control
Message-ID: <20191111040750.GB6379@sigill.intra.peff.net>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
 <20191110204126.30553-2-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191110204126.30553-2-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 12:41:25PM -0800, Robin H. Johnson wrote:

> Support the progress output options from pack-objects in git-bundle's
> create subcommand. Most notably, this provides --quiet as requested on
> the git mailing list per [1]
> 
> Reference: https://www.mail-archive.com/git@vger.kernel.org/msg182844.html <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>

I'm glad you included the message-id here, since "182844" is useless if
mail-archive.com ever goes away. We usually just cite public-inbox for
that reason, since its URLs just use the message-id anyway:

  https://public-inbox.org/git/robbat2-20190806T191156-796782357Z@orbis-terrarum.net

> +--progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal, unless -q
> +	is specified. This flag forces progress status even if
> +	the standard error stream is not directed to a terminal.
> +
> +--all-progress::
> +	When --stdout is specified then progress report is
> +	displayed during the object count and compression phases
> +	but inhibited during the write-out phase. The reason is
> +	that in some cases the output stream is directly linked
> +	to another command which may wish to display progress
> +	status of its own as it processes incoming pack data.
> +	This flag is like --progress except that it forces progress
> +	report for the write-out phase as well even if --stdout is
> +	used.
> +
> +--all-progress-implied::
> +	This is used to imply --all-progress whenever progress display
> +	is activated.  Unlike --all-progress this flag doesn't actually
> +	force any progress display by itself.
> +
> +-q::
> +--quiet::
> +	This flag makes the command not to report its progress
> +	on the standard error stream.

Do we need all four of these?

Just saying "--no-progress" would do what you want right now. I could
understand the desire for a general "--quiet" flag that implies
"--no-progress", and shuts off any other non-progress chatter as well.
There isn't any now, but it could be a future proofing thing (plus
having a "-q" option is standard). But I think we should document it
that way from the outset (though I notice you probably just lifted this
from pack-objects, IMHO it should be more clear, too).

The "all-progress" thing doesn't seem useful at this level. pack-objects
needs it so that it can do the right thing when being driven by
upload-pack versus send-pack. But for a bundle, we're always writing to
a file. We'd always want "all-progress" (and that's what the current
code does).

Likewise, "all-progress-implied" is about setting the "all-progress" bit
but still letting pack-objects decide whether to show progress based on
isatty(2). I don't think we'd need that here at all (we check isatty
ourselves, and we'd always want all-progress).

So could we perhaps simplify this to:

  1. Set show_progress to isatty(2).

  2. Make --progress a parseopt bool, setting show_progress to 1 (or if
     we see "--no-progress").

  3. Pass "--no-progress" or "--all-progress" to pack-objects, based on
     show_progress.

  4. (Optional) Make "--quiet" a synonym for "--no-progress", with the
     documentation that it may later encompass other messages.

-Peff
