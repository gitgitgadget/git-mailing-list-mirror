From: Nicolas Pitre <nico@cam.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 13:06:44 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161236180.5518@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org>
 <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:07:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFtM-0005DY-Sx
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965655AbXCPRGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965712AbXCPRGr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:06:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33070 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965655AbXCPRGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:06:46 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF0006MRA78Q690@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 13:06:44 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42381>

On Fri, 16 Mar 2007, Linus Torvalds wrote:

> The most performance-critical objects for uncompression are commits and 
> trees. At least for the kernel, the average size of a tree object is 678
> bytes. And that's ignoring the fact that most of them are then deltified, 
> so about 80% of them are likely just a ~60-byte delta.

This is why in pack v4 there will be an alternate tree object 
representation which is not deflated at all.

In short we intend to have 3 tables where common things are factored 
out:

 1) the path component string table (deflated)

 2) author/committer string table (deflated)

 3) sorted SHA1 table (obviously not deflated)

The sorted SHA1 table will be part of the pack instead of being in the 
pack index.  The idea is that most SHA1's are already duplicated in the 
pack already anyway within commit and tree objects.  With a single table 
then commit and tree objects can index into that SHA1 table rather than 
providing the SHA1 value inline for the objects they refer to.

This means that a tree object record would be only 6 bytes according to 
the current design: 2 bytes to index into the path component string 
table (which also include the mode information), and 4 bytes to index 
into the sorted SHA1 table.  And similarly for commit objects.

This means that the pack index will only have a table of offsets 
corresponding to the table of sorted SHA1's.

So... walking revisions will become only a matter of picking the first 
commit object, using the tree index value (which is not deflated), but 
instead of using it in the SHA1 table it could be used in the offset 
table to find the location of the corresponding tree object directly.  
Same goes for tree entries, or for locating the parent's commit object.

No deflating, no binary searching, no SHA1 comparisons.  Plain straight 
pointer dereference.

Then, if you want to filter tree walking on path spec, you only need to 
locate the path component in the path table once and use the 
corresponding index to filter tree entries instead of repeated strcmp().  
Same thing if you want to filter commits based on author/committer.  
One side effect of this is that you can tell straight away that a path 
doesn't exist in the whole pack if one of its components cannot be found 
in the table (that works only if no legacy tree representations are 
present of course).  That should make history walking blazingly fast.

The only thing that gets deflated is the commit message which needs to 
be inflated only when displaying it.

And so far that makes for quite smaller packs too!


Nicolas
