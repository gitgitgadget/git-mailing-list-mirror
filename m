From: Jeff King <peff@peff.net>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Fri, 22 Mar 2013 18:24:39 -0400
Message-ID: <20130322222438.GA13207@sigill.intra.peff.net>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <20130319181042.GA14295@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 23:25:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAOh-00023N-MM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423405Ab3CVWYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:24:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36188 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423359Ab3CVWYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:24:47 -0400
Received: (qmail 6036 invoked by uid 107); 22 Mar 2013 22:26:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 18:26:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 18:24:39 -0400
Content-Disposition: inline
In-Reply-To: <20130319181042.GA14295@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218857>

On Tue, Mar 19, 2013 at 02:10:42PM -0400, Jeff King wrote:

> > The issue bisects to 94bc671 (Add directory pattern matching to
> > attributes, 2012-12-08). That commit actually tests not only that
> > "subdir/" matches, but also that just "subdir" does not match.
> [...]
> So I think the regression is accidental. And we would want tests like
> this on top (which currently fail):
> [...]

I'm having trouble figuring out the right solution for this.

The problem is in path_matches, which used to receive just the unadorned
pathname, and now receives "path/" for directories. It now looks like
this:

> static int path_matches(const char *pathname, int pathlen,
> 			const char *basename,
> 			const struct pattern *pat,
> 			const char *base, int baselen)
> {
> 	const char *pattern = pat->pattern;
> 	int prefix = pat->nowildcardlen;
> 
> 	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
> 	    ((!pathlen) || (pathname[pathlen-1] != '/')))
> 		return 0;

This first stanza checks that a pattern like "foo/" must be matched by a
real directory. Which is fine; that's the point of adding the "/" to the
pattern.

> 	if (pat->flags & EXC_FLAG_NODIR) {
> 		return match_basename(basename,
> 				      pathlen - (basename - pathname),
> 				      pattern, prefix,
> 				      pat->patternlen, pat->flags);
> 	}
> 	return match_pathname(pathname, pathlen,
> 			      base, baselen,
> 			      pattern, prefix, pat->patternlen, pat->flags);
> }

But then here we'll end up feeding "foo/" to be compared with "foo",
which we don't want. For a pattern "foo", we want to match _either_
"foo/" or "foo". So you'd think something like:

  if (pathlen && pathname[pathlen-1] == '/')
          pathlen--;

would work. But it seems that match_basename, despite taking the length
of all of the strings we pass it, will happily use NUL-terminated
functions like strcmp or fnmatch. Converting the former to check lengths
should be pretty straightforward. But there is no version of fnmatch
that does what we want. I wonder if we using wildmatch can get around
this limitation.

-Peff
