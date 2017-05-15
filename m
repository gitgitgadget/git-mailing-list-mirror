Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753EC201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbdEOWYL (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:24:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:52214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdEOWYK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:24:10 -0400
Received: (qmail 31226 invoked by uid 109); 15 May 2017 22:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 22:24:09 +0000
Received: (qmail 22189 invoked by uid 111); 15 May 2017 22:24:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 18:24:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 18:24:07 -0400
Date:   Mon, 15 May 2017 18:24:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: t5400 failure on Windows
Message-ID: <20170515222406.hxab2wrapv75ybmj@sigill.intra.peff.net>
References: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 10:05:29PM +0200, Johannes Sixt wrote:

> I observe the following failure on Windws with origin/next, in
> t5400-send-pack.sh
> 
> +++ diff -u expect refs
> --- expect      Mon May 15 06:54:59 2017
> +++ refs        Mon May 15 06:54:59 2017
> @@ -1,4 +1,3 @@
>  5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master
> -5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD
>  5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
>  53d9066ca10f2e103b33caf3a16a723553c33b00 .have
> error: last command exited with $?=1
> not ok 16 - receive-pack de-dupes .have lines

Interesting that it's the symref. I wonder if that is important (though
they should always be implemented as a real symref file and not a
symlink, so I don't think FS limitations would come into play).

For sanity, you might want to double-check that the "shared-fork"
repository has that symref on disk, and that for-each-ref reports it.
But...

> The trace file looks like this:
> 
> -------- trace --------
> packet: receive-pack> 5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.13.0.497.g5af12421b0
> packet: receive-pack> 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD

Wait, there it is in the receive-pack output. But if we look at what
"push" receives:

> packet:         push< 5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.13.0.497.g5af12421b0
> packet: receive-pack> 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
> packet:         push< 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master

It's skipped! So either:

  1. receive-pack wrote the trace line without sending it (which seems
     an unlikely bug to differ between platforms)

  2. push some didn't receive it (which makes no sense; this is a stream
     socket and it was able to parse the next pktline)

  3. push did get it but for some reason didn't write the trace (also
     unlikely as with option 1)

  4. There is something racy and unportable about both programs writing
     to the same trace file. It's opened with O_APPEND, which means that
     each write should atomically position the pointer at the end of the
     file. Is it possible there's a problem with that in the way
     O_APPEND works on Windows?

     If that was the case, though, I'd generally expect a sheared write
     or a partial overwrite. The two origin/HEAD lines from the two
     programs are the exact same length, but I'd find it more likely for
     the overwrite to happen with one of the follow-on lines.

So all of those sound kind of implausible. If you run the test over and
over, does it happen consistently, and is it always the same line?

-Peff
