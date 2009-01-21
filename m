From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Wed, 21 Jan 2009 23:17:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
References: <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlPT-0004yl-1o
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbZAUWRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbZAUWRa
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:17:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:59018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753103AbZAUWR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:17:29 -0500
Received: (qmail invoked by alias); 21 Jan 2009 22:17:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 21 Jan 2009 23:17:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/va4dGgvDvjzg+TOTDpBKCGszyoUl6sE7spfIEA7
	b6zuVwGFBPCr6F
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090121190757.GB21686@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106688>

Hi,

On Wed, 21 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 02:26:56AM +0100, Johannes Schindelin wrote:
> 
> > Well, in this case, you will find that the "bug" is _at most_ some 
> > binaries not being found.
> > [...]
> > (Actually, with my new patch, the may be replaced, but _only_ if 
> > necessary, and the same thing would apply as I said earlier: the binary 
> > would not be found, or a binary from the PATH would be run without 
> > valgrind; but the next runs will not have the problem.)
> 
> You can run a random binary from the PATH.

No.  You seem to assume that a test script can run all kinds of Git 
commands while another, is replacing the symlinks in $GIT_VALGRIND/bin/ at 
the same time.

Fact is: every test script will check $GIT_VALGRIND/bin/ for 
up-to-dateness first.  Before running any Git command.

During that time, races are possible, but non-fatal, because they all try 
to do the same thing.

Except, of course, if you replace a script by a builtin _while your test 
is running the up-to-date check of $GIT_VALGRIND/bin/_!  But I would have 
no word of consolation for you in that case.

So, can we agree that every test script tries to keep $GIT_VALGRIND/bin/ 
up-to-date before the first Git command is called?

Now, you might assume that it is possible that one test-script symlinked 
the Git command while another removed it.

But the script that removed the symlink will recreate it right away.

Granted, during that time, the other script could have gone off to call a 
Git command in that very brief time span, but keep in mind: it does not 
take a long time from rm to ln -s, _and_ the other script would have to go 
on to call a Git command _right through that time_.

And you know which command that might be?

Exactly.  git init.  Which takes a long, long, long time, and where I 
really could not care less if it is called from the PATH or not.

Note: this would be only possible if both scripts checked the same name at 
the very same time, coming to the very same result that the name needs 
symlinking.  Unlikely.

Note, too: such a replacing/creating could only take place the very first 
time you run valgrind, or when a script was replaced by a builtin.  IOW 
very, very rarely to begin with.

Now the big question: is this highly, highly unlikely issue relevant?

And I say: no.  Because even in that highly, highly, highly unlikely 
event, all that will happen is that a git init (which is tested later, 
anyway) is not valgrinded.

Besides, if that race would happen _and_ you would see any issues, you'd 
run the test again, without parallelization, because you would not be able 
to discern what messages belong together from the output of "make -j50 
test" anyway.

And the whole issue goes away, because that call will again try to 
make GIT_VALGRIND/bin up-to-date, and there will be no chance for a race 
this time.

Phew.  A lot of time, a lot of braincycles, and a lot of keystrokes wasted 
on that subject, don't you think?

Ciao,
Dscho
