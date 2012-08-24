From: Jeff King <peff@peff.net>
Subject: Re: misleading diff-hunk header
Date: Fri, 24 Aug 2012 10:29:09 -0400
Message-ID: <20120824142908.GA15162@sigill.intra.peff.net>
References: <503385D0.5070605@tim.thechases.com>
 <87a9xoi82i.fsf@thomas.inf.ethz.ch>
 <5033AC55.8080405@tim.thechases.com>
 <7vfw7gdtfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Chase <git@tim.thechases.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 16:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4usy-0001fT-HJ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 16:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab2HXO3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 10:29:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47302 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396Ab2HXO3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 10:29:13 -0400
Received: (qmail 712 invoked by uid 107); 24 Aug 2012 14:29:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Aug 2012 10:29:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2012 10:29:09 -0400
Content-Disposition: inline
In-Reply-To: <7vfw7gdtfg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204212>

On Tue, Aug 21, 2012 at 10:52:03AM -0700, Junio C Hamano wrote:

> >>> diff.{type}.xfuncname seems to start searching backwards in
> >>> from the beginning of the hunk, not the first differing line.
> >> [...]
> >>>   @@ -4,4 +4,5 @@ int call_me(int maybe)
> >>>
> >>>    int main()
> >>>    {
> >>>   +  return 0;
> >>>    }
> >>>
> >>> misleadingly suggesting that the change occurred in the call_me()
> >>> function, rather than in main()
> >> 
> >> I think that's intentional, and matches what 'diff -p' does.  It gives
> >> you the context before the hunk.  After all, if a new function starts in
> >> the leading context lines, you can see that in the usual diff data.
> 
> Correct.  It is about "give the user _more_ hint/clue on the context
> of the hunk", in addition to what the user can see in the
> pre-context of the hunk, so it is pointless to hoist "int main()"
> there.

I don't think it is pointless. If you are skimming a diff, then the hunk
headers stand out to easily show which functions were touched. Of
course, as you mentioned later in your email, it is not an exhaustive
list, and I think for Tim's use case, he needs to actually read and
parse the whole patch.

But mentioning call_me here _is_ pointless, because it is not relevant
context at all (it was not modified; it just happens to be located near
the code in question).  So I would argue that showing main() is more
useful to a reader.

It gets even more obvious as you increase the context. Imagine I have
code like this:

   int foo(void)
   {
          return 1;
   }

   int bar(void)
   {
          return 2;
   }

   int baz(void)
   {
          return 3;
   }

and I modify "baz" to return "4" instead. With the regular diff
settings, the hunk header would claim that "bar()" is the context in the
hunk header. But if I ask for -U7, then "foo()" is mentioned in the hunk
header. To me, that doesn't make sense; the modification is exactly the
same, so why would the hunk header differ?

I suppose one could argue that the hunk header is not showing the
context of the change, but rather the context of the surrounding context
lines. But that doesn't seem useful to me.

We discussed this a while ago and you did a "how about this" patch:

  http://article.gmane.org/gmane.comp.version-control.git/181385

Gmane seems to be acting up this morning, so here is the patch (and your
comment) for reference:

> Would this be sufficient?  Instead of looking for the first line that
> matches the "beginning" pattern going backwards starting from one line
> before the displayed context, we start our examination at the first line
> shown in the context.
> 
>  xdiff/xemit.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 277e2ee..5f9c0e0 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -131,7 +131,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>  
>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
>  			long l;
> -			for (l = s1 - 1; l >= 0 && l > funclineprev; l--) {
> +			for (l = s1; l >= 0 && l > funclineprev; l--) {
>  				const char *rec;
>  				long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
>  				long newfunclen = ff(rec, reclen, funcbuf,

In the case we were discussing then, the modified function started on
the first line of context. But as Tim's example shows, it doesn't
necessarily have to. I think it would make more sense to start counting
from the first modified line.

-Peff
