From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Optimize diff-delta.c
Date: Tue, 01 May 2007 12:05:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0705011124250.6574@xanadu.home>
References: <1178030967273-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 01 18:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiur9-00007Y-BY
	for gcvg-git@gmane.org; Tue, 01 May 2007 18:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbXEAQFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbXEAQFa
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 12:05:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30977 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbXEAQF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 12:05:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHD00IZNE10OQG0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2007 12:05:25 -0400 (EDT)
In-reply-to: <1178030967273-git-send-email-mkoegler@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45955>

On Tue, 1 May 2007, Martin Koegler wrote:

> As the delta format only supports 32 bit offsets, the uncompressed
> blob size is limited to 4GB.

Right.  I think it would be a good idea to extend the delta format as 
well to allow for larger offsets in pack v4.

> The delta index has approximately the same size in memory as the
> uncompressed blob ((blob size)/16*(sizeof(index_entry)).

One thing that could be done with really large blobs is to create a 
sparser index, i.e. have a larger step than 16.  Because the delta match 
loop scans backward after a match the sparse index shouldn't affect 
compression that much on large blobs and the index could be 
significantly smaller.

> I tried to speed up the delta generation by searching for a common 
> prefix, as my blobs are mostly append only. I tested it with about 
> less than 1000 big blobs. The time for finding the deltas decreased 
> from 17 to 14 minutes cpu time.

I'm surprised that your patch makes so much of a difference.  Normally 
the first window should always match in the case you're trying to 
optimize and the current code should already perform more or less the 
same as your common prefix match does.

Ah, no, actually what your patch does is a pessimisation of the matching 
code by not considering other and possibly better matches elsewhere in 
the reference buffer whenever there is a match at the beginning of both 
buffers.  I don't think this is a good idea in general.

What you should try instead if you want to make the process faster is to 
lower the treshold used to consider a match sufficiently large to stop 
searching.  That has the potential for even faster processing as the 
"optimization" would then be effective throughout the buffer and not 
only at the beginning.

Currently the treshold is implicit and equal to 65536.  Please consider 
this patch instead of yours for testing:

diff --git a/diff-delta.c b/diff-delta.c
index 9f998d0..755c0a9 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -315,6 +315,9 @@ create_delta(const struct delta_index *index,
 				/* this is our best match so far */
 				msize = ref - entry->ptr;
 				moff = entry->ptr - ref_data;
+				/* a sufficiently large match is good enough */
+				if (msize >= 4096)
+					break;
 			}
 		}
 

You could experiment with that value to determine the best speed vs size 
compromize.


Nicolas
