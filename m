From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 16:30:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002181604310.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
 <7v635ub8oa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:30:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiDx5-0002mF-MO
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 22:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab0BRVaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 16:30:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47683 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab0BRVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 16:30:22 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY200A3G3QKQC50@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Feb 2010 16:30:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v635ub8oa.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140382>

On Thu, 18 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> Honesty is very good.  An alternative implementation that does not hurt
> >> performance as much as the "paranoia" would, and checks "the input well
> >> enough" would be very welcome.
> >
> > Can't we rely on the mtime of the source file?  Sample it before 
> > starting hashing it, then make sure it didn't change when done.
> 
> I suspect that opening to mmap(2), hashing once to compute the object
> name, and deflating it to write it out, will all happen within the same
> second, unless you are talking about a really huge file, or you started at
> very near a second boundary.

How is the index dealing with this?  Surely if a file is added to the 
index and modified within the same second then 'git status' will fail to 
notice the changes.  I'm not familiar enough with that part of Git.

Alternatively, you could use the initial mtime sample to determine the 
filesystem's time granularity by noticing how many LSBs are zero.  
Let's say FAT should have a granularity of one second.  Then if the 
mtime of the file is less than one second away before starting to hash 
then just wait for one second.  If one second later the mtime has 
changed and still less than a second away then abort.  If after the hash 
the mtime has changed then abort.

On a recent filesystem, it is likely that the mtime granularity is a 
nanosecond.  Nevertheless the above algorithm should just work all the 
same, although it is unlikely that the mtime will be within the current 
nanosecond, hence the probability for having to do an initial wait is 
almost zero.  On kernels without hires timers the granularity will be 
like 10 ms.

Of course you might be unlucky and the initial mtime sample happens to 
be right on a whole second even on a high resolution mtime filesystem, 
in which case the delay test will consider one second instead of 10 ms 
or whatever.  but the probability is rather small that you'll end up 
with all sub-second bits to be all zeroes causing a longer delay than 
actually necessary, and this would matter only for files that would have 
been modified within that second.  I don't think there is a reliable way 
to enquire a filesystem+OS time stamping granularity.


Nicolas
