From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/6] Add "S_IFDIRLNK" file mode infrastructure for git links
Date: Mon, 9 Apr 2007 21:14:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092114300.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7l8-0006iL-Qk
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082AbXDJEPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbXDJEPG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:15:06 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42959 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933082AbXDJEPE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:15:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4ExPD025592
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:14:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4Ewm5031030;
	Mon, 9 Apr 2007 21:14:58 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.953 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44112>


This just adds the basic helper functions to recognize and work with git
tree entries that are links to other git repositories ("subprojects").
They still aren't actually connected up to any of the code-paths, but
now all the infrastructure is in place.

The next commit will start actually adding actual subproject support.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 cache.h |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index eb57507..1b3d00e 100644
--- a/cache.h
+++ b/cache.h
@@ -25,6 +25,22 @@
 #endif
 
 /*
+ * A "directory link" is a link to another git directory.
+ *
+ * The value 0160000 is not normally a valid mode, and
+ * also just happens to be S_IFDIR + S_IFLNK
+ *
+ * NOTE! We *really* shouldn't depend on the S_IFxxx macros
+ * always having the same values everywhere. We should use
+ * our internal git values for these things, and then we can
+ * translate that to the OS-specific value. It just so
+ * happens that everybody shares the same bit representation
+ * in the UNIX world (and apparently wider too..)
+ */
+#define S_IFDIRLNK	0160000
+#define S_ISDIRLNK(m)	(((m) & S_IFMT) == S_IFDIRLNK)
+
+/*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
  *
@@ -104,6 +120,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
 {
 	if (S_ISLNK(mode))
 		return htonl(S_IFLNK);
+	if (S_ISDIR(mode) || S_ISDIRLNK(mode))
+		return htonl(S_IFDIRLNK);
 	return htonl(S_IFREG | ce_permissions(mode));
 }
 static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
@@ -121,7 +139,7 @@ static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned in
 }
 #define canon_mode(mode) \
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
-	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
+	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFDIRLNK)
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
-- 
1.5.1.110.g1e4c
