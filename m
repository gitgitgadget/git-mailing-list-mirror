From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] sha1_name: implement @{push} shorthand
Date: Tue, 31 Mar 2015 18:32:01 -0400
Message-ID: <20150331223200.GC31948@peff.net>
References: <20150331173339.GA17732@peff.net>
 <20150331173834.GF18912@peff.net>
 <xmqqk2xwq25m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:32:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4he-0004MT-An
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbbCaWcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:32:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:40709 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbbCaWcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:32:04 -0400
Received: (qmail 30472 invoked by uid 102); 31 Mar 2015 22:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 17:32:03 -0500
Received: (qmail 29504 invoked by uid 107); 31 Mar 2015 22:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 18:32:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 18:32:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2xwq25m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266572>

On Tue, Mar 31, 2015 at 02:37:25PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > index 0796118..5d9df25 100644
> > --- a/Documentation/revisions.txt
> > +++ b/Documentation/revisions.txt
> > @@ -98,6 +98,31 @@ some output processing may assume ref names in UTF-8.
> >    `branch.<name>.merge`).  A missing branchname defaults to the
> >    current one.
> >  
> > +'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
> > +  The suffix `@{push}` reports the branch "where we would push to" if
> 
> The corresponding description for upstream begins like this:
> 
>   The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
> 
> and makes me wonder if the existing backslashes are unnecessary, or
> if you forgot to use them in the new text.

They are necessary inside single-quotes, but not inside backticks. IMHO
this entire file should be using backticks, but I didn't want to
reformat the entire file (and so I tried to at least keep the heading in
the same style as the rest of it).

> > +static char *tracking_ref_for(struct remote *remote, const char *refname)
> > +{
> > +	char *ret;
> > +
> > +	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
> > +	if (!ret)
> > +		die(_("@{push} has no local tracking branch for remote '%s'"),
> > +		    refname);
> 
> I would imagine that it would be very plausible that anybody with a
> specific remote and the name of the ref that appears on that remote
> would want to learn the local name of the remote-tracking ref we use
> to track it.

I am not sure I understand. We do _not_ have a local name we use to
track it. That is the error. I can print "remote %s does not have branch
%s", if that is what you mean.

> But the error message limits the callers only to those who are
> involved in @{push} codepath.  Shouldn't the error check be done in
> the caller instead, anticipating the day this useful function ceases
> to be static?

Is it really a useful general function? If you remove the die() message,
it is literally a one-liner. My purpose in pulling it out at all was not
to repeat the die() message over and over in get_push_branch().

> I would suspect that such a change would make it just a one-liner,
> but I think this helper that takes remote and their refname is much
> easier to read than four inlined calls to apply_refspecs() that have
> to spell out remote->fetch, remote->fetch_refspec_nr separately.
> 
> Perhaps we would want 
> 
> 	struct refspecs {
>         	int nr, alloc;
>                 const char **refspec;
> 	} fetch_refspec;
> 
> in "struct remote", instead of these two separate fields, and then
> make apply_refspecs() take "struct refspecs *"?  I haven't checked
> and thought enough to decide if we want "struct refspec *" also in
> that new struct, though.

I think it is more complicated, as there are actually two arrays indexed
by each {fetch,push}_refspec_nr. We have "fetch_respec", which contains
the text (I assume), and then the "struct refspec". So ideally those
would be stored together in a single list, but of course many helper
functions want just the "struct refspec" list. So you still end up with
two lists, but just pushed down into a single struct. I guess that's
better, but I was trying to find a bound to my refactoring rather than
touching all of the code. :-/

-Peff
