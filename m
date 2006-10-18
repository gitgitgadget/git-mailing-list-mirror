From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 22:08:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610172140270.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
 <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
 <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 04:09:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0rj-0008G1-3r
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 04:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWJRCJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 22:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJRCJA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 22:09:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21979 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750823AbWJRCI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 22:08:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7B0021G7AXIMF0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 22:08:58 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29179>

On Tue, 17 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> > > 
> > > .. and it sorts _differently_ on a big-endian vs little-endian thing, 
> > > doesn't it?
> > 
> > Sure.  But who cares?  The sorting is just there to 1) perform binary 
> > searches on the list of deltas based from a given object, and 2) find a 
> > list of all deltas with the same base object.
> 
> _I_ care.

OK, So I do.

> The new code is messy. It's fragile, and already showed one very 
> fundamental bug which depended on architectures.

My stance is that it is not fragile.  Sure it had one bug that depended 
on an architecture difference, but so was commit ac58c7b18e about.

The code also has many consistency checks all over so that it doesn't 
write out garbage if such bugs arise.  And that fundamental bug was 
actually a trivial one that was caught right away by such consistency 
check.

> These things matter. We have had very few bugs in git, and one of the 
> reasons is (I believe) that we haven't had ad-hoc code. I get _very_ 
> nervous when you mix up SHA1 names with somethign totally different 
> without even a flag to say which one it is. That's just nasty.

But there _is_ a flag for damn sake.  Did you at least try to understand 
the code and not just skim over it from 10000 feet above?

It is really simple:

 - if the found union content matches with a reference union initialized 
   through the sha1 member then deltas[j].obj->type == OBJ_REF_DELTA 
   must be true.

 - if the found union content matches with a reference union initialized 
   through the sha1 member then deltas[j].obj->type == OBJ_OFS_DELTA 
   must be true.

 - For all deltas with deltas[j].obj->type == OBJ_REF_DELTA there can 
   not be more than one of them with the same union value.

 - For all deltas with deltas[j].obj->type == OBJ_OFS_DELTA there can 
   not be more than one of them with the same union value.

There is _no_ confusion possible.

> The fact that the code then behaves (and behave_d_) differently on 
> different architectures is just a sign of the problem.

Does this mean that, with your own change to xdiff that has just been 
committed, you actually created a "problem"?  Because this is a change 
that creates different behaviors whether a 32-bit or 64-bit architecture 
is used, Right?

But of course not.  We want it to behave differently on 64-bit than 
32-bit.  My code is in the _same_ camp since I explicitly want it to 
sort numbers differently whether it is a little endian or big endian 
machine.

So this is not a problem this is a feature, and very by design.

> "Who cares?" is not a good question to ask for a SCM. 

Please just try to understand why I'm claming this is not important in 
this very case.  Please do me this favor.


Nicolas
