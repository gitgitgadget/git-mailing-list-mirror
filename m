From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 18:52:49 -0400
Message-ID: <20120627225248.GB27566@sigill.intra.peff.net>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
 <7vbok4785a.fsf@alter.siamese.dyndns.org>
 <20120627221106.GE2292@sigill.intra.peff.net>
 <20120627221938.GA1742@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:53:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk179-0005FB-6m
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918Ab2F0WxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:53:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47359
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757751Ab2F0Www (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:52:52 -0400
Received: (qmail 5582 invoked by uid 107); 27 Jun 2012 22:52:55 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 18:52:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 18:52:49 -0400
Content-Disposition: inline
In-Reply-To: <20120627221938.GA1742@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200770>

On Wed, Jun 27, 2012 at 11:19:39PM +0100, Chris Webb wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know that configured vs compiled-in is the right distinction
> > there, though. If I'm building a minimal git for a stripped-down machine
> > and I don't want to include the HTML pages locally, I might want to set
> > the html path to a URL at build-time. That saves each user from having
> > to configure it.
> 
> How about only testing for a git documentation directory if both
> help.htmlpath isn't set (so we're using the compiled-in version) and the
> compiled-in version doesn't contain ://?

That just seems needlessly complex. Why not just check for "://" and be
done?

Let's take a step back for a moment. Why is that check even there? You
can always just hand the path (or URL, or whatever) to the browser
command and hope it can make sense of it. If it can't, it will give you
an error.

I think the check is purely about being slightly nicer when there are no
HTML docs at all (e.g., because you didn't bother building them, or your
binary distribution didn't include them). If your browser is graphical,
we'll spawn it with a bogus URL, and the error message will be in some
window elsewhere on your desktop. Git will happily exit without a
further message. By adding in that check, we can detect that situation
and produce an error message immediately.

So one solution would be to simply remove the check entirely. It was a
slight nicety in some situations, but expanding the definition of the
HTML path to include full URLs means we can no longer accurately
determine what exists and what does not. So we can just stop trying and
let the browser handle it completely.

Another option would be to introduce a new "net" type of help format
which accepts a URL instead of a path. That would leave the existing
code-path untouched. But it does seem needlessly complex, as it would do
more or less the same thing as the "html" format.

-Peff
