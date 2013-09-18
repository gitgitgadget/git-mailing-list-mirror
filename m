From: Nicolas Pitre <nico@fluxnic.net>
Subject: Git pack v4: next step, help required
Date: Wed, 18 Sep 2013 13:40:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309181120390.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 19:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMLk0-0003bJ-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 19:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab3IRRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 13:40:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53786 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3IRRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 13:40:35 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTC005C813BIB30@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Sep 2013 13:40:23 -0400 (EDT)
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234975>


I think the pack v4 format and compatibility code is pretty stable now, 
and probably as optimal as it can reasonably be.

@Junio: might be a good idea to refresh your pu branch again.

Now the biggest problem to solve is the actual tree 
"deltification".  I don't have the time to spend on this otherwise very 
interesting problem (IMHO at least) so I'm sending this request for help 
in the hope that more people would be keen to contribute their computing 
skills to solve this challenge.

I'll make a quick description of the pv4 tree encoding first and explain 
the problem to solve afterwards.

A pv4 tree is comprised of two types of records: immediate tree entry 
and tree sequence copy.

1) Immediate Tree Entry

This is made of the following tuple:

	<path component index>,{SHA1 reference index>

The path component index refers to the path dictionary table where path 
strings and file modes are uniquely stored.  The SHA1 index refers to 
the sorted SHA1 table as previously found in the pack index but which is 
now part of the pack file itself.  So on average a single tree entry may 
take between 1 to 2 bytes for the path component index and 1 to 3 bytes 
for the SHA1 index.

2) Tree Sequence Copy

This is used to literally copy a contiguous list of tree entries from 
another tree object.  This goes as follows:

	<tree entry where to start>,<number of entries to copy>
	[,<SHA1 index of the object to copy from>]

So instead of having arbitrary copying of data like in delta objects, we 
refer directly to tree entries in another object.  The big advantage 
here is that the tree walker may directly jump to the copied object 
without having to do any delta patching and caching. The SHA1 index is 
optional if it refers to the same copied object as the previous tree 
sequence copy record in this tree object.  And another possible 
optimization for the tree walker when enumerating objects is to skip the 
copy entry entirely if the object being copied from has already been 
enumerated.

The size of this entry is more variable and is typically between 1 to 2 
bytes for the start index, 1 to 2 bytes for the copy size, and 0 to 3 
bytes for the SHA1 index.

So... what to do with this?

Currently the "deltification" is achieved using a pretty dumb heuristic 
which is to simply take each tree object in a pack v2 with their 
corresponding base delta object and perform a straight conversion into 
pack v4 tree format i.e. use copy records whenever possible as long as 
they represent a space saving over the corresponding immediate tree 
entries (which is normally the case).

However this is rather sub-optimal for two reasons:

1) This doesn't benefit from the ability to use multiple base objects to 
   copy from and is potentially missing on additional opportunities for 
   copy sequences which are not possible in the selected base object 
   from the pack v2 delta base selection. Pack v4 is already quite 
   smaller than pack v2 yet it might possibly be smaller still.

2) This makes deep delta chains very inefficient at runtime when the 
   pack is subsequently accessed.

Let's consider this example to fully illustrate #2.

	Tree A:
	entry 0:	"foo.txt"
	entry 1-3:	copy from tree B: start=2 count=3

	Tree B:
	entry 0-5:	copy from tree C: start=2 count=5
	entry 6:	"bar.txt"

	Tree C:
	entry 0:	"file_a"
	entry 1:	"file_b"
	entry 2:	"file_c"
	entry 3:	"file_D"
	entry 4:	"file_E"
	entry 5:	"file_F"
	entry 6:	"file_G"

This is a good example of what typically happens when the above heuristic 
is applied.  And it is not uncommon to see a long indirection chain of 
"copy those 2 entries from that other object" sometimes reaching 50 
levels deep where the same 2 (or more) entries require up to 50 object 
hops before they can be obtained.

Obviously here the encoding should be optimized to reduce the chaining 
effect simply by referring to the final object directly.  Hence tree A 
could be encoded as follows:

	Tree A:
	entry 0:	"foo.txt"
	entry 1-3:	copy from tree C: start=4 count=3

The on-disk encoding is likely to be the same size but the runtime 
access is greatly optimized.

Now... instead of trying to do reference simplification by factoring out 
the chain effect, I think a whole new approach to tree delta compression 
for pack v4 should be developed which would also address issue #1 above.

For example, we may try to make each canonical tree objects into 
sequences of hashed tree entries in memory where each tree entry would 
be reduced down to a single CRC32 value (or even Adler32 for speed).  
Each tree object would then be represented by some kind of 32-bit 
character "string".  Then it is just a matter of applying substring 
matching algorithms to find the best copy sequences without creating 
reference cycles, weighted by the number of indirections involved when 
a referred object already has a copy sequence covering part or all of 
the matched string. Etc.

Or that can be something else entirely.  Certainly there are similar 
problems already solved in the literature somewhere.

And it has to be _fast_.

So if someone is on the lookout for a nice algorithmic and coding 
challenge then here's your opportunity!


Nicolas
