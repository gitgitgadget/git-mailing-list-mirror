From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [announce] (nearly) full jgit revision machinary
Date: Fri, 14 Mar 2008 03:20:00 -0400
Message-ID: <20080314072000.GX8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 08:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja4Di-0005ej-Gr
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 08:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbYCNHUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 03:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYCNHUI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 03:20:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38631 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYCNHUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 03:20:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ja4Cu-0004tP-ES; Fri, 14 Mar 2008 03:20:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8AFF820FBAE; Fri, 14 Mar 2008 03:20:00 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77186>

I have a nearly complete revision machinary implementation for jgit.
The series follows on top of my pack index v2 work, which is in my
master branch of repo.or.cz/egit/spearce.git.

This series started because I found the History view was just too
slow for words.  Running JProbe on Eclipse pointed out that our
existing revision walking code was not up to the challenge of a
real-world sized repository.

Here goes a summary...  series is here:

    git://repo.or.cz/egit/spearce.git revwalk


  Fixes and cleanups
  ------------------
    * Correct unsigned integer conversion issues
    * Include refs/remotes as part of the ref search path
    * Only use bytes 1-5 for a SHA-1 ObjectId hashCode
    * Fix the OBJECT_ID_LENGTH constant at 20
    * Hand unroll the ObjectId.equals method
    * Don't bother caching commits in the delta base cache
    * Teach FileMode how to return the proper instance of itself
    * Teach FileMode about S_IFGITLINK being 0160000
    * Teach FileMode about MISSING being 0

    These have nothing to do with the series directly, but were
    done to improve its code or fix some earlier bugs.


  Revision Machinary
  ------------------
    * New revision walking library for jgit
    * Teach RevWalk about uninteresting commits
    * Document the flag constants used in RevWalk
    * Implement a commit filtering API for RevWalk
    * Make all RevFilter implementations cloneable
    * Allow RevFilters to break out of the main walk loop
    * Implement a commit time based RevFilter for before/after filtering
    * Refactor basic commit walking from RevWalk to a streamable iterator API
    * Evaluate RevFilters before inserting parent commits to pending
    * Dispose of a RevCommit as soon as it is no longer interesting
    * Use a FIFO queue of RevCommit during reset rather than sorting by date

    Aside from --topo-order this is a nearly full revision machinary.
    Features like --author, --committer, --grep, --not, all work.
    We don't parse "A..B" but we can do it as "A --not B", or
    "A ^B ^C D".

    The package's performance on Java 6/x86/Windows is well within
    spitting distance of Git on Cygwin.  I'm seeing jgit take just
    over 50 ms longer to produce back ~13,000 commits.

    I'll get --topo-order done soon, most likely this weekend. It
    will probably also get an incremental restart trick like we do
    in C Git, where we shovel the data out as early as we can but
    signal a restart if topo order was violated.

    Memory can still be reduced a tad, but its fast as heck.
    Our main suckage for memory is the ObjectId class.  On a modern
    HotSpot JVM it costs 44 bytes to store a 20 byte SHA-1.  I think
    our second main suckage is the ObjectIdMap.  java.util.HashMap is
    not that efficient when it comes to memory usage.


  Tree Diff
  ---------
    * New tree walking library for jgit
    * Implement a tree entry filtering API for TreeWalk
    * Define a path limiter for TreeWalk to reduce results

    Turns out the Tree class is too slow for serious work.  This is
    a concurrent tree walker that can do an N-way difference of
    an arbitrary number of trees, recursively and shallow.  We can
    also limit the difference to only entries matching a particular
    filter expression.

    I spent a good amount of time tuning this library, but it
    probably can still benefit from more micro-optimization.  Java is
    just dog slow, but I think we're doing almost the best we can.

    At present this library only does tree objects, but it should
    also be able to walk the local filesystem and an index (or
    two or three) concurrently with trees.  I'll implement those
    other iterators in the near future.


  Path Limiter & Parent Rewrites
  ------------------------------
    * Implement path limited revision walking and parent rewriting
    * Allow revwalk and treewalk to directly access cached object data

    These changes give us functionality like "git log HEAD -- foo.c",
    where the DAG gets subsetted down to only those commits that
    had an interesting change against foo.c.  Yes, it also works
    on directories and combinations of paths.

    I've done a bunch of manual testing and differencing against
    the C Git output for the same inputs, and jgit is producing
    identical results.  That's with "--parents".  So we can now
    get a dense, plottable subsetted DAG. Yay.

    When the path limiter is enabled we spend ~98% of our CPU time
    inside of the treewalk package introduced above for the tree
    difference feature.  Its horribly slow.  If the path we are
    looking for is early enough in the tree we're not too far off
    from C Git's performance, but try matching on say "t" and the
    world falls over.  We are 4x slower.


  Fixes and cleanups
  ------------------
    * Implement some basic command line programs built on top of jgit

    This a "jgit" command line wrapper, along with basic subcommand
    tools like "log", "rev-list", "ls-tree" and "diff-tree", all
    built on top of the above functionality.  jgit is starting to
    feel like it is actually capable of doing some of the major
    functions C Git does.

    "jgit log | less" has a slight lag before the first commit when
    compared to "git log", but is still faster than "svn log".  ;-


-- 
Shawn.
