From: Junio C Hamano <gitster@pobox.com>
Subject: Re: newbie question
Date: Fri, 03 Jul 2009 12:22:49 -0700
Message-ID: <7vvdm9r2pi.fsf@alter.siamese.dyndns.org>
References: <e4a904790907031139rc61c2e0t6b9dbbc0c3dc379e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 21:23:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMoML-0006IP-2n
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 21:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759254AbZGCTWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759245AbZGCTWs
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 15:22:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42940 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250AbZGCTWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 15:22:46 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090703192250.DEQP25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Fri, 3 Jul 2009 15:22:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id BXNp1c00D4aMwMQ04XNpDU; Fri, 03 Jul 2009 15:22:49 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=n7VpOXHxuAFQ4qj51ocA:9
 a=wEPXcx6ZznPjPxSGxqEA:7 a=tGtOE_88JWCh5CnTkZVlu_y7e1IA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <e4a904790907031139rc61c2e0t6b9dbbc0c3dc379e@mail.gmail.com> (Alex K.'s message of "Fri\, 3 Jul 2009 11\:39\:45 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122707>

Alex K <spaceoutlet@gmail.com> writes:

> I would think the following simple pattern would be possible:
>
> Create two branches A and B. Switch to A, modify some files, do not
> commit to A, switch to B. Now B should not show any of the changes
> performed to A? However a git status while on B does show that the
> files on A have been modified. Is there something I am missing?

Yes, you are missing the basic concept of how git works and how to work
with git.

"Switch to A, modify some files, do not commit to A".

The modification does _not_ belong to A at this point yet.

Then you "switch to B."  At this point, you switched branches and carried
your modification along with you.  B does _not_ show any of the changes
performed to A, as you never committed to A yet.

What you see is the changes you performed to your _work tree_ (and your
_index_, if you are using it).

And this is a deliberately designed behaviour.  When you start hacking on
something, you often do not know many things a-priori, including

 - if the change is small and simple enough that you can finish it in a
   single sitting;

 - what is the oldest branch that the change is necessary

The former means that you may start working on a cool feature while you
have a checkout of your 'master' branch, but then you realize that the
necessary changes are much more involved than what you originally thought,
and you are better off building that feature on a new side branch while
you have to work on completing it, and in the meantime, you would want to
keep your 'master' branch clean, so you do _not_ want to commit any of
this work-in-progress there.  So the behaviour allows you to do this:

    $ hack hack hack ;# yeah, looking good
    $ hack hack      ;# oops, this is a bit more complex than I thought
    $ git checkout -b cool-feature
    $ hack more ;# good point to snapshot even though it is not complete
    $ git commit 
    $ hack even more ;# oops, boss tells me to fix something else right away
    $ git commit -a -m 'WIP' ;# I'll come back to it later
    $ git checkout master
    $ work test work test ;# handle boss's wish
    $ git commit -a -m 'Urgent fix'
    $ git push origin master ;# emergency handled well
    $ git checkout cool-feature
    $ hadk hack ;# continue working
    ...

Notice the third step where you switch to the branch cool-feature (newly
created).  You are taking your changes up to that point in your work tree
along with you when starting to work in that branch, and it is a good
thing.

The latter means that you may start fixing a bug while you have a checkout
of your 'master' branch, but then realize that the bug has existed from a
long time ago, and the same fix needs to go to your maintenance branch.
Again, the behaviour allows you to do this:

    $ fix test fix test ;# Ok, I think it is good.
    $ git blame HEAD -- broken.rb ;# where did this bug came from anyway?
    ... find the commit that introduced the bug from the above blame ...
    $ git branch --with $commit ;# on which branches is the bad commit in?
    ... realize that the maintenance branch also has the same bug ...
    $ git checkout maint
    $ test it again
    $ git commit ;# commit fix to the oldest applicable branch
    $ git checkout master
    $ git merge maint ;# and propagate it upwards

Again, notice that the "checkout" to switch to the 'maint' branch takes
the changes in your work tree along with you, and that is what allows you
to fix the bug in the oldest applicable branch.

It also happens that you notice an unrelated breakage while working on
something on a topic branch 'feature', and realize that the breakage is
grave enough that you should fix it on 'master' branch.  You would do
this:

    $ git checkout feature ;# let's do a cool feature
    $ edit feature.rb ;# yeah, looking good
    $ edit broken.rb ;# this is unrelated
    $ git checkout master
    $ git add broken.rb ;# only add the fix to the index
    $ git commit -m 'Fix' ;# never use "commit -a" when you do this
    $ git checkout feature ;# continue working

Again, because the changes to broken.rb (together with the changes to
feature.rb) are carried across branch switching, you can fix the buggy  
code on your master branch, and come back (again, taking the changes to
feature.rb with you) to continue.
