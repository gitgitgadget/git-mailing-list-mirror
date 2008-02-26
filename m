From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support TEST_GIT_PATH variable for the path for the git
 to test
Date: Tue, 26 Feb 2008 15:46:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261539130.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251600220.19024@iabervon.org> <7v63wch9ia.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802261242210.19024@iabervon.org> <7v63wb5zec.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802261350510.19024@iabervon.org>
 <7vpruj4ge1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:47:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6hc-0004Pc-I7
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765418AbYBZUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765153AbYBZUqW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:46:22 -0500
Received: from iabervon.org ([66.92.72.58]:43291 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764875AbYBZUqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:46:21 -0500
Received: (qmail 22872 invoked by uid 1000); 26 Feb 2008 20:46:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 20:46:17 -0000
In-Reply-To: <7vpruj4ge1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75171>

On Tue, 26 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> I did not mean to imply I was presenting the whole solution; I
> >> was trying to hint at a different direction which may or may not
> >> work.  I did not look at what test_create_repo() actually did
> >> when I wrote the message, but you are right.  It too needs to
> >> be made conditional, and when trying an installed version, it
> >> should not do the "template" dance but let the installed "git init"
> >> figure it out.
> >
> > Does it need to be conditional, or is simply "git init" right (where we've 
> > already set environment variables for the local stuff if applicable)?
> 
> I suspect "uninstalled" cases (both "here" and "elsewhere")
> needs to do the template magic, while "installed" case should be
> just "git init".

Ah, but that doesn't have to be here, since we can (and, AFAICT do) use 
the GIT_TEMPLATE_DIR environment variable, and can set it as appropriate 
in the setup code.

> >> > There's additionally the problem that things which are built for testing 
> >> > in the git directory won't be installed anywhere.
> >> 
> >> To test without installing, in order to make them call out their
> >> siblings, I have this piece that I source to a new shell:
> >> 
> >>         GIT_EXEC_PATH=`pwd`
> >>         PATH=`pwd`:/usr/bin:/bin
> >>         GITPERLLIB=`pwd`/perl/blib/lib
> >>         export GIT_EXEC_PATH PATH GITPERLLIB
> >
> > Might be nice to have a "sgitpath" (on the model of sg or su) in t/, since 
> > this is handy in general.
> 
> I have them in ./+denv and after building if I want to see it
> work in real repo elsewhere I do:
> 
> 	: gitster; sh
>         $ . ./+denv
>         $ cd ../elsewhere.git
>         $ do the real workload trial
>         $ ^D

I was thinking it would be handy to have around t/ in case you want to go 
step-by-step through a failing test, using the git the test would use. For 
that purpose, it would also be handy to pick up the environment variables 
I'm introducing in this thread, I guess.

> > You understood correctly the first time; I was unclear the second time. 
> > The problem here is that, in order to run tests, we call 
> > "test-absolute-path", "test-genrandom", etc., and we can't use these from 
> > the user's $PATH because, being only for testing, they don't get installed 
> > there. We need to get git-remote (for example) from $PATH, but 
> > test-genrandom from $(pwd)/.. in order to make the tests run.
> 
> Ok, so even "installed" case need to rely on "test-blah" we build.

Right. Would it be okay to build those into t/helpers/* or something, 
instead of into the project root, so that they're just naturally separate 
from the actual program?

	-Daniel
*This .sig left intentionally blank*
