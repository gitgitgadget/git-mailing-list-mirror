From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Re: blinking test
	WindowCacheGetTest.testCache_TooSmallLimit
Date: Sat, 25 Jul 2009 12:42:54 -0700
Message-ID: <20090725194254.GC11191@spearce.org>
References: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com> <20090724225118.GZ11191@spearce.org> <200907251934.37145.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 21:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUn95-00021e-SJ
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbZGYTmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 15:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZGYTmy
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:42:54 -0400
Received: from george.spearce.org ([209.20.77.23]:56240 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZGYTmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 15:42:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8C15B381FD; Sat, 25 Jul 2009 19:42:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907251934.37145.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124061>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> > > The test WindowCacheGetTest.testCache_TooSmallLimit sometimes fails
> > > (on less than third of runs on Windows) with the following stacktrace:
> 
> Could it be threading-related (cache). I've never seen it on the machine where I build for
> the update site and it is a single core machine, but I "this" machine that has two cores it happens, not
> as offen as 1/6, but enough to annoy me a bit, perhaps 1/20. If it is related to bad synchronization
> it should happen more often the more cores you have.

No, its not threading related.  I think I at least partially
understand what is going on.

WindowCache's base class, OffsetCache, does evictions by randomly
selecting a starting point in the table, and then scanning at most
evictBatch segments of the table before giving up.

When testCache_TooSmallLimit needs to access another window it must
first evict the current window, as the cache size is set to exactly
1 window in this test.

If the RNG selects the starting point at an empty segment, and
evictBatch is smaller than the total table size, we may not scan
the segment which contains an open window.  The eviction stops
before it actually expires an entry, and the cache is permitted to
allocate more than it was supposed to.

The test failure is random due to two different things going on:

 - The starting point for eviction is determined by an RNG, whose
   seed is initialized randomly at the start of the tests.

 - The position of a given entry in the segment table is partially
   determined by the System.identityHashCode of the PackFile instance
   it is being loaded for.  Since that differs as the JVM allocs
   and reclaims objects, there is some randomness caused by the
   order tests are run in.

However, in this test I'm still not quite sure why its failing,
because evictBatch is equal to the table size (both 2), so any
eviction here should have scanned the full table.

-- 
Shawn.
