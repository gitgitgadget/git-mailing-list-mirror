From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 04:50:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710310441530.4362@racer.site>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
 <Pine.LNX.4.64.0710310329520.4362@racer.site> <20071031041751.GA3326@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 05:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In5Yd-0006G3-PL
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 05:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbXJaEvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 00:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXJaEvq
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 00:51:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:34176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752578AbXJaEvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 00:51:45 -0400
Received: (qmail invoked by alias); 31 Oct 2007 04:51:43 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp043) with SMTP; 31 Oct 2007 05:51:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191W4kIiuZ1r0yr7WLWOzUeY/4xjbbe6qRj6UdRVJ
	mI3Knp2Rv9jpe/
X-X-Sender: gene099@racer.site
In-Reply-To: <20071031041751.GA3326@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62792>

Hi,

On Wed, 31 Oct 2007, Bj?rn Steinbrink wrote:

> On 2007.10.31 03:34:47 +0000, Johannes Schindelin wrote:
> 
> > On Wed, 31 Oct 2007, Bj?rn Steinbrink wrote:
> > 
> > > @@ -246,6 +292,13 @@ OPTIONS
> > >  	Instead of ignoring merges, try to recreate them.  This option
> > >  	only works in interactive mode.
> > >  
> > > +\--first-parent::
> > > +	Only follow the first parent commits in merge commits when looking
> > > +	for the commits that are to be rebased. This is most useful with -p
> > > +	as it will cause rebase to recreate the merges against the original
> > > +	branches instead of rebasing those branches as well. This option
> > > +	only works in interactive mode.
> > > +
> > 
> > Hmm.  I had to read this several times to understand it.  Maybe 
> > something like this instead?
> > 
> > \--first-parent::
> > 	When you want to preserve merges, this option allows you to rebase 
> > 	only the commits which were not merged in, i.e. which are in the
> > 	first parent ancestry of the current HEAD.
> > +
> > This option only makes sense together with --preserve-merges.
> 
> Hm, I think that it might make might sense without -p. Say that your 
> topic branch is following two other branches like this:
> 
> ---o---o---o--------o topicB
>             \        \
> --o---A---o---o---o---o---B topicA
>          /       /
> o---o---o---o---o master
> 
> topicB branched off from master earlier than topicA and you currently
> require stuff from master..topicB _and_ topicB..master, so AFAICT, you
> need sth. like the above.
> 
> Let's say that topicB simplifies some internal API and you desperately
> wanted to use that, while master introduced some new stuff that you also
> use. Now your stuff is finished, but it becomes obvious that topicB is
> still too broken to go into master any time soon. Then you could do:
> 
> git rebase -i --first-parent master topicA
> 
> to get:
> 
> --o---o---o topicB (branched from master somewhere to the left)
> 
>              o---o---o---A---B topicA
>             /
> ---o---o---o master
> 
> Depending on how much topicA really depends on topicB, you might need to
> fix a bunch of stuff, but it might be worth it.

Okay, I see now.

> How about:
> \--first-parent::
> 	When this option is given and --preserve-merges is not, then
> 	merge commits are completely ignored and only commits from the
> 	first parent ancestry are rebased. This allows to pretend that
> 	merges never happened.
> 
> 	If --preserve-merges is also given, the merge commits are
> 	preserved, but only their first parent is rebased as opposed to
> 	the default behaviour which would rebase all parents.

Okay.

> > Also, could you please add a test case to make sure that your patch 
> > works as advertised (and that this functionality will not be broken in 
> > future commits)?
> 
> Ok, might take some time, as I currently have no clue how the test stuff 
> for git works :-/ Well, I'm sure #git will be helpful :-)

Just have a look at t/t3404-rebase-interactive.sh.  The easiest way to 
proceed would be to read it from the end.  You'll see that every test case 
starts with "test_expect_success", followed by a message and a piece of 
shell code.

I usually enhance some existing test script instead of inventing a new 
one.

In your case, I would run t3404 by

	cd t
	sh t3404*

The working directory of these tests is in the subdirectory trash/ of t/.  
After one run of t3404, I would go there and look at what is there with 
gitk.

In your case, you want to have at least a few merges.  Build them up in 
the test case, using echo, git add, git commit and git checkout.  Then run 
an appropriate git rebase -i --first-commit [-p], and test that the 
outcome makes sense.

You need not test _everything_.  Just the differences with regards to 
normal rebase.  For example, that a side branch is _not_ rebased, but 
"git rev-parse HEAD~2^2" is the same as before the rebase.

And remember to connect all commands with && so that a failure in one 
command leads to the failure of the whole test case.

Hth,
Dscho
