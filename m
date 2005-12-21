From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to set up a shared repository
Date: Wed, 21 Dec 2005 22:36:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512212222430.18118@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512211919040.16640@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy82e5ftx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 22:36:56 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpBdk-0007YW-Ft
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 22:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVLUVgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 16:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVLUVgt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 16:36:49 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63913 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932159AbVLUVgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 16:36:48 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 84BEB13FC87; Wed, 21 Dec 2005 22:36:47 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 67FED9E268; Wed, 21 Dec 2005 22:36:47 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 469669E20A; Wed, 21 Dec 2005 22:36:47 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3BC7A13FC89; Wed, 21 Dec 2005 22:36:47 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy82e5ftx.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13902>

Hi,

On Wed, 21 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > A. Setting up the umask
> >
> > 1. Separate repository box
> >
> > If you are lucky enough that you can afford a separate machine for the 
> > shared repository: Good. Just make sure that the umask is set group 
> > friendly, either by ensuring that (assuming the login shell is bash) 
> > $HOME/.bash_profile contains the line
> >
> > 	umask 0002
> 
> I suspect a bash started from ssh noninteractive session does
> not read .bash_profile --- you may want to check.

Yes, you're right. But after all, this section was meant to put a little 
pressure on you to agree to core.umask ;-)

> > 2. Some server accessible by ssh
> >
> > 	git-repo-config core.umask 0002
> 
> Not yet ;-)

Well, it is a reality here ;-)

> > B. Making sure the index is not corrupted by a push
> >
> > 1. No checkout!
> >
> > You can use the shared repository just like you use CVS: no working 
> > directory. To disallow a checkout, just do
> >
> > 	touch .git/index
> > 	chmod a-rwx .git/index
> >
> > Every attempt to modify the index (which is invalid), will now result in 
> > an error.
> 
> Arrrgh....what a hack.  But it is a good hack.

It is the simplest way to achieve the goal (at least that I could think 
of). Thanks for the compliment!

> > 2. Ensure index and working directory consistency (no locking)
> >
> > If you want to be able to work on the project in the shared repository, 
> 
> I am very tempted to end this sentence with "please don't" ;-).

You are very welcome to do so!

Of course, the use case is git itself. I host a private version with all 
the goodies I like so much, and which you unfortunately do not like as 
much.

It is a phantastic way to keep git up to date without having to login 
manually. It is also a phantastic way to break the setup spectacularly 
when something goes wrong.

> > create hooks, as follows:
> 
> Your update hook looks sane if too strict.  I do not think of
> any reason to push and fast forward a branch that is not pointed
> at by .git/HEAD.  Not that I encourage pushing into a non-naked
> repository where an uncontrolled random development happens,
> though.

Is it too strict?

:        #!/bin/sh
:        
:        # if the working directory contains modifications, do not allow 
:        # push

This checks if the ref being pushed is the current HEAD:

:        HEAD=$(git-symbolic-ref HEAD)
:        case "$1" in
:        $HEAD)

Only if it is, this check occurs

:                unset GIT_DIR
:                cd .. && test -z "$(git-diff-index --name-only HEAD)";;
:        esac

IMHO this does exactly the right thing: Fail only if the ref to push is 
the current HEAD *and* something is not committed.

> > Note that I did not check if a push locks another push.
> 
> Although it does protect against stomping on each other by
> read/do-work/re-read-and-swap cycle, push does not lock. If you
> want to run a build from the post-update hook you need to
> serialize the build yourself.

Yes, I feared that much. Also note that in my dangerous setup, something 
could go awfully wrong because post-update is currently compiling git 
itself, while somebody else wants to use it.

So, more and more I think about it, I should not do it then. But for a few 
days, I am the only user!

Thanks,
Dscho
