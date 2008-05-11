From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] repack: modify behavior of -A option to leave
 unreferenced objects unpacked
Date: Sat, 10 May 2008 21:10:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805101157090.23581@xanadu.home>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
 <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
 <20080510060345.GC11556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: drafnel@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 03:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv06b-0002w3-Rf
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 03:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbYEKBK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 21:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbYEKBK6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 21:10:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35556 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYEKBK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 21:10:56 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0O00080JA5HWC0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 May 2008 21:10:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080510060345.GC11556@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81722>

On Sat, 10 May 2008, Jeff King wrote:

> Also, should --keep-unreachable be deprecated / removed?

Depends.  If it has no maintenance cost then we might as well keep it 
around.

> I still like Geert's suggestion of unpacking them to a _different_
> place. That helps to avoid spurious "gc --auto" invocations caused by
> too many prunable objects. Though it certainly doesn't solve it, and
> maybe that just needs to be fixed separately.

Having a separate location for objects seems clunky to me.

And the fundamental problem isn't solved indeed -- you may end up with 
many non expired unreachable loose objects already without packing them.

> Possibly the "gc --auto" test should be:
> 
>   - count objects; if too few, exit
>   - count unreachable loose objects; if too few, exit

Determining the number of unreachable objects is quite costly, packed or 
not.  So that isn't a good thing to do on every 'git gc --auto' 
invokation.

>   - run gc
> 
> That means having a lot of unreachable objects will still incur some
> extra processing, but not as much as a full repack. And it won't bug the
> user with a "you need to repack" message.

The auto gc performs incremental packing most of the time.  And that is 
way faster than figuring out which objects are unreachable.

For example, running 'git prune' in my Linux repo takes 16 seconds, even 
when there is nothing to prune.  Running 'git repack' (with no option so 
to perform an incremental repack) took less than 2 seconds to pack 541 
reachable objects that happened to be loose.

I'm now starting to wonder if there is a reason for keeping unreachable 
objects that used to be packed.  Putting --keep-unreachable aside for 
now, the only way an unreachable object could have entered a pack is if 
it used to be reachable before through the commit history or reflog.  
So if they're not reachable anymore, that's most probably because their 
reflog expired.  So what's the point for keeping them even longer?  
What's the reasoning that led to the creation of --keep-unreachable in 
the first place?


Nicolas
