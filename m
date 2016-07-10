Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE3B1FE4E
	for <e@80x24.org>; Sun, 10 Jul 2016 06:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbcGJGQt (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 02:16:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:42468 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750748AbcGJGQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 02:16:48 -0400
Received: (qmail 20855 invoked by uid 102); 10 Jul 2016 06:16:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 10 Jul 2016 02:16:49 -0400
Received: (qmail 23836 invoked by uid 107); 10 Jul 2016 06:17:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 10 Jul 2016 02:17:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jul 2016 02:16:45 -0400
Date:	Sun, 10 Jul 2016 02:16:45 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
Message-ID: <20160710061644.GA19640@sigill.intra.peff.net>
References: <20160710055402.32684-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710055402.32684-1-tytso@mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 01:54:02AM -0400, Theodore Ts'o wrote:

> Add new format specifiers which allow the printing of reflog
> timestamp.  This allows us to know when operations which change HEAD
> take place (e.g., guilt pop -a, which does the equivalent of a "git
> reset --hard commit"), since using %cr will display when the commit
> was originally made, instead of when HEAD was moved to that commit.

Hrm. You can already get dates like:

  git log --date=relative -g --format=%gd

(or --date=iso, or whatever). But:

  1. It's always branch@{...date...}, not just ...date...

  2. It takes over %gd, so this:

> git log -g --pretty=format:'%Cred%h%Creset %gd %gs %Cgreen(%gr)%Creset %s' --abbrev-commit

can't be done (you cannot show both HEAD@{0} and "5 minutes ago").

So the status quo definitely isn't as flexible as it could be. I'm just
not excited about adding a bunch more obscure two-character codes that
don't even cover all of the possible date formats (I know we have the
same problem for the author/committer timestamps, but we are stuck with
those for historical reasons).

I wonder if a better approach would be:

  1. In the short term, add specific designators for the fields you'd
     want. One for HEAD@{n} that is unaffected by date, as %gd is (or
     even one for the branch-name and one for "n"). And one for the
     reflog date, by itself, in whatever format --date= asked for.

     That would let you do your format above, though it does not let you
     show the reflog date in multiple formats.

  2. In the long term, teach log's pretty formatter to handle less
     obscure syntax, that can include arguments. The pretty-printer in
     for-each-ref can already do "%(authordate:relative)", and accepts
     any date-format that git knows about. We should do the same here.

I dunno. Your patch does not make either of those paths _harder_, and it
is not like there isn't precedent. It just bloats the user-visible
interface with stuff that would later become redundant (but that we
can't get rid of because of backwards compatibility).

-Peff
