From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 21:49:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPk21-0006bw-EU
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZAUUtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZAUUtN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:49:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:34220 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751041AbZAUUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 15:49:12 -0500
Received: (qmail invoked by alias); 21 Jan 2009 20:49:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 21 Jan 2009 21:49:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Cdr1CXVNC5h97Fg7mWO+o0efJoyy33PN0Y2kFVY
	iGSOc2hLvA6Sot
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090121190201.GA21686@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106665>

Hi,

On Wed, 21 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 02:10:17AM +0100, Johannes Schindelin wrote:
> 
> > 	- symbolic links are inspected for correct targets now, and if they
> > 	  point somewhere else than expected, they are removed (this can
> > 	  error out if the file could not be removed) and recreated.
> 
> Now you _do_ have a race on this, and triggering it will cause you to
> run a random version of git from your PATH, not using valgrind (instead
> of running the version from the repo using valgrind). Something like:
> 
>   A: execvp("git-foo")
>   B: oops, "git-foo" is out of date
>   B: rm $GIT_VALGRIND/git-foo
>   A: look for $GIT_VALGRIND/git-foo; not there
>   A: look for $PATH[1]/git-foo; ok, there it is
>   B: ln -s ../../git-valgrind $GIT_VALGRIND/git-foo

Except that A had to check the link first, and it was out-of-date already 
-- except if you changed a script into a builtin _and_ run make while a 
valgrinded test is called _and_ you're unlucky.

> > +--valgrind::
> > +	Execute all Git binaries with valgrind and stop on errors (the
> > +	exit code will be 126).
> 
> It doesn't necessarily stop: it just causes the command to fail, which
> causes the test to fail. Which _will_ stop if you have "-i".
> 
> Also, you might want to mention that valgrind errors go to stderr, so
> using "-v" is helpful.

Okay.

> > +	# override all git executables in PATH and TEST_DIRECTORY/..
> > +	GIT_VALGRIND=$TEST_DIRECTORY/valgrind/bin
> 
> I think you should leave GIT_VALGRIND pointing to the main valgrind
> directory. That way it is more convenient for people using
> GIT_VALGRIND_OPTIONS to make use of GIT_VALGRIND without having to ".."
> everything (for example, they may want to pick and choose suppressions
> to load for their platform).

Okay.

> > +			case "$base" in
> > +			*.sh|*.perl)
> > +				symlink_target=../unprocessed-script
> > +			esac
> 
> AFAIK, this triggers an error if I try to call "git-foo.perl" directly.

Yep.

> What does this have to do with valgrind?

Nothing, except that the infrastructure is there now.

> Why does this error checking happen when I run --valgrind, but _not_ 
> otherwise?

Because we can only check for that kind of mistake in our scripts (which 
the author would not realize is a mistake when running on a system where 
GIT_SHELL=/bin/sh) when we redirect GIT_EXEC_PATH.

So basically, it would take a tremendous effort otherwise, but here, it is 
just easy.

> And yes, I know the answer is "because it's easy to do here, since
> --valgrind is munging the PATH anyway". But my point is that that is an
> _implementation_ detail, and the external behavior to a user is
> nonsensical.
> 
> The fact that there are other uses for munging the PATH than valgrind
> implies to me that we should _always_ be munging the PATH like this to
> catch these sorts of errors. And then "--valgrind" can just change the
> way we munge.

Hmm.  Maybe.

> > +			# create the link, or replace it if it is out of date
> > +			if test ! -h "$GIT_VALGRIND"/"$base" ||
> > +			    test "$symlink_target" != \
> > +					"$(readlink "$GIT_VALGRIND"/"$base")"
> > +			then
> 
> readlink is not portable; it's part of GNU coreutils. Right now valgrind
> basically only runs on Linux, which I think generally means that
> readlink will be available (though I have no idea if there are
> distributions that vary in this). However, there is an experimental
> valgrind port to FreeBSD and NetBSD, which are unlikely to have
> readlink.

As I mentioned earlier: let's bridge this bridge when we face it 
(probably it involves making a test-readlink).

Or are you insisting that the patch should be reworked _now_ so that 
GIT_EXEC_PATH _always_ points somewhere else?

I hope not, because then you break Windows.

Ciao,
Dscho
