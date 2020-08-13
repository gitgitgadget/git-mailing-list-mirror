Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0592AC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82612074D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 09:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMJBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:01:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgHMJBK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 05:01:10 -0400
Received: (qmail 17150 invoked by uid 109); 13 Aug 2020 09:01:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 09:01:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11507 invoked by uid 111); 13 Aug 2020 09:01:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 05:01:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 05:01:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] upload-pack: use buffered I/O to talk to rev-list
Message-ID: <20200813090107.GB3092220@coredump.intra.peff.net>
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
 <cf395005-af63-f698-fe19-6c4b6f1a8a4b@web.de>
 <CAP8UFD1rDZOQSDWhc+xdEQVX+Umq-nE-sd-orgKZ3UWTWFHJhw@mail.gmail.com>
 <866055fd-7857-3eb3-6dae-befc8f891994@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <866055fd-7857-3eb3-6dae-befc8f891994@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 07:57:20AM +0200, René Scharfe wrote:

> Am 13.08.20 um 07:17 schrieb Christian Couder:
> > On Wed, Aug 12, 2020 at 6:54 PM René Scharfe <l.s.r@web.de> wrote:
> >
> >> -       close(cmd->in);
> >> +       if (ferror(cmd_in) || fflush(cmd_in))
> >> +               goto error;
> >> +       fclose(cmd_in);
> >>         cmd->in = -1;
> >
> > I wonder if setting cmd->in to -1 is still useful...
> 
> The patch doesn't change its usefulness.  It probably was not necessary
> to begin with.

Right. We exit immediately after setting it, but it's not clearly a dead
load: the "cmd" struct is passed in from the caller. Prior to 2997178ee6
(upload-pack: split check_unreachable() in two, prep for
get_reachable_list(), 2016-06-12), it was part of a longer function
which did have more error handling.

But after the split, has_unreachable() knows that it is always closed
after do_reachable_revlist() returns, so it never looks at cmd.in again.
It might be worth removing just to avoid confusion.

I thought this also implied that the conditional close() in the error
block was not necessary, but it is. In the existing code we could "goto
error" from start_command() failing, before we ever assign to cmd->in.
The run-command API clears the struct in that case (so we'd see cmd->in
== 0, and avoid closing).

> >> -       if (cmd->in >= 0)
> >> -               close(cmd->in);
> >> +       if (cmd_in)
> >> +               fclose(cmd_in);
> >
> > ...as we don't check cmd->in anymore at the end of the function, but
> > we now check cmd_in instead. So should cmd_in have been set to -1
> > instead of cmd->in?
> 
> This error handler is not reached from the place that sets cmd->in back
> to -1.  It can be reached from a place where cmd_in is still NULL, so
> this check is necessary and setting cmd_in to NULL above is not needed.

Right, that makes sense. Your NULL cmd_in is replacing the zero'd
cmd->in from start_command().

So I think your patch is correct. It might be worth removing the "-1"
assignment on top.

-Peff
