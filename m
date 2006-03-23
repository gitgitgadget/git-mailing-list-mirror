From: Andreas Ericsson <ae@op5.se>
Subject: Re: Best way to generate a git tree containing only a subset of commits
 from another tree?
Date: Thu, 23 Mar 2006 04:20:20 +0100
Message-ID: <442213F4.7040603@op5.se>
References: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>	<4421EF5F.3000601@op5.se> <7vu09q54a6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 23 04:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMGNF-0002lS-RW
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 04:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWCWDUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 22:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCWDUY
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 22:20:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:31687 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932290AbWCWDUX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 22:20:23 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4CCF46BCFE; Thu, 23 Mar 2006 04:20:20 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu09q54a6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17850>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
  >>If you have several topic branches, one for each series of commits,
>>you should be able to do an octopus, like so:
>>
>>   $ git pull . <topic-branches-to-publish>
> 
> 
> Octopus is orthogonal to the issue at hand.  Further, I suspect
> that the original repository by Anton is not that cleanly
> organized to have such topic branches -- otherwise the question
> would not have come up to begin with.
> 

<sidenote>
I've never understood what orthogonal means in this sense. "at a right 
angle" as in flagging for attention or the exactly counter-productive to 
what one should use?
</sidenot>

> 
>>If you *don't* have several topic branches, or if some commits aren't
>>in topic-branches, you could try something like this (untested,
>>although it shouldn't break anything except the for-linus branch which
>>you can re-create fairly simply)
>>
>>  $ for b in <topic-branches-for-linus>; do
>>      git checkout $b
>>      git rebase for-linus || (git reset --hard; echo $b >> to-merge)
>>    done
> 
> 
>>  # now merge what couldn't be rebased
>>  $ git checkout for-linus
>>  $ git pull . $(cat to-merge)
> 
> 
> Now you lost me here.  When rebase refuses because of
> conflicting changes, you are doing "reset --hard" but I suspect
> you meant "reset --hard ORIG_HEAD" to recover the original head.


I actually meant to reset the for-linus branch, although it would have 
to be reset to the state it was before trying the rebase, which means 
creating and deleting a tag or some other marker.

I really should install an alco-lock on my MUA.


> Further, I would have expected you to be rebasing on top of
> linus, not for-linus, in case you may already have pulled other
> topic branches into it.
> 

Perhaps. I said 'for-linus' to make sure there was an easy way to 
recover to state 1 in case of errors. I also rewrote the part above 
twice to account for topic branches, so it doesn't make much sense 
without the background thinking.


> Your merging those branches that have conflicting changes on top
> of for-linus (that starts out at Linus's tip) is sensible, but
> one word of caution is the history contained within the topic
> branch should be sane.  What are you going to do with branches
> that cleanly rebase on top of for-linus?
> 

Nothing. 'for-linus' should be updated each time a rebase completes 
success-fully, so all the cleanly rebased branches should be in a linear 
commit-history on top of each other. Granted, most projects won't have 
many topic-branches (or other commit-chains) that rebase on top of each 
other like that, but...

> 
>>... If your vanilla tree is up-to-date and he pulls
>>from you before pulling from someone else or adding other commits this
>>isn't necessary, although you'll have to do
>>
>>   $ git checkout linus; git pull . for-linus
>>
>>to get the vanilla branch up to speed with Linus' HEAD.
> 
> 
> I am not sure I follow you here.
> 
> If Linus hasn't pulled from you, you can either just keep asking
> (you do not have to update for-linus), or rebuild it based on
> more recent Linus's tip.
> 

What I meant was that the thing he has in "for-linus" will match what 
Linus has in "master" verbatim if Linus doesn't have commits on top of 
his "master" that aren't in Anton's "for-linus" (originating from 
"linus"). That sentence didn't make sense to me right now.

> 	$ git fetch linus ;# to update to Linus's tip
> 	$ git checkout for-linus
>         $ git reset --hard linus
> 
> If Linus has pulled from you, there is nothing more than the
> above for you to do.

The above command would reset the "for-linus" branch to the state it had 
before he applied all his changes. I meant that if he wants to track 
Linus' exact HEAD in some branch he could do that by tracking his own if 
the changes since merge-base are identical. I was clearly complicating 
things by mentioning such a highly conditional exception.


>  If you want to rebuild for-linus branch,
> (maybe because you fixed things in some of your topic branches),
> after the above, you could:
> 
>         $ git pull . this-topic
>         $ git pull . that-topic
>         ...
> 
> This is nicer to Linus _if_ your topics overlap with recent
> changes to the Linus's tree.  Otherwise you do not necessarily
> have to rebuild for-linus branch.
> 

But it's very nasty in case Linus has already pulled the changes, which 
was what I assumed he would have done.

I was most likely a bit diffuse. Everything else seems to be at the 
moment, and I like to blend in. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
