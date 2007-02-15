From: Nicolas Pitre <nico@cam.org>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 17:14:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702151651440.1757@xanadu.home>
References: <17876.51013.561979.431717@lisa.zopyra.com>
 <Pine.LNX.4.64.0702151557410.1757@xanadu.home>
 <17876.52962.662946.582507@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 23:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHot8-0007rR-Oj
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161486AbXBOWOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161489AbXBOWOw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:14:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59867 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161486AbXBOWOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:14:51 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDI00L42Z4QM470@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Feb 2007 17:14:51 -0500 (EST)
In-reply-to: <17876.52962.662946.582507@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39858>

On Thu, 15 Feb 2007, Bill Lear wrote:

> On Thursday, February 15, 2007 at 16:00:23 (-0500) Nicolas Pitre writes:
> >On Thu, 15 Feb 2007, Bill Lear wrote:
> >
> >> We are about to switch to git 1.5 from git 1.4.4.1.  I cannot remember
> >> if someone posted about this, but what is the danger of working on a
> >> tracking branch --- there are abundant cautions about doing this, but
> >> I can't recall and can't find the reason this is bad.
> >
> >A tracking branch is supposed to be a local mirror of what is available 
> >remotely.  If you commit local changes to it then you break that model.
> 
> Ok, so I break the model, what is the harm in that?  Can I no longer
> pull from or push to the remote branch?  Do I corrupt something
> locally?  Does something else break?  I'm trying to formulate an
> explanation to our users why the 1.5 way is superior and I can't just
> say "if you do that you break the model".

If you commit on top of a tracking branch, then you won't be ablt to 
update that branch with remote changes because the tracking branch will 
contain local changes that the remote doesn't have.  In other words, the 
remote end won't be able to determine the set of changes you are 
missing to send you only those missing changes.

At that point it is still possible to do the reverse, i.e. push your 
local changes to the remote then both local and remote branches will be 
in sync.  But that works only if the remote was not updated by someone 
else.  If the remote was updated by someone else, then you fall into the 
same situation as if you committed on top of a tracking branch and you 
try to fetch, because it is then impossible for you to determine what 
the remote is lacking since you won't find the remote changes in your 
local repository.  You are then stuck in a dead lock.

Now there is of course a way to force a push or a fetch even if the 
above scenarios occur.  But if you force the push then the remote 
changes that you don't have will be lost.  If you force a fetch then 
your local changes that the remote doesn't have will be lost.

This is why it is better to have a tracking branch that is modified only 
by fetching remote changes only.  When you make a local copy of that 
branch and commit changes to that work branch, then you can push those 
changes to update the remote branch.  And if the remote branch has 
changed then you have the possibility of updating the tracking branch 
with the remote changes you don't have yet, merge them into your local 
copy with your work, and reattempt the push.  But that works fine only 
if the tracking branch is always a subset of what the remote has.


Nicolas
