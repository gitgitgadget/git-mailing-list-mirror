From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] git-cherry: make <upstream> parameter optional
Date: Thu, 1 Jan 2009 22:56:29 +0100
Message-ID: <200901012256.29546.markus.heidelberg@web.de>
References: <200812291845.20500.markus.heidelberg@web.de> <7vr63mivx3.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 22:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIVZy-00034N-8W
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZAAV4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbZAAV4Y
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:56:24 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:46482 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbZAAV4X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:56:23 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id E7D0CFB5659E;
	Thu,  1 Jan 2009 22:56:14 +0100 (CET)
Received: from [89.59.70.163] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LIVWY-0008Ci-00; Thu, 01 Jan 2009 22:56:14 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vr63mivx3.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18wuYjSRN7WoWrP0aVz6OcZBpoRa927oXlOUnLb
	Y/FWwS4GlD0R5dnJNQt+qMurLBJYTSFaX5whoo8lAwSzcO1Mze
	C7PqJ+fdySNR4MxXWrmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104331>

The upstream branch <upstream> now defaults to the first tracked
remote branch, which is set by the configuration variables
branch.<name>.remote and branch.<name>.merge of the current branch.

Without such a remote branch, the command "git cherry [-v]" fails with
usage output as before and an additional message.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Junio C Hamano, 01.01.2009:
> > -'git cherry' [-v] <upstream> [<head>] [<limit>]
> > +'git cherry' [-v] [<upstream>] [<head>] [<limit>]
> 
> Shouldn't this be [<upstream> [<head> [<limit>]]]?

Sure.


 Documentation/git-cherry.txt |    3 ++-
 builtin-log.c                |   16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 74d14c4..7deefda 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
-'git cherry' [-v] <upstream> [<head>] [<limit>]
+'git cherry' [-v] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
 -----------
@@ -51,6 +51,7 @@ OPTIONS
 
 <upstream>::
 	Upstream branch to compare against.
+	Defaults to the first tracked remote branch, if available.
 
 <head>::
 	Working branch; defaults to HEAD.
diff --git a/builtin-log.c b/builtin-log.c
index 99d1137..7e9616e 100644
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
+"git cherry [-v] [<upstream> [<head> [<limit>]]]";
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
