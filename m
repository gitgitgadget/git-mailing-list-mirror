From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/5] reset: add option "--keep" to "git reset"
Date: Sat, 23 Jan 2010 05:18:28 +0100
Message-ID: <201001230518.29049.chriscool@tuxfamily.org>
References: <20100119042404.4510.48855.chriscool@tuxfamily.org> <20100119042602.4510.24100.chriscool@tuxfamily.org> <7vockqbq44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Daniel Convissor <danielc@analysisandsolutions.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 05:15:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYXPZ-0005YW-TQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 05:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab0AWEPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 23:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415Ab0AWEPk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 23:15:40 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40675 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab0AWEPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 23:15:38 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 50BF3818047;
	Sat, 23 Jan 2010 05:15:26 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 36C0681806B;
	Sat, 23 Jan 2010 05:15:22 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vockqbq44.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137809>

On mardi 19 janvier 2010, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The purpose of this new option is to discard some of the
> > last commits but to keep current changes in the work tree.
> >
> > The use case is when you work on something and commit
> > that work. And then you work on something else that touches
> > other files, but you don't commit it yet. Then you realize
> > that what you commited when you worked on the first thing
> > is not good or belongs to another branch.
> >
> > So you want to get rid of the previous commits (at least in
> > the current branch) but you want to make sure that you keep
> > the changes you have in the work tree.
>
> You did this:
>
> 	git checkout master
> 	work; git commit ; work; git commit ; work; git commit
> 	edit ; git add ; ... (but not commit)
>
> and noticed the three commits should not be on master but on a new
> branch.
>
> I think we currently teach users to do something like this:
>
> 	git stash
>         git branch topic
>         git reset --hard HEAD~3
>         git stash pop
>
> Instead you want to do this:
>
> 	git branch topic
>         git reset --keep HEAD~3
>
> Surely you halved the number of command involved, but is this really an
> improvement?  At least I can visualize (and more importantly, explain to
> new users) how the "stash, flip and unstash" works, why it is safe, and
> how to recover when "pop" stops in conflicts, but I have no confidence in
> explaining what "reset --keep" does and how to recover when it refuses to
> work to new users.

Of course new users should be told about "git stash" before being told 
about "git reset --keep" and "git reset --merge". These 2 options are 
mostly for advanced users who want shortcuts and are ready to learn a few 
more options to speed up some of their common tasks.

Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01), ended with:

-------------------
    Yes, yes, with a dirty tree you could always do

        git stash
        git reset --hard
        git stash apply

    instead, but isn't "git reset --merge" a nice way to handle one 
particular simple case?
-------------------

and I claim that the same is true for "--keep". It is just a nice way to 
handle one particular simple case.

> Another way to accomplish the same thing might be:
>
> 	git branch -m topic
>         git checkout -b master HEAD~3
>
> and with the same number of commands, conceptually it may be easier to
> understand than "reset --keep".  What you committed so far belongs to
> another branch "topic", so you name the current history that way, and
> then you switch branches with "checkout" that keeps your local
> modifications. It also opens the possibility of retrying with "-m" after
> checkout refuses to acti, to take the same mix-up risk CVS/SVN users
> have, if you are very confident that your local change conflicts only
> minimally with the change made on the topic and you can resolve them.

Sorry but I don't find that easier to understand. On the contrary I find 
awkward to have to rename the current branch first.

My first reaction when I realize that my current work belongs to another 
branch is just to create another branch with a good name, and then I try to 
find a way to make the new branch clean. It would be strange and perhaps a 
little bit unsafe, at least for me, to have to rename the current branch 
and then recreate it with some good content.

> Of course, when you are not interested in keeping the topmost commits at
> all, you either
>
> 	git stash ; git reset --hard HEAD~3 ; git stash pop
>
> or
>
> 	git reset --keep HEAD~3
>
> but even in this case, I think "stash, flip and unstash" is easier to
> explain, especially when teaching what to do if things go wrong.
>
> I dunno.  Is this really an useful addition that helps real-world
> workflows and is worth a five patch series, or is this just "because we
> can" patch?

I know that I will use the new option. At least I will use it much more 
than --merge that I never used at $dayjob, probably because I don't merge a 
lot of stuff.

Best regards,
Christian.
