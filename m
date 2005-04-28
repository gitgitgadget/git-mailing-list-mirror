From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 12:08:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504281147500.30848-100000@iabervon.org>
References: <200504271251.00635.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:03:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRBTR-0001bI-8u
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 18:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVD1QIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVD1QIO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 12:08:14 -0400
Received: from iabervon.org ([66.92.72.58]:57093 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261784AbVD1QIK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 12:08:10 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DRBYf-00004t-00; Thu, 28 Apr 2005 12:08:09 -0400
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504271251.00635.mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Chris Mason wrote:

> I haven't seen a tool yet to find which changeset modified a given file, so 
> I whipped up something.  The basic idea is to:

What is the answer supposed to be in the presence of merges? It seems like
you shouldn't report the merge that brought in the change, but rather
(assuming it's available) the changeset that originally made it.

That is:

go through the history tree:
  if a commit has a parent with a different version:
    if it also has a parent with the same version as the child, ignore the
      different parent(s) and enqueue the same parent(s)
    otherwise, report it (for a single head, it's the original change; for
      a merge, it merged two changes to the file)
  otherwise, enqueue all the parents

Sorting by time is probably not useful, because there must be some source
of the current version, and all paths going back, after ignoring versions
that were replaced by it in a merge, must go back to that source, so
depth-first search is fastest. (If there are multiple possible solutions,
then it means that multiple people applied the same patch, and any of them
should do).

This should be easy in C, but difficult in something that isn't generating
the history info itself.

	-Daniel
*This .sig left intentionally blank*

