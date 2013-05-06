From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Mon, 6 May 2013 14:44:51 -0400
Message-ID: <20130506184451.GB23568@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com>
 <20130503172853.GB21715@sigill.intra.peff.net>
 <51879E2D.8060506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 06 20:45:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQPB-0003De-St
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 20:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab3EFSox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 14:44:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:40523 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab3EFSox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 14:44:53 -0400
Received: (qmail 21278 invoked by uid 102); 6 May 2013 18:45:13 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 13:45:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 14:44:51 -0400
Content-Disposition: inline
In-Reply-To: <51879E2D.8060506@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223482>

On Mon, May 06, 2013 at 02:12:29PM +0200, Michael Haggerty wrote:

> > I think that would be correct (modulo that step 1 cannot happen for
> > enumeration). But we would like to avoid loading all loose refs if we
> > can. Especially on a cold cache, it can be quite slow, and you may not
> > even care about those refs for the current operation (I do not recall
> > the exact original motivation for the lazy loading, but it was something
> > along those lines).
> 
> Lazy loading was first inspired by the observation that effectively
> every git invocation was loading *all* loose references to do an
> iteration over refs/replace/ (which I've never even used!)  This was
> absolutely killing the performance of filter-branch, which creates a lot
> of loose references and invokes git many times--even though the cache
> was warm.

Yeah, obviously we want to avoid that. I _think_ we can even keep the
lazy loading, as long as keep the ordering as:

  1. Load a chunk of loose refs (whatever we need for the current
     iteration request).

  2. Double-check that our packed-refs cache is up to date, and reload
     if necessary.

  3. Return the results to the caller.

It would perhaps increase latency to getting results to the caller
(since otherwise we can start feeding answers to the caller as we walk
the tree), but should not increase the total amount of work (just the
extra stat() of packed-refs, once per for_each_ref, which is not much).

I'll see if I can cook up a patch.

-Peff
