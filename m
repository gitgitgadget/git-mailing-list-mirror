From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Wed, 27 Feb 2008 14:47:39 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271430130.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net> <alpine.LNX.1.00.0802261709180.19665@iabervon.org> <alpine.LSU.1.00.0802262239200.22527@racer.site>
 <alpine.LNX.1.00.0802261742260.19665@iabervon.org> <7vzltn2qsd.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802261933551.19665@iabervon.org> <7vy79718tn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:48:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSGL-00051t-0f
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbYB0Trn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbYB0Trn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:47:43 -0500
Received: from iabervon.org ([66.92.72.58]:32903 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbYB0Trm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:47:42 -0500
Received: (qmail 30403 invoked by uid 1000); 27 Feb 2008 19:47:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 19:47:39 -0000
In-Reply-To: <7vy79718tn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75291>

On Tue, 26 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > There's nothing in the documentation to suggest that you can use 
> > GIT_CONFIG to affect how the old repository is read, or that GIT_CONFIG 
> > doesn't affect the new repository. Actually, as far as I can tell, the 
> > configuration of a repository you're cloning (local or remote) doesn't 
> > matter at all. Note that GIT_DIR and GIT_WORK_TREE refer to the new repo, 
> > so it would be surprising for GIT_CONFIG to refer to the old one.
> 
> There was a bit of confusion in this discussion.
> 
> GIT_DIR the user may have in the environment may refer to the
> old reopsitory before "git clone" is invoked, but it should not
> matter at all, as the origin of the cloning comes from the
> command line and that is where we will read from.  The scripted
> version sets GIT_DIR for our own use to point at the new
> repository upfront and exports it, so we are safe from bogus
> GIT_DIR value the user may have in the environment.

Huh. I think there's a comment in some test or somewhere that made me 
think that "GIT_DIR=dest.git git clone foo" would write to dest.git 
instead of ./foo/.git, but your description here is accurate.

> GIT_WORK_TREE naming the new repository feels Ok, as you do not
> care about the work tree of the original tree when cloning, and
> you may want to have a say in where the work tree associated
> with the new repository should go.

We currently definitely support "GIT_WORK_TREE=work git clone something", 
pretty much explicitly on line 235 of git-clone.sh.

> GIT_CONFIG the user may have will refer to the old repository
> before "git clone" is invoked, as there is no new repository
> built yet.  But clone does not read from the old config, so "you
> can use GIT_CONFIG to read from old repository" may be true, but
> it does not matter.  We won't use it (we do _not_ want to use
> it) to read from the old configuration file.
> 
> We would however want to make sure that we write to the correct
> configuration file of the new repository and not some random
> other place, and that's where the environment variable in the
> scripted version comes into the picture.
> 
> In the scripted version, the only way to make sure which exact
> configuration file is updated is to set and export GIT_CONFIG
> when running "git config", so there are a few places that does
> exactly that (e.g. call to git-init and setting of core.bare).
> Unfortunately many codepaths in the scripted version are utterly
> careless (e.g. setting of remote."$origin".fetch); they should
> make sure that they protect themselves against GIT_CONFIG the
> user may have in the environment that point at random places.

Since it sets GIT_DIR, it also could simply unset GIT_CONFIG, and then 
everything would just write to the config file for the new GIT_DIR. On the 
other hand, if you have GIT_CONFIG exported in your environment, and you 
set up a repository with "git clone", and clone unsets or overrides 
GIT_CONFIG, then your new repository will immediately be unusable, because 
clone will set up the config file inside the new repository, but nothing 
you run after that will look in the new repository, since everything else 
obeys the GIT_CONFIG you still have set.

On the other hand, I don't see why any git command other than "git config" 
(run my the user directly) has any business looking at GIT_CONFIG, since 
it's only mentioned in the man page for git-config, and not in general for 
configuration, the wrapper, or other programs.

	-Daniel
*This .sig left intentionally blank*
