From: "C. Scott Ananian" <cscott@cscott.net>
Subject: space compression (again)
Date: Fri, 15 Apr 2005 13:19:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri Apr 15 19:17:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMUQV-0004Wu-11
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 19:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVDORTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVDORTu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 13:19:50 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:7342 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261871AbVDORTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 13:19:38 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMUTi-000789-00
	for <git@vger.kernel.org>; Fri, 15 Apr 2005 13:19:38 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've been reading the archives (a bad idea, I know).  Here's a concrete 
suggestion for GIT space-compression which is (I believe) consistent with 
the philosophy of GIT.

Why are blobs per-file?  [After all, Linus insists that files are an 
illusion.]  Why not just have 'chunks', and assemble *these* 
into blobs (read, 'files')?  A good chunk size would fit evenly into some 
number of disk blocks (no wasted space!).

We already have the rsync algorithm which can scan through a file and 
efficiently tell which existing chunks match (portions of) it, using a 
rolling checksum. (Here's a refresher:
    http://samba.anu.edu.au/rsync/tech_report/node2.html
).  Why not treat the 'chunk' as the fundamental unit, and compose files 
from chunks?

This should get better space utilization: a small change to file X 
will only require storage to save the changed chunk, plus meta data to 
describe the chunks composing the new file.  I propose keeping this only 
one-level deep: we can only specify chunks, not pieces of files.

Unlike xdelta schemes, there is no 'file' dependency.  Chunks for a blob 
can be and are shared among *all the other files and versions in the 
repository*.  Moving pieces from file 'a' to file 'b' "just works".

Best of all, I believe this can be done in a completely layered fashion. 
From git's perspective, it's still 'open this blob' or 'write this blob'. 
It just turns out that the filesystem representation of a blob is slightly 
more fragmented.  Even better, you ought to be able to convert your 
on-disk store from one representation to the other: the named blob doesn't 
change, just 'how to fetch the blob' changes.  So, for example, Linus' 
tree can be unchunked for speed, but the release tree (say) can pull 
pruned history from Linus into a chunked on-disk representation that can 
be efficiently wget'ted (only new chunks need be transferred).

My first concern is possible fragmentation: would we end up with a large 
number of very small chunks, and end up representing files as a list of 
lines (effectively)?  Maybe someone can think of an effective coalescing 
strategy, or maybe it is sufficient just to avoid creating chunks smaller 
than a certain size (ie, possibly writing redundant data to a new chunk, 
just to improve the possibility of reuse).

I'm also not sure what the best 'chunk' size is.  Smaller chunks save more 
space but cost more to access (# of disk seeks per file/blob).  Picking a 
chunk half the average file size should reduce space by ~50% while only 
requiring ~2 additional seeks per file-read. OTOH, rsync experience 
suggests 500-1000 byte chunk sizes.  Probably empirical testing is best.

Lastly, we want to avoid hitting the dcache to check the existence of 
chunks while encoding.  In a large repository, there will be a very large 
number of chunks.  We don't *have* to index all of them, but our 
compression gets better the more chunks we know about.  The rsync 
algorithm creates hash tables of chunks at different levels of granularity 
to avoid doing a full check at every byte of the input file.  How large 
should this cached-on-disk chunk hash table be to avoid saturating it as 
the repository grows (maybe the standard grow-as-you-go hash table is 
fine; you only need one bit per entry anyway)?

Thoughts?  Is the constant-factor overhead of indirection-per-blob going 
to kill git's overwhelming speed?
  --scott

JUBILIST explosion MKULTRA HTAUTOMAT Indonesia Shoal Bay RUCKUS ammunition 
GPFLOOR Hager SDI MKDELTA KUBARK Dictionary Soviet  BLUEBIRD Delta Force
                          ( http://cscott.net/ )
