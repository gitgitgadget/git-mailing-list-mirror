From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: space compression (again)
Date: Fri, 15 Apr 2005 11:34:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:31:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVZx-0005pF-UC
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVDOSdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDOSdN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:33:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:47579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbVDOScY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 14:32:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FIWLs4009157
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 11:32:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FIWK0i007338;
	Fri, 15 Apr 2005 11:32:21 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, C. Scott Ananian wrote:
> 
> Why are blobs per-file?  [After all, Linus insists that files are an 
> illusion.]  Why not just have 'chunks', and assemble *these* 
> into blobs (read, 'files')?  A good chunk size would fit evenly into some 
> number of disk blocks (no wasted space!).

I actually considered that. I ended up not doing it, because it's not 
obvious how to "block" things up (and even more so because while I like 
the notion, it flies in the face of the other issues I had: performance 
and simplicity).

The problem with chunking is:
 - it complicates a lot of the routines. Things like "is this file 
   unchanged" suddenly become "is this file still the same set of chunks",
   which is just a _lot_ more code and a lot more likely to have bugs.
 - you have to find a blocking factor. I thought of just going it fixed 
   chunks, and that just doesn't help at all. 
 - we already have wasted space due to the low-level filesystem (as 
   opposed to "git") usually being block-based, which means that space 
   utilization for small objects tends to suck. So you really want to 
   prefer objects that are several kB (compressed), and a small block just
   wastes tons of space.
 - there _is_ a natural blocking factor already. That's what a file 
   boundary really is within the project, and finding any other is really 
   quite hard.

So I'm personally 100% sure that it's not worth it. But I'm not opposed to
the _concept_: it makes total sense in the "filesystem" view, and is 100%
equivalent to having an inode with pointers to blocks. I just don't think 
the concept plays out well in reality.

		Linus
