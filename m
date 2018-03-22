Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CB01F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 11:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeCVLS3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 07:18:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:38632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752044AbeCVLS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 07:18:28 -0400
Received: (qmail 10174 invoked by uid 109); 22 Mar 2018 11:18:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 11:18:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18720 invoked by uid 111); 22 Mar 2018 11:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 07:19:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 07:18:26 -0400
Date:   Thu, 22 Mar 2018 07:18:26 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] diff-highlight: detect --graph by indent
Message-ID: <20180322111826.GA22763@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
 <20180321055900.GB15674@sigill.intra.peff.net>
 <0e2317fc-cfec-ba7f-8ded-59cc6b7f9a63@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e2317fc-cfec-ba7f-8ded-59cc6b7f9a63@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 10:59:31AM +0000, Phillip Wood wrote:

> > +sub handle_line {
> > +	my $orig = shift;
> > +	local $_ = $orig;
> > +
> > +	# match a graph line that begins a commit
> > +	if (/^(?:$COLOR?\|$COLOR?[ ])* # zero or more leading "|" with space
> > +	         $COLOR?\*$COLOR?[ ]   # a "*" with its trailing space
> > +	      (?:$COLOR?\|$COLOR?[ ])* # zero or more trailing "|"
> > +	                         [ ]*  # trailing whitespace for merges
> 
> Hi Peff, thanks for looking at this. I've only had a quick look through
> but I wonder if this will be confused by commit messages that contain
>   * bullet points
>   * like this

I think we should be OK because the commit messages are indented by 4
spaces, and we allow only single spaces amidst the graph-drawing bits
(and we respect the "*" only in those graph-drawing bits).

So I think you could fool it with something like:

  git log --graph --format='* oops!'

or maybe even:

  git log --graph --format='%B'

but not with a regular git-log format. Those final corner cases I don't
think we can overcome; it's just syntactically ambiguous. Unless perhaps
we traced the graph lines from the start of the output and knew how many
to expect, but that seems rather complicated.

Ultimately the best solution would be to avoid this parsing nonsense
entirely by teaching Git's internal diff to produce the highlighting
internally.

-Peff

PS I also eyeballed the results of "git log --graph -p --no-merges
  -1000" piped through the old and new versions. There are several
  changes, but they all look like improvements.
