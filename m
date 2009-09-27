From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Sat, 26 Sep 2009 22:26:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909262140280.4997@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
 <4ABD9C2C.60800@redhat.com> <4ABE1818.6010007@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Sun Sep 27 04:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrjXE-0003P2-VE
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 04:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbZI0C03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 22:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZI0C03
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 22:26:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52198 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZI0C03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 22:26:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQL005PFYS8EG90@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 Sep 2009 22:26:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4ABE1818.6010007@redhat.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129192>

On Sat, 26 Sep 2009, Jason Merrill wrote:

> On 09/26/2009 12:44 AM, Jason Merrill wrote:
> > git config remote.origin.fetch 'refs/remotes/*:refs/remotes/origin/*'
> > git fetch
> 
> git count-objects -v before:
> 
> count: 44
> size: 1768
> in-pack: 1399509
> packs: 1
> size-pack: 600456
> prune-packable: 0
> garbage: 0

I'm sure if you had done 'git rev-list --all --objects | wc -l' at that 
point, the result would have been something around 900000.  That's the 
actual number of objects git had a reference to, compared to the total 
objects contained in the object store.

> and after (transferred 278MB):
> 
> count: 44
> size: 1768
> in-pack: 1947339
> packs: 2
> size-pack: 1178408
> prune-packable: 8
> garbage: 0

And those 500000 extra objects or so (minus a couple dozens which were 
probably used to "complete" the fetched thin pack and are duplicates of 
local objects -- the fetch progress message gave the exact number) were 
obtained from the remote repository because git has no way to tell the 
remote it already had them.  That's what I was explaining in my previous 
email.

> and then after git gc --prune=now:
> 
> count: 0
> size: 0
> in-pack: 1399613
> packs: 1
> size-pack: 839900
> prune-packable: 0
> garbage: 0
> 
> So I only actually needed 104 more objects, but fetch wasn't clever enough to
> see that, and my new pack is much less efficient.

Like I said, it's not that the fetch wasn't clever enough.  Rather that 
your initial clone asked for way too many objects in the first place.  
That's what my patch fixed.

Now the pack efficiency can be explained as well.  A single pack is 
always going to be more efficient than 2 packs.  Problem is when you do 
a gc, by default git does the least costly operation which consists of 
copying as much data from existing packs without extra processing.  
That means that many objects were copied from the second (newly 
received) pack although a better delta representation was most probably 
available in the other larger pack (remember that most objects from that 
second pack already existed in the first pack).  Git do select the 
second pack in preference to the other pack because it is more recent, 
and normally more recent packs contains more recent objects which is a 
good heuristic to optimizes the object enumeration.  In this case this 
didn't produce a good result, but again we're talking about a scenario 
which is bogus from the start and shouldn't be.

So if you do a 'git gc --aggressive' and let it run for a while, you 
should get back a smaller pack, possibly even much smaller than the 
original 
one.


Nicolas
