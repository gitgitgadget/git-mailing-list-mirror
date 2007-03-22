From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 09:17:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUPyZ-0007iJ-5e
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 17:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933771AbXCVQRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 12:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934090AbXCVQRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 12:17:16 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37969 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933771AbXCVQRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 12:17:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2MGHCG9009079
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 09:17:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2MGHBOg024305;
	Thu, 22 Mar 2007 09:17:11 -0700
In-Reply-To: <200703211024.04740.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42862>


[ Git list cc'd again - I modified your branch names and commit header 
  line just in case you care about those ]

On Wed, 21 Mar 2007, Alexander Litvinov wrote:
> 
> I have a good news : I got the breakage again. And I can reproduce it :-)
> 
> This is a version of git with three your patches.
> 
> Here is the steps to broke my repo:

So does it break every time if you do this particular sequence with the 
particular state that it has?  If so, wonderful, since it should mean that 
you can also recreate the file that got corrupted as a blob.

> $ git prune
> $ git fsck --full
> dangling commit 50267ccaa820c456bd361db808f99d81714cbce8
> $ git rebase fix-autoxyzzy                                    
> First, rewinding head to replay your work on top of it...
> HEAD is now at 42af3b2... Replace ...
> Applying 'Show ...'
> 
> Wrote tree 851c5d8d2213c60efc1bd081b0012bfcc9e558b5
> Committed: e7117e5637e881368ff04e94a27dca2abdb12d38

And then..

> [lan@ac-7923bb4c6c14 navitel (debug-autoxyzzy)]$ git fsck --full
> error: corrupt loose object 'c01848491b53c3dcfd738149193a14d3c9abe107'
> error: c01848491b53c3dcfd738149193a14d3c9abe107: object corrupt or missing
> missing blob c01848491b53c3dcfd738149193a14d3c9abe107
> dangling commit 50267ccaa820c456bd361db808f99d81714cbce8
> 
> What can I do to debug this ?

Every time there's a corrupt object, if you can send it to me, that would 
be good. If you can tell the source for the corrupt object and can send 
that to me too, that's always even better, but even in the absense of 
that, the more corrupt objects I have, the better the chances that I see 
some pattern. And if it's always the same object that gets corrupted the 
same way when you start from a particular starting point, that would also 
be very interesting to know.

Considering that the "don't use hardlinks on cygwin" thing didn't matter 
for you (and really, I would have only expected it to matter if you used 
^C to kill a process in the middle or something), you migth also be better 
off just trackng the standard git, since it now has Nicos extra 
consistency checks over and beyond those I send you. 

It's also possible that the real bug is that we have some memory scribble 
internally in git, and that it shows up for you just because Cygwin and/or 
WinXp has different allocation patterns than other platforms. Do you know 
if there are any "debugging malloc" libraries for Cygwin? Something like 
ElectricFence/dmalloc under Linux, or running with valgrind.

Since it happens after a single rebase, if it's a git bug (as opposed 
to,for example, a zlib problem or simply a problem in your combination of 
vmware/winxp/cygwin), it would be the recursive merge that screws up. It 
*is* one of the more complex operations (especially if it also ends up 
doing file-level merging, which I assume it does), so some memory 
allocation problem there is not out of the question, although it's strange 
that you see it but the (many more) users on UNIX never seem to - it's not 
like rebase is an uncommon operation!

		Linus
