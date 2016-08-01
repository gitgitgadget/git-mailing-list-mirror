Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB1E1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 23:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbcHAXZ3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 19:25:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52994 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754503AbcHAXZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 19:25:19 -0400
Received: (qmail 24024 invoked by uid 102); 1 Aug 2016 23:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 19:24:33 -0400
Received: (qmail 19771 invoked by uid 107); 1 Aug 2016 23:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 19:24:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 19:24:29 -0400
Date:	Mon, 1 Aug 2016 19:24:29 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Tauner <stefan.tauner@gmx.at>
Cc:	git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
Message-ID: <20160801232429.mb43wxev5lyhxyiw@sigill.intra.peff.net>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
 <20160616095947.GA15988@sigill.intra.peff.net>
 <0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
 <20160801213631.2ttdlermxw2wbnbi@sigill.intra.peff.net>
 <0LzskF-1bGAH81g5T-014za7@mail.gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0LzskF-1bGAH81g5T-014za7@mail.gmx.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 11:49:09PM +0200, Stefan Tauner wrote:

> > For instance, if I do:
> > 
> >   git init
> >   echo content >file
> >   git add file
> >   git commit -m "$(perl -e 'print join(" ", 1..100)')"
> > 
> > I get a commit message with one long unwrapped line, which I can view
> > via git-log, etc.
> 
> That's approximately what I did in my tests as well. And like you, when
> I do this in a fresh repository, it works like that..

One thing to look at, I guess, is whether they are corrupted coming in
to the repository, or when they are being formatted.

If you do:

  git cat-file commit HEAD

you will get the raw bytes of the commit object stored by git. In the
example above, it obviously shows one long line. Have you checked that
it does so in your cases that misbehave?

> > (I wondered at first if the extra "cat" and "-m" could be messing up
> > whitespace for you, but it should not, as the quoting around "$input"
> > should preserve things like newlines. And anyway, the bug in that case
> > would be the _opposite_; I'd expect it to stuff everything onto a single
> > line rather than breaking lines).
> 
> The commit messages I try to process are nothing special really... just
> very long and not subject-like (because SVN and not giving too much
> thought to them sometimes). The only special thing I can think of is
> that they have been processed by git-svn earlier.

Hmm. The usual problem with svn-imported commits is not long lines,
exactly, but rather that the commit message has one big paragraph at the
top, rather than a subject/body split.

So when you ask git for the "subject" in such a case, it may paste many
lines together as a single one. For example:

  $ commit=$(seq 1 5 | git commit-tree HEAD^{tree})
  $ git cat-file commit $commit
  tree 07753f428765ac1afe2020b24e40785869bd4a85
  author Jeff King <peff@peff.net> 1470093739 -0400
  committer Jeff King <peff@peff.net> 1470093739 -0400

  1
  2
  3
  4
  5

  $ git log --format=%s $commit
  1 2 3 4 5

So could it be that your lines actually _are_ broken in the git objects,
but "%s" and other tools try to salvage them as a single subject?

I don't recall offhand whether git-svn does line-wrapping or any other
commit-message munging.

-Peff
