From: Nicolas Pitre <nico@cam.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Fri, 04 Apr 2008 09:11:34 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0804040844470.2947@xanadu.home>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
 <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
 <m3tziita2y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Roman Shaposhnik <rvs@Sun.COM>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 15:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhlii-0004Lm-Cn
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 15:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762761AbYDDNLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 09:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763093AbYDDNLi
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 09:11:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25154 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763067AbYDDNLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 09:11:36 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JYS00JYAXZAJ6F0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 Apr 2008 09:11:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3tziita2y.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78802>

On Thu, 3 Apr 2008, Jakub Narebski wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Thu, 3 Apr 2008, Roman Shaposhnik wrote:
> >> 
> >> The last item (trees) also seem to take the most space and the most 
> >> reasonable explanation that I can offer is that NetBeans repository has 
> >> a really weird structure where they have approximately 700 (yes, seven 
> >> hundred!) top-level subdirectories there. They are clearly 
> >> Submodules-shy, but that's another issue that I will need to address 
> >> with them.
> > 
> > Trees taking the biggest amount of space is not unheard of, and it may 
> > also be that the name heuristics (for finding good packing partners) could 
> > be failign, which would result in a much bigger pack than necessary. 
> > 
> > So if you already did an aggressive repack like the above, I'd happily 
> > take a look at whether maybe it's bad heuristics for finding tree objects 
> > to pair up for delta-compression. Do you have a place where you can put 
> > that repo for people to clone and look at? 
> 
> Hmmm... I wonder if it would be the case that would speed-up
> development of pack v4.

Not really.  Pack v4 won't magically shrink a repository to less than 
half the pack v3 size.

I think we're simply facing the same situation as with the initial GCC 
repository which shrank from 3GB down to 300MB or so due to misfitted 
repacking parameters.

> If I remember correctly one of bigger changes
> was the way trees were represented in pack; the biggest improvement
> was for trees.

Yes, but that wasn't really so much about size but rather access speed 
by not deflating them. The pack v4 tree representation would certainly 
help, of course, but I suspect that simply repacking with more 
aggressive window/depth arguments would be even more effective in this 
case.

> One of bigger hindrances, as I understand it, in developing pack v4
> was the fact that it didn't offer that much of improvement in typical
> cases for the work needed... but perhaps "your" repository would be
> good showcase for pack v4.

The biggest hindrance for pack v4 is actually the lack of a native 
runtime tree walking, and having both tree object formats properly and 
optimally abstracted has not been looked at yet.

Speed is the primary goal for pack v4.  The fact that it also provides a 
10% pack reduction is only consequential.  But without native tree 
walking we must recreate the legacy tree format on the fly each time a 
tree object is loaded which dwarfs any improvements pack v4 is aiming 
for (yes it is still a little bit faster than pack v3 nevertheless, but 
not yet significantly enough to overcome the incompatibility costs).


Nicolas (who wishes he was still a student with plenty of hacking time)
