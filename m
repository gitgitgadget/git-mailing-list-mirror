From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] diff: turn on rename detection progress reporting
Date: Fri, 25 Mar 2011 05:09:18 -0400
Message-ID: <20110325090918.GA7085@sigill.intra.peff.net>
References: <20110324174556.GA30661@sigill.intra.peff.net>
 <20110324175124.GD30685@sigill.intra.peff.net>
 <4D8C53DA.1010300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:09:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q331M-0001FH-7n
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab1CYJJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 05:09:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49813
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab1CYJJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:09:22 -0400
Received: (qmail 11218 invoked by uid 107); 25 Mar 2011 09:10:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 05:10:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 05:09:18 -0400
Content-Disposition: inline
In-Reply-To: <4D8C53DA.1010300@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169969>

On Fri, Mar 25, 2011 at 09:35:38AM +0100, Johannes Sixt wrote:

> Am 3/24/2011 18:51, schrieb Jeff King:
> > Since all of the progress happens before we generate any
> > output, this looks OK, even when output goes to a pager.
> > We do the usual --progress/--no-progress options and check
> > isatty(2) to enable the feature.
> 
> Why does it look good? Because the pager is not spawned, yet? Then this is
> not so good because on Windows we don't have a facility to wait until
> there is output, and for this reason we spawn the pager immediately.

It depends on your pager. Less is careful not to produce any output
until it has something to show, for exactly this reason. So it looks
fine even if the pager has been started[1].

But if you have your pager set to "tig" (or you have manually piped to
it), it looks awful. And something like "git show $branch | tig" is ugly
even on Unix.

I'm not sure what the right solution is. We can add a config option like
pager.progress, but it seems like something the user shouldn't have to
care about and set manually. And that doesn't help when the user has
manually invoked a pager that takes over the terminal, like "git log |
tig".

-Peff

[1] Actually, there is a slight bug in my patch; if your pager has been
started, our isatty(2) test fails. So you get no progress for "git show"
on Windows, anyway, unless you use "--progress". "git diff", on the
other hand, starts the pager afterwards, so it does work.
