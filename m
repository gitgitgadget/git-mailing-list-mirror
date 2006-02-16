From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Wed, 15 Feb 2006 22:41:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602152226130.5606@localhost.localdomain>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
 <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 04:41:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9a1P-0008Gs-BW
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 04:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBPDl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 22:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWBPDl0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 22:41:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29605 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932137AbWBPDlZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 22:41:25 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUR0000IGX00AB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Feb 2006 22:41:25 -0500 (EST)
In-reply-to: <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16266>

On Wed, 15 Feb 2006, Junio C Hamano wrote:

> When generating a new pack, notice if we have already the wanted
> object in existing packs.  If the object has a delitified
> representation, and its base object is also what we are going to
> pack, then reuse the existing deltified representation
> unconditionally, bypassing all the expensive find_deltas() and
> try_deltas() routines.
> 
> Also, when writing out such deltified representation and
> undeltified representation, if a matching data already exists in
> an existing pack, just write it out without uncompressing &
> recompressing.

Great !

> Without this patch:
> 
>     $ git-rev-list --objects v1.0.0 >RL
>     $ time git-pack-objects p <RL
> 
>     Generating pack...
>     Done counting 12233 objects.
>     Packing 12233 objects....................
>     60a88b3979df41e22d1edc3967095e897f720192
> 
>     real    0m32.751s
>     user    0m27.090s
>     sys     0m2.750s
> 
> With this patch:
> 
>     $ git-rev-list --objects v1.0.0 >RL
>     $ time ../git.junio/git-pack-objects q <RL
> 
>     Generating pack...
>     Done counting 12233 objects.
>     Packing 12233 objects.....................
>     60a88b3979df41e22d1edc3967095e897f720192
>     Total 12233, written 12233, reused 12177
> 
>     real    0m4.007s
>     user    0m3.360s
>     sys     0m0.090s
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * This may depend on one cleanup patch I have not sent out, but
>    I am so excited that I could not help sending this out first.
> 
>    Admittedly this is hot off the press, I have not had enough
>    time to beat this too hard, but the resulting pack from the
>    above passed unpack-objects, index-pack and verify-pack.

In fact, the resulting pack should be identical with or without this 
patch, shouldn't it?

FYI: I have list of patches to produce even smaller (yet still 
compatible) packs, or less dense ones but with much reduced CPU usage.  
All depending on a new --speed argument to git-pack-objects.  I've been 
able to produce 15-20% smaller packs with the same depth and window 
size, but taking twice as much CPU time to produce. Combined with your 
patch, one could repack the object store with the maximum compression 
even if it is expensive CPU wise, but any pull will benefit from it 
afterwards with no additional cost.

I only need to find some time to finally clean and re-test those 
patches...


Nicolas
