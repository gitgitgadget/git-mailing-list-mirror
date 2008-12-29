From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-cherry: make <upstream> parameter optional
Date: Mon, 29 Dec 2008 18:45:20 +0100
Message-ID: <200812291845.20500.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 18:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHMCT-0007ke-Lv
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 18:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbYL2RpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 12:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYL2RpN
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 12:45:13 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:39251 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYL2RpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 12:45:12 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8F740FB3D030
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 18:45:10 +0100 (CET)
Received: from [91.19.66.120] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LHMAw-00007R-00
	for git@vger.kernel.org; Mon, 29 Dec 2008 18:45:10 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/V1P6luozwaSqVrBaQ9OjLNc7NlfuHcHfM/dNP
	O4L2K9QSZjEoSFRf66qqkqziqAEUTG4cNZ+Ez5yzPWjb1RfSE0
	xcQsIGiGE/demPuBy2/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104118>

The upstream branch <upstream> now defaults to the first tracked
remote branch, which is set by the configuration variables
branch.<name>.remote and branch.<name>.merge of the current branch.

Without such a remote branch, the command "git cherry [-v]" fails with
usage output as before and an additional message.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

I'm not sure, whether the usage output would be still necessary.

 Documentation/git-cherry.txt |    3 ++-
 builtin-log.c                |   16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 74d14c4..556ea23 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
-'git cherry' [-v] <upstream> [<head>] [<limit>]
+'git cherry' [-v] [<upstream>] [<head>] [<limit>]
 
 DESCRIPTION
 -----------
@@ -51,6 +51,7 @@ OPTIONS
 
 <upstream>::
 	Upstream branch to compare against.
+	Defaults to the first tracked remote branch, if available.
 
 <head>::
 	Working branch; defaults to HEAD.
diff --git a/builtin-log.c b/builtin-log.c
index 99d1137..243f857 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -16,6 +16,7 @@
 #include "patch-ids.h"
 #include "run-command.h"
 #include "shortlog.h"
+#include "remote.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -1070,13 +1071,14 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 }
 
 static const char cherry_usage[] =
-"git cherry [-v] <upstream> [<head>] [<limit>]";
+"git cherry [-v] [<upstream>] [<head>] [<limit>]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct patch_ids ids;
 	struct commit *commit;
 	struct commit_list *list = NULL;
+	struct branch *current_branch;
 	const char *upstream;
 	const char *head = "HEAD";
 	const char *limit = NULL;
@@ -1099,7 +1101,17 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		upstream = argv[1];
 		break;
 	default:
-		usage(cherry_usage);
+		current_branch = branch_get(NULL);
+		if (!current_branch || !current_branch->merge
+					|| !current_branch->merge[0]
+					|| !current_branch->merge[0]->dst) {
+			fprintf(stderr, "Could not find a tracked"
+					" remote branch, please"
+					" specify <upstream> manually.\n");
+			usage(cherry_usage);
+		}
+
+		upstream = current_branch->merge[0]->dst;
 	}
 
 	init_revisions(&revs, prefix);
-- 
1.6.1.35.ge4490
