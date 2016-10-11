Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653FF1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbcJKTRP (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:17:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55987 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbcJKTRP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:17:15 -0400
Received: (qmail 1570 invoked by uid 109); 11 Oct 2016 19:17:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 19:17:14 +0000
Received: (qmail 12222 invoked by uid 111); 11 Oct 2016 19:17:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 15:17:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 15:17:13 -0400
Date:   Tue, 11 Oct 2016 15:17:13 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Message-ID: <20161011191712.ms3n5uzufko7c7z2@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <20161011190103.fovcwsze77hkew4t@sigill.intra.peff.net>
 <CA+55aFzw24pHGOYFBFVvTbU1Cudcr8zcPt_RvdQSxrKY5weCbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzw24pHGOYFBFVvTbU1Cudcr8zcPt_RvdQSxrKY5weCbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 12:07:40PM -0700, Linus Torvalds wrote:

> On Tue, Oct 11, 2016 at 12:01 PM, Jeff King <peff@peff.net> wrote:
> >
> > My implementation is a little more complicated because it's also setting
> > things up for grouping by trailers (so you can group by "signed-off-by",
> > for example). I don't know if that's useful to your or not.
> 
> Hmm. Maybe in theory. But probably not in reality - it's just not
> unique enough (ie there are generally multiple, and if you choose the
> first/last, it should be the same as author/committer, so it doesn't
> actually add anything).

The implementation I did credited each commit multiple times if the
trailer appeared more than once. If you want to play with it, you can
fetch it from:

  git://github.com/peff jk/shortlog-ident

and then something like:

  git shortlog --ident=reviewed-by --format='...reviewed %an'

works. I haven't found it to really be useful for more than toy
statistic gathering, though.

> There are possibly other things that *could* be grouped by and might be useful:
> 
>  - main subdirectory it touches (I've often wanted that)
> 
>  - rough size of diff or number of files it touches
> 
> but realistically both are painful enough that it probably doesn't
> make sense to do in some low-level helper.

Yeah, I think there's a lot of policy there in what counts as "main",
the rough sizes, etc. I've definitely done queries like that before, but
usually by piping "log --numstat" into perl. It's a minor pain to get
the data into perl data structures, but once you have it, you have a lot
more flexibility in what you can compute.

That might be aided by providing more structured machine-readable output
from git, like JSON (which I don't particularly like, but it's kind-of a
standard, and it sure as hell beats XML). But obviously that's another
topic entirely.

> > I'm fine with this less invasive version, but a few suggestions:
> >
> >  - do you want to call it --group-by=committer (with --group-by=author
> >    as the default), which could later extend naturally to other forms of
> >    grouping?
> 
> Honestly, it's probably the more generic one, but especially for
> one-off commands that aren't that common, it's a pain to write. When
> testing it, I literally just used "-c" for that reason.

It's not the end of the world to call it "-c" now, and later define "-c"
as a shorthand for "--group-by=committer", if and when the latter comes
into existence.

Keep in mind that shortlog takes arbitrary revision options, too, and
"-c" is defined there for combined diffs. I can't think of a good reason
to want to pass it to shortlog, though, so I don't think it's a big
loss.

-Peff
