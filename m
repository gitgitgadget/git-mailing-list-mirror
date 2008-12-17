From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Committer, author and tagger time should not be
	parsed as 32 bit signed int
Date: Wed, 17 Dec 2008 14:48:44 -0800
Message-ID: <20081217224844.GK32487@spearce.org>
References: <200812172328.07371.robin.rosenberg.lists@dewire.com> <1229553172-2038-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD5Dm-0002bW-65
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYLQWsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYLQWsp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:48:45 -0500
Received: from george.spearce.org ([209.20.77.23]:34091 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbYLQWsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:48:45 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7230F38200; Wed, 17 Dec 2008 22:48:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229553172-2038-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103406>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> If not dates past 2038 will be parsed the wrong way when
> parsed into a RevCommit or RevTag object.

Uhm, sure.

But there's also the commitTime field in RevCommit, its used to
sort commits during walking.  In 2038 that will also overflow.

Also, if you search the code for '2038' you'll find a remark
about the year 2038 in DirCacheEntry.smudgeRacilyClean.  Last
I looked at the git sources I think this field in the index is
treated as a signed time_t so we can't set the high bits and
extend it out another 60+ years.

Honestly, I'm not sure this patch is worth the code duplication
without fixing our other two known 2038 problem spots... and
I really don't want to make RevCommit.commitTime into a long,
as that will bloat out the object allocations and slow down the
comparsion on 32 bit JVMs.  Right now at the end of 2008 the memory
isn't as readily available and there's still a lot of 32 bit JVMs.
Another 10 years we'll probably be looking at 256 bit wide registers
being very common, and 1 PB of core memory, and extending these
fields out to a long will be trivial.  And we'll still have 20
years to make the transition.

I'd rather just tag the fields with "2038" so we can search for
them in the future.  Like say this:

--8<--
Mark the other two locations that break in the year 2038

When the 32 bit timestamp rolls over in 2038 these spots in JGit
will break, unless we upgrade them to use a 64 bit long before then.
For now its too time and memory intensive to use a full long here,
but in another 10 years we should have enough computing power that
this is a moot point and we can upgrade the code paths marked with
by 'git grep 2038'.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    2 ++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 9d30018..bcfd8c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -129,6 +129,8 @@ else if (nParents == 1) {
 		ptr = RawParseUtils.committer(raw, ptr);
 		if (ptr > 0) {
 			ptr = RawParseUtils.nextLF(raw, ptr, '>');
+
+			// In 2038 commitTime will overflow unless it is changed to long.
 			commitTime = RawParseUtils.parseBase10(raw, ptr, null);
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 55a3001..c2d591b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -414,6 +414,8 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 		final String email = decode(cs, raw, emailB, emailE - 1);
 
 		final MutableInteger ptrout = new MutableInteger();
+
+		// In 2038 "when" will overflow.  Switch to a long before then.
 		final int when = parseBase10(raw, emailE + 1, ptrout);
 		final int tz = parseTimeZoneOffset(raw, ptrout.value);
 
-- 
1.6.1.rc3.302.gb14d9


-- 
Shawn.
