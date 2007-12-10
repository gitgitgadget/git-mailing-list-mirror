From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 11:03:32 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101048230.555@xanadu.home>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
 <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
 <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
 <9e4733910712092219kd86e576k33b11c93179f6475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1l6z-00013N-97
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXLJQDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXLJQDe
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:03:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39721 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbXLJQDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:03:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU00GC9CLWPUG0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 11:03:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712092219kd86e576k33b11c93179f6475@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67726>

On Mon, 10 Dec 2007, Jon Smirl wrote:

> It seems to be caused by looping over those runs of 100,000 identical
> hash entries.

As mentioned earlier, there simply can't be 100000 identical hash 
entries.

> 5091699 24.6407 :                       for (entry = index->hash[i]; entry < index->hash[i+1]; entry++) {
> 5301791 25.6575 :                               const unsigned char *ref = entry->ptr;

This loop is the very heart of the delta search code.  It is normal to 
see it high on the graph.  In some worst cases, this loop might even be 
entered for every byte in the source buffer.

And yet I bring you back to your observation about the fact that the 
source pack used for the repack (whether it is the 2.1GB pack or the 
300MB pack) has a great influence on the performance outcome.  The code 
above, though, would be executed the very exact number of times, and the 
exact amount of memory allocated, regardless of the source pack used (as 
long as you use -f with 'git repack' of course).

So this cannot be the culprit.


Nicolas
