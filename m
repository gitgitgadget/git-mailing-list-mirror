From: Nicolas Pitre <nico@cam.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 12:34:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703221215150.18328@xanadu.home>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200832150.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220847540.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUQEq-00076i-RO
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 17:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934103AbXCVQeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934112AbXCVQeF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 12:34:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18639 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934103AbXCVQeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 12:34:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFB00DW9COQGT10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Mar 2007 12:34:03 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703220847540.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42865>

On Thu, 22 Mar 2007, Linus Torvalds wrote:

> Ok, apart from #1, those should be in current -git now, along with better 
> validation checks (by Nico) when packing. So hopefully at least when there 
> is corruption in a loose object, we will now always notice when we do a 
> "git repack", and will never generate a broken pack-file. Knock wood.

Not yet actually.  What I did do is to make index-pack perform more 
validation and ensure it never accept SHA1 collisions.

For the repack case... I think there should be a better way.  Either we 
revalidate the full SHA1 which would be expensive as we'd basically lose 
most advantages of direct pack data copy.

What I'm pondering is some sort of lightweight checksum like adler32 for 
object data in the pack but stored in the index.  Since index-pack 
already perform the full SHA1 already, it could as well provide a 
checksum for the raw pack object data for the repack case.  Currently we 
try to validate reused pack data by attempting an inflate pass on the 
object payload, but that doesn't validate the object type nor the 
reference SHA1 to delta base objects which could get corrupted and 
copied without noticing into another pack.

> Of course, I actually wonder if the bug might be in your version of zlib 
> (miscompiled or some other thing), in which case *any* amount of 
> pre-validation won't really help, because it will become corrupted when we 
> deflate it prior to writing. For example, if "deflateBound()" sometimes 
> doesn't give a valid upper bound and we allocate too little space..

Well, since we provide the size of the allocated output buffer to zlib 
it would be seriously broken if it overflowed it.  Also zlib perform a 
checksum verification of the deflated data if I remember correctly.  So 
it seems to me that zlib should be quite self validating already.


Nicolas
