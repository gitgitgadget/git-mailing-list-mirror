From: Nicolas Pitre <nico@cam.org>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 19:16:15 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803191910170.2947@xanadu.home>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 00:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7Wz-0006vh-3U
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 00:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937539AbYCSXQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbYCSXQT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 19:16:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45875 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937507AbYCSXQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 19:16:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JY000KSG3B34C11@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 19:16:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77586>

On Wed, 19 Mar 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Wed, 19 Mar 2008, Junio C Hamano wrote:
> >> 
> >> Having said that, I am not sure how the auto gc is triggering for your
> >> (presumably reasonably well maintained) repository that has only small
> >> number of loose objects.  I haven't seen auto-gc annoyance myself (and
> >> git.git is not the only project I have my git experience with), and Linus
> >> also said he hasn't seen breakages.
> >
> > I think it was 'autopacklimit'.
> >
> > I think the correct solution is along the following lines:
> >
> >  - disable "git gc --auto" entirely when "gc.auto <= 0" (ie we don't even 
> >    care about 'autopacklimit' unless automatic packing is on at all)
> >
> >    Rationale: I do think that if you set gc.auto to zero, you should 
> >    expect git gc --auto to be disabled.
> 
> Sensible, I would say.

Seconded.

> >  - make the default for autopacklimit rather higher (pick number at 
> >    random: 50 instead of 20).
> >
> >    Rationale: the reason for "git gc --auto" wasn't to keep things 
> >    perfectly packed, but to avoid the _really_ bad cases. The old default 
> >    of 20 may be fine if you want to always keep the repo very tight, but 
> >    that wasn't why "git gc --auto" was done, was it?
> 
> I do not think "very tight" was the reason, but on the other hand, my
> personal feeling is that 20 was already 10 too many pack idx files we have
> to walk linearly while looking for objects at runtime.

Since commit f7c22cc68ccb this is no longer such an issue.

> Each auto gc that sees too many loose objects will add a new packfile (we
> do not do "repack -a" for obvious reasons) that would hopefully contain
> 6-7k objects, so you would need to generate 120-140k objects before
> hitting the existing 20 limit.
> 
> And then auto gc will notice you have too many packs, and "repack -A" to
> pack them down in a single new pack, and you are back to "single pack with
> less than 6-7k loose objects" situation for the cycle to continue.
> 
> At least, that is the theory.

Note that the current fetch.unpackLimit might play a role as well, 
especially if you fetch often (often meaning that you're more likely to 
have the received pack exploded into loose objects, or you're 
accumulating many small packs).


Nicolas
