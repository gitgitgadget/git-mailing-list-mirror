From: Jeff King <peff@peff.net>
Subject: Re: Question about PERL_PATH
Date: Sat, 7 May 2011 20:13:26 -0400
Message-ID: <20110508001326.GA13282@sigill.intra.peff.net>
References: <4DC3F804.3080205@mev.co.uk>
 <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
 <robbat2-20110507T174237-068953557Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org, abbotti@mev.co.uk
X-From: git-owner@vger.kernel.org Sun May 08 02:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIrd9-0006IQ-6I
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 02:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1EHANc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 20:13:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41146
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab1EHANb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 20:13:31 -0400
Received: (qmail 24016 invoked by uid 107); 8 May 2011 00:15:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 May 2011 20:15:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 May 2011 20:13:26 -0400
Content-Disposition: inline
In-Reply-To: <robbat2-20110507T174237-068953557Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173071>

On Sat, May 07, 2011 at 06:02:48PM +0000, Robin H. Johnson wrote:

> On Fri, May 06, 2011 at 09:05:08AM -0700,  Junio C Hamano wrote:
> > The variable is not PERL_COMMAND_LINE, but is PERL_PATH, so I think it
> > should expects the path to the program.
> > 
> > Our testsuite also rely on it being the path to the program by enclosing
> > the reference to it inside double quotes, to make sure that PERL_PATH set
> > to "/Program Files/Perl/perl.exe" works.  Didn't Gentoo folks see any test
> > breakage before shipping the ebuild procedure?
> The entire test suite completes fine with our
> PERL_PATH="${EPREFIX}/usr/bin/env perl" setting.

This is more luck than anything. For example, you are skipping all of
the perl tests (t9700) and all of the git-svn tests (t91*), because they
both try do something like:

  if ! "$PERL_PATH" -e "use SomeModule"; then
    skip_all="You don't have SomeModule installed"
  fi

So you are skipping many tests accidentally, and it is only luck that
all such uses are currently tests that handle a broken "$PERL_PATH" in
this way. It is entirely likely that this usage may end up causing a
test suite failure at some point in the future.

If we want to support this use of env/, we need to provide separate
Makefile variables for "what goes at the top of a perl script" and "what
we use to run perl".

> This was originally put into place because of our bug #326625 [1].
> From that bug:
> ====
> Git does not compile if local::lib installed in user's home directory if
> 'sudo' is used to raise privileges. Local::lib exports environment
> variable PERL5_MM_OPTS, which contains string INSTALL_BASE='...'.
> Variable PREFIX is set in package's Makefile.pl. Package will not
> compile if both of these variables are set.
> ====
> (Full logs attached in the bug).
> 
> If you can suggest a better way to fix the user's bug, I'll revert the
> PERL_PATH change.

It looks like we auto-build the perl bits of the Makefile by calling:

  $(PERL_PATH) Makefile.PL PREFIX=$(prefix) INSTALL_BASE=''

which seems to me like it should override local::lib's INSTALL_BASE
(which also doesn't seem ideal, but I wouldn't expect it to cause this
error). But surely the solution involves changing this line in
perl/Makefile to handle the local::lib case?

I also don't see how this is git-specific. From my reading of the bug
report, local::lib will fail to work any time the user does:

  perl Makefile.PL PREFIX=anything

which seems odd. Wouldn't other packages be running into this problem,
then, too (i.e., anything which has a little bit of perl and
automagically runs MakeMaker on behalf of the user)?

-Peff
