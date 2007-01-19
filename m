From: Junio C Hamano <junkio@cox.net>
Subject: Re: Decoding git show-branch output
Date: Fri, 19 Jan 2007 14:26:50 -0800
Message-ID: <7v64b2fyad.fsf@assigned-by-dhcp.cox.net>
References: <17840.50115.999227.260259@lisa.zopyra.com>
	<8aa486160701190613j6493daccofc259a8b17c0f1d1@mail.gmail.com>
	<17841.13791.627478.602602@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82CQ-0006RE-0u
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXASW0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbXASW0w
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:26:52 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50944 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939AbXASW0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:26:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119222651.PMNC7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 17:26:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DAT81W0011kojtg0000000; Fri, 19 Jan 2007 17:27:08 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17841.13791.627478.602602@lisa.zopyra.com> (Bill Lear's message
	of "Fri, 19 Jan 2007 15:19:27 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37213>

Bill Lear <rael@zopyra.com> writes:

> master~3 ^2 ~2
>
> Means the 2nd (first generation) parent of the second parent of the
> 3rd (first generation) parent?  Is there a way to simply state this in
> plain words, say in terms of commits/merges?

You had one commit (master~3^2~2).  You built one commit on top
of it (master~3^2~1) and another (master~3^2).

That one was merged into something else as the second parent,
and the merge result is master~3 (that "something else" is
master~4 aka master~3^ aka master~3^1).

You built three commits on top of that, and that is where your
master currently is.

> I'm unsure how to
> interpret the above, especially since none of us has been developing
> on a branch (I see no other branch names except master, also).

But you are.  Each repository are independent and the branches
your developers have, even though each of them have only one,
are separate branches.  You are exercising the distributedness
of git development model.

> I'm not sure if this is sane: is it ok to clone the company repo,
> then push from that clone into a bare repo, then from there to
> the company one?

That's essentially everybody doing distributed development does
in git land -- it is very sane.

> Is git doing some sort of weird, silent pseudo-merge
> that we don't understand, thus generated what appears to be a very
> tangled, albeit brief, history, when we examine it?

I do not think so, but the person creating a commit may first be
pulling from the central location, which needs a merge and
results in one.  That's very common in centralized workflow
modelled after how CVS is used.

Let's say you have the central (perhaps bare but it does not
matter if it is bare or not) repository and two workers, Alice
and Bob.  They both clone from it and make one commit each in
their repositories.  The commit ancestries in the entire world
would look like this:

          .---o Alice's 'master'
         /
 ---o---o-------o Bob's 'master'
        ^
        central repo's 'master'

Then Bob pushes to the central repo.  Since it is a
fast-forward, his push is accpeted and the picture would become
like this:

          .---o Alice's 'master'
         /
 ---o---o-------o Bob's 'master'
                ^
                central repo's 'master'

When Alice wants to push her changes back to the central repo,
it is not a fast-forward and is refused.  We currently suggest
Alice to first pull from the central repo (this is how CVS is
used -- you try "cvs commit" and get complaints, then you say
"cvs update" and retry).

What happens is that in Alice's repository, if Bob's change and
Alice's change does not conflict, this "pull" creates a merge
commit.

          .---o---o Alice's 'master'
         /       /
 ---o---o-------o Bob's 'master'
                ^
                central repo's 'master'

Then Alice can push out her changes.

          .---o---o Alice's 'master' == central repo's 'master'
         /       /
 ---o---o-------o Bob's 'master'
                
If Bob pulls from the central repo at this point, it will also
fast-forward and these three repositories end up with


          .---o---o Alice's 'master' == central repo's 'master'
         /       /  == Bob's 'master'
 ---o---o-------o

One thing you _could_ do is to train your users to rebase after
push fails, if you do not want these merges.

After her push fails here...

          .---o Alice's 'master'
         /
 ---o---o-------o Bob's 'master'
                ^
                central repo's 'master'

Alice could rebase by:

	$ git fetch
	$ git rebase origin

The first "git fetch" (if Alice is using the default
configuration created by recent "git clone") fetches from the
central repo and stores the 'master' branch at the central repo
as her tracking branch (.git/refs/remotes/origin/master).  This
can be referenced on the command line as 'origin' (again, if
Alice is using the default configuration created by recent "git
clone").  What these commands do is:

(1) git-fetch makes central repo's 'master' locally available to
    Alice as 'origin'

          .---o Alice's 'master'
         /
 ---o---o-------o Bob's 'master'
                ^
                central repo's 'master' == Alice's 'origin'

(2) git-rebase forward ports the commits on Alice's 'master'
    since it forked from the central repo, and creates this
    graph:


                  .---o Alice's 'master', updated
                 /
 ---o---o-------o Bob's 'master'
                ^
                central repo's 'master' == Alice's 'origin'

After these, 'master' in Alice's repository is a fast-forward
and she can now push to update the central repository.

It would be usually a good idea to rebase if Alice's work is
trivial since she synchronized with the central repository the
last time.  If it is a very involved changes, however, it often
is not worth worrying about keeping merges out of the history.
Your developers _are_ working in parallel and there is not much
point in insisting to lineralize the history too much.
