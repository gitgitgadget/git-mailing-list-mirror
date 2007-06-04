From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries
 too.
Date: Mon, 4 Jun 2007 09:23:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> 
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Childs <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvFLI-0006E8-D9
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbXFDQXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756780AbXFDQXV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 12:23:21 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:48924 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756648AbXFDQXU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 12:23:20 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l54GNDZN024006;
	Mon, 4 Jun 2007 09:23:15 -0700
In-Reply-To: <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49114>



On Mon, 4 Jun 2007, Bryan Childs wrote:
> 
> Oh lord no - I never meant to imply that we'd be checking those
> binaries in, I just meant to hi-light that we need a central
> repository to build those binaries from

Heh. I get worried (and judging from other responses, I wasn't the only 
one) when people start talking about generated binaries and SCM's.

Because people _have_ traditionally done things like commit the generated 
files too. 

But if it's just an automated build server, everything is good. That's 
trivial to do.

> > In *practice*, I suspect that once you get used to the git model, you'd
> > actually end up with a hybrid scheme, where you might have a *smaller*
> > core group with commit access to the central repository (in git, it
> > wouldn't be "commit access", it would really be "ability to push", but
> > that's a technical difference rather than anything conceptually huge), and
> > members in that core group end up pulling from others.
> 
> This sounds like what we eventually came up with. I'm not sure how
> soon we'll make a switch to a git repository, but when we do, this
> seems to be the best model for the conversion in the short term, and
> perhaps in the long term too.

Yes. As mentioned, the kernel model of having just one person push is 
actually fairly rare. 

When you have multiple people pushing, you have issues that I never have, 
but that you've already seen with CVS/SVN, for all the same reasons: you 
may need to merge the changes that others have done while you were working 
on yours.

However, the git "push" model is *different* from the CVS/SVN "commit" 
model.

In CVS/SVN, if you want to commit, and somebody else has done updates to 
the central repository, the "cvs commit" phase will obviously tell you 
that you're not up-to-date, and you cannot commit at all. So you end up 
doing a "cvs update -d" equivalent to first update your tree, then you 
have to resolve any conflicts, and then you can try to commit again.

In git, this is technically very different, yet similar. Since you can 
always commit to your *local* repository, when you do a "git commit", 
you'll never have any conflicts at all, because there is no conflicting 
work!

But the conflicts happen when you then do a "git push" to send out your 
commit(s) to the central repository. If nobody else has done any changes, 
at that point, you'll get exactly the same kind of situation as when you 
do a CVS commit, and the server will tell you that you're not up-to-date, 
and will refuse to take your push.

(The message is different: git will tell you that you try to push a commit 
that is not a "strict superset" of what the central repository has).

So when that happens with git, you actually have two different options:

 - you can do "git pull" to merge the central changes, and in that case 
   you get the exact same kinds of conflict markers for any conflicting 
   code that you would have gotten for "cvs update"

   This is how most people would probably use it, and it's the simplest 
   one, where you get very traditional commit conflict markers, fix it up, 
   and commit the merge. 

   However, it does end up making the history explicitly showing the 
   parallelism that happened, and while that is *correct* and can be very 
   useful, sometimes it means that especially if you've done just trivial 
   changes, you might want to take an alternate approach that "linearizes" 
   the history and makes it appear linear instead of parallel:

 - instead of doing a "git pull" that merges the two branches (your work, 
   and the work that happened by somebody else in the central repo while 
   you did it), you *may* also just want to do a "git fetch" to fetch the 
   changes from the central repo, and then do "git rebase origin" to 
   linearize the work you did on _top_ of those central repo one (so that 
   it no longer looks like a branch, and looks linear)

   In the "git rebase" case, you'll effectively merge your commits one at 
   a time, and you may thus have to fix up *multiple* conflicts. So it's 
   potentially more work, but it results in a simpler history if you want 
   it.

Regardless of how you ended up sorting out the fact that you had parallel 
development, once you've resolved it, you do a "git push" again, and now 
the stuff you're pushing is a proper superset of what the central 
repository had, so it will happily push it out.

(Of course, the exact same thing that can happen with CVS central 
repositories can happen with git ones too: by the time you've resolved all 
the differences and are ready to push them to the central one, somebody 
else might have pushed *more*, and you may need to do another "update" ;)

> Yes, after I'd sent my email this morning I found you could do pushes
> as well as pulls. That'll teach me to RTFM properly next time.

I think we talk a lot more about pulls, because we have had more people 
ask about them, and because more people tend to pull than to push.

The pull is also somewhat easier to explain. The pushing thing always has 
to talk about resolving differences when different people have pushed, so 
teaching people to push by necessity involves first teaching them about 
merging (ie pull or rebase).

Also, "push" is also a bit more interesting to explain, because a "push" 
won't update the working tree on the other end, so when you explain 
pushing, you should also explain about "bare" repositories (which I didn't 
do)), ie about having git repositories without any working tree associated 
with them.

So there is a bit of a learning experience involved, but espeically if 
some of the developers have seen git used in other environments (perhaps 
not as developers, just as users), it shouldn't be *that* hard to pick up. 
But there does seem to be a pretty big mental leap from the "centralized" 
thing to the "distributed" thing - I just moved over so long ago that I 
even have trouble understanding why people sometimes don't seem to find 
the distributed model the only natural and sane thing to do.

(It really does seem to be one of those "aha!" moments. People think 
distributed just adds a lot of complexity, and it takes a "Oh, *THAT* is 
how it works" kind of enlightenment to just switch your brain over, and I 
guarantee that once that moment on enlightenment hits, you'll never go 
back, but I cannot guarantee that that moment will happen for all 
developers ;)

		Linus
