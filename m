From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Mon, 29 Feb 2016 06:11:23 -0500
Message-ID: <20160229111123.GA29769@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
 <20160227122511.GR1766@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 29 12:11:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaLjo-0007od-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbcB2LL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 06:11:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:51300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753986AbcB2LL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:11:26 -0500
Received: (qmail 13663 invoked by uid 102); 29 Feb 2016 11:11:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:11:26 -0500
Received: (qmail 24851 invoked by uid 107); 29 Feb 2016 11:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:11:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 06:11:23 -0500
Content-Disposition: inline
In-Reply-To: <20160227122511.GR1766@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287824>

On Sat, Feb 27, 2016 at 12:25:11PM +0000, John Keeping wrote:

> On Fri, Feb 26, 2016 at 06:29:57PM -0500, Jeff King wrote:
> > This reverts commit 68889b416d5b6a5cf7d280a428281d635fe9b292.
> [snip]
> > The original patch was not spurred by an actual bug report,
> > but by an observation[1] that was essentially "eh, this
> > looks unnecessarily restrictive". It _is_ restrictive, but
> > it turns out to be necessarily so. :)
> 
> The aim of the original series was to improve the documentation, so I
> don't think it's unreasonable to consider this a regression and revert
> the functional change.  Although I think we can improve the behaviour
> slightly (see below).

Thanks for looking this over. I agree that the changes you suggested
would be an improvement over what I posted. But I tried out the
alternate plan to handle the repo-setup more gracefully inside the loop.
I think that looks much simpler (at the very least, I had to spend a lot
fewer words trying to justify it in the commit message!).

And that makes most of your suggestions obsolete. I'll go through
them...

> > +--local-env-vars::
> > +	List the GIT_* environment variables that are local to the
> > +	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
> > +	Only the names of the variables are listed, not their value,
> > +	even if they are set.
> 
> I think we should add:
> 
> 	No other arguments may be supplied.

So now you can give other arguments. I doubt it's a _good idea_ to do
so, but you could certainly do:

  git rev-parse --git-dir --local-env-vars

if you wanted to. You can even do the opposite, and I guess it would be
correct as long as you popped the final line off the end as --git-dir.

So I guess we could restrict it, but I don't think it's an issue in
practice, and it does technically work.

> > +--resolve-git-dir <path>::
> > +	Check if <path> is a valid repository or a gitfile that
> > +	points at a valid repository, and print the location of the
> > +	repository.  If <path> is a gitfile then the resolved path
> > +	to the real repository is printed.
> 
> Again I think this should say that only the `path` argument may be
> supplied.

This one I think is more reasonable to use along with other options. Or
you could even pass a sequence of:

  git rev-parse --resolve-git-dir foo --resolve-git-dir bar

Again, I doubt it's very useful in practice, but it does the obvious
thing (whereas with my original patch, it silently ignored subsequent
options).

> > +	if (argc == 2 && !strcmp("--local-env-vars", argv[1])) {
> 
> Maybe:
> 
> 	if (argc > 1 && !strcmp("--local-env-vars", argv[1])) {
> 		if (argc != 2)
> 			die("--local-env-vars must be the only argument");
> 
> since the behaviour of:
> 
> 	$ git rev-parse --local-env-vars --
> 	--local-env-vars
> 	--
> 
> is quite surprising.

This now does what you'd expect (it's probably not _useful_, but at
least it isn't horrifying and surprising, like the v1 behavior).

> > +	if (argc > 2 && !strcmp(argv[1], "--resolve-git-dir")) {
> 
> This is less bad, but again it might be nice to provide a better error
> if the path argument isn't supplied.

This one is OK now, too.

> > @@ -706,12 +721,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  				add_ref_exclusion(&ref_excludes, arg + 10);
> >  				continue;
> >  			}
> > -			if (!strcmp(arg, "--local-env-vars")) {
> 
> What about leaving this in and replacing the body of the if statement
> with:
> 
> 	die("--local-env-vars must be the first argument");
> 
> ?  I expect this will significantly reduce debugging time if anyone is
> relying on the current behaviour.

The new version I sent covers this, too (and it does the right thing).


Thanks for a careful review of the corner cases. Even though my response
to all of them is "yeah, but your suggestion is now obsolete", it makes
me feel better about the v2 patch to see that it magically clears up all
of these issues.

-Peff
