Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4398E203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 10:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbcLJKYv (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 05:24:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:54605 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752203AbcLJKYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 05:24:49 -0500
Received: (qmail 6425 invoked by uid 109); 10 Dec 2016 10:24:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 10:24:49 +0000
Received: (qmail 25764 invoked by uid 111); 10 Dec 2016 10:25:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 05:25:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 05:24:46 -0500
Date:   Sat, 10 Dec 2016 05:24:46 -0500
From:   Jeff King <peff@peff.net>
To:     Klaus Ethgen <Klaus@Ethgen.ch>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210102446.2sf3dxy7yj7sifcd@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
 <20161210092928.jkaf2rwxhicafmxr@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161210092928.jkaf2rwxhicafmxr@ikki.ethgen.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 10:29:28AM +0100, Klaus Ethgen wrote:

> > I think we long time ago in 2005 have declared that a colon in a
> > directory name would not work for Git repositories because of things
> > like GIT_CEILING_DIRECTORIES, GIT_ALTERNATE_OBJECT_DIRECTORIES; so I
> > do not think we terribly mind that direction.
> 
> That is the first I hear and I really wonder about.
> 
> A colon a perfectly allowed character in POSIX filesystems.

Sure, it's allowed, but it will cause problems due to other syntactic
conventions.  Try putting "/usr/path:with:colons" into your $PATH
variable, for instance. Try rsyncing "xxx:yyy.git" somewhere.

Git does have heuristics for figuring out the difference between
"host:repo.git" as an SSH remote versus a local path, but they're not
foolproof.

> Moreover, it was no problem before and was introduced as a problem just
> in that version. Even more, a pull (and so a clone I believe) of such a
> path is absolutely ok. Just the push fails.

Sort of. This has always been a problem with the variables Junio
mentioned. The change in v2.11 is that the alternates subsystem is being
used in some cases where it wasn't before, which is surfacing this
limitation in more places.

> > directory, i.e. GIT_OBJECT_QUARANTINE_DIRECTORY, whose value is
> > added without splitting to the list of alternate object stores, and
> > the quarantine codepath can export that instead.
> 
> I didn't get it, why is there a need to split? I mean, it is not
> possible to push to two locations at the same time, so why is there
> splitting at all?

Because the new quarantine feature[1] is built on top of the existing
alternates mechanism, which can have several sources.

I do think we should address this as a regression, but I think repo
names with colons are always going to suffer from some corner cases.

-Peff

[1] See 25ab004c5 and the commits leading up to it for more discussion
    of what the new feature is, if you're curious.
