From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 16:51:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1107201538590.21187@xanadu.home>
References: <20110718114834.12406.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: anthonyvdgent@gmail.com, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 22:55:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjdnd-0004ag-Lh
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 22:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab1GTUvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 16:51:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63873 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1GTUvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 16:51:41 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mr-mrz22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LON00JL4GM4JZE0@vl-mr-mrz22.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 Jul 2011 16:51:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110718114834.12406.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177547>

On Mon, 18 Jul 2011, George Spelvin wrote:

> Storing the generation number inside the commit means that a commit
> with a generation number has a different hash than a commit without one.
> This means that people won't want to break the hashes of existing commits
> by adding them.  In many cases, ever.
> 
> Which means that git will have to be able to work without the generation
> numbers forever.

I've been diverting myself from $day_job by reading through this thread.  
Still, I couldn't make my mind between having the generation number 
stored in the commit object or in a separate cache by reading all the 
arguments for each until now. Admittedly I'm not as involved in the 
design of Git as I once was, so my comments can be considered with the 
same proportions.

Obviously, with a perfect design, we would have had gen numbers from the 
beginning.  But we did mistakes, and now have to regret and live with 
them (and yes I have my own share of responsibility for some of those 
regrets which are now embodied in the Git data format).

> If the generation numbers are stored in a separate data structure that
> can be added to an existing repository, then a new version of git can
> do that when needed.  Which lets git depend on always having the the
> generation numbers to do all history walking and stop using commit date
> based heuristics completely.

To me this is the killer argument.  Being able to forget about the 
broken date heuristics entirely and simplify the code is what makes the 
external cache so fundamentally better as it can be applied to any 
existing repositories.  And it has no backward compatibility issues as 
old Git version won't work any worse if they can't make any usage of 
that cache.

The alternative of having to sometimes use the generation number, 
sometimes use the possibly broken commit date, makes for much more 
complicated code that has to be maintained forever.  Having a solution 
that starts working only after a certain point in history doesn't look 
eleguant to me at all.  It is not like having different pack formats 
where back and forth conversions can be made for the _entire_ history.

And if you don't care about graft/replace then the cached data is 
immutable just like the in-commit version would, so there is no 
consistency issues.  If you do care about graft/replace (or who knows 
what other dag alteration scheme might be created in 5 years from now) 
then a separate cache will be required _anyway_, regardless of any 
in-commit gen number.

So to say that if a generation number is _really_ needed, then it should 
go in a separate cache.  Saying that if we would have done it initially 
then it would have been inside the commit object is not a good enough 
justification to do it today if it can't be applied to the whole of 
already existing repositories and avoid special cases.

I however have not formed any opinion on that fundamental question i.e. 
whether or not gen numbers are worth it in today's conditions. Neither 
did I think about the actual cache format (I don't think that adding it 
to the pack index is a good idea if grafts are to be honored) which 
certainly has bearing on that fundamental question too.

But I don't see the point of starting to add them now to commit objects, 
even if we regret not doing it initially, simply because having them 
appear randomly based on the Git version/implementation being used is 
still much uglier than some ad hoc cache or even not having them at all.


Nicolas
