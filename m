From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Some git performance measurements..
Date: Wed, 28 Nov 2007 18:49:04 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 03:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxZSy-0006uP-Gg
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 03:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbXK2CtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 21:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbXK2CtI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 21:49:08 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43059 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719AbXK2CtH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 21:49:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAT2n52A028373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 18:49:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAT2n4kj032169
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 18:49:04 -0800
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66494>


So, today, I finally started looking a bit at one of the only remaining 
performance issues that I'm aware of: git behaviour under cold-cache and 
particularly with a slow laptop harddisk isn't as nice as I wish it should 
be.

Sadly, one big reason for performance downsides is actually hard to 
measure: since we mmap() all the really critical data structures (the 
pack-file index and data), it doesn't show up really well in any of the 
otherwise really useful performance tools (eg strace and ltrace), because 
the bulk of the time is actually spent not in libraries or in system 
calls, but simply on regular instructions that take a page fault.

Not a lot that I see we can do about that, unless we can make the 
pack-files even denser.

But one very interesting thing I did notice: some loads open the 
".gitignore" files *way* too much. Even in cases where we really don't 
care. And when the caches are cold, that's actually very expensive, even 
if - and perhaps _especially_when_ - the file doesn't exist at all (ie 
some filesystems that don't use hashes will look through the whole 
directory before they see that it's empty).

An example of totally unnecessary .gitignore files is what a plain "git 
checkout" with no arguments ends up doing:

	git read-tree -m -u --exclude-per-directory=.gitignore HEAD HEAD

which is *really* quite expensive, and a lot of the cost is trying to open 
a .gitignore file in each subdirectory that are never even used.

Just to give a feel for *how* expensive that stupid .gitignore thing is, 
here's a pretty telling comparison of using --exclude-per-directory and 
not using it:

With totally pointless --exclude-per-directory (aka "git checkout"):

	[torvalds@woody linux]$ time git read-tree -m -u --exclude-per-directory=.gitignore HEAD HEAD
	real    0m13.475s
	user    0m0.108s
	sys     0m0.228s

Without:

	[torvalds@woody linux]$ time git read-tree -m -u HEAD HEAD
	real    0m5.923s
	user    0m0.100s
	sys     0m0.044s

now, I'm not all that happy about that latter six-second time either, but 
both of the above numbers were done with completely cold caches (ie after 
having done a "echo 3 > /proc/sys/vm/drop_caches" as root).

With hot caches, both of the numbers are under a tenth of a second (in 
fact, they are very close: 0.092s and 0.096s respectively), but the 
cold-cache case really shows just how horrible it is to (try to) open many 
files.

Doing an open (or an lstat) on individual files will be a totally 
synchronous operation, with no room for read-ahead etc, so even if your 
disk in *theory* gets 80MB/s off the platter, when you do an open() or 
lstat(), you're basically doing three or four small data-dependent IO 
operations, and as a result even a fast disk will take almost a hundredth 
of a second per open/lstat operation.

Less than a hundredth of a second may not sound much, but when we have 
1700+ directories in the kernel trees, doing that for each possible 
.gitignore file is really really expensive!

(Doing an "lstat()" of each file is much cheaper in comparison, because at 
least you'll get several director entries and probably a few related 
inodes with each IO. But opening just _one_ file per directory like the 
.gitignore code does, really kills your IO throughput)

Now, timings like these are why I'm looking forward to SSD's. They may 
have the same throughput as a disk, but they can do thousands of dependent 
IOPS, and help latency-bound cases like this by an order of magnitude. But 
when we're doing those .gitignore file reads totally unnecassarily, that 
just hurts..

			Linus
