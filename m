From: Jeff King <peff@peff.net>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 05:59:43 -0400
Message-ID: <20130319095943.GA6031@sigill.intra.peff.net>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <20130316114118.GA1940@sigill.intra.peff.net>
 <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
 <20130319093034.GA29997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:00:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHtL5-0002En-39
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab3CSJ7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 05:59:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58128 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756266Ab3CSJ7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 05:59:48 -0400
Received: (qmail 26938 invoked by uid 107); 19 Mar 2013 10:01:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 06:01:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 05:59:43 -0400
Content-Disposition: inline
In-Reply-To: <20130319093034.GA29997@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218492>

On Tue, Mar 19, 2013 at 05:30:34AM -0400, Jeff King wrote:

> On Tue, Mar 19, 2013 at 09:17:32AM +0100, Thomas Rast wrote:
> 
> > > but the line in question is:
> > >
> > >   if (deepest_delta < delta_obj->delta_depth)
> > >
> > > And in the debugger, both of those variables appear to have sane values
> > > (nor should either impacted by the patch you bisected to). On top of
> > > that, running with pack.threads=1 produces the same error. So I think it
> > > may be a false positive from valgrind, and unrelated to your issue.
> > 
> > I find that somewhat unlikely, for two reasons: memcheck is actually
> > quite good at finding uninitialized memory use, it just isn't that good
> > at distinguishing if it makes a difference.  Most false positives are of
> > the "loading an entire word and discarding most of it" kind.
> 
> Yes, that has been my experience with valgrind false positives, too. But
> if this is a real problem, it may be different from the OP's issue. It
> seems to trigger for me in v1.7.10, before Duy's threading patches. It
> does not seem to be in v1.7.5. I'm bisecting now.

Hmph. It bisects to Junio's d1a0ed1 (index-pack: show histogram when
emulating "verify-pack -v", 2011-06-03), which introduces those lines.
The deepest_delta variable is static, so by definition it is always
initialized to something. So I guess some objects may not have
delta_depth set. Still looking.

-Peff
