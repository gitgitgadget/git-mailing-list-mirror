From: Nicolas Pitre <nico@cam.org>
Subject: observations on parsecvs testing
Date: Thu, 15 Jun 2006 16:37:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 22:37:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqyas-00045j-8g
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWFOUhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFOUhb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:37:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49080 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751336AbWFOUhb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:37:31 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0X00ARS5AIO600@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Jun 2006 16:37:30 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Keith Packard <keithp@keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21906>


My machine is a P4 @ 3GHz with 1GB ram.

Feeding parsecvs with the Mozilla repository, it first ran for 175 
minutes with about 98% CPU spent in user space reading the 100458 ,v 
files and writing 700000+ blob objects.  Memory usage grew to 1789MB 
total while the resident memory saturated around 700MB.  This part was 
fine even with 1GB of ram since unused memory was gently pushed to swap.  
Only problem is that spawned git-pack-object instances started failing 
with memory allocation by that time, which is unffortunate but not 
fatal.

But then things started to go bad after all ,v files were parsed.  The 
parsecvs dropped to 3% CPU while the rest of the time was spent waiting 
after swap IO and therefore no substantial progress was made at that 
point.

So the Mozilla clearly requires 2GB of ram to realistically be converted 
to GIT using parsecvs, unless its second phase is reworked to avoid 
totally random access in memory in order to improve swap behavior, or 
its in-memory data set is shrinked at least by half.

Also rcs2git() is very inefficient especially with files having many 
revisions as it reconstructs the delta chain on every call.  For example 
mozilla/configure,v has at least 1690 revisions, and actually converting 
it into GIT blobs goes at a rate of 2.4 objects per second _only_ on my 
machine.  Can't objects be created as the delta list is walked/applied 
instead?  That would significantly reduce the initial convertion time.


Nicolas
