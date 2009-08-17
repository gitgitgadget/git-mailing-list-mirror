From: Nicolas Pitre <nico@cam.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 13:06:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908171228570.6044@xanadu.home>
References: <20090817072315.4314.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: bdonlan@gmail.com, johnflux@gmail.com, P@draigBrady.com,
	art.08.09@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5fw-0004RI-CB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbZHQRGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbZHQRGu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:06:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36102 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbZHQRGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:06:50 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOJ00B7E5OMCQJ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 12:55:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090817072315.4314.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126234>

On Mon, 17 Aug 2009, George Spelvin wrote:

> If it helps anyone resolve license issues, here's a from-FIPS-180-2
> implementation that's placed in the public domain.  That should be
> compatible with any license.
> 
> It uses Linus's and Artur's performance ideas, and some of Linus' macro
> ideas (in the rotate implementation), but tries to be textually different.
> Is there anything recognizable that anyone cares to clam copyright to?

I don't think this trick of making source code textually different from 
another work while still intimately mimicking the same structure entitles 
you to any copyright (or non copyright) claims over that other work.  I 
certainly wouldn't bet any dime for this standing up in court.  
Otherwise anyone could grab any copyrighted source code and perform a 
bunch of search-and-replace ops on it, and maybe some code reordering 
for good measure, to be able to claim own copyright on it. It is 
probably much safer to simply ask the people involved to agree with your 
relicensing.  And so far I don't see anyone with a stake in this 
fiercely wanting to stick to a particular license.

> It's not quite 100% finished, as I haven't benchmarked it against Linus's
> code yet, but it's functionally correct.
> 
> It's also clean with -W -Wall -Wextra.

Not if you try with the unaligned put_be32() as the destination pointer 
is marked const.

As to the actual result on ARM... Well, the assembly _looks_ much worse 
than Linus' version.  It uses a stack frame of 152 bytes instead of 64 
bytes.  The resulting binary is also 6868 bytes large compared to 6180 
bytes.  Surprisingly, the performance is not that bad (the reason for 
the underlined "looks" above) albeit still a bit worse, like 5% slower.  
I was expecting much worse than that.

One possible reason for the bad assembly is probably due to the fact 
that gcc is not smart enough to propagate constant address offsets 
across different pointer types.  For example, my first version of 
get_be32() was a macro that did this:

#define SHA_SRC(t) \
  ({ unsigned char *__d = (unsigned char *)&data[t]; \
     (__d[0] << 24) | (__d[1] << 16) | (__d[2] << 8) | (__d[3] << 0); })

With such a construct, gcc would always allocate a register to hold __d 
and then dereference that with an offset from 0 to 3.  Whereas:

#define SHA_SRC(t) \
   ({   unsigned char *__d = (unsigned char *)data; \
        (__d[(t)*4 + 0] << 24) | (__d[(t)*4 + 1] << 16) | \
        (__d[(t)*4 + 2] <<  8) | (__d[(t)*4 + 3] <<  0); })

does produce optimal assembly as only the register holding the data 
pointer is dereferenced with the absolute byte offset.  I suspect your 
usage of inline functions has the same effect as the first SHA_SRC 
definition above.

Also, wrt skipping the last 3 write back to the 16 word array...  For 
all the (limited) attempts I've made so far to do that, it always ended 
up making things worse.  I've yet to investigate why though.


Nicolas
