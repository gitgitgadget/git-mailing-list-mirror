From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: 1.5.0.rc1.g4494: Can't use a bare GIT_DIR to add
Date: Fri, 12 Jan 2007 17:15:11 -0300
Message-ID: <200701122015.l0CKFB8j022355@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5SoA-0002D0-0T
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbXALUPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXALUPX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:15:23 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37262 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030226AbXALUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:15:22 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0CKFBq6024032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Jan 2007 17:15:16 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0CKFB8j022355;
	Fri, 12 Jan 2007 17:15:11 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Fri, 12 Jan 2007 09:56:48 -0800." <7vzm8ot9gf.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 12 Jan 2007 17:15:16 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2437/Thu Jan 11 20:59:09 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36701>

Junio C Hamano <junkio@cox.net> wrote:
> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
> 
> > I tried this:
> >   
> >   mkdir xyz
> >   cd xyz
> >   git --git-dir=../xyz.git   
> >      # Initialized empty Git repository in ../xyz.git/
> >   echo Junk > file-a
> >   git --git-dir=../xyz.git add .
> >      # fatal: add cannot be used in a bare git directory
> >
> > I expected that "GIT_DIR is bare, over there, stuff is here" works the same
> > as "GIT_DIR is .git, right here among stuff".

> Sheesh, why didn't you speak out earlier while the discussion
> was on (I am not serious, git mailing list is still moving too
> fast for people to be always on top of)?

Because I just noticed :-(

> Now, seriously.

[...]

> You said "I tried".  Is this something you do in real life?

There was a discussion going on about importing several tarballs (one
version after the other) into git. If you want to just export the result,
not futz around in it, it leads naturally to doing something like:

  mkdir /base/test.git
  cd /base/test.git; git --bare init
  for v in 0.8.0.99 0.99a 0.99b 1.0 1.1 1.2.0 1.2.1 1.2.2; do
    cd /work
    tar zxf test-$v.tar.gz
    cd test-$v
    git --git-dir=/base/test.git add .
    git --git-dir=/base/test.git commit -a "Version $v"
    git --git-dir=/base/test.git tag v$v
    cd /work
    rm -rf test-$v
  done

> This _is_ a regression, as we are checking something we did not
> check before and refusing to work in cases where we did.  But I
> am not sure if reverting to lift the safety (for that matter,
> introducing the third "depends" alternative) is better than the
> latest behaviour.

It grates me somewhat that there isn't a clean way of saying "My .git stuff
is over there". No big deal, really.

And it is not a "depends", AFAICS: GIT_DIR says where to stash stuff, users
had better know what they are doing in that case... so perhaps allow
anything if GIT_DIR is set?

> For one thing, you could (sometime before the "git add ." and do
> this only once) do:
> 
> 	$ ln -s ../xyz.git .git
> 
> and that would make all the future git operation work without
> the --git-dir parameter (or GIT_DIR environment) in xyz
> directory.  An added benefit is that it would even allow git
> command to work from a subdirectory of xyz (specifying GIT_DIR
> or --git-dir means you are bypassing the discovery for the top
> of the working tree, so you have to always be at the top).

For this particular case this is no real help.

But no big deal to me. Still trying to wrap my brain aound git, that's all.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
