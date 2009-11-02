From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 19:59:45 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911011829130.14365@iabervon.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru> <7v8weq50pm.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911011348190.14365@iabervon.org> <7vljiqxapw.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911011518590.14365@iabervon.org>
 <20091101230442.GA20264@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 02:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4lHK-0000U2-8o
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 02:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbZKBA7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 19:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZKBA7r
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 19:59:47 -0500
Received: from iabervon.org ([66.92.72.58]:36422 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbZKBA7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 19:59:44 -0500
Received: (qmail 1853 invoked by uid 1000); 2 Nov 2009 00:59:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Nov 2009 00:59:45 -0000
In-Reply-To: <20091101230442.GA20264@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131889>

On Sun, 1 Nov 2009, Jeff King wrote:

> On Sun, Nov 01, 2009 at 04:19:34PM -0500, Daniel Barkalow wrote:
> 
> > > > Do things like git_path() fail cleanly if there was no git directory?  If
> > > > not, there should probably be tests of nongit on paths that actually need 
> > > > a git directory,...
> > > 
> > > I don't know.  Again, you tell me ;-)
> > 
> > I'm not an expert on that part. But it looks like it misbehaves, returning 
> > ".git/foo" even when that path doesn't make sense.
> 
> I will not admit to being an expert in that area, but yes, that is what
> I observed before while looking into some of our weird startup problems.
> We really have two systems for setting up the environment:
> 
>   - setup_git_directory, which tries to do everything at the outset (but
>     which we don't necessarily run for all commands, and where "outset"
>     is defined as when the git wrapper handles an actual command, which
>     means we sometimes do quite a bit of stuff beforehand)
> 
>   - some lazy magic in environment.c, mostly setup_git_env. If
>     setup_git_directory has been run, this does the right thing because
>     it reads GIT_DIR from the environment as set previously. But if not,
>     then it can quite often do the wrong thing (as you noticed).
> 
> I tried simply ditching the lazy magic, but that doesn't work: there are
> many cases where setup_git_directory hasn't been run. Moving it to the
> very beginning doesn't quite work, either. I don't remember the details,
> sadly. It may be that the lazy setup_git_env magic should, rather than
> doing anything itself, call setup_git_directory if it has not been
> initialized. But at that point, you might as well setup_git_directory in
> every program, since just about every one is going to want to look at
> git_path at some point.
> 
> Sorry, I know that is vague. Refactoring this area has been on my plate
> for so long that I have forgotten all the details, and it is such a
> messy area that I am continually procrastinating on diving back into it.
> ;)

I've been looking at it, just now, and I might try to clean stuff up. The 
problem I'm running into is that, in some cases, you have to call 
setup_git_directory_gently(), and it might determine that there is no git 
repo, but then the various environment functions don't distinguish between 
the situation where you haven't called it at all and the situation where 
you called it and determined there to be no answer. Furthermore, a lot of 
functions seem to be getting git_path(something), ignoring the fact that 
there is no repo, and acting like there is a repo that has simply not got 
the file it is looking for.

	-Daniel
*This .sig left intentionally blank*
