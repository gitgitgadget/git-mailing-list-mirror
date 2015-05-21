From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/14] remote.c: report specific errors from
 branch_get_upstream
Date: Thu, 21 May 2015 14:49:10 -0400
Message-ID: <20150521184910.GA3490@peff.net>
References: <20150521044429.GA5857@peff.net>
 <20150521044532.GH23409@peff.net>
 <xmqq7fs1kcfd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:49:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVX0-0002Rd-2I
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040AbbEUStQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:49:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:34186 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754484AbbEUStN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:49:13 -0400
Received: (qmail 12629 invoked by uid 102); 21 May 2015 18:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 13:49:13 -0500
Received: (qmail 6421 invoked by uid 107); 21 May 2015 18:49:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 14:49:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 14:49:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fs1kcfd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269644>

On Thu, May 21, 2015 at 11:33:58AM -0700, Junio C Hamano wrote:

> > +static const char *error_buf(struct strbuf *err, const char *fmt, ...)
> >  {
> > -	if (!branch || !branch->merge || !branch->merge[0])
> > -		return NULL;
> > +	if (err) {
> > +		va_list ap;
> > +		va_start(ap, fmt);
> > +		strbuf_vaddf(err, fmt, ap);
> > +		va_end(ap);
> > +	}
> > +	return NULL;
> > +}
> 
> Many of our functions return -1 to signal an error, and that is why
> it makes sense for our error() helper to return -1 to save code in
> the caller, but only because the callers of this private helper use
> a NULL to signal an error, this also returns NULL.  If we were to
> use the "callers can opt into detailed message by passing strbuf"
> pattern more widely, we would want a variant of the above that
> returns -1, too.  And such a helper would do the same thing as
> above, with only difference from the above is to return -1.

Yeah, this is not really a good general-purpose purpose function in that
sense. I have often wanted an error() that returns NULL, but avoided
adding just because it seemed like needless proliferation.

The real reason to include the return value at all in error() is to let
you turn two-liners into one-liners. We could drop the return value from
this helper entirely (or make it -1, but of course no callers would use
it) and write it out long-hand in the callers:

  if (!branch->merge) {
	error_buf(err, ...);
	return NULL;
  }

That is really not so bad, as there are only a handful of callers.

> > +const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
> > +{
> > +	if (!branch)
> > +		return error_buf(err, _("HEAD does not point to a branch"));
> > +	if (!branch->merge || !branch->merge[0] || !branch->merge[0]->dst) {
> > +		if (!ref_exists(branch->refname))
> > +			return error_buf(err, _("no such branch: '%s'"),
> > +					 branch->name);
> > +		if (!branch->merge)
> > +			return error_buf(err,
> > +					 _("no upstream configured for branch '%s'"),
> > +					 branch->name);
> > +		return error_buf(err,
> > +				 _("upstream branch '%s' not stored as a remote-tracking branch"),
> > +				 branch->merge[0]->src);
> > +	}
> > +
> >  	return branch->merge[0]->dst;
> >  }
> 
> This is a faithful conversion of what the get_upstream_branch() used
> to do, but that ref_exists() check and the error checking there look
> somewhat out of place.
> 
> It makes the reader wonder what should happen when "branch->refname"
> does not exist as a ref, but "branch->merge[0]->dst" can be fully
> dereferenced.  Should it be an error, or if it is OK, the reason why
> it is OK is...?

Yeah, my goal here was to faithfully keep the same logic, but I had a
similar head-scratching moment. What would make more sense to me is:

  if (!branch)
	return error("HEAD does not point to a branch");

  if (!branch->merge || !branch->merge[0]) {
	/*
	 * no merge config; is it because the user didn't define any, or
	 * because it is not a real branch, and get_branch auto-vivified
	 * it?
	 */
	if (!ref_exists(branch->refname))
		return error("no such branch");
	return error("no upstream configured for branch");
  }

  if (!branch->merge[0]->dst)
	return error("upstream branch not stored as a remote-tracking branch");

  return branch->merge[0]->dst;


Hopefully the comment there answers your question; it is not that we
truly care whether the ref exists, but only that we are trying to tell
the difference between a "real" branch and a struct that is an artifact
of our internal code.

Note also that the original may dereference branch->merge[0] even if it
is NULL. I think that can't actually happen in practice (we only
allocate branch->merge if we have at least one item to put in it, and
all of the checks of branch->merge[0] are actually being over-careful).
But the code I just wrote above does not have that problem.

-Peff
