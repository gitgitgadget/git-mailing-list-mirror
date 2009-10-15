From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
   HEAD  was
Date: Thu, 15 Oct 2009 18:29:26 +0200
Message-ID: <4AD74DE6.9010800@drmicha.warpmail.net>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>  <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>  <alpine.LNX.2.00.0910141509200.32515@iabervon.org>  <alpine.LFD.2.00.0910141616530.20122@xanadu.home>  <7v7huxbtbk.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.0910141647390.20122@xanadu.home>  <7vws2xa9lu.fsf@alter.siamese.dyndns.org>  <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151054190.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 18:36:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyTJe-0004nb-0T
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 18:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbZJOQaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933257AbZJOQaM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 12:30:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39995 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933246AbZJOQaL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Oct 2009 12:30:11 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DCF8AB229B;
	Thu, 15 Oct 2009 12:29:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 15 Oct 2009 12:29:34 -0400
X-Sasl-enc: hAaIpvAkdiCIwR9+XfJeBPTJc10QPNAxlGhWg6IUOr8C 1255624174
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 94D946B5E9;
	Thu, 15 Oct 2009 12:29:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091015 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <alpine.LNX.2.00.0910151054190.32515@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130399>

Daniel Barkalow venit, vidit, dixit 15.10.2009 17:36:
> On Thu, 15 Oct 2009, James Pickens wrote:
> 
>> On Wed, Oct 14, 2009 at 4:09 PM, Jeff King <peff@peff.net> wrote:
>>> That makes the most sense to me. If "git checkout" could write metadata
>>> into HEAD (or into DETACH_HEAD, as in Daniel's patch), then checkout
>>> could record an "ok to commit" bit. And could also be used to change it
>>> after the fact. E.g.:
>>>
>>>  $ git checkout --detach=commit origin/master
>>>  $ git commit ;# should be ok
>>>
>>>  $ git checkout --detach=examine origin/master
>>>  $ git commit ;# complain
>>>  $ git checkout --detach=commit HEAD
>>>  $ git commit ;# ok
>>>
>>> I guess something like "rebase" should detach with "ok to commit", since
>>> it is planning on attaching the commits later. I'm not sure about "git
>>> bisect". I guess probably it should be "not ok to commit" to be on the
>>> safe side, and then somebody can "git checkout --detach=commit" if they
>>> want to.
>>
>> How about not detaching the head at all if the user checks out any ref, and
>> reject commits if he checked out a tag or remote branch.  For example:
>>
>> $ git checkout origin/master
>> $ git status
>> # On branch origin/master
>> $ git commit ;# complain
>>
>> $ git checkout v1.0.1
>> $ git status
>> # On tag v1.0.1
>> $ git commit ;# complain
>>
>> $ git checkout v1.0.1^0 ;# detach
>> $ git commit ;# ok
>>
>> I think this would help the newbies and wouldn't cost the experts too much.
>> Checking out anything other than a plain ref would still detach the head, and
>> commits on a detached head would still be allowed.
> 
> I think reducing users' exposure to the "detached HEAD" state would just 
> make it take longer for them to find that state familiar.

Yep. Which is why I keep suggesting that git clone does not create any
local branches at all ;)

> It's not like the concept is actually very difficult or unusual. CVS has 
> it as "cvs checkout -r <something>" or "cvs checkout -D <something>"; SVN 
> has it as "svn checkout -r <something>". It was weird and scary in CVS if 
> you did it (it was "sticky tags", and you had to find a different option 
> to get back to normal), but SVN is easier ("svn checkout -r HEAD").

svn up -r HEAD

> I think the description used in CVS and SVN (and, I think, others) is that 
> you're not at the HEAD revision. I think they both account for the state 
> where you've checked out the revision by number that's the latest 
> revision, but you still can't grow the branch because you can't 
> simultaneously stay on r1000 (as requested explicitly) and add a new 
> commit.

I'd say the fundamental difference is that in CVS and SVN, there is
always only one "tip", which they call HEAD. This is also why revision
numbers make sense.

In git and hg there can be many tips (branch heads) from which to grow
the DAG. Heck, you can grow a new one from any commit ;)

> So maybe the right explanation is:
> 
> $ git checkout master; git branch
> * master
> $ git checkout origin/master; git branch
> * origin/master (not at head)

Ouch, please don't. HEAD has a completely different meaning in git. I
know you know, of course.

> $ git checkout 123cafe^5; git branch
> * 123cafe^5 (not at head)
> $ git checkout HEAD^2; git branch
> * 123cafe^5^2
> $ git commit; git branch
> * (temporary branch)
> 
> Then we can say that one way that git is different from SVN is that all 
> branches of other repositories are read-only, and you can't be at the 
> head when you're on them (because the head of those branches are in 
> different repositories); instead you grow the history locally, and you 
> tell the remote branch to adopt your history.

You can change your refs/remotes/origin/master, of course, it's just by
convention (for a good reason) that git treats them as read-only, and
porc. respects that.

git's branches are simply completely different, they're movable tags,
and I think that's one point new users *have* to grok. Once they're over
this then even detached heads are a natural thing.

>> Perhaps as an additional safety feature, Git could refuse to switch away 
>> from a detached head if the head isn't reachable from any ref
> 
> As far as I know, people don't actually seem to lose stuff this way. In 
> part, that's because they get scared before they get there; in part, 
> that's because they just don't think to go there; and in part, we tell 
> them how to recover stuff at that point (using the ref log or the sha1).

Maybe we just don't scare them enough yet :)

Michael
