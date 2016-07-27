Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505F6203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 13:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbcG0N6Y (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 09:58:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:49809 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751617AbcG0N6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 09:58:23 -0400
Received: (qmail 22611 invoked by uid 102); 27 Jul 2016 13:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 09:58:23 -0400
Received: (qmail 16783 invoked by uid 107); 27 Jul 2016 13:58:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 09:58:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 09:58:20 -0400
Date:	Wed, 27 Jul 2016 09:58:20 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil@pennock-tech.com>
Cc:	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727135820.GC14928@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727081414.GA21451@breadbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 04:14:14AM -0400, Phil Pennock wrote:

> The reflog contains timestamp information, but these were not exposed to
> `--pretty`.  Four of the six author/committer format string
> second-letters were still available and copied, but `d`/`D` are taken
> for reflog selector formatting.  So use `%gT` for "time" instead of
> "date" mnemonic for using `--date=...` formatting.

Hrm. Since Ted was not cc'd, it is not clear to me whether this is
coincidental or in response to the thread over in

  http://thread.gmane.org/gmane.comp.version-control.git/299201

To summarize, I think the conclusion there was that we would go with at
least the 't' and 'r' formatters in the short term. The 'i/I' ones were
not something Ted cared about that much, I think, but they do make
things orthogonal with the other ident dates.

Your '%gT' seems like a nice idea in principle, though I'm not sure it
is all that useful due to the way that --date impacts %gd.  In other
words:

  git log -g --format=%gd --date=rfc

will already respect --date (albeit with "ref@{...}" wrapped around it).
But even with your patch, you cannot do:

  git log -g --format="%gd %gT" --date=rfc

to get "HEAD@{0} ...rfc-date...", because the presence of "--date" is
the trigger to switch the meaning of "%gd".

So the final solution is more like:

  - a formatter for just the reflog time, respecting date

  - a formatter for just the reflog index (the "0" in HEAD@{0})

  - a formatter for the ref name (just the "HEAD" in HEAD@{0})

And I'm not sure if we want to do that now with a bunch of arcane
two-letter placeholders, or wait for a refactoring where they can get
more readable names like %(reflog-index).

-Peff
