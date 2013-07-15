From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] cat-file: disable object/refname ambiguity check for
 batch mode
Date: Mon, 15 Jul 2013 00:23:48 -0400
Message-ID: <20130715042348.GB20900@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
 <20130712062004.GA15572@sigill.intra.peff.net>
 <51DFC2B2.3080300@alum.mit.edu>
 <20130712092212.GA4859@sigill.intra.peff.net>
 <51DFDAAF.60808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyaKK-0007Fd-HB
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab3GOEXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:23:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:35660 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab3GOEXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:23:50 -0400
Received: (qmail 20795 invoked by uid 102); 15 Jul 2013 04:25:11 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Jul 2013 23:25:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jul 2013 00:23:48 -0400
Content-Disposition: inline
In-Reply-To: <51DFDAAF.60808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230415>

On Fri, Jul 12, 2013 at 12:30:07PM +0200, Michael Haggerty wrote:

> But with particular respect to "git cat-file", I see problems:
> 
> 1. get_ref_snapshot() would have to read all loose and packed refs
> within the specified subtree, because loose refs have to be read before
> packed refs.  So the call would be expensive if there are a lot of loose
> refs.  And DWIM wouldn't know in advance where the references might be,
> so it would have to set prefix="".  If many refs are looked up, then it
> would presumably be worth it.  But if only a couple of lookups are done
> and there are a lot of loose refs, then using a cache would probably
> slow things down.
> 
> The slowdown could be ameliorated by adding some more intelligence, for
> example only populating the loose refs cache after a certain number of
> lookups have already been done.

I had assumed we would load the loose ref cache progressively by
directory. Of course that only helps avoiding "refs/foo/*" when you are
interested in "refs/heads/foo". If your "refs/heads/*" is very large,
you have to load all of it, and at some point it is cheaper to do a few
stat() calls than to actually readdir() the whole directory. On the
other hand, that is basically how packed-refs work now (if we hit any
ref, we have to load the whole file), and repos with many refs would
typically pack them all anyway.

> 2. A "git cat-file --batch" process can be long-lived.  What guarantees
> would users expect regarding its lookup results?

I hadn't really intended this for general lookups, but just to speed up
the refname warning, where being out-of-date is more acceptable (since
the warning is a purely informational hint).

-Peff
