From: Nicolas Pitre <nico@cam.org>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 07 Dec 2007 15:46:30 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Dec 07 21:47:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0k64-0008TX-18
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 21:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbXLGUqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 15:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbXLGUqd
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 15:46:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54183 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbXLGUqc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 15:46:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP00C6Y5PG9N60@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Dec 2007 15:46:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67455>

On Fri, 7 Dec 2007, david@lang.hm wrote:

> On Fri, 7 Dec 2007, Jon Smirl wrote:
> 
> > I noticed two things when doing a repack of the gcc repo. First is
> > that the git process is getting to be way too big. Turning off the
> > delta caches had minimal impact. Why does the process still grow to
> > 4.8GB?
> > 
> > Putting this in perspective, this is a 4.8GB process constructing a
> > 330MB file. Something isn't right. Memory leak or inefficient data
> > structure?
> 
> keep in mind that that 330MB file is _very_ heavily compressed. the simple
> zlib compression is probably getting you 10:1 or 20:1 compression and the
> delta compression is a significant multiplier on top of that.

Doesn't matter.  Something is indeed fishy.

The bulk of pack-objects memory consumption can be estimated as follows:

1M objects * sizeof(struct object_entry) ~= 100MB
256 window entries with data (assuming a big 1MB per entry) = 256MB
Delta result caching was disabled therefore 0MB
read-side delta cache limited to 16MB

So the purely ram allocation might get to roughly 400MB.

Then add the pack and index map, which, depending on the original pack 
size,
might be 2GB.

So we're pessimistically talking of about 2.5GB of virtual space.

The other 2.3GB is hard to explain.


Nicolas
