From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 20:48:42 +0000 (UTC)
Message-ID: <loom.20051020T220751-355@post.gmane.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com> <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com> <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 20 22:53:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EShNl-0003V3-HT
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 22:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVJTUvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 16:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVJTUvM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 16:51:12 -0400
Received: from main.gmane.org ([80.91.229.2]:30415 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932532AbVJTUvI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 16:51:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EShLW-0002rl-S4
	for git@vger.kernel.org; Thu, 20 Oct 2005 22:49:07 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 22:49:06 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 22:49:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10379>

Linus Torvalds <torvalds <at> osdl.org> writes:

> For those of us who have a separate branch to track the original (I call 
> mine "parent), this tells the story:
> 
> 	* refs/heads/parent: does not fast forward to branch 'master' of
master.kernel.org:/pub/scm/git/git;
> 	  not updating.

Yes, I screwed up.  One honest mistake and another stupid one.

Note that "those of us" above include everybody who did "git-clone" to
set up the repository and left the default "Pull: master:origin" line in
.git/refs/remotes/origin.

> Junio, please don't do that. It really screws people up. Now people can't 
> fetch your head any more, and can't track you, because your branch isn't 
> stable any more.

Sorry, and yes that was the "honest mistake" part.  I know I should never
rewind beyond what I already have pushed out, and usually I carefully follow
that rule.

But this time I forgot that I pushed something out and also failed to re-check
what I pushed out before rewinding (the check is done by fetching from
master.kernel.org myself).

And another stupid mistake part was when I pushed out the result.  send-pack
correctly refused to update the master side, but I forced it without much
thinking.

Sorry about these mistakes.

Having said that, all is not lost.  Your message made it sound like the
new head was completely re-rooted and there is no common commit (which
almost gave me a heart attack), but I do not think it is that bad.  It is
more like pulling from two places.

               -----(A) head merlyn and everybody
             /          pulled from kernel.org previously
  --- common ------------------------------------(B) head rebased and pushed
                                                     out by mistake

The "parent" head you described in your message is A above, and what is on
kernel.org is B.  A is known as "origin" in the default setup git-clone makes.

If you have *no* further development on top of (A), the recovery is simple.

   $ git checkout master ;# make sure you are on your "master" branch.
   $ git fetch origin +master:origin ;# force "origin" to be (B)
   $ git reset --hard origin ;# reset your "master" branch to (B)

If you had any further development on top of (A), then the graph would look
like:
               -----(A)---------------(X) your tip
             /
  --- common ----------------------(B)

The merge conflict message you got when you pulled is result of trying to
merge (X) and (B).

There are two things we could do.

One is to forward port your changes between (A) and (X) on top of (B):

   $ git checkout master ;# make sure you are on your "master" branch.
   $ git tag anchor-a origin ;# stash (A) away
   $ git fetch origin +master:origin ;# force "origin" to be (B)
   $ git checkout -b rescue-stupid-junio origin
   $ rm -fr .dotest
   $ git format-patch -k --stdout anchor-a..master | git am -k -3

Depending on the changes between A and X, forward porting may result in
conflicting/unapplicable patches.  The individual changes are found in
.dotest/ directory and you can re-run 'git am -i' after fixing up the
conflicts.

Then validate the tip of the result to make sure forward porting did not lose
your changes:

   $ git diff origin..rescue-stupid-junio

If the result look OK, then we can make this your master branch.

   $ git checkout master
   $ git reset --hard rescue-stupid-junio

and clean things up by

   $ rm -f .git/refs/tags/anchor-a
   $ git branch -d rescue-stupid-junio

Another thing we could do is to treat as if this stupid maintainer briefly
had a twin who did concurrent development, and merge (X) and (B).

   $ git checkout master
   $ git pull origin +master:origin

This, as Merlyn and you saw, probably would result in merge conflicts which
need to be resolved manually.

Unfortunately I do not have access right now to commits between "common" and
(A) in the above picture (I am at work), so I cannot try any of the above out
myself.
