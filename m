From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 23:32:43 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org>
 <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 05:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLu1H-0006SB-O2
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 05:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbXB0Ecq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 23:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXB0Ecq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 23:32:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37984 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbXB0Ecp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 23:32:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE300GGATYJ1QQ1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 23:32:44 -0500 (EST)
In-reply-to: <20070227003118.GH1639@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40692>

On Mon, 26 Feb 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > Actually I've been thinking about another format already.
> > 
> > What about keeping the pack offset as 32 bits like it is today, but for 
> > index v2 if the top bit is set then this become an index into another 
> > table containing 64-bit offsets as needed.  This way there is no waste 
> > of space for most projects where the pack has yet to reach the 2GB limit 
> > for many years to come.
> 
> Actually Troy's patch tries to do this by using the current format
> and only switching to the new one if the packfile exceeds 4 GiB.
> Rather smart.

Yes I saw the patch.  But what I propose is different.  In fact I'd 
require far less changes to the existing code.  The idea is to continue 
to store a 32-bit value along with the SHA1 just like we do today.  
Then, appended to that would be another table containing a list of 
64-bit offsets.

Now if the offset stored in the index is smaller than 2GB you store it 
as we do today.  If it is >= 2GB then a 64-bit index would be added to 
the extra offset table and the 32-bit entry along with the SHA1 would be 
an index into that second table instead, with the top bit set to 
distinguish it from a normal 32-bit offset (actually 31 bits).  So for 
offsets larger than 31 bits then they have an additional level of 
indirection.

The code to implement this would be minimal.  And since objects placed 
at the end of a pack (those more likely to incure the indirection 
overhead) are further back in history they won't get accessed 
very often anyway.

Then nothing prevents us from inserting the next-object-index table in 
between (its size is known while the 64-bit offset one may vary) then 
the code that doesn't care about it need no look at it. 

> One thought I had here was to expand the fan-out table from 1<<8
> entries to 1<<16 entries, then store only the low 18 bytes of
> the SHA-1.  We would have another 2 bytes worth of space to store
> the offset, pushing our total offset up to 48 bits.

That would penalize small packs a lot.  the index would always start 
from 256KB in size.  With a pack of 100 objects (our current treshold 
for keeping a pack) that means a 258KB index file.  Currently the index 
file for a 100-object pack is 3.4KB.


Nicolas
