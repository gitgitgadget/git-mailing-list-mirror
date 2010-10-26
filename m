From: Johan Herland <johan@herland.net>
Subject: [PATCHv5.1 22/23] cmd_merge(): Parse options before checking MERGE_HEAD
Date: Tue, 26 Oct 2010 03:30:27 +0200
Message-ID: <201010260330.29194.johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <201010251203.00389.johan@herland.net> <201010260326.33200.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 03:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAYN2-0007Jh-HP
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 03:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0JZBab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 21:30:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48806 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab0JZBab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 21:30:31 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAV0066UIUUXN00@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Oct 2010 03:30:30 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E19CC1799423_CC62F35B	for <git@vger.kernel.org>; Tue,
 26 Oct 2010 01:30:29 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C3FBA1796294_CC62F35F	for <git@vger.kernel.org>; Tue,
 26 Oct 2010 01:30:29 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAV006FSIUT1Y00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Oct 2010 03:30:29 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <201010260326.33200.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159976>

Reorder the initial part of builtin/merge.c:cmd_merge() so that command-line
options are parsed _before_ we load the index and check for MERGE_HEAD
(and exits if it exists). This does not change the behaviour of 'git merge',
but is needed in preparation for the implementation of 'git merge --abort'
(which requires MERGE_HEAD to be present).

Signed-off-by: Johan Herland <johan@herland.net>
---

In the previous version of this patch, I somehow managed to misplace
parts of t7609 here instead of in the next commit. Fixed now.

Otherwise, no changes.


...Johan

 builtin/merge.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..702f399 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -895,22 +895,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
 
-	if (read_cache_unmerged()) {
-		die_resolve_conflict("merge");
-	}
-	if (file_exists(git_path("MERGE_HEAD"))) {
-		/*
-		 * There is no unmerged entry, don't advise 'git
-		 * add/rm <file>', just 'git commit'.
-		 */
-		if (advice_resolve_conflict)
-			die("You have not concluded your merge (MERGE_HEAD exists).\n"
-			    "Please, commit your changes before you can merge.");
-		else
-			die("You have not concluded your merge (MERGE_HEAD exists).");
-	}
-
-	resolve_undo_clear();
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
@@ -929,6 +913,23 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
+
+	if (read_cache_unmerged()) {
+		die_resolve_conflict("merge");
+	}
+	if (file_exists(git_path("MERGE_HEAD"))) {
+		/*
+		 * There is no unmerged entry, don't advise 'git
+		 * add/rm <file>', just 'git commit'.
+		 */
+		if (advice_resolve_conflict)
+			die("You have not concluded your merge (MERGE_HEAD exists).\n"
+			    "Please, commit your changes before you can merge.");
+		else
+			die("You have not concluded your merge (MERGE_HEAD exists).");
+	}
+	resolve_undo_clear();
+
 	if (verbosity < 0)
 		show_diffstat = 0;
 
-- 
1.7.3.2.173.gab1c9.dirty
