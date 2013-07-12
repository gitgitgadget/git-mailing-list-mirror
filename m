From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] cat-file: disable object/refname ambiguity check for
 batch mode
Date: Fri, 12 Jul 2013 05:22:12 -0400
Message-ID: <20130712092212.GA4859@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
 <20130712062004.GA15572@sigill.intra.peff.net>
 <51DFC2B2.3080300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 12 11:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxZYW-00048S-B0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 11:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683Ab3GLJWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 05:22:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:37703 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543Ab3GLJWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 05:22:15 -0400
Received: (qmail 26127 invoked by uid 102); 12 Jul 2013 09:23:33 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 04:23:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 05:22:12 -0400
Content-Disposition: inline
In-Reply-To: <51DFC2B2.3080300@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230189>

On Fri, Jul 12, 2013 at 10:47:46AM +0200, Michael Haggerty wrote:

> > The solution feels a little hacky, but I'm not sure there is a better
> > one short of reverting the warning entirely.
> > 
> > We could also tie it to warn_ambiguous_refs (or add another config
> > variable), but I don't think that makes sense. It is not about "do I
> > care about ambiguities in this repository", but rather "I am going to
> > do a really large number of sha1 resolutions, and I do not want to pay
> > the price in this particular code path for the warning").
> > 
> > There may be other sites that resolve a large number of refs and run
> > into this, but I couldn't think of any. Doing for_each_ref would not
> > have the same problem, as we already know they are refs there.
> 
> ISTM that callers of --batch-check would usually know whether they are
> feeding it SHA-1s or arbitrary object specifiers.  (And in most cases
> when there are a large number of them, they are probably all SHA-1s).

Thanks for bringing this up; I had meant to outline this option in the
cover letter, but forgot when posting.

If were designing cat-file from scratch, I'd consider having --batch
take just 40-hex sha1s in the first place. Since we can't do that now
for backwards compatibility, having an option is the best we can do
there.

But having to use such an option to avoid a 10x slowdown just strikes me
as ugly for two reasons:

  1. It's part of the user-visible interface, and it seems like an extra
     "wtf?" moment when somebody wonders why their script is painfully
     slow, and why they need a magic option to fix it. We're cluttering
     the interface forever.

  2. It's a sign that the refname check was put in for a specific
     performance profile (resolving one or a few refs), but didn't
     consider resolving a large number. I'm wondering what other
     performance regressions it's possible to trigger.

> So instead of framing this change as "skip object refname ambiguity
> check" (i.e., sacrifice some correctness for performance), perhaps it
> would be less hacky to offer the following new feature:

I wouldn't frame it as "correctness for performance" at all. The check
does not impact behavior at all, and is purely informational (to catch
quite a rare situation, too). I'd argue that the check simply isn't that
interesting in this case in the first place.

> To cat-file we could add an option like "--sha1-only" or "--literal" or
> "--no-dwim" (... better names are failing me) which would skip *all*
> dwimming of 40-character strings.  It would also assume that any shorter
> strings are abbreviated SHA-1s and fail if they are not.  This would be
> a nice feature by itself ("these are object names, dammit, and don't try
> to tell me differently!") and would have the additional small advantage
> of speeding up lookups of abbreviated SHA-1s, which (regardless of your
> patch) otherwise go through the whole DWIM process.

I can see in theory that somebody might want that, but I am having a
hard time thinking of a practical use.

> I understand that such an option alone would leave some old scripts
> suffering the performance regression caused by the check, but in most
> cases it would be easy to fix them.

I'm less worried about old scripts, and more worried about carrying
around a confusing option forever, especially when I expect most
invocations to use it (perhaps my experience is biased, but I use
cat-file --batch quite a lot in scripting, and it has almost always been
on the output of rev-list).

IOW, it seems like a poor default, and we are choosing it only because
of backwards compatibility. I guess another option is to switch the
default with the usual deprecation dance.

Yet another option is to consider what the check is doing, and
accomplish the same thing in a different way. The real pain is that we
are individually trying to resolve each object by hitting the filesystem
(and doing lots of silly checks on the refname format, when we know it
must be valid).

We don't actually care in this case if the ref list is up to date (we
are not trying to update or read a ref, but only know if it exists, and
raciness is OK). IOW, could we replace the dwim_ref call for the warning
with something that directly queries the ref cache?

-Peff
