From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Wed, 24 Aug 2011 22:05:20 +0200
Message-ID: <20110824200520.GE45292@book.hvoigt.net>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu> <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu> <20110813125438.GC4783@book.hvoigt.net> <4E54B394.2070006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJhb-0005uE-1x
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab1HXUFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:05:23 -0400
Received: from darksea.de ([83.133.111.250]:54202 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752326Ab1HXUFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 16:05:22 -0400
Received: (qmail 5417 invoked from network); 24 Aug 2011 22:05:21 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 22:05:21 +0200
Content-Disposition: inline
In-Reply-To: <4E54B394.2070006@alum.mit.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180032>

On Wed, Aug 24, 2011 at 10:17:24AM +0200, Michael Haggerty wrote:
> On 08/13/2011 02:54 PM, Heiko Voigt wrote:
> > On Sat, Aug 13, 2011 at 12:36:29AM +0200, Michael Haggerty wrote:
> >> diff --git a/refs.c b/refs.c
> >> index 8d1055d..f02cf94 100644
> >> --- a/refs.c
> >> +++ b/refs.c
> > 
> > ...
> > 
> >> @@ -205,23 +208,28 @@ struct cached_refs *create_cached_refs(const char *submodule)
> >>   */
> >>  static struct cached_refs *get_cached_refs(const char *submodule)
> >>  {
> >> -	if (! submodule) {
> >> -		if (!cached_refs)
> >> -			cached_refs = create_cached_refs(submodule);
> >> -		return cached_refs;
> >> -	} else {
> >> -		if (!submodule_refs)
> >> -			submodule_refs = create_cached_refs(submodule);
> >> -		else
> >> -			/* For now, don't reuse the refs cache for submodules. */
> >> -			clear_cached_refs(submodule_refs);
> >> -		return submodule_refs;
> >> +	struct cached_refs *refs = cached_refs;
> >> +	if (! submodule)
> >> +		submodule = "";
> > 
> > Maybe instead of searching for the main refs store a pointer to them
> > locally so you can immediately return here. That will keep the
> > performance when requesting the main refs the same.
> 
> I am assuming that the number of submodules will be small compared to
> the number of refs in a typical submodule.  Therefore, given that the
> refs are stored in a big linked list and that the only thing that can
> realistically be done with the list is to iterate through it, the cost
> of finding the reference cache for a specific (sub-)module should be
> negligible compared to the cost of the iteration over refs in the cache.
>  Treating the main module like the other submodules makes the code
> simpler, so I would prefer to leave it this way.

I just thought I mention it since it is a change and you are already
special casing the main module with this if(!submodule) but you are
probably right and in most cases (many refs and few submodules) this
change is negligible.

> If iteration over refs ever becomes a bottleneck, then optimization of
> the storage of refs within a (sub-)module would be a bigger win than
> special-casing the main module.  And that is what I would like to work
> towards.
> 
> > If I see it correctly you are always prepending to the linked list 
> 
> This is true.
> 
> >                                                                    and
> > in case many submodules get cached this could slow down the iteration
> > over the refs of the main repository.
> 
> Is this a realistic concern?  Remember that the extra search over
> submodules only occurs once for each scan through the list of references.
> 
> I wrote an additional patch that moves the least-recently accessed
> module to the front of the list.  But I doubt that the savings justify
> the 10-odd extra lines of code, so I kept it to myself.  Please note
> that this approach gives pessimal performance (2x slower) if the
> submodules are iterated over repeatedly.  If you would like me to add
> this patch to the patch series, please let me know.

No I don't think this is necessary.

> Long-term, it would be better to implement a "struct submodule" and use
> it to hold submodule-specific data like the ref cache.  Then users could
> hold on to the "struct submodule *" and pass it, rather than the
> submodule name, to the functions that need it.  But this goes beyond the
> scope of what I want to change now, especially since I have no
> experience even working with submodules.
> 
> Summary: I hope I have convinced you that the extra overhead is
> negligible and does not justify additional code.  But if you insist on
> more emphasis on performance (or obviously if you have numbers to back
> up your concerns) then I would be willing to put more work into it.

Yes I am also fine with the current state. I do not have a strong
opinion about this. This already adds enough improvements of the
submodule ref caching which looks a lot nicer than before.

Cheers Heiko
