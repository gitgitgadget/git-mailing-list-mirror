From: Jeff King <peff@peff.net>
Subject: Re: BUG: "git checkout" displays Q-escaped commit titles
Date: Sun, 4 May 2008 15:45:41 -0400
Message-ID: <20080504194541.GD13029@sigill.intra.peff.net>
References: <20080502133903.GA3079@mithlond.arda.local> <20080502140536.GA3518@sigill.intra.peff.net> <7vlk2qsukd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 21:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JskAG-0006jf-IN
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 21:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbYEDTpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 15:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbYEDTpk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 15:45:40 -0400
Received: from peff.net ([208.65.91.99]:3711 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398AbYEDTpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 15:45:40 -0400
Received: (qmail 28238 invoked by uid 111); 4 May 2008 19:45:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 15:45:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 May 2008 15:45:41 -0400
Content-Disposition: inline
In-Reply-To: <7vlk2qsukd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81195>

On Sat, May 03, 2008 at 06:54:10PM -0700, Junio C Hamano wrote:

> > .... It seems like pp_title_line should perhaps just be checking
> > for fmt == CMIT_FMT_EMAIL, but I'm not sure if that would break anything
> > else,...
> 
> Yeah, your patch obviously would fix the caller, as subject and
> after_subject should not be given unless you are doing FMT_EMAIL.  But I
> also think we should not even look at subject and after_subject unless fmt
> is CMIT_FMT_EMAIL inside pp_title_line().

It took a look, and that feels a little wrong, too; we end up with a
function that ignores half of its parameters based on the value of one
of the other parameters, which makes me feel that it really should be
two separate functions.

So maybe there is some heavier refactoring to be done there. In general,
I think pretty_print has gotten a bit messy because of the increase in
the number of formats.  We might do better to turn it "inside out":
rather than going sequentially through and switching each stage on the
format type, make a set of good utility functions and have each format
type implemented as a function that builds out of the utility
primitives.

I also think we can turn several of the formats into --pretty=format:
aliases, which should make the code a lot simpler.  I had also wanted to
add a few features (one of them was giving pretty printing more context
of the tree walk, so you could do things like --pretty=format:'Patch
X/Y: %s' where X and Y would be substitutions for "current number in
walk" and "total number in walk."

I can try to take a look at that sometime in the next week or so, though
I expect it is major enough surgery to be for the next release cycle.

-Peff
