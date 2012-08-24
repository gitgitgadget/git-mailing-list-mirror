From: Jeff King <peff@peff.net>
Subject: Re: misleading diff-hunk header
Date: Fri, 24 Aug 2012 12:44:15 -0400
Message-ID: <20120824164415.GA23262@sigill.intra.peff.net>
References: <503385D0.5070605@tim.thechases.com>
 <87a9xoi82i.fsf@thomas.inf.ethz.ch>
 <5033AC55.8080405@tim.thechases.com>
 <7vfw7gdtfg.fsf@alter.siamese.dyndns.org>
 <20120824142908.GA15162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Chase <git@tim.thechases.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 18:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wzi-0000kl-Rp
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 18:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759718Ab2HXQoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 12:44:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47408 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab2HXQoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 12:44:19 -0400
Received: (qmail 2091 invoked by uid 107); 24 Aug 2012 16:44:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Aug 2012 12:44:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:44:15 -0400
Content-Disposition: inline
In-Reply-To: <20120824142908.GA15162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204221>

On Fri, Aug 24, 2012 at 10:29:09AM -0400, Jeff King wrote:

> > Would this be sufficient?  Instead of looking for the first line that
> > matches the "beginning" pattern going backwards starting from one line
> > before the displayed context, we start our examination at the first line
> > shown in the context.
> > 
> >  xdiff/xemit.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> > index 277e2ee..5f9c0e0 100644
> > --- a/xdiff/xemit.c
> > +++ b/xdiff/xemit.c
> > @@ -131,7 +131,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
> >  
> >  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
> >  			long l;
> > -			for (l = s1 - 1; l >= 0 && l > funclineprev; l--) {
> > +			for (l = s1; l >= 0 && l > funclineprev; l--) {
> >  				const char *rec;
> >  				long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
> >  				long newfunclen = ff(rec, reclen, funcbuf,
> 
> In the case we were discussing then, the modified function started on
> the first line of context. But as Tim's example shows, it doesn't
> necessarily have to. I think it would make more sense to start counting
> from the first modified line.

That patch would look something like this:

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d11dbf9..441ecf5 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -194,7 +194,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
 			get_func_line(xe, xecfg, &func_line,
-				      s1 - 1, funclineprev);
+				      xche->i1 - 1, funclineprev);
 			funclineprev = s1 - 1;
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,

Note that this breaks a ton of tests. Some of them are just noise (e.g.,
t4042 changes line 2, so line 1 is the top of the context; before, we
would show no hunk header, since we were at the top of the file, but now
we will show line 1). Some of them are improved in the way that this
patch intends (e.g., t4051).

But some I'm not sure of. For instance, the failure in t4018.38 is odd.
I think it's because the pattern it is looking for is a somewhat odd toy
example (it's looking for a line with "s" in it, so naturally when we
shift the start-point of our search, we are likely to find some other
false positive). But it raises an interesting point: what if the pattern
is just looking for lines in a list, and not an enclosing function?

For example, imagine you have a file a list of items, one per line.
With the old code, you'd get:

	diff --git a/old b/new
	index f384549..1066a25 100644
	--- a/old
	+++ b/new
	@@ -2,3 +2,3 @@ one
	 two
	-three
	+three -- modified
	 four

So the hunk header is showing you something useful; the element just
above your context. But with my patch, you'd see:

	diff --git a/old b/new
	index f384549..1066a25 100644
	--- a/old
	+++ b/new
	@@ -2,3 +2,3 @@ two
	 two
	-three
	+three -- modified
	 four

I.e., it shows the element just before the change, which is already in
the context anyway. So it's actually less useful. Although note that the
current behavior is not all that useful, either; it is not really giving
you any information about the change, but rather just showing one extra
line of context.

So I would say that which you would prefer might depend on exactly what
you are diffing. But I would also argue that in any case where the new
code produces a worse result, the hunk header was not all that useful to
begin with.

-Peff
