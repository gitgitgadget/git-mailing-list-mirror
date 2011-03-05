From: Jeff King <peff@peff.net>
Subject: Re: [Bug] %[a|c]d placeholder does not respect --date= option in
 combination with git archive
Date: Sat, 5 Mar 2011 14:50:20 -0500
Message-ID: <20110305195020.GA3089@sigill.intra.peff.net>
References: <4D6F5FA8.5030105@gmx.de>
 <20110303151019.GC1074@sigill.intra.peff.net>
 <4D70BA9C.1080902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dietmar Winkler <dietmarw@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:50:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvxUj-000420-G6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab1CETuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 14:50:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab1CETuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 14:50:24 -0500
Received: (qmail 14142 invoked by uid 111); 5 Mar 2011 19:50:21 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Mar 2011 19:50:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2011 14:50:20 -0500
Content-Disposition: inline
In-Reply-To: <4D70BA9C.1080902@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168507>

On Fri, Mar 04, 2011 at 11:10:36AM +0100, Dietmar Winkler wrote:

> Well in
> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html it says:
> 
>   "The placeholders are the same as those for the option
> --pretty=format: of git-log(1), except that they need to be wrapped like
> this: $Format:PLACEHOLDERS$ in the file."
> 
> And in git log the list includes (besides the various date formats) also
> 
>  %ad: author date (format respects --date= option)
>   ...
>  %cd: committer date *
> 
> *) actually here the string "(format respects --date= option)" is
> missing. Otherwise what committer date format are we speaking about ;)
> 
> So either the documentation should make clear that the substitution will
> *not* work or (and this would be preferable) fix the substitution so
> that it works as documented.

Yeah, the documentation is misleadingly vague there. I've improved it in
the patch series below.

> > I remember at some point discussing extending the specifier syntax to
> > allow things like "%(ad,date=short)", but it was never implemented. I
> > think that would be the cleanest way to do what you want.
> 
> Yes that would be even better since it would give one the freedom of
> defining different format for the subsitutions  in different places in a
> project. Shame it was not accepted.

I think we got bogged down in what exactly the extended format should
look like and then nothing got done. I spent a few hours yesterday
looking again at how bad it would be to extend the syntax to handle both
the traditional format and '%(foo,arg=value)' but there are lot of
corner cases.

So this morning I scrapped that and just added "%ad(mode)" which was
much simpler, and matches syntactically with some of our other commands.
It's in the series below.

> > The second cleanest would be adding an archive.date variable. Which is
> > much simpler, obviously. But I think making "log.date" start applying to
> > archive substitutions is going to surprise some people and possibly
> > break their setups.
> 
> How should this surprise people? If the used %ad they would have
> expected a configuration depended substitution to start with. If they
> wanted a log.date *independent* substitution they should have (according
> to the documentation) some of the other formats (e.g., %ar, %ai, ...).
> So I don't really see this as a reason for not fixing this bug.

Imagine a project which uses "git archive" as part of its scripts for
building a distribution tarball. I.e., you run "make dist" or similar,
and it produces the tarball. The gitattributes and $Format:%ad$
placeholders are contained in the upstream repository. So anybody who
clones it can run "make dist" and get the identical tarball.

Now imagine as a developer on the project, you prefer to see your logs
with a different date format. So you set log.date to "short". But if
git-archive behaves as you want it to, then your "make dist" is now
broken. It generates different results to everyone else's.

Anyway, hopefully the point becomes moot with this patch series, which
lets you do %ad(short) in your format strings:

  [1/2]: pretty.c: give format_person_part the whole placeholder
  [2/2]: pretty.c: allow date formats in user format strings

-Peff
