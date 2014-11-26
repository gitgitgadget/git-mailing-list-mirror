From: Jeff King <peff@peff.net>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Tue, 25 Nov 2014 20:24:49 -0500
Message-ID: <20141126012448.GA11183@peff.net>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:24:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtRLi-0003sD-4Q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbaKZBYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 20:24:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:45056 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbaKZBYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 20:24:50 -0500
Received: (qmail 18096 invoked by uid 102); 26 Nov 2014 01:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 19:24:50 -0600
Received: (qmail 3309 invoked by uid 107); 26 Nov 2014 01:24:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 20:24:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 20:24:49 -0500
Content-Disposition: inline
In-Reply-To: <20141126010051.GA29830@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260260>

On Tue, Nov 25, 2014 at 08:00:51PM -0500, Jeff King wrote:

> On Wed, Nov 26, 2014 at 09:42:42AM +0900, Mike Hommey wrote:
> 
> > I have a note tree with a bit more than 200k notes.
> >
> > $ time git notes --ref foo show $sha1 > /dev/null
> > real    0m0.147s
> > user    0m0.136s
> > sys     0m0.008s
> > 
> > That's a lot of time, especially when you have a script that does that
> > on a fair amount of sha1s.
> 
> IIRC, the notes code populates an in-memory data structure, which gives
> faster per-commit lookup at the cost of some setup time. Obviously for a
> single lookup, that's going to be a bad tradeoff (but it does make sense
> for "git log --notes"). I don't know offhand how difficult it would be
> to tune the data structure differently (or avoid it altogether) if we
> know ahead of time we are only going to do a small number of lookups.
> But Johan (cc'd) might.

One other question: how were your notes created?

I tried to replicate your setup by creating one note per commit in
linux.git (over 400k notes total). I did it with one big mktree,
creating a single top-level notes tree. Doing a single "git notes show"
lookup on the tree was something like 800ms.

However, this is not what trees created by git-notes look like. It
shards the object sha1s into subtrees (1a/2b/{36}), and I think does so
dynamically in a way that keeps each individual tree size low. The
in-memory data structure then only "faults in" tree objects as they are
needed. So a single lookup should only hit a small part of the total
tree.

Doing a single "git notes edit HEAD" in my case caused the notes code to
write the result using its sharding algorithm. Subsequent "git notes
show" invocations were only 14ms.

Did you use something besides git-notes to create the tree? From your
examples, it looks like you were accounting for the sharding during
lookup, so maybe this is leading in the wrong direction (but if so, I
could not reproduce your times at all even with a much larger case).

-Peff
