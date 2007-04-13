From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Fix gitlink index entry filesystem matching
Date: Fri, 13 Apr 2007 09:24:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130923440.28042@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704130919070.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 18:24:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOZS-0000Cm-5i
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbXDMQYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXDMQYS
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:24:18 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40233 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbXDMQYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:24:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DGOFIs024612
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 09:24:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DGOE1Z004041;
	Fri, 13 Apr 2007 09:24:14 -0700
In-Reply-To: <Pine.LNX.4.64.0704130919070.28042@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44420>


The code to match up index entries with the filesystem was stupidly
broken.  We shouldn't compare the filesystem stat() information with
S_IFDIRLNK, since that's purely a git-internal value, and not what the
filesystem uses (on the filesystem, it's just a regular directory).

Also, don't bother to make the stat() time comparisons etc for DIRLNK
entries in ce_match_stat_basic(), since we do an exact match for these
things, and the hints in the stat data simply doesn't matter.

This fixes "git status" with submodules that haven't been checked out in
the supermodule.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 read-cache.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4040fac..72d7d7c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -123,9 +123,9 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 		if (ce_compare_link(ce, xsize_t(st->st_size)))
 			return DATA_CHANGED;
 		break;
-	case S_IFDIRLNK:
-		/* No need to do anything, we did the exact compare in "match_stat_basic" */
-		break;
+	case S_IFDIR:
+		if (S_ISDIRLNK(ntohl(ce->ce_mode)))
+			return 0;
 	default:
 		return TYPE_CHANGED;
 	}
@@ -156,7 +156,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 			changed |= TYPE_CHANGED;
 		else if (ce_compare_gitlink(ce))
 			changed |= DATA_CHANGED;
-		break;
+		return changed;
 	default:
 		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
 	}
-- 
1.5.1.1.786.gdc49a-dirty
