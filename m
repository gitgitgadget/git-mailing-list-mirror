From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: JGit server performance
Date: Sat, 7 Mar 2009 19:22:14 -0800
Message-ID: <20090308032214.GU16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 04:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg9gT-0005eR-Q9
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 04:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZCHDWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 22:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbZCHDWQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 22:22:16 -0500
Received: from george.spearce.org ([209.20.77.23]:59321 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZCHDWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 22:22:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5BBAF38211; Sun,  8 Mar 2009 03:22:14 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112610>

As Gerrit Code Review provides Gitosis-like functionality, but
that is implemented through JGit's pure Java implementation, the
performance of JGit's UploadPack matters to me.

JGit is about 66% slower on my hardware when cloning the linux-2.6
repository, compared to git-core (jgit 2m21s, git-core 1m23s).

The bottlenecks are:

  ~41.2% in ObjectLoader.getCachedBytes()

    This is the tree objects being parsed out of the pack file.
    The problem here (I believe) is we have horrible locality
    when reading.  The delta base for a tree isn't in memory most
    of the time, because its been evicted by other trees accessed
    since the last time that tree was touched.

    Conceptually this makes some sense, as ObjectWalk does a depth
    first traversal through the tree of each commit, in most-recent
    to least-recent commit order.  On a larger project like the
    kernel we'll touch a lot more objects between two root trees,
    and there isn't even any guarantee that two root trees that
    appear near each other in the commit sequence have a delta
    base relationship.

  ~20.5% in AbstractTreeIterator.getEntryObjectId()

    The bulk of the time here is really down in NB.decodeInt32().
    We spend a lot of time converting an object id in a tree data
    stream into an AnyObjectId (really a reused MutableObjectId)
    so that we can probe the ObjectIdSubclassMap to see if we have
    seen this object before.

    The sad fact is, we need all 20 bytes to be converted into the 5
    words, because the majority of the time, we have actually seen
    the object before, and it exists in our hash table.  The only
    way to know is to convert and compare all 5 words.  Any attempt
    to lazily convert the 5 words would just make it slower.

... and it falls off from there.

I'm at a loss on how to improve the performance.  I don't think that
we can do anything about the 20% in getEntryObjectId() due to the
way our data structures are organized around the 5-word ObjectId,
and not a byte[].  That 20% is a penalty git-core doesn't have to
pay, and is most certainly one reason why JGit is so much slower.

The only thing that may work is to modify ObjectWalk to try and
deduce some delta-chain locality from the pack.  Buffer up objects
that it needs to parse in a queue, rank them by the delta base
they would need to use, and then try to unfold the base first,
and then the children.

That is, do something like what IndexPack does, where we try to
unpack each object exactly once, and recursively process the delta
chain children after unpacking the parent.

We _might_ get better locality if we can queue up all root trees,
process all of them, then process the first level children, etc,
so go breadth first.

But that seems like a lot of code, and it probably wrecks the simple
recency ordering produced natively by ObjectWalk.  :-\

-- 
Shawn.
