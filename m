From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance problem, long run of identical hashes
Date: Mon, 10 Dec 2007 15:11:15 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101458140.555@xanadu.home>
References: <9e4733910712100707i66e185bofe22805b8e0ba4d8@mail.gmail.com>
 <alpine.LFD.0.99999.0712101037270.555@xanadu.home>
 <85tzmqnxua.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 21:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1oyZ-00055C-9V
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 21:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbXLJULR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 15:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbXLJULR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 15:11:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34493 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbXLJULQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 15:11:16 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU00FHAO2R5QB0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 15:11:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <85tzmqnxua.fsf@lola.goethe.zz>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67751>

On Mon, 10 Dec 2007, David Kastrup wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Mon, 10 Dec 2007, Jon Smirl wrote:
> >
> >> I added some debug printfs which show that I
> >> have a 100,000+ run of identical hash entries. Processing the 100,000
> >> entries also causes RAM consumption to explode.
> >
> > That is impossible.  If you look at the code where those hash entries 
> > are created in create_delta_index(), you'll notice a hard limit of 
> > HASH_LIMIT (currently 64) is imposed on the number of identical hash 
> > entries.
> 
> On the other hand, if we have, say, laaaaaarge streaks of zeros, what
> happens is that we have 64 hashes seeing them.  Now about 4096 bytes are
> compared, and then the comparison stops.

No.

What would happen in that case is that the first hash entry pointing 
somewhere in the beginning of the zero chunk will match _at least_ 4096 
bytes, probably much more, up to the end of the buffer if that is 
possible.

> Then it scans backwards to
> seek for more zeros (and finds about 64k of them before it stops)

The first hash entry for those zeroes is going to point at an offset not 
greater than 15 bytes from the start of the zero area.  So, unless both 
buffers are going to match even before that zero area, the backward scan 
will stop quickly.

> folds them into the current compacted form.  Each of these backward
> scans (of which we have 64 in the worst case) is in a different memory
> area.  So since we scan/compare areas of 64k for each advance of 4k, we
> have an overscanning factor of 16 (for a worst case scenario).

Actually, if we matched 100MB of zeroes, we'll just encode that in a 
suite of 64KB copy operations, and continue scanning the buffer after 
that 100MB.

So I don't see where your scan/compare areas of 64k for each advance of 
4k comes from.

> Not sure whether this is what we are seeing here.  It would still not
> explain exploding memory usage I think.

Right.


Nicolas
