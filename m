From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 17:21:12 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031705440.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqRO-0004NA-0W
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945958AbXDCVVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbXDCVVT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:21:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23624 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945958AbXDCVVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:21:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX000SFXZCI970@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 17:21:12 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43668>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 3 Apr 2007, Nicolas Pitre wrote:
> > > 
> > > Yeah. What happens is that inside the repo, because we do all the 
> > > duplicate object checks (verifying that there are no evil hash collisions) 
> > > even after fixing the memory leak, we end up keeping *track* of all those 
> > > objects.
> > 
> > What do you mean?
> 
> Look at what we have to do to look up a SHA1 object.. We create all the 
> lookup infrastructure, we don't *just* read the object. The delta base 
> cache is the most obvious one. 

It is caped to 16MB, so we're far from the 200+ MB count.

> > I'm of the opinion that this patch is unnecessary.  It only helps in 
> > bogus workflows to start with, and it makes the default behavior unsafe 
> > (unsafe from a paranoid pov, but still).  And in the _normal_ workflow 
> > it should never trigger.
> 
> Actually, even in the normal workflow it will do all the extra unnecessary 
> work, if only because the lookup costs of *not* finding the entry.
> 
> Lookie here:
> 
>  - git index-pack of the *git* pack-file in the v2.6/linux directory (zero 
>    overlap of objects)
> 
>    With --paranoid:
> 
> 	2.75user 0.37system 0:03.13elapsed 99%CPU
> 	0major+5583minor pagefaults
> 
>    Without --paranoid:
> 
> 	2.55user 0.12system 0:02.68elapsed 99%CPU
> 	0major+2957minor pagefaults
> 
> See? That's the *normal* workflow. Zero objects found. 7% CPU overhead 
> from just the unnecessary work, and almost twice as much memory used. Just 
> from the index file lookup etc for a decent-sized project.

7% overhead over 2 second and a half of CPU which, _normally_, happens 
when cloning the whole thing over a network connection which, if you're 
lucky and have a 6mbps cable connection, will still be spread over 5 
minutes of real time.  And that is assuming that you're cloning a big 
project inside itself which wouldn't work anyway.  Otherwise a big clone 
wound run index-pack in an empty repo where the lookup of exinsting 
object is zero.  Remains git-fetch which should concern itself with much 
smaller packs pushing this overhead in the noise.

> Now, in the KDE situation, the *unnecessary* lookups will be about ten 
> times more expensive, both on memory and CPU, just because the repository 
> is about 20x the size. Even with no actual hits.

So?  When would you really perform such an operation in a meaningful 
way?

The memory usage worries me.  I still cannot explain nor justify it.  
But the CPU overhead is certainly not of any concern in _normal_ usage 
scenarios, is it?

If anything that might be a good test case for the newton-raphson pack 
lookup idea.


Nicolas
