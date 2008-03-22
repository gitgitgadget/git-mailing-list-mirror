From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 8/7] When adding files to the index, add support for
 case-independent matches
Date: Sat, 22 Mar 2008 14:19:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221417430.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 22:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdB8Y-0004yD-BM
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 22:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbYCVVTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbYCVVTk
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 17:19:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32978 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754423AbYCVVTj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 17:19:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MLJWa6017650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 14:19:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MLJUY3027019;
	Sat, 22 Mar 2008 14:19:31 -0700
In-Reply-To: <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.754 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77851>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Sat, 22 Mar 2008 13:19:49 -0700

This simplifies the matching case of "I already have this file and it is 
up-to-date" and makes it do the right thing in the face of 
case-insensitive aliases.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is patch 1/2 to make "git add" act better. Discard the previous 
simplistic and overly die()-eager patch that I hadn't signed off on.

 read-cache.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5dc998d..8c57adf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -431,9 +431,9 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 {
-	int size, namelen, pos;
+	int size, namelen;
 	struct stat st;
-	struct cache_entry *ce;
+	struct cache_entry *ce, *alias;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
 	if (lstat(path, &st))
@@ -466,13 +466,11 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
 	}
 
-	pos = index_name_pos(istate, ce->name, namelen);
-	if (0 <= pos &&
-	    !ce_stage(istate->cache[pos]) &&
-	    !ie_match_stat(istate, istate->cache[pos], &st, ce_option)) {
+	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
+	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, &st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
-		ce_mark_uptodate(istate->cache[pos]);
+		ce_mark_uptodate(alias);
 		return 0;
 	}
 
-- 
1.5.5.rc0.31.gdcfd.dirty
