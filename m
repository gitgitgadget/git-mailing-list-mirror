From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries
 too.
Date: Mon, 4 Jun 2007 08:20:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Childs <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 17:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvEMP-0007uX-Bo
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 17:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbXFDPUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755996AbXFDPUf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:20:35 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:57372 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755886AbXFDPUe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 11:20:34 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l54FKL10021186;
	Mon, 4 Jun 2007 08:20:23 -0700
In-Reply-To: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.812 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49106>



On Mon, 4 Jun 2007, Bryan Childs wrote:
> 
> 1) Due to the nature of our project, with multiple architectures
> supported, we strive to provide a binary build of our software with
> every commit to the subversion repository. This is so that we can
> provide a working firmware for the majority of our users that don't
> have the necessary know-how for cross-compiling and so forth.

Git has no problems with binaries, but I _really_ I hope that you don't 
actually want to check these binaries into the repository? You could do 
that, and the git delta algorithm might even be able to compress the 
binaries against each other, but it could still be pretty nasty.

And by "pretty nasty" I don't mean that git won't be able to handle it: I 
suspect it's no worse from a disk size perspective than SVN.  But since 
git is distributed, it means that everybody who fetches it will get the 
whole archive with whole history - it means that cloning the result is 
going to be really painful with tons of old binaries that nobody really 
cares about beign pushed around.

So I *hope* that you want to just have automated build machinery that 
builds the binaries to a *separate* location? You could use git to archive 
them, and you can obviously (and easily) name the resulting binary blobs 
by the versions in the source tree, but I'm just saying that trying to 
track the binaries from within the same git repository as the source code 
is less than optimal.

> 2) Unlike the Linux Kernel, which Linus uses as a prime example of
> something git is very useful for, the Rockbox project has no central
> figurehead for anyone to consider as owning the "master" repository
> from which to build the "current" version of the Rockbox firmware for
> any given target.

The kernel is really kind of odd in that it has just a single maintainer. 
That's usually the case only for much smaller projects.

And no, git is not at all exclusively *designed* for that situation, 
although it is arguably one situation that git works really well for. 

There is nothing to say that you cannot have shared repositories that are 
writably by multiple users. Anything that works for a single person works 
equally well for a "group of people" that all write to the same central 
git repo. It ends up not being how the kernel does things (not because of 
git, but because it's not how I've ever worked), but the kernel situation 
really _is_ pretty unusual.

So git makes everybody have their own repository in order to commit, but 
you can (and some people do) just view that as your "CVS working tree", 
and every time you commit, you end up pushing to some central repository 
that is writable by the "core group" that has commit access.

In *practice*, I suspect that once you get used to the git model, you'd 
actually end up with a hybrid scheme, where you might have a *smaller* 
core group with commit access to the central repository (in git, it 
wouldn't be "commit access", it would really be "ability to push", but 
that's a technical difference ratehr than anything conceptually huge), and 
members in that core group end up pulling from others.

But that would literally be once you have gotten used to the git model, 
and you can start out just totally emulating the old CVS/SVN model with a 
single central repository.

> 3) With a central repository, for which we have a limited number of
> individuals having commit access, it's easy for us to automate a build
> based on each commit the repository receives.

.. and that's exactly how you'd do it with git too. You wouldn't have a 
"commit trigger", but you'd have a "receive trigger", which triggers 
whenever somebody pushes to the central repository.

And that does mean that a developer might do a series of _five_ commits 
locally on his own machine, and they are totally invisible to everybody 
until he pushes to the central repository: and then the build will build 
just the top-most end result commit. So you'd not necessarily have a 
binary for _each_ commit, but:

 - you could (if you really wanted to) actually force people to always 
   send just one commit at a time. You could even enforce that in the 
   pre-receive triggers, so that people *cannot* push multiple commits at 
   a time.

   Quite frankly, I really don't think you want to go this way. I think 
   you want to perhaps _encourage_ people to send just one commit at a 
   time, but the much better model is the other choice:

 - realize that the git model tends to encourage many small commits 
   (because you *can* make commits without impacting others), so when you 
   fix something, or add a new feature, with git, you can do it as many 
   small steps, and then only "push" when it's ready.

   IOW, if you encourage people to do small step-wise changes, you 
   probably don't even *want* a build for each commit, you really want a 
   build for the case where "my feature is now ready, I'll push". So you'd 
   effectively get one build not per commit, but per "publication point".

But anyway, it really boils down to: you *can* use a distributed 
development model to emulate a totally centralized situation (put another 
way: "centralized" is just one very trivial special case of 
"distributed"), but I suspect that while you might want to start out 
trying to change as little as possible in your development model, I 
equally strongly suspect that you'll find out that the distributed nature 
makes _some_ changes to the model very natural, and you'll end up with 
more of a hybrid setup: aspects of a centralized model, but with 
distributed elements.

		Linus
