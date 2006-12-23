From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sat, 23 Dec 2006 02:33:17 -0500
Message-ID: <20061223073317.GA9837@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Nt-0001lG-21
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWLWHdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLWHdW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:33:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38723 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbWLWHdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:33:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1NH-000357-WF; Sat, 23 Dec 2006 02:32:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 465AD20FB65; Sat, 23 Dec 2006 02:33:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35281>

This 17 patch series implements my much discussed, but never produced
(until now), 'mmap sliding window' for packfile data access.

The key idea behind this topic is to mmap large non-contiguous
segments of a packfile rather than the entire file.  If available
virtual memory is getting low we unmap the least recently used
packfile segment to free up address space for the currently needed
segment.

This series also permits accessing packfiles up to 4 GiB in size,
even on systems which permit only 2 GiB of virtual memory within
a single process (e.g. Windows and some older UNIXes).  Of course
4 GiB is still the upper limit on packfile size due to the current
format of the index file.

This series is 'pu' ready, but it may be too early to bring it
directly into 'next'.

Patch summary
-------------

  1 - Replace unpack_entry_gently with unpack_entry.
  2 - Introduce new config option for mmap limit.
  3 - Refactor packed_git to prepare for sliding mmap windows.
  4 - Use off_t for index and pack file lengths.
  5 - Create read_or_die utility routine.
  6 - Refactor how we open pack files to prepare for multiple windows.

    Most of the above changes are incremental refactorings to help
    get the code in a state where we can start to implement and make
    use of the struct pack_window concept this series introduces.

  7 - Replace use_packed_git with window cursors.
  8 - Loop over pack_windows when inflating/accessing data.
  9 - Document why header parsing won't exceed a window.
 10 - Unmap individual windows rather than entire files.
 11 - Fully activate the sliding window pack access.

    These commits actually implement the core of the mmap sliding
    window implementation and the necessary garbage collection to
    support unmapping the least recently used window.

 12 - Load core configuration in git-verify-pack.
 13 - Ensure core.packedGitWindowSize cannot be less than 2 pages.
 14 - Improve error message when packfile mmap fails.
 15 - Support unmapping windows on 'temporary' packfiles.

    The above sequence of commits are bug fixes on top of the initial
    commits.  I did not fold these back into the earlier commits
    as I felt the bug fix commit messages provided useful details.

 16 - Create pack_report() as a debugging aid.
 17 - Test suite for sliding window mmap implementation.

    These provide debugging and testing tools.
