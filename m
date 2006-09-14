From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Thu, 14 Sep 2006 15:21:19 -0400
Message-ID: <20060914192119.GC10556@spearce.org>
References: <4509A7EC.9090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 21:21:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNwm7-0005Jw-0g
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWINTVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWINTVY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:21:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37053 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751061AbWINTVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 15:21:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNwlt-0002Rb-HD; Thu, 14 Sep 2006 15:21:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9DA5F20FB1F; Thu, 14 Sep 2006 15:21:19 -0400 (EDT)
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <4509A7EC.9090805@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27029>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> The contents of the index file still reflect the full tree but flag each
> object (file or symlink) separately as part of the checkout or not. The
> WD_Prefix string is so that a partial checkout consisting of only
> objects somewhere in the a/b/c/d/ tree can be found in the working
> directory without the a/b/c/d/ prefix to the path of the object.

Why not just load a partial index?

If we only want "a/b/c/d" subtree then only load that into the index.
At git-write-tree time return the new root tree by loading the tree
of the current `HEAD` commit and walking down to a/b/c/d, updating
that with the tree from the index, then walking back updating each
node you recursed down through.  Finally output the new root tree.

The advantage is that if you have a subtree checked out you aren't
working with the entire massive index.

But how does this let the user checkout and work on the 10 top
level directories at once and perform an atomic commit to all
of them, but not checkout the other 100+ top level directories?
As I recall this was desired in the Mozilla project for example.
 
> [*3*] Possibly split the index up by directory and store the parts in
> the working directory. An index "distributed" in this way would have
> a "natural" cache-tree built in and (finally) be able support empty
> directories.

Please, no.  On a project with a large number of directories
operations like git-write-tree would take a longer time to scan the
index and generate the new trees.  I unfortunately work on such
projects as its common for Java applications to be very deeply
nested and large projects have a *lot* of directories.

-- 
Shawn.
