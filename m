From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 17:32:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181711350.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <m3fxbpneqe.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
 <200908182302.10619.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWIQ-00087l-7a
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbZHRVck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbZHRVck
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:32:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35093 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZHRVcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:32:39 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL003SYCNNM9F0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 17:21:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200908182302.10619.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126458>

On Tue, 18 Aug 2009, Jakub Narebski wrote:

> You can probably get number and size taken by delta and non-delta (base)
> objects in the packfile somehow.  Neither "git verify-pack -v <packfile>"
> nor contrib/stats/packinfo.pl did help me arrive at this data.

Documentation for verify-pack says:

|When specifying the -v option the format used is:
|
|        SHA1 type size size-in-pack-file offset-in-packfile
|
|for objects that are not deltified in the pack, and
|
|        SHA1 type size size-in-packfile offset-in-packfile depth base-SHA1
|
|for objects that are deltified.

So a simple script should be able to give you the answer.

> >> (BTW what happens if this pack is larger than file size limit for 
> >> given filesystem?).
> > 
> > We currently fail.  Seems that no one ever had a problem with that so 
> > far. We'd have to split the pack stream into multiple packs on the 
> > receiving end.  But frankly, if you have a repository large enough to 
> > bust your filesystem's file size limit then maybe you should seriously 
> > reconsider your choice of development environment.
> 
> Do we fail gracefully (with an error message), or does git crash then?

If the filesystem is imposing the limit, it will likely return an error 
on the write() call and we'll die().  If the machine has a too small 
off_t for the received pack then we also die("pack too large for current 
definition of off_t").

> If I remember correctly FAT28^W FAT32 has maximum file size of 2 GB.
> FAT is often used on SSD, on USB drive.  Although if you have  2 GB
> packfile, you are doing something wrong, or UGFWIINI (Using Git For
> What It Is Not Intended).

Hopefully you're not performing a 'git clone' off of a FAT filesystem.  
For physical transport you may repack with the appropriate switches.

> >> If it fails, client ask first for first half of of
> >> repository (half as in bisect, but it is server that has to calculate
> >> it).  If it downloads, it will ask server for the rest of repository.
> >> If it fails, it would reduce size in half again, and ask about 1/4 of
> >> repository in packfile first.
> > 
> > Problem people with slow links have won't be helped at all with this.  
> > What if the network connection gets broken only after 49% of the 
> > transfer and that took 3 hours to download?  You'll attempt a 25% size 
> > transfer which would take 1.5 hour despite the fact that you already 
> > spent that much time downloading that first 1/4 of the repository 
> > already.  And yet what if you're unlucky and now the network craps on 
> > you after 23% of that second attempt?
> 
> A modification then.
> 
> First try ordinary clone.  If it fails because network is unreliable,
> check how much we did download, and ask server for packfile of slightly
> smaller size; this means that we are asking server for approximate pack
> size limit, not for bisect-like partitioning revision list.

If the download didn't reach past the critical point (75 MB in my linux 
repo example) then you cannot validate the received data and you've 
wasted that much bandwidth.

> > I think it is better to "prime" the repository with the content of the 
> > top commit in the most straight forward manner using git-archive which 
> > has the potential to be fully restartable at any point with little 
> > complexity on the server side.
> 
> But didn't it make fully restartable 2.5 MB part out of 37 MB packfile?

The front of the pack is the critical point.  If you get enough to 
create the top commit then further transfers can be done incrementally 
with only the deltas between each commits.

> A question about pack protocol negotiation.  If clients presents some
> objects as "have", server can and does assume that client has all 
> prerequisites for such objects, e.g. for tree objects that it has
> all objects for files and directories inside tree; for commit it means
> all ancestors and all objects in snapshot (have top tree, and its 
> prerequisites).  Do I understand this correctly?

That works only for commits.

> If we have partial packfile which crashed during downloading, can we
> extract from it some full objects (including blobs)?  Can we pass
> tree and blob objects as "have" to server, and is it taken into account?

No.

> Perhaps instead of separate step of resumable-downloading of top commit
> objects (in snapshot), we can pass to server what we did download in
> full?

See above.

> BTW. because of compression it might be more difficult to resume 
> archive creation in the middle, I think...

Why so?  the tar+gzip format is streamable.


Nicolas
