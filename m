Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A443A1F404
	for <e@80x24.org>; Sat, 30 Dec 2017 01:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdL3Bzg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 20:55:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:49470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750741AbdL3Bzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 20:55:35 -0500
Received: (qmail 23655 invoked by uid 109); 30 Dec 2017 01:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Dec 2017 01:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2722 invoked by uid 111); 30 Dec 2017 01:56:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 29 Dec 2017 20:56:04 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Dec 2017 20:55:33 -0500
Date:   Fri, 29 Dec 2017 20:55:33 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Zefram <zefram@fysh.org>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
Message-ID: <20171230015533.GA27130@sigill.intra.peff.net>
References: <87zi616vgf.fsf@evledraar.gmail.com>
 <20171229225121.13805-1-avarab@gmail.com>
 <20171229231631.GS3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171229231631.GS3693@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 06:16:31PM -0500, Todd Zullinger wrote:

> Ævar Arnfjörð Bjarmason wrote:
> > No idea how to test this, in particular trying to pipe the output of
> > color.ui=never v.s. color.ui=auto to a file as "auto" will disable
> > coloring when it detects a pipe, but this fixes the issue.
> 
> You might be able to use similar methods as those Jeff used
> in the series merged from jk/ui-color-always-to-auto:
> 
> https://github.com/gitster/git/tree/jk/ui-color-always-to-auto

Yeah, test_terminal is the solution to testing. But...

> He may also have some ideas about this issue in general.
> (Or they could be tramatic memories, depending on how
> painful it was to dig into the color code.)

Yep. If we make diff-tree support color.ui, it's going to break a bunch
of other stuff (like add--interactive) for people who set color.ui=always.
I know this empirically, because we did that in v2.13, and a bunch of
people complained. ;)

The root of the problem is that the plumbing diff-tree defaults its
internal color variable to "auto" in the first place. In theory the best
way forward is fixing that, but it's likely to have a bunch of fallouts
itself (scripts which use plumbing and where the user _does_ want color
will stop showing it). This bug has been around since v1.8.4, I think,
so it's hard to say how many people are depending on it at this point.

A hackier option which would probably make most people happy would be to
have plumbing respect "color.ui=never", but not any other values.

I think the history of the back and forth is:

  - 4c7f1819b3 (make color.ui default to 'auto', 2013-06-10) introduced
    the problem of plumbing defaulting to "auto". This was in v1.8.4.

  - we did something similar to Ævar's patch in 136c8c8b8f (color: check
    color.ui in git_default_config(), 2017-07-13). That shipped in
    v2.14.2, and people with color.ui=always complained, because things
    like add--interactive broke for them.

  - we tried fixing it with 6be4595edb (color: make "always" the same as
    "auto" in config, 2017-10-03), but that broke people doing "git -c
    color.ui=always" as an equivalent of "--color". We talked about
    making the "-c" config behave differently from on-disk config, but
    got pretty disgusted at the weird hacks. And so...

  - we ended up with 33c643bb08 (Revert "color: check color.ui in
    git_default_config()", 2017-10-13), which just reverts the whole
    mess back to the pre-v2.14 state. This shipped in v2.15.

So I don't think we want to go down that road again. If anything, we
want to either fix the original sin from 4c7f1819b3, or we want to do
the "respect only never" hack.

-Peff
