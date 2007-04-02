From: Geert Bosch <bosch@adacore.com>
Subject: Re: [RFC] Packing large repositories
Date: Mon, 2 Apr 2007 08:22:17 +0200
Message-ID: <64E16DEF-E572-4384-9E68-42EBBCE678B1@adacore.com>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com> <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org> <20070330062324.GU13247@spearce.org> <alpine.LFD.0.83.0703300851270.3041@xanadu.home> <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com> <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 08:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYFvu-00017m-Ei
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 08:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933876AbXDBGWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 02:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbXDBGWX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 02:22:23 -0400
Received: from nile.gnat.com ([205.232.38.5]:41478 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933876AbXDBGWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 02:22:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 4BEC648CFEB;
	Mon,  2 Apr 2007 02:22:19 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 03243-01-7; Mon,  2 Apr 2007 02:22:19 -0400 (EDT)
Received: from [205.232.38.91] (vpn202.gnat.com [205.232.38.91])
	by nile.gnat.com (Postfix) with ESMTP id 3551148CDBB;
	Mon,  2 Apr 2007 02:22:18 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43598>


On Mar 31, 2007, at 20:36, Linus Torvalds wrote:

> So here's a suggestion:
>
>  - start finding a range using the 256-entry fan-out, exactly the  
> way we
>    did for the binary search. It's cheap. We could probably avoid EVEN
>    THIS, and just do one more newton-raphson iteration more. But  
> since we
>    have the data, we migth as well use it. After all, it really  
> *is* just
>    a first approximation of newton-raphson, and while it uses only  
> 8 bits
>    (and we could do better), at least it's an *exact* one.
>
>  - use newton-raphson to iterate closer. It should be a much faster  
> way to
>    find the rough area for the entry we're searching for than binary
>    search. Two or three iterations should get us there, easily.
>
>  - do a linear search once you're close enough.

Actually, I had implemented this first, using two newton-raphson
iterations and then binary search. With just one iteration is
too little, and one iteration+binary search often is no win.
Two iterations followed by binary search cuts the nr of steps in
half for the Linux kernel. Two iterations followed by linear search
is often worse, because of "unlucky" cases that end up doing many
probes. Still, during the 5-8 probes in moderately large repositories
(1M objects), each probe pretty much requires its own cache line:
very cache unfriendly.

By using a fan-out table with an average nr of entries per bin
of 32 or so, you get a total cache footprint of between 1 and 2 bits
per entry for the random lookup. So, a complete lookup only hits
about 3 cache lines.  After a few lookups, almost all of the
fan-out table will be in cache, while currently, the cache is
filled with useless 24 byte SHA1+offset of unrelated objects.

   -Geert

PS. I'm travelling now, so can't participate in the discussion
     or send code as much as I'd like and mail may be late or
     out of sequence.
