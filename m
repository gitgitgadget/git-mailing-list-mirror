From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/5] Update fast-import documentation to discuss crash reports
Date: Thu, 14 Feb 2008 01:34:46 -0500
Message-ID: <20080214063446.GE30678@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXhE-0005F9-GL
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761492AbYBNGew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758536AbYBNGew
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:34:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60661 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756910AbYBNGet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:34:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXgF-0004Vo-Of; Thu, 14 Feb 2008 01:34:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 715B920FBAE; Thu, 14 Feb 2008 01:34:46 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73858>

Recent versions of fast-import will now dump information out upon
crashing, making it possible for the frontend developer to review
some state information and possibly restart the import from the
point where it crashed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fast-import.txt |   87 +++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bd625ab..96f6767 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -805,6 +805,93 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+Crash Reports
+-------------
+If fast-import is supplied invalid input it will terminate with a
+non-zero exit status and create a crash report in the top level of
+the Git repository it was importing into.  Crash reports contain
+a snapshot of the internal fast-import state as well as the most
+recent commands that lead up to the crash.
+
+All recent commands (including stream comments, file changes and
+progress commands) are shown in the command history within the crash
+report, but raw file data and commit messages are excluded from the
+crash report.  This exclusion saves space within the report file
+and reduces the amount of buffering that fast-import must perform
+during execution.
+
+After writing a crash report fast-import will close the current
+packfile and export the marks table.  This allows the frontend
+developer to inspect the repository state and resume the import from
+the point where it crashed.  The modified branches and tags are not
+updated during a crash, as the import did not complete successfully.
+Branch and tag information can be found in the crash report and
+must be applied manually if the update is needed.
+
+An example crash:
+
+====
+	$ cat >in <<END_OF_INPUT
+	# my very first test commit
+	commit refs/heads/master
+	committer Shawn O. Pearce <spearce> 19283 -0400
+	# who is that guy anyway?
+	data <<EOF
+	this is my commit
+	EOF
+	M 644 inline .gitignore
+	data <<EOF
+	.gitignore
+	EOF
+	M 777 inline bob
+	END_OF_INPUT
+
+	$ git-fast-import <in
+	fatal: Corrupt mode: M 777 inline bob
+	fast-import: dumping crash report to .git/fast_import_crash_8434
+
+	$ cat .git/fast_import_crash_8434
+	fast-import crash report:
+	    fast-import process: 8434
+	    parent process     : 1391
+	    at Sat Sep 1 00:58:12 2007
+
+	fatal: Corrupt mode: M 777 inline bob
+
+	Most Recent Commands Before Crash
+	---------------------------------
+	  # my very first test commit
+	  commit refs/heads/master
+	  committer Shawn O. Pearce <spearce> 19283 -0400
+	  # who is that guy anyway?
+	  data <<EOF
+	  M 644 inline .gitignore
+	  data <<EOF
+	* M 777 inline bob
+
+	Active Branch LRU
+	-----------------
+	    active_branches = 1 cur, 5 max
+
+	  pos  clock name
+	  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+	   1)      0 refs/heads/master
+
+	Inactive Branches
+	-----------------
+	refs/heads/master:
+	  status      : active loaded dirty
+	  tip commit  : 0000000000000000000000000000000000000000
+	  old tree    : 0000000000000000000000000000000000000000
+	  cur tree    : 0000000000000000000000000000000000000000
+	  commit clock: 0
+	  last pack   :
+
+
+	-------------------
+	END OF CRASH REPORT
+====
+
 Tips and Tricks
 ---------------
 The following tips and tricks have been collected from various
-- 
1.5.4.1.1309.g833c2
