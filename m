From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 22/23] cmd_merge(): Parse options before checking MERGE_HEAD
Date: Tue, 09 Nov 2010 22:49:58 +0100
Message-ID: <1289339399-4733-23-git-send-email-johan@herland.net>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 22:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFw6F-0000yR-LM
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab0KIVvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:51:13 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61168 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755476Ab0KIVuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:50:32 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN005XL0NOCV30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:20 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 833E11799801_CD9C21CB	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:20 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4B8CB1797775_CD9C21CF	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:19 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN00HVN0NLS730@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:15 +0100 (MET)
X-Mailer: git-send-email 1.7.3.2.173.gab1c9.dirty
In-reply-to: <1289339399-4733-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161085>

Reorder the initial part of builtin/merge.c:cmd_merge() so that command-line
options are parsed _before_ we load the index and check for MERGE_HEAD
(and exits if it exists). This does not change the behaviour of 'git merge',
but is needed in preparation for the implementation of 'git merge --abort'
(which requires MERGE_HEAD to be present).

This patch has been improved by the following contributions:
- Junio C Hamano: fixup minor style issues

Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/merge.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..478a492 100644
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
+	if (read_cache_unmerged())
+		die_resolve_conflict("merge");
+
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
