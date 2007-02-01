From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Don't find objects in packs which aren't available anymore.
Date: Thu, 1 Feb 2007 15:52:38 -0500
Message-ID: <20070201205238.GD19009@spearce.org>
References: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCivN-0000bC-T0
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbXBAUwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423005AbXBAUwn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:52:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43575 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423003AbXBAUwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:52:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCiv2-0005Kr-KL; Thu, 01 Feb 2007 15:52:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED68520FBAE; Thu,  1 Feb 2007 15:52:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38400>

Matthias Lederhofer identified a race condition where a Git reader
process was able to locate an object in a packed_git index, but
was then preempted while a `git repack -a -d` ran and completed.
By the time the reader was able to seek in the packfile to get the
object data, the packfile no longer existed on disk.

In this particular case the reader process did not attempt to
open the packfile before it was deleted, so it did not already
have the pack_fd field popuplated.  With the packfile itself gone,
there was no way for the reader to open it and fetch the data.

I'm fixing the race condition by teaching find_pack_entry to ignore
a packed_git whose packfile is not currently open and which cannot
be opened.  If none of the currently known packs can supply the
object, we will return 0 and the caller will decide the object is
not available.  If this is the first attempt at finding an object,
the caller will reprepare_packed_git and try again.  If it was
the second attempt, the caller will typically return NULL back,
and an error message about a missing object will be reported.

This patch does not address the situation of a reader which is
being starved out by a tight sequence of `git repack -a -d` runs.
In this particular case the reader will try twice, probably fail
both times, and declare the object in question cannot be found.
As it is highly unlikely that a real world `git repack -a -d` can
complete faster than a reader can open a packfile, so I don't think
this is a huge concern.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 277319b..37669d6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1405,6 +1405,18 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 		}
 		offset = find_pack_entry_one(sha1, p);
 		if (offset) {
+			/*
+			 * We are about to tell the caller where they can
+			 * locate the requested object.  We better make
+			 * sure the packfile is still here and can be
+			 * accessed before supplying that answer, as
+			 * it may have been deleted since the index
+			 * was loaded!
+			 */
+			if (p->pack_fd == -1 && open_packed_git(p)) {
+				error("packfile %s cannot be accessed", p->pack_name);
+				continue;
+			}
 			e->offset = offset;
 			e->p = p;
 			hashcpy(e->sha1, sha1);
-- 
1.5.0.rc3.1.ge4b0e
