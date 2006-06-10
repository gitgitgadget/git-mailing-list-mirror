From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 10:36:12 +0200
Message-ID: <448A847C.20105@dawes.za.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org> <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org> <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com> <87y7w5lowc.wl%cworth@cworth.org> <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 10:36:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoyxG-0004nH-G5
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 10:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFJIgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 04:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWFJIgV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 04:36:21 -0400
Received: from sd-green-bigip-62.dreamhost.com ([208.97.132.62]:49614 "EHLO
	spunkymail-a17.dreamhost.com") by vger.kernel.org with ESMTP
	id S1750823AbWFJIgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 04:36:20 -0400
Received: from [192.168.201.67] (dsl-165-2-55.telkomadsl.co.za [165.165.2.55])
	by spunkymail-a17.dreamhost.com (Postfix) with ESMTP id 9DD8F738A2;
	Sat, 10 Jun 2006 01:36:14 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21601>

Linus Torvalds wrote:
> 
> On Fri, 9 Jun 2006, Carl Worth wrote:
> 
>> On Fri, 9 Jun 2006 22:21:17 -0400, "Jon Smirl" wrote:
>>> Could you clone the repo and delete changesets earlier than 2004? Then
>>> I would clone the small repo and work with it. Later I decide I want
>>> full history, can I pull from a full repository at that point and get
>>> updated? That would need a flag to trigger it since I don't want full
>>> history to come over if I am just getting updates from someone else's
>>> tree that has a full history.
>> This is clearly a desirable feature, and has been requested by several
>> people (including myself) looking to switch some large-ish histories
>> from an existing system to git.
> 
> The thing is, to some degree it's really fundamentally hard.
> 
> It's easy for a linear history. What you do for a linear history is to 
> just get the top commit, and the tree associated with it, and then you 
> cauterize the parent by just grafting it to go away. Boom. You're done.
> 
> The problems are that if the preceding history _wasn't_ linear (or, in 
> fact, _subsequent_ development refers to it by having branched off at an 
> earlier point), and you try to pull your updates, the other end (that 
> knows about all the history) will assume you have all the history that you 
> don't have, and will send you a pack assuming that.
> 
> Which won't even necessarily have all the tree/blob objects (it assumed 
> you already had them), but more annoyingly, the history won't be 
> cauterized, and you'll have dangling commits. Which you can cauterize by 
> hand, of course, but you literally _will_ have to get the objects and 
> cauterize the thing by hand.
> 
> You're right that it's not "fundamentally impossible" to do: the git 
> format certainly _allows_ it. But the git protocol handshake really does 
> end up optimizing away all the unnecessary work by knowing that the other 
> side will have all the shared history, so lacking the shared history will 
> mean that you're a bit screwed.

Here's an idea. How about separating trees and commits from the actual 
blobs (e.g. in separate packs)? My reasoning is that the commits and 
trees should only be a small portion of the overall repository size, and 
should not be that expensive to transfer. (Of course, this is only a 
guess, and needs some numbers to back it up.)

So, a shallow clone would receive all of the tree objects, and all of 
the commit objects, and could then request a pack containing the blobs 
represented by the current HEAD.

In this way, the user has a history that will show all of the commit 
messages, and would be able to see _which_ files have changed over time 
e.g. gitk would still work - except for the actual file level diff, "git 
log" should also still work, etc

This would also enable other optimisations.

For example, documentation people would only need to get the objects 
under the doc/ tree, and would not need to actually check out the 
source. Git could detect any actual changes by checking whether it has 
the previous blob in its local repository, and whether the file exists 
locally. Creating a patch would obviously require that the person checks 
out the previous version, but one could theoretically commit a new blob 
to a repo without having the previous one (not saying that this would be 
a good idea, of course)

This would probably require Eric Biederman's "direct access to blob" 
patches, I guess, in order to be feasible.

Regards,

Rogan
