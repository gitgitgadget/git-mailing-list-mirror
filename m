From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 23:14:48 -0500
Message-ID: <20160120041447.GA12811@sigill.intra.peff.net>
References: <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
 <20160119215928.GA6556@sigill.intra.peff.net>
 <20160119222802.GC6556@sigill.intra.peff.net>
 <20160120012253.GD16090@google.com>
 <20160120013436.GA24541@sigill.intra.peff.net>
 <xmqqbn8h6mrl.fsf@gitster.mtv.corp.google.com>
 <20160120020039.GD24541@sigill.intra.peff.net>
 <xmqq4me96kd2.fsf@gitster.mtv.corp.google.com>
 <xmqqziw153yg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 05:14:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLkAY-0000KW-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 05:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327AbcATEOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 23:14:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:56759 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933097AbcATEOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 23:14:50 -0500
Received: (qmail 4515 invoked by uid 102); 20 Jan 2016 04:14:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 23:14:50 -0500
Received: (qmail 30413 invoked by uid 107); 20 Jan 2016 04:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 23:15:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 23:14:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqziw153yg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284427>

On Tue, Jan 19, 2016 at 07:23:35PM -0800, Junio C Hamano wrote:

> A consequence of this is if you are running filter-branch without
> any tree filters (i.e. no_index) but with "--prune-empty", and a
> commit and its parent actually have different trees but one (or
> both) of them are broken, "diff-tree" _might_ say "they are the
> same" and you end up skipping a commit when you do not want to.  If
> your plan was to run another round of filter-branch, this time with
> a "broken tree encoding correction" tree-filter, on the result of
> the first "--prune-empty" filtering, we would definitely end up with
> a wrong history.

Yeah, that is the case I was thinking about.

> But for such a case, I would say you should be running the
> correction filter as the very first thing.  So I am not sure if it
> matters in practice.

I'd also agree with that.

> One possible action item out of this is that we might want to think
> about giving the obvious and stupid optimization to such invocation
> of "diff-tree --quiet".  I _think_ we correctly avoid descending
> into the identical subtrees while doing a recursive diff-tree by
> saying "hey these two corresponding directories have the same tree
> object names", but there is no fundamental reason why we shouldn't
> be doing the same optimization at the top-level of the comparison.

Yeah, I just assumed we did, but a simple strace shows that is not the
case. I doubt it matters _too_ much in practice, but it would probably
be easy to do.

-Peff
