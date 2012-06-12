From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:39:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121536570.23555@xanadu.home>
References: <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
 <20120612175046.GA16522@sigill.intra.peff.net> <m2fwa0fk0y.fsf@igel.home>
 <alpine.LFD.2.02.1206121507120.23555@xanadu.home>
 <20120612192318.GC16911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Shawn Pearce <spearce@spearce.org>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWvq-0001pN-Be
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab2FLTjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:39:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20562 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab2FLTjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:39:08 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I00M3SRX5E750@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 15:39:07 -0400 (EDT)
In-reply-to: <20120612192318.GC16911@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199841>

On Tue, 12 Jun 2012, Jeff King wrote:

> So the race window depends on the time it takes "git prune" to run.
> 
> I wonder if git-prune could do a double-check of the refs. Something
> like:
> 
>   1. calculate reachability on all refs
> 
>   2. read list of objects to prune, and make a list of unreachable ones
> 
>   3. calculate reachability again (which should be very cheap, because
>      you can stop when you get to an object you have already seen)
> 
>   4. Drop any objects found in (3) from the list in (2), and delete
>      items from your list
> 
> But I think that still has a race where objects are created before
> step 2, but are not actually referenced until after step 3. I think
> doing it safely may actually require a repo-wide prune lock.

Yeah... that's what I was thinking too.  Maybe we're making our life 
overly miserable by trying to avoid any locking here.


Nicolas
