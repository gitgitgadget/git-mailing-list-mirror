From: Nicolas Pitre <nico@cam.org>
Subject: Re: New index-pack "keep" violates "never overwrite"
Date: Tue, 20 Mar 2007 15:07:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703201454280.18328@xanadu.home>
References: <20070320053813.GC29288@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 20:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTjgA-0002VJ-ED
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 20:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbXCTTH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934029AbXCTTH1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 15:07:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18641 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbXCTTH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 15:07:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF700483UGAXHR0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 15:07:22 -0400 (EDT)
In-reply-to: <20070320053813.GC29288@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42757>

On Tue, 20 Mar 2007, Shawn O. Pearce wrote:

> This is something that has been bothering me for several weeks now.
> 
> Waaaaaaay back Git was considered to be secure as it never overwrote
> an object it already had.  This was ensured by always unpacking the
> packfile received over the network (both in fetch and receive-pack)
> and our already existing logic to not create a loose object for an
> object we already have.
> 
> Lately however we keep "large-ish" packfiles on both fetch and push
> by running them through index-pack instead of unpack-objects.  This
> would let an attacker perform a birthday attack. 

This has been nagging me as well since I made the index-pack changes.  
But I dismissed that possibility as pure paranoia.

[...]
> The fix does appear to be simple.  Just don't write the existing
> object to the output packfile.  But really that is a lot more like
> what unpack-objects does: buffer deltas we cannot resolve yet, and
> only write out what we cannot find through our ODB.  The logic in
> index-pack ain't built for that...

Nah.  You would have to fix every delta base offsets up etc. and make 
the whole thing into a complex mess.

Instead, we only have to check for the local presence of every objects 
in the pack, and when one packed object does exist locally and 
doesn't match the pack content we simply need to bail out with great 
distress.  If we really get a SHA1 collision, evil or not, we simply 
just cannot continue as if nothing happened.

Patch to follow...


Nicolas
