From: Nicolas Pitre <nico@cam.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 12:11:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606091127540.19403@localhost.localdomain>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
 <e6b798$td3$1@sea.gmane.org> <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 18:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FojaT-0001fX-0K
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 18:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWFIQLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWFIQLo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 12:11:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10156 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030272AbWFIQLn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 12:11:43 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0L00CP4OZI4HI0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Jun 2006 12:11:42 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21531>

On Fri, 9 Jun 2006, Linus Torvalds wrote:

> 
> 
> On Fri, 9 Jun 2006, Jakub Narebski wrote:
> > Jon Smirl wrote:
> > 
> > >> git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(
> > > 
> > > We are all having problems getting this to run on 32 bit machines with
> > > the 3-4GB process size limitations.
> > 
> > Is that expected (for 10GB repository if I remember correctly), or is there
> > some way to avoid this OOM?

What was that 10GB related to, exactly?  The original CVS repo, or the 
unpacked GIT repo?

> So a single 2GB pack is already very much pushing it. It's really really 
> hard to map in a 2GB file on a 32-bit platform: your VM is usually 
> fragmented enough that it simply isn't practical. In fact, I think the 
> limit for _practical_ usage of single packs is probably somewhere in the 
> half-gig region, unless you just have 64-bit machines.

Sure, but have we already reached that size?

The historic Linux repo currently repacks itself into a ~175MB pack for 
63428 commits.

The current Linux repo is ~103MB with a much shorter history (27153 
commits).

Given the above we can estimate the size of the kernel repository after 
x commits as follows:

	slope = (175 - 103) / (63428 - 27153) = approx 2KB per commit

	initial size = 175 - .001985 * 63428 = 49MB

So the initial kernel commit is about 49MB in size which is coherent 
with the corresponding compressed tarball.  Subsequent commits are 2KB 
in size on average.  Given that it will take about 233250 commits before 
the kernel reaches the half gigabyte pack file, and given the current 
commit rate (approx 23700 commits per year), that means we still have 
nearly 9 years to go.  And at that point 64-bit machines are likely to 
be the norm.

So given those numbers I don't think this is really an issue.  The Linux 
kernel is a rather huge and pretty active project to base comparisons 
against.  The Mozilla repository might be difficult to import and 
repack, but once repacked it should still be pretty usable now even on a 
32-bit machine even with a single pack.

Otherwise that should be quite easy to add a batch size argument to 
git-repack so git-rev-list and git-pack-objects are called multiple 
times with sequential commit 
ranges to create a repo with multiple packs.


Nicolas
