From: Nicolas Pitre <nico@cam.org>
Subject: Re: "failed to read delta base object at..."
Date: Wed, 27 Aug 2008 15:17:05 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808271458320.1624@xanadu.home>
References: <20080825164602.GA2213@fieldses.org>
 <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
 <20080825213104.GI2213@fieldses.org>
 <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
 <20080825221321.GL2213@fieldses.org>
 <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
 <48B46B04.70102@gmail.com> <48B46F46.9090302@gmail.com>
 <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jason McMullan <jason.mcmullan@gmail.com>, git@vger.kernel.org,
	bfields@fieldses.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQX4-0001R6-Vg
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYH0TRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYH0TRN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:17:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21899 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbYH0TRM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:17:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6900AIIXKHZ8B0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Aug 2008 15:17:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93926>

On Wed, 27 Aug 2008, Linus Torvalds wrote:

> 
> 
> On Tue, 26 Aug 2008, Jason McMullan wrote:
> > 
> > All bets are off when data=writeback.
> 
> Not the way git writes pack-files. It does a fsync() before moving them 
> into place (at least newer git versions do), so the data is stable.

And isn't the bad data block size and alignment a bit odd for a 
filesystem crash corruption?

> I do worry about wild pointers. I can't recognize the data, and it 
> definitely doesn't look like any git internal data structures, but 16-bit 
> data _is_ what zlib internally uses for things like the decoding tables. 
> 
> 
> So if there is some use-after-free issue, I could imagine things like this 
> happening inside of git. People do occasionally run valgrind on git, 
> though, and it's been clean in the past, but I don't know if that has ever 
> been done on the threaded packing, for example.

However, in the pack-objects case, it is almost impossible to have such 
a corruption since the data is SHA1 summed immediately before being 
written out.  In the index-pack case, it is even less likely since the 
data is SHA1 summed immediately after being written out.  So there is no 
window for random pointer access corrupting the data without also 
influencing the pack checksum outcome.  Therefore, if the pack content 
doesn't match its checksum, then the corruption must have occurred 
outside of git, otherwise the checksum would have included corrupted 
data already and the pack checksum would match.


Nicolas
