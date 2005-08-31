From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Reorganize read-tree
Date: Tue, 30 Aug 2005 23:48:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 05:46:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAJX2-0002Oj-Pf
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 05:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVHaDon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 23:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHaDon
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 23:44:43 -0400
Received: from iabervon.org ([66.92.72.58]:63504 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932345AbVHaDon (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 23:44:43 -0400
Received: (qmail 32440 invoked by uid 1000); 30 Aug 2005 23:48:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Aug 2005 23:48:27 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7968>

I got mostly done with this before Linus mentioned the possibility of
having multiple index entries in the same stage for a single path. I
finished it anyway, but I'm not sure that we won't want to know which of
the common ancestors contributed which, and, if some of them don't have a
path, we wouldn't be able to tell. The other advantages I see to this
approach are:

 - it uses the more common parser of tree objects, moving toward having
   only one (diff-cache still uses read_tree(), however).
 - it doesn't need to do very complicated things with the index; the
   original read-tree does a bunch of stuff with an index with a gap in
   the middle containing obsolete entries.
 - it uses a much simpler method of finding directory/file conflicts,
   which is possible because the struct trees represent directories as
   well as files.
 - it deals with each path completely before going on to the next one,
   instead of first dealing with each input tree and then dealing with
   each path.
 - it removes a lot of intimate knowledge of the index structure from the
   program.

The general idea is that it figures out what trees you want, and then
iterates through the entry lists together, recursing into directories, and
calls the merge function with an array of the index entries (not yet
added) for the path in each tree; the merge function adds the appropriate
things to the index.

Note that this set doesn't include calling merge functions with multiple
ancestors or remotes; that can be done when we've decided on whether my
version of read-tree is worth using.

There are various potential refinements, plus removing a bunch of memory
leaks, still to do, but I think this is sufficiently close to review.

(Refinements: it ought to have two indices in memory, the old and the new,
and never modify the old and only append to the new, to simplify things
further; it ought to use a sentinal value for the index entry to indicate
that there is something in the tree to conflict with there being a file at
the given path; the --emu23 logic could be clearer)

The first patch adds a few functions to the object library.
The second patch changes read-tree around; It is essentially a rewrite,
except for the merge functions and main().

	-Daniel
*This .sig left intentionally blank*
