From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 17:25:32 -0500
Message-ID: <20120126222532.GA12855@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <4F2119E6.8010109@viscovery.net>
 <20120126165456.GA5278@sigill.intra.peff.net>
 <7vmx9a2o23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 23:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqXlF-0005TN-H9
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 23:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab2AZWZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 17:25:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46023
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538Ab2AZWZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 17:25:36 -0500
Received: (qmail 30145 invoked by uid 107); 26 Jan 2012 22:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 17:32:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 17:25:32 -0500
Content-Disposition: inline
In-Reply-To: <7vmx9a2o23.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189167>

On Thu, Jan 26, 2012 at 12:42:28PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And no, I didn't do any cycle detection. We could either do:
> >
> >   1. Record some canonical name for each source we look at (probably
> >      realpath() for files, and the sha1 for refs), and don't descend
> >      into already-seen sources.
> >
> >   2. Simply provide a maximum depth, and don't include beyond it.
> >
> > The latter is much simpler to implement, but I think the former is a
> > little nicer for the user.
> 
> Another thing I wondered after reading this patch was that it will be a
> rather common "mistake" to include the same file twice, one in ~/.gitconfig
> and then another in project specific .git/config, or more likely, people
> start using useful ones in ~their/.gitconfig, and then the site administrator
> by popular demand adding the same include in /etc/gitconfig to retroactively
> cause the same file included twice for them.
> 
> Your first alternative solution should solve this case nicely as well, I
> would think.

Agreed. I'll implement that, then.

There's a slight complication with when to clear the "I have seen this"
mark for each source. If you are interested only in breaking cycles,
then obviously you can just clear the marks as you pop the stack. But if
you want to stop repeated inclusion down different branches of the
include tree, you need to keep the marks until you're done (e.g., the
same file referenced by .git/config and ~/.gitconfig). But you do still
need to clear them, because we repeatedly call git_config with different
callback functions, and we need to re-parse each time.

I think it should be sufficient to make the marks live through
git_config(), and get cleared after that (so all of .git/config,
~/.gitconfig, and /etc/gitconfig will only load a given include once,
but another call to git_config will load it again).

-Peff
