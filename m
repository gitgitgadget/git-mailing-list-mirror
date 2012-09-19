From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Document conventions on static initialization and else
 cuddling
Date: Wed, 19 Sep 2012 22:14:03 +0100
Message-ID: <20120919211403.GF19246@atlantic.linksys.moosehall>
References: <7v627pzsr7.fsf@alter.siamese.dyndns.org>
 <1348081202-17361-1-git-send-email-git@adamspiers.org>
 <7vk3vpg2v1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TERb7-0002sb-Im
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab2ISVOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 17:14:08 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45201 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2ISVOH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 17:14:07 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B0CE92E39E;
	Wed, 19 Sep 2012 22:14:04 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vk3vpg2v1.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206003>

On Wed, Sep 19, 2012 at 01:43:46PM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > Signed-off-by: Adam Spiers <git@adamspiers.org>
> > ---
> >
> > I have begun work on fixing existing code to adhere to these
> > guidelines on braces, but there are currently a lot of violations,
> > which means any patches to fix them would be large.  So before I spend
> > any more time on it, I would like to check whether such patches would
> > be welcomed? And if so, should I be doing that on the master branch?
> 
> In general, no.

[snipped]

> > I have also added some simple rules such as `check-brace-before-else'
> > to the top-level Makefile which perform appropriate `grep -n' commands
> > to detect violations and for example easily fix them via emacs' M-x
> > grep.  These rules can be invoked together via a `check-style' target.
> > Would this also be welcomed?  If so, should the checks all be
> > introduced in a single commit, or each check along with the code which
> > was fixed with its help?
> 
> I am not enthused, personally.

OK, I'll drop work on these then.

[snipped]

> >  Documentation/CodingGuidelines | 42 +++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 37 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > index 57da6aa..1a2851d 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -117,17 +117,49 @@ For C programs:
> >     "char * string".  This makes it easier to understand code
> >     like "char *string, c;".
> >  
> > + - We avoid unnecessary explicit initialization of BSS-allocated vars
> > +   (static and globals) to zero or NULL:
> > +
> > +	static int n;
> > +	static char **ch;
> > +
> > +   rather than:
> > +
> > +	static int n = 0;
> > +	static char **ch = NULL;
> 
> As I said, I am in general not in favor of piling more rules here,
> but we've seen this one in new contribution often enough that it is
> a good addition.

Yes, I am proposing its addition precisely because its current
omission resulted in a small but non-negligible amount of both my time
and yours being wasted in a recent patch review cycle.

> > +
> > +   These are superfluous according to ISO/IEC 9899:1999 (a.k.a. C99);
> > +   see item 10 in section 6.7.8 ("Initialization") of WG14 N1256 for
> > +   the exact text:
> > +
> > +     http://open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf
> 
> But I do not think this explanation is necessary.  "This is one of
> our house rules" is a sufficient reason people, who want to blindly
> obey guidelines, need to see.

I presume I'm not the only person who wishes to obey guidelines but
also understand why they exist.  In general, a deeper understanding of
the purpose behind guidelines helps improve judgement about when and
how to apply them.

> >   - We avoid using braces unnecessarily.  I.e.
> >  
> >  	if (bla) {
> >  		x = 1;
> >  	}
> >  
> > -   is frowned upon.  A gray area is when the statement extends
> > -   over a few lines, and/or you have a lengthy comment atop of
> > -   it.  Also, like in the Linux kernel, if there is a long list
> > -   of "else if" statements, it can make sense to add braces to
> > -   single line blocks.
> > +   is frowned upon.  A gray area is when the statement extends
> > +   over a few lines, and/or you have a lengthy comment atop of
> > +   it.  Also, like in the Linux kernel, it can make sense to add
> > +   braces to single line blocks if there are already braces in
> > +   another branch of the same conditional, and/or there is long
> > +   list of "else if" statements.
> 
> Reflowing text without reason is frowned upon as it makes the
> review unnecessary harder by hiding where things have changed.

There was a reason, it just wasn't a particularly good one :-) (emacs
reflows by paragraph, so you have to go out of your way to stop it
reflowing existing text.)

BTW, for anyone else reading who is confused by the fact that the
quoted hunk above shows no signs of reflowing, I think the hunk itself
has been re-reflowed back to the original width (presumably
deliberately in order to determine what really changed).

> You are suggesting to
> 
>         /* Turn this into ... */        /* ... this instead */
>         if (condition)                  if (condition) {
>                 true;                           true;
>         else {                          } else {
>                 otherwise;                      otherwise;
>                 ...                             ...
>         }                               }
> 
> I do not think such an update is wrong per-se, but among different
> shades of gray, the left is probably one of the most minor kind of
> violations.

I was under the impression it was _your_ suggestion ;-)

  http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=204975

Perhaps I read too much into that, since it was concerning the mirror
image case (i.e. where the 'else' branch is a single statement and the
'if' branch requires braces), but they seem like stylistically
equivalent debates to me.

Thanks for the review, Junio.  Based on my responses above, what would
you like me to do with the patch (if anything)?
