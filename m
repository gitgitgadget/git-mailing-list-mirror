From: Jeff King <peff@peff.net>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 18:04:42 -0500
Message-ID: <20091101230442.GA20264@coredump.intra.peff.net>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
 <7v8weq50pm.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0911011348190.14365@iabervon.org>
 <7vljiqxapw.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0911011518590.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 00:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4jTh-0000t4-9n
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 00:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbZKAXEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 18:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZKAXEm
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 18:04:42 -0500
Received: from peff.net ([208.65.91.99]:41848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbZKAXEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 18:04:41 -0500
Received: (qmail 18205 invoked by uid 107); 1 Nov 2009 23:08:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 01 Nov 2009 18:08:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Nov 2009 18:04:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0911011518590.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131882>

On Sun, Nov 01, 2009 at 04:19:34PM -0500, Daniel Barkalow wrote:

> > > Do things like git_path() fail cleanly if there was no git directory?  If
> > > not, there should probably be tests of nongit on paths that actually need 
> > > a git directory,...
> > 
> > I don't know.  Again, you tell me ;-)
> 
> I'm not an expert on that part. But it looks like it misbehaves, returning 
> ".git/foo" even when that path doesn't make sense.

I will not admit to being an expert in that area, but yes, that is what
I observed before while looking into some of our weird startup problems.
We really have two systems for setting up the environment:

  - setup_git_directory, which tries to do everything at the outset (but
    which we don't necessarily run for all commands, and where "outset"
    is defined as when the git wrapper handles an actual command, which
    means we sometimes do quite a bit of stuff beforehand)

  - some lazy magic in environment.c, mostly setup_git_env. If
    setup_git_directory has been run, this does the right thing because
    it reads GIT_DIR from the environment as set previously. But if not,
    then it can quite often do the wrong thing (as you noticed).

I tried simply ditching the lazy magic, but that doesn't work: there are
many cases where setup_git_directory hasn't been run. Moving it to the
very beginning doesn't quite work, either. I don't remember the details,
sadly. It may be that the lazy setup_git_env magic should, rather than
doing anything itself, call setup_git_directory if it has not been
initialized. But at that point, you might as well setup_git_directory in
every program, since just about every one is going to want to look at
git_path at some point.

Sorry, I know that is vague. Refactoring this area has been on my plate
for so long that I have forgotten all the details, and it is such a
messy area that I am continually procrastinating on diving back into it.
;)

-Peff
