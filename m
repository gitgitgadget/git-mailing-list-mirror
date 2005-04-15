From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: another perspective on renames.
Date: Fri, 15 Apr 2005 10:47:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504151031330.27637@cag.csail.mit.edu>
References: <Pine.LNX.4.61.0504141759440.7261@cag.csail.mit.edu>
 <20050414221626.10c6c0e7.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:45:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMS3S-0005hN-MN
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 16:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVDOOrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 10:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDOOrn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 10:47:43 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:64930 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261808AbVDOOrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 10:47:18 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMS6A-0005um-00; Fri, 15 Apr 2005 10:47:10 -0400
To: Paul Jackson <pj@engr.sgi.com>
In-Reply-To: <20050414221626.10c6c0e7.pj@engr.sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Apr 2005, Paul Jackson wrote:

> To me, rename is a special case of the more general case of a
> big chunk of code (a portion of a file) that was in one place
> either being moved or copied to another place.
>
> I wonder if there might be someway to use the tools that biologists use
> to analyze DNA sequences, to track the evolution of source code,
> identifying things like common chunks of code that differ in just a few
> mutations, and presenting the history of the evolution, at selectable
> levels of detail.

The rsync algorithm (http://samba.anu.edu.au/rsync/tech_report/node2.html) 
is probably a good place to start, although it is relatively sensitive to 
mutations.  It will be able to efficiently detect identical blocks larger 
than some block size N (512 bytes or so for rsync).  You might well 
consider smaller blocks to be irrelevant.  The data can be made 
considerably more useful to developers by canonicalizing before searching 
(ie, compressing whitespace to ' ', etc)[*].  Note that the identical 
regions do *not* have to line up on block boundaries; see the rsync 
algorithm for more detail.

I think Linus has made a persuasive case that the 'developer-friendly' 
features of an SCM (ie annotate, log, and friends) can be built *on top* 
of GIT.   This is a perfect example.  Since the computation is non-trivial 
(although linear in the number of lines of code involved in the history of 
a file; ie doesn't depend on the unrelated size of the archive), it might 
make sense for the front-end SCM to maintain its own caches --- for 
example, of the block and rolling checksums for each file required by the 
rsync algorithm.  The key point being that these are just *caches*, not 
essential history information, and can always be wiped and regenerated.

The nice 'feature' of this system (some may disagree, I guess) is that it 
does *not* depend on extensive programmer annotation of file changes (ie, 
chunk A in file B came from lines C-D of file D, or file E was once named 
F, etc).  By inferring history from content-similar files and blocks, it 
seems that it would be more able to generate useful results after 
importing third-party sources, which may come in distinct 'releases' but 
lack explicit history annotations.
   --scott

[*] in general, i will be *glad* to see source-management move away from 
CVS' line-oriented style; there's no good reason we should still be worrying
about whitespace changes, etc.  When we build 'developer-friendly' tools 
we should make every effort to auto-detect source code, image formats, 
etc, and automatically perform appropriate canonicalization and 
beautification of diffs, because this can be/should be/is entirely 
separate from git's underlying storage representation.

Mk 48 PANCHO ZPSECANT MKDELTA SCRANTON D5 SLBM JMTRAX Delta Force 
MI6 SGUAT Khaddafi SMOTH interception mail drop SECANT PBSUCCESS Cocaine
                          ( http://cscott.net/ )
