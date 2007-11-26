From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 14:52:05 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261433210.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:52:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwk0K-0003zj-LI
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbXKZTwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbXKZTwI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:52:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26597 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbXKZTwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:52:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400A46PUTRZ10@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 14:52:05 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66103>

On Mon, 26 Nov 2007, Dana How wrote:

> Currently data can be quickly copied from pack to pack,
> but data cannot be quickly copied blob->pack or pack->blob

I don't see why you would need the pack->blob copy normally.

> (there was an alternate blob format that supported this,
>  but it was deprecated).  Using the pack format for blobs
> would fix this.

Then you can do just that for big enough blobs where "big enough" is 
configurable: encapsulate them in a pack instead of a loose object.  
Problem solved.  Sure you'll end up with a bunch of packs containing 
only one blob object, but given that those blobs are so large to be a 
problem in your work flow when written out as loose objects, then they 
certainly must be few enough not to cause an explosion in the number of 
packs.

> It would also mean blobs wouldn't need to
> be uncompressed to get the blob type or size I believe.

They already don't.

> So far this has prevented me from deploying git here
> (and is half the reason I have not been active recently).
> Currently we use p4 and we have large files.
> When a large file is checked in (submitted),
> it is compressed *once* and sent over the network --
> these are the only delays that end-users experience.
> 
> The equivalent operation in git would require the creation of
> the blob,  and then of a temporary pack to send to the server.
> This requires 3 calls to zlib for each blob,  which for very
> large files is not acceptable at my site.

I currently count 2 calls to zlib, not 3.  And with big blobs as packs, 
as suggested above then you'd have only one call when actually staging 
their content.  This should be really straight forward to implement 
given that pack-objects is already a built-in.


Nicolas
