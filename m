From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 00:23:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505112350420.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 06:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW57p-0001OX-6I
	for gcvg-git@gmane.org; Thu, 12 May 2005 06:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVELEYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 00:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVELEYH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 00:24:07 -0400
Received: from iabervon.org ([66.92.72.58]:43524 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261163AbVELEYC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 00:24:02 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DW5Ea-0006RK-00; Thu, 12 May 2005 00:23:40 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've come up with a way to handle projects like cogito which are based on
other projects. I think that it actually solves the real problem with such
projects, and it is actually very simple.

The problem that such projects run into, especially while both the core
and the non-core projects are in a state of substantial flux and when the 
non-core developer(s) contribute needed changes to the core, is that the
two projects not only have to be tracked, they have to be kept in 
sync. That is, a particular version of cogito requires a particular
version of git. There is a bit of convenience to having the tools
magically do the right thing when you check out the child project, but the
thing that really requires tool support is that you need to be able to
find the version of git-pb which matches the version of cogito you're
trying to build (and you might be searching the history for where a bug
was introduced, so you may not be able to use the latest of either).

The solution is to add a header to commits: "include {hash}", which simply
says that the given hash, which is from the core project, is the commit
needed to build this commit of the non-core project. This comes from an
argument to commit-tree ("-I", perhaps), and the parsing code needs to
identify the reference so that fsck-cache stays happy.

Git doesn't do anything more; wrapping layers would be able to take care
of the rest. When the wrapping layer determines that you are checking out
a commit with an include header, it also checks out the included commit,
using a different index file. The core treats everything as if you had a
bunch of non-tracked files in the directory (those being the things in the
other project). When you commit, it first commits any includes (if
needed), identifies the resulting core head, and passes that to the
include for the final result.

It seems to me like this should work perfectly. The one weakness is that
it's quite annoying to do by hand, since you have to simultaneously track
two index files and remember to pass the argument to commit-tree each
time. (Also, it means that you'd ideally pull git-pb from the cogito
repository with a client that ignores things not reachable from your head,
although Petr could still just copy and prune to match the current
situation).

I've written up the git changes needed, if people are interested in the
patch.

	-Daniel
*This .sig left intentionally blank*

