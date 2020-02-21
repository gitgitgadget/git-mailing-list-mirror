Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B4C35640
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A456208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgBUFcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:32:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:50072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbgBUFcX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 00:32:23 -0500
Received: (qmail 15756 invoked by uid 109); 21 Feb 2020 05:32:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 05:32:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16149 invoked by uid 111); 21 Feb 2020 05:41:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 00:41:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 00:32:21 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git does not wait on hook exes (^C)
Message-ID: <20200221053221.GC1280313@coredump.intra.peff.net>
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
 <20200221000141.GA6462@camp.crustytoothpaste.net>
 <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
 <20200221011138.GB6462@camp.crustytoothpaste.net>
 <CA+dzEBk5D9x=sQnKDwAPHXOS_8gnA37X9sn+ccpfViEauiC5ww@mail.gmail.com>
 <20200221022558.GD6462@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221022558.GD6462@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 02:25:58AM +0000, brian m. carlson wrote:

> On 2020-02-21 at 01:20:51, Anthony Sottile wrote:
> > My hook in question is a python process: https://pre-commit.com
> > 
> > It doesn't really do all that much on SIGINT but prints "(^C)
> > Interrupted" and offers a crash log when receiving ^C -- this races
> > with the git process terminating and causes terminal spew (sometimes
> > with pretty bad consequences with input breaking until `reset`
> > depending on which thing wins the tty reset race).
> 
> Thanks, this is helpful context.  I don't know that Git waiting for the
> process is going to fix the broken terminal state, although it will
> likely fix the jumbled output.
> 
> I'm not planning on writing a patch, but I think an interesting patch to
> see might be if we called wait(2) in a loop in a SIGINT handler but
> didn't reinstall the signal handler, which means that a second Ctrl-C
> would kill Git.  I believe that's what certain other programs do, and
> that might address many of the problems in both scenarios.

The run-command struct has a clean_on_exit flag, as well as a
wait_after_clean flag, that would do what you want: when we're killed by
SIGINT, we'd pass the signal on to the child and then wait for to
finish.  That first step should generally be unnecessary for SIGINT
(since as you noted, it will usually be delivered to the whole process
group), but it shouldn't hurt.

To get the double-^C behavior, I think cleanup_children_on_signal()
would have to be reordered to pop the signal handler first before
calling cleanup_children().

I'm not quite convinced that's all worth doing, or wouldn't have other
unforeseen consequences. But if anybody is interested in experimenting,
I think the patch would only be a few lines (set those flags when
running hooks, and then that reordering).

-Peff
