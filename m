X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] grep: do not skip unmerged entries when grepping in the working tree.
Date: Sun, 26 Nov 2006 12:49:46 -0800
Message-ID: <7vvel2rl05.fsf@assigned-by-dhcp.cox.net>
References: <ekc9q7$36e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 20:49:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekc9q7$36e$1@sea.gmane.org> (Johannes Sixt's message of "Sun, 26
	Nov 2006 15:53:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32367>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoQwk-0006ck-BX for gcvg-git@gmane.org; Sun, 26 Nov
 2006 21:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935540AbWKZUtt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935559AbWKZUtt
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 15:49:49 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53676 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S935553AbWKZUtr
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 15:49:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126204947.VWNS9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 15:49:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rYpv1V00k1kojtg0000000; Sun, 26 Nov 2006
 15:49:56 -0500
To: Johannes Sixt <johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org

We used to skip unmerged entries, which made sense for grepping
in the cached copies, but not for grepping in the files on the
working tree.

Noticed by Johannes Sixt.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
  Johannes Sixt <johannes.sixt@telecom.at> writes:

  > $ git-grep getSibling -- kdbg/exprwnd.h    # this file had a conflict
  > $ grep getSibling -- kdbg/exprwnd.h       
  >     { return static_cast<VarTree*>(getSibling()); }
  > $ git-update-index kdbg/exprwnd.h
  > $ git-grep getSibling -- kdbg/exprwnd.h       
  > kdbg/exprwnd.h:    { return static_cast<VarTree*>(getSibling()); }

  This is because unmerged entries were ignored.

 builtin-grep.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ad7dc00..9873e3d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -268,7 +268,7 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		char *name;
-		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
+		if (!S_ISREG(ntohl(ce->ce_mode)))
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
@@ -280,12 +280,19 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			memcpy(name + 2, ce->name, len + 1);
 		}
 		argv[argc++] = name;
-		if (argc < MAXARGS)
+		if (argc < MAXARGS && !ce_stage(ce))
 			continue;
 		status = exec_grep(argc, argv);
 		if (0 < status)
 			hit = 1;
 		argc = nr;
+		if (ce_stage(ce)) {
+			do {
+				i++;
+			} while (i < active_nr &&
+				 !strcmp(ce->name, active_cache[i]->name));
+			i--; /* compensate for loop control */
+		}
 	}
 	if (argc > nr) {
 		status = exec_grep(argc, argv);
@@ -316,14 +323,24 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 
 	for (nr = 0; nr < active_nr; nr++) {
 		struct cache_entry *ce = active_cache[nr];
-		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
+		if (!S_ISREG(ntohl(ce->ce_mode)))
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
-		if (cached)
+		if (cached) {
+			if (ce_stage(ce))
+				continue;
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0);
+		}
 		else
 			hit |= grep_file(opt, ce->name);
+		if (ce_stage(ce)) {
+			do {
+				nr++;
+			} while (nr < active_nr &&
+				 !strcmp(ce->name, active_cache[nr]->name));
+			nr--; /* compensate for loop control */
+		}
 	}
 	free_grep_patterns(opt);
 	return hit;
-- 
1.4.4.1.ge3fb

