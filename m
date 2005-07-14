From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 08:51:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507140832490.19183@g5.osdl.org>
References: <20050713135052.C6791@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org> <20050714083700.A26322@flint.arm.linux.org.uk>
 <tnxu0ixoiuo.fsf@arm.com> <20050714105938.A31383@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 17:52:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt60J-0000F8-9x
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 17:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVGNPvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVGNPvx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 11:51:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261541AbVGNPvw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 11:51:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6EFpjjA001174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 08:51:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6EFpihb018707;
	Thu, 14 Jul 2005 08:51:44 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050714105938.A31383@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, Russell King wrote:
> 
> Actually, I should've left the sh -x /usr/bin/cg-diff drivers/serial/8250.c
> running a little longer.  It's not the git-update-cache command which
> is taking the time, it's git-diff-cache.

Ok. git-diff-cache actually ends up reading your HEAD tree, and that, in
turn, is 1000+ tree objects. So it can take a while for the whole tree,
especially in the nonpacked and uncached case.

git-diff-tree (comparing two trees) is smart enough to limit itself to 
just the sub-trees that have been named, and would have compared the two 
trees by looking up just eight objects (three subdirectories from each 
tree, and then the file itself from both trees). 

But git-diff-cache isn't - because it's comparing the tree against the
index file, and the index is inevitably the whole tree.

And I now think I know what makes it slow. Not only are you basically
opening 1100 files (the tree objects - there's really that many
subdirectories in the kernel. Scary), but because you have alternate
object directories, and almost all of the objects are in the alternate
(not your primary), you'll basically always end up _first_ looking in the
primary, failing, and then looking in the alternate.

Together with the hashing, you'll be looking all over the place, in other
words ;)

Which means that you'll be needing a fair amount of memory to keep all of
those negative dentries etc cached (and the directory tree too).

This is something the pack-files will just help enormously with, but it
was only recently that we turned git around to check the pack-files
_first_, and the object directories second, so you probably won't see it
(not to mention that you probably don't have big pack-files at all ;)

I'll look into making diff-cache be more efficient. I normally don't use
it myself, so I didn't bother (I use git-diff-files, which is way more
efficient, but doesn't show the difference against the _tree_, it shows
the difference against the index. Since cogito tries to hide the index
from you, cogito can't very well use that).

			Linus
