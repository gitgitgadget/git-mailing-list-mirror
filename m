From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Wed, 27 Feb 2008 15:31:49 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271523130.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net> <alpine.LNX.1.00.0802261709180.19665@iabervon.org> <alpine.LSU.1.00.0802262239200.22527@racer.site>
 <alpine.LNX.1.00.0802261742260.19665@iabervon.org> <7vzltn2qsd.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802261933551.19665@iabervon.org> <7vy79718tn.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271430130.19665@iabervon.org>
 <7vy796rwkb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSx5-0006X8-2o
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018AbYB0Ubx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 15:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757937AbYB0Ubx
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 15:31:53 -0500
Received: from iabervon.org ([66.92.72.58]:41941 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757297AbYB0Ubw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 15:31:52 -0500
Received: (qmail 2250 invoked by uid 1000); 27 Feb 2008 20:31:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 20:31:49 -0000
In-Reply-To: <7vy796rwkb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75300>

On Wed, 27 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Since it sets GIT_DIR, it also could simply unset GIT_CONFIG, and then 
> > everything would just write to the config file for the new GIT_DIR. On the 
> > other hand, if you have GIT_CONFIG exported in your environment, and you 
> > set up a repository with "git clone", and clone unsets or overrides 
> > GIT_CONFIG, then your new repository will immediately be unusable, because 
> > clone will set up the config file inside the new repository, but nothing 
> > you run after that will look in the new repository, since everything else 
> > obeys the GIT_CONFIG you still have set.
> 
> Yes, I think an interactive environment that has GIT_CONFIG is
> simply misconfigured.
> 
> But on the other hand, I could well imagine a script that does
> this:
> 
> 	#!/bin/sh
> 	GIT_CONFIG=$elsewhere; export GIT_CONFIG
>         do things to the $elsewhere file via git-config
>         git clone $something $new
>         talk about the $new in the $elsewhere file via git-config
> 	(
>         	unset GIT_CONFIG ;# I am writing the script carefully!
> 		cd $new
>                 do something inside the clone
> 	)
>         talk more about the $new in the $elsewhere file via git-config
> 	exit

That seems counterintuitive to me. If you created $new with init instead 
of clone, entirely different things would happen. And any other git 
commands outside the subshell would behave oddly. (Actually, the first of 
these reminds me why I thought git-clone used the caller's $GIT_DIR: 
git-init does.)

> > On the other hand, I don't see why any git command other than "git config" 
> > (run my the user directly) has any business looking at GIT_CONFIG, since 
> > it's only mentioned in the man page for git-config, and not in general for 
> > configuration, the wrapper, or other programs.
> 
> I think reading from the configuration file is done by
> everybody, and GIT_CONFIG affects where the information is read
> from.  Maybe it was a misfeature.  I dunno.

It makes sense that it would work that way, but the documentation should 
probably reflect that in config.txt.

	-Daniel
*This .sig left intentionally blank*
