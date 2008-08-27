From: Nicolas Pitre <nico@cam.org>
Subject: Re: "failed to read delta base object at..."
Date: Wed, 27 Aug 2008 16:46:38 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808271627540.1624@xanadu.home>
References: <20080825164602.GA2213@fieldses.org>
 <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
 <20080825213104.GI2213@fieldses.org>
 <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
 <20080825221321.GL2213@fieldses.org>
 <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
 <48B46B04.70102@gmail.com> <48B46F46.9090302@gmail.com>
 <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808271458320.1624@xanadu.home>
 <alpine.LFD.1.10.0808271222250.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_EyVxtL8Fwo28ZSdim8ofGw)"
Cc: Jason McMullan <jason.mcmullan@gmail.com>, git@vger.kernel.org,
	bfields@fieldses.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRw4-0006wi-C0
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbYH0UrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbYH0UrG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:47:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52445 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbYH0UrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:47:05 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6A00B5B1PQVQC1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Aug 2008 16:46:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808271222250.3363@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93947>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_EyVxtL8Fwo28ZSdim8ofGw)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Wed, 27 Aug 2008, Linus Torvalds wrote:

> On Wed, 27 Aug 2008, Nicolas Pitre wrote:
> 
> > However, in the pack-objects case, it is almost impossible to have such 
> > a corruption since the data is SHA1 summed immediately before being 
> > written out.
> 
> Yes. Anything that uses the "sha1write()" model (which includes the 
> regular pack-file _and_ the index) should generally be pretty safe. 

What that means is that if git was the cause of the corruption itself 
then the pack would still match its checksum (verify-pâck would still 
fail nevertheless).

> However, we do have this odd case of fixing up the pack after-the-fact 
> when we receive it from somebody else (because we get a thin pack and 
> don't know how many objects the final result will have). And that case 
> seems to be not as safe, because it
> 
>  - re-reads the file to recompute the SHA1
> 
>    This is understandable, and it's fairly ok, but it does mean that there 
>    is a bigger chance of the SHA1 matching if something has corrupted the 
>    file in the meantime!

I think that can be fixed.  When reading the file back, it is possible 
to compute 2 sha1s: one to compare with the recieved one using original 
pack header, and the second which would be the final one.  FRom a 
certain offset, new objects were added, so that first sha1 is validated 
against the received one and reset, and at the end, it should correspond 
to the sha1 of added objects that we should compute when writing them.


Nicolas

--Boundary_(ID_EyVxtL8Fwo28ZSdim8ofGw)--
