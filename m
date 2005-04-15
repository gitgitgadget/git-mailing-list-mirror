From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: space compression (again)
Date: Fri, 15 Apr 2005 14:45:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:44:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVms-0007d3-Oa
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVDOSqr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDOSqr
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:46:47 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:4278 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261907AbVDOSqI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 14:46:08 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMVpL-0007uY-00; Fri, 15 Apr 2005 14:46:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, Linus Torvalds wrote:

> The problem with chunking is:
> - it complicates a lot of the routines. Things like "is this file
>   unchanged" suddenly become "is this file still the same set of chunks",
>   which is just a _lot_ more code and a lot more likely to have bugs.

The blob still has the same hash; therefore the file is still the same.
Nothing looks inside blobs; they just want either the hash or the full 
contents (if I understand the algorithms correctly).
I agree it's more code, but I think it can be nicely layered.

> - you have to find a blocking factor. I thought of just going it fixed
>   chunks, and that just doesn't help at all.

rsync uses a fixed chunk size, but this chunk can start at any offset (ie, 
not constrained to fixed boundaries).  This means that adding a single 
line to the file works like you'd expect, even though all the chunk 
boundaries change.  [I think this is what you're talking about.]

> - we already have wasted space due to the low-level filesystem (as
>   opposed to "git") usually being block-based, which means that space
>   utilization for small objects tends to suck. So you really want to
>   prefer objects that are several kB (compressed), and a small block just
>   wastes tons of space.

Not on (say) reiserfs, and not over the network.  I'm proposing (at the 
moment) easy conversion from chunked to unchunked disk representation,
so that you can leave things unchunked if (for example) you know you're 
running ext2 with a large block size.

> - there _is_ a natural blocking factor already. That's what a file
>   boundary really is within the project, and finding any other is really
>   quite hard.

Well, yes, it may be nontrivial.  But 'quite hard' depends on your 
perspective, I guess.  Given a cache of existing chunks, it's just a 
few table lookups. =)

> So I'm personally 100% sure that it's not worth it. But I'm not opposed to
> the _concept_: it makes total sense in the "filesystem" view, and is 100%
> equivalent to having an inode with pointers to blocks. I just don't think
> the concept plays out well in reality.

So I guess I'll have to implement this and find out, won't I? =)
  --scott

AMLASH overthrow SDI Suharto HBDRILL SMOTH SUMAC SYNCARP kibo Blair 
Diplomat Kojarena CIA cracking counter-intelligence CABOUNCE anthrax
                          ( http://cscott.net/ )
