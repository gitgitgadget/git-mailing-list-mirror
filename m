From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Memory issue with fast-import, why track branches?
Date: Sun, 21 Dec 2008 14:17:02 -0800
Message-ID: <20081221221702.GC17355@spearce.org>
References: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWd2-0006ke-RD
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbYLUWRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYLUWRF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:17:05 -0500
Received: from george.spearce.org ([209.20.77.23]:46520 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYLUWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:17:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C95538200; Sun, 21 Dec 2008 22:17:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103721>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> I tracked down an issue I have when importing a big repository. For
> some reason memory usage keeps increasing until there is no more
> memory.
> 
> After looking at the code my guess is that I have a humongous amount
> of branches.
> 
> Actually they are not really branches, but refs. For each git commit
> there's an original mtn ref that I store in 'refs/mtn/sha1', but since
> I'm using 'commit refs/mtn/sha1' to store it, a branch is created for
> every commit.
> 
> I guess there are many ways to fix the issue, but for starters I
> wonder why is fast-import keeping track of all the branches? In my
> case I would like fast-import to work exactly the same if I specify
> branches or not (I'll update them later).

Because fast-import has to buffer them until the pack file is done.
The objects aren't available to the repository until after a
checkpoint is sent or until the stream ends.  Either way until
then fast-import has to buffer the refs so they don't get exposed
to other git processes reading that same repository, because they
would point to objects that the process cannot find.

I guess it could release the brnach memory after it dumps the
branches in a checkpoint, but its memory allocators work under an
assumption that strings (like branch and file names) will be reused
heavily by the frontend and thus they are poooled inside of a string
pool.  The branch objects are also pooled inside of a common alloc
pool, to ammortize the cost of malloc's block headers out over the
data used.

IOW, fast-import was designed for ~5k branches, not ~1 million
unique branches.

-- 
Shawn.
