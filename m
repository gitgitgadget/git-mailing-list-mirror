From: Nicolas Pitre <nico@cam.org>
Subject: Re: Horrible re-packing?
Date: Mon, 05 Jun 2006 17:20:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606051637490.24152@localhost.localdomain>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 23:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMUx-0008OK-9n
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWFEVU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFEVU2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:20:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4971 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750891AbWFEVU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 17:20:28 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0E00LCUOLZW7C0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 05 Jun 2006 17:20:23 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21343>

On Mon, 5 Jun 2006, Linus Torvalds wrote:

> 
> 
> On this same thread..
> 
> This trivial patch not only simplifies the name hashing, it actually 
> improves packing for both git and the kernel.
> 
> The git archive pack shrinks from 6824090->6622627 bytes (a 3% 
> improvement), and the kernel pack shrinks from 108756213 to 108219021 (a 
> mere 0.5% improvement, but still, it's an improvement from making the 
> hashing much simpler!)

OK here's the scoop.  I still have a sample repo (I forget who it was 
from) that used to exhibit a big packing size regression which was fixed 
a while ago.  I tend to test new packing strategies on that repo as well 
since it has rather interesting characteristics that makes it pretty 
sensitive to changes to name hashing and size filtering heuristics.

Before this hashing patch (including the rev-list fix):

$ git repack -a -f
Generating pack...
Done counting 46391 objects.
Deltifying 46391 objects.
 100% (46391/46391) done
Writing 46391 objects.
 100% (46391/46391) done
Total 46391, written 46391 (delta 7457), reused 38934 (delta 0)
Pack pack-7f766f5af5547554bacb28c0294bd562589dc5e7 created.
$ ll .git/objects/pack/pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
-rw-rw-r--  1 nico nico 39486095 Jun  5 16:28 .git/objects/pack/pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

Now with this patch applied:

$ git repack -a -f
Generating pack...
Done counting 46391 objects.
Deltifying 46391 objects.
 100% (46391/46391) done
Writing 46391 objects.
 100% (46391/46391) done
Total 46391, written 46391 (delta 9920), reused 36447 (delta 0)
Pack pack-7f766f5af5547554bacb28c0294bd562589dc5e7 created.
$ ll .git/objects/pack/pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
-rw-rw-r--  1 nico nico 16150417 Jun  5 16:31 .git/objects/pack/pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

In other words, the pack shrunk to less than half the size of the 
previous one !

And yes fsck-objects still pass (I was doubtful at first).


Nicolas
