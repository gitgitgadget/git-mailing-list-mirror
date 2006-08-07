From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 01:04:23 -0400
Message-ID: <20060807050422.GD20514@spearce.org>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com> <20060806180323.GA19120@spearce.org> <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 07 07:05:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9xIt-0005bI-0R
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 07:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWHGFEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 01:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWHGFEa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 01:04:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42956 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751037AbWHGFEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 01:04:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9xHv-0006M4-V7; Mon, 07 Aug 2006 01:04:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A2AE20FB77; Mon,  7 Aug 2006 01:04:23 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24997>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> >So the new version should take about 20 MB of memory and should
> >produce a valid pack and index in the same time as it does only
> >the pack now.  Plus it won't generate duplicates.
> 
> I did a run with this and it works great.

Good.  :-) On my drive in to work this afternoon I realized
that making you specify the size of the object table is stupid,
I could easily allocate a thousand objects at a time rather than
preallocating the whole thing.  Oh well.  fast-import thus far
hasn't been meant as production code for inclusion in core GIT,
but maybe it will get cleaned up and submitted as such if your
conversion efforts go well and produce a better CVS importer.
 
> I'm staring at the cvs2svn code now trying to figure out how to modify
> it without rewriting everything. I may just leave it all alone and
> build a table with cvs_file:rev to sha-1 mappings. It would be much
> more efficient to carry sha-1 throughout the stages but that may
> require significant rework.

Does it matter?  How long does the cvs2svn processing take,
excluding the GIT blob processing that's now known to take 2 hours?
What's your target for an acceptable conversion time on the system
you are working on?


Any thoughts yet on how you might want to feed trees and commits
to a fast pack writer?  I was thinking about doing a stream into
fast-import such as:

	<4 byte length of commit><commit><treeent>*<null>

where <commit> is the raw commit minus the first "tree nnn\n" line, and
<treeent> is:

	<type><sp><sha1><sp><path><null>

where <type> is one of 'B' (normal blob), 'L' (symlink), 'X'
(executable blob), <sha1> is the 40 byte hex, <path> is the file from
the root of the repository ("src/module/foo.c"), and <sp> and <null>
are the obvious values.  You would feed all tree entries and the pack
writer would split the stream up into the individual tree objects.

fast-import would generate the tree(s) delta'ing them against the
prior tree of the same path, prefix "tree nnn\n" to the commit
blob you supplied, generate the commit, and print out its ID.
By working from the first commit up to the most recent each tree
deltas would be using the older tree as the base which may not be
ideal if a large number of items get added to a tree but should be
effective enough to generate a reasonably sized initial pack.

It would however mean you need to monitor the output pipe from
fast-import to get back the commit id so you can use it to prep
the next commit's parent(s) as you can't produce that in Python.

-- 
Shawn.
