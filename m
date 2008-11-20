From: Jeff King <peff@peff.net>
Subject: Re: Whats happening with git-notes?
Date: Thu, 20 Nov 2008 11:51:37 -0500
Message-ID: <20081120165137.GB27808@coredump.intra.peff.net>
References: <1227183162.23155.32.camel@vaio> <alpine.DEB.1.00.0811201410320.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Ansell <mithro@mithis.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Cm0-0004QC-9f
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 17:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYKTQvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbYKTQvl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 11:51:41 -0500
Received: from peff.net ([208.65.91.99]:4817 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbYKTQvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 11:51:40 -0500
Received: (qmail 19316 invoked by uid 111); 20 Nov 2008 16:51:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Nov 2008 11:51:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2008 11:51:37 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811201410320.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101460>

On Thu, Nov 20, 2008 at 02:12:54PM +0100, Johannes Schindelin wrote:

> The same goes on here.  I wanted to take Peff's idea -- that hadn't 
> occurred to me back when I tried to help Johan with his notes idea -- 
> which is to read in the whole notes tree into a singleton when needed, and 
> incorporate it into my existing test framework.
> 
> Maybe I'll find time later today.

In case you do work on it, let me quickly communicate the two thoughts I
have had since the GitTogether (and you can feel free to ignore them,
but I want to try to say them before you code something differently,
so you at least have the _choice_ of ignoring them. :) ).

One is some thoughts on naming, which I already articulated here:

  http://article.gmane.org/gmane.comp.version-control.git/100402

The other is on speeding up tree lookup. I think the "notes as a git
tree" is sound, but as we obviously realized, somewhat slow. So the
"speeding up notes" code is really about "speeding up tree lookup". And
while it would be nice for pack v4 to fix this for free, I don't think
we want to wait for that. And I think the "build a hash on the fly"
approach that I posted earlier is a sensible way to go.

_But_ where I think we should differ from that patch is that any notes
speedup should really be about a generic interface for speeding up tree
lookup. That is, it should come in the generic form of:

  void tree_study(struct tree_study_context *c, struct tree *tree);
  void tree_study_lookup(struct tree_study_context *c, const char *name);

where "tree_study" spends some cycles to make "tree_study_lookup" much
faster.  And obviously most tree lookups wouldn't want to make this
tradeoff, but there may be a few other places that look in the same tree
several times, and we can benchmark them to see if they benefit. And if
and when faster non-studied tree lookup comes about, we can adjust the
tree studying algorithm easily.

-Peff
