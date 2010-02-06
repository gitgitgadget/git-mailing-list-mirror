From: Jeff King <peff@peff.net>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Fri, 5 Feb 2010 22:51:43 -0500
Message-ID: <20100206035143.GA31784@sigill.intra.peff.net>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 04:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndbov-0001iS-Dq
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 04:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0BFDvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 22:51:46 -0500
Received: from peff.net ([208.65.91.99]:41342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab0BFDvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 22:51:45 -0500
Received: (qmail 737 invoked by uid 107); 6 Feb 2010 03:51:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 05 Feb 2010 22:51:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2010 22:51:43 -0500
Content-Disposition: inline
In-Reply-To: <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139140>

On Fri, Feb 05, 2010 at 03:31:06PM -0800, Junio C Hamano wrote:

> Jan Engelhardt <jengelh@medozas.de> writes:
> 
> > Just about now I wanted to grep for accesses of a particular struct 
> > member. Needless to say that it was not a very amusing experience.
> > I would expect that (1) probably fails:
> >
> > (1)	$ git grep '->cnt' net/ipv4/netfilter/
> > 	error: unknown switch `>'
> >
> > So far so good, seems reasonable and matches what I would expect from 
> > most other userspace tools. So let's add -- to terminate the option 
> > list:
> 
> Also you can say "grep -e '->cnt'".  Not just "git grep" but regular grep
> understands this, too.

GNU grep understands "grep -- '->cnt'", so I find myself typing it a
lot. Even though "--" is used for revision and pathname separation, I
don't think there is a conflict in also using it to separate options
from patterns for the case that there is no "-e" at all. In other words:

  git grep -- foo

is not ambiguous. That "--" could not possibly be separating revisions
from pathnames because we have not yet seen any pattern, which is bogus.
In a case like:

  git grep -e pattern -- foo

I think it is clear that the "--" is separating pathnames, because we
already have a pathname. This matches standard grep, which will treat
the first non-option as a pattern only if we have no "-e" pattern.

So I think we can do just do this:

diff --git a/builtin-grep.c b/builtin-grep.c
index 0ef849c..46ffc1d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -889,6 +889,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
 
+	/*
+	 * skip a -- separator; we know it cannot be
+	 * separating revisions from pathnames if
+	 * we haven't even had any patterns yet
+	 */
+	if (argc > 0 && !opt.pattern_list && !strcmp(argv[0], "--")) {
+		argv++;
+		argc--;
+	}
+
 	/* First unrecognized non-option token */
 	if (argc > 0 && !opt.pattern_list) {
 		append_grep_pattern(&opt, argv[0], "command line", 0,

and make everybody happy. But I admit I haven't thought about it more
than 5 minutes or so, so perhaps there is a case I am missing that will
be ambiguous or confusing. The worst I could come up with is the
double-double-dash case:

  git grep -- pattern revision -- pathname

It is perhaps not as pretty as

  git grep -e pattern revision -- pathname

but I don't think it is ambiguous.

> > (2)	$ git grep -- '->cnt' net/ipv4/netfilter/
> > 	fatal: bad flag '->cnt' used after filename
> >
> > *bzzt*.
> 
> This indeed is bzzt, especially if you had a file called "./->cnt" in the
> work tree.  That would mean that you cannot tell the command to look for a
> pattern in the work tree.
> 
> But because you are not giving anything before "--", that "git grep" is
> not looking for anything.  Indeed, (2) is a user error.  If you try this:

That is not quite true. The way "git grep" is implemented now, it is
actually grepping for "--". parse_options stops at the "--", leaving it
in argv, and then we assume whatever is left by parse_options is a
pattern (since we saw no "-e"). But of course it is looking in the
'->cnt' pathspec (or revision!), which is bogus (and gets you "bad flag used
after filename").

But as you noted with:

> > What works is (3).
> >
> > (3)	$ git grep -- -- '->cnt' net/ipv4/netfilter/

...disambiguating the pathspec with the extra "--" gets it past option
parsing and looking for "--".

So actually my patch above is breaking somebody who truly wanted to grep
for "--" by doing

  git grep --

but that is sufficiently insane that I'm not too worried about it.

-Peff
