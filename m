From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/6] diff-lib: use ce_mode_from_stat() rather than messing
 with modes manually
Date: Mon, 9 Apr 2007 21:13:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092112540.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:01:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7jd-0006Rx-NW
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbXDJENe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbXDJENe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:13:34 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42917 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933030AbXDJENd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:13:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4DUPD025547
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:13:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4DT5w030995;
	Mon, 9 Apr 2007 21:13:30 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.953 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44107>


The diff helpers used to do the magic mode canonicalization and all the
other special mode handling by hand ("trust executable bit" and "has
symlink support" handling).

That's bogus. Use "ce_mode_from_stat()" that does this all for us.

This is also going to be required when we add support for links to other
git repositories.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 diff-lib.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 5c5b05b..c6d1273 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -357,7 +357,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 					continue;
 			}
 			else
-				dpath->mode = canon_mode(st.st_mode);
+				dpath->mode = ntohl(ce_mode_from_stat(ce, st.st_mode));
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -374,8 +374,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 					int mode = ntohl(nce->ce_mode);
 					num_compare_stages++;
 					hashcpy(dpath->parent[stage-2].sha1, nce->sha1);
-					dpath->parent[stage-2].mode =
-						canon_mode(mode);
+					dpath->parent[stage-2].mode = ntohl(ce_mode_from_stat(nce, mode));
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
 				}
@@ -424,15 +423,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 		if (!changed && !revs->diffopt.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
-
-		newmode = canon_mode(st.st_mode);
-		if (!trust_executable_bit &&
-		    S_ISREG(newmode) && S_ISREG(oldmode) &&
-		    ((newmode ^ oldmode) == 0111))
-			newmode = oldmode;
-		else if (!has_symlinks &&
-		    S_ISREG(newmode) && S_ISLNK(oldmode))
-			newmode = oldmode;
+		newmode = ntohl(ce_mode_from_stat(ce, st.st_mode));
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
 			    ce->name, NULL);
-- 
1.5.1.110.g1e4c
