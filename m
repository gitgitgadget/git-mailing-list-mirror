From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-gc: by default use safer "-A" option to repack when not
 --prune'ing
Date: Wed, 10 Oct 2007 18:49:29 -0500
Message-ID: <470D6509.5020607@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IflJL-00013Z-B5
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827AbXJJXtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbXJJXtp
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:49:45 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36900 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731AbXJJXto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:49:44 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9ANnUti005040;
	Wed, 10 Oct 2007 18:49:30 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Oct 2007 18:49:29 -0500
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
X-OriginalArrivalTime: 10 Oct 2007 23:49:29.0984 (UTC) FILETIME=[33127000:01C80B98]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--8.609300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ2MDA4LTE1MDY0NC0xNTA2?=
	=?us-ascii?B?NzMtNzAyMzU4LTcwNDQyNS03MDUxMDItNzA4NTU4LTcwNDkyNy03?=
	=?us-ascii?B?MDExNjMtNzAwNjkzLTcwODY1NS03MDM3ODgtNzExOTUzLTcwNjE1?=
	=?us-ascii?B?MC03MDE5MTQtMTA2NDIwLTcwMDE2MC03MDQyNTctMTg4MDE5LTcw?=
	=?us-ascii?B?NjI5MC03MDQ0MjEtNzA0NzQ3LTcwMDMyNC03MDE3MzUtNzEwMjA3?=
	=?us-ascii?B?LTcwMTU3Ni03MDI5MTEtNzA0OTgzLTcwNjI0OS03MDk1ODQtNzAy?=
	=?us-ascii?B?MTE4LTcwMDc3MS03MDE3MTktNzA2NTM4LTcwNzQ1MS03MTExMDkt?=
	=?us-ascii?B?MTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60570>

This makes use of repack's new "-A" option which does not drop packed
unreachable objects. This makes git-gc safe to call at any time,
particularly when a repository is referenced as an alternate by
another repository.

git-gc --prune will use the "-a" option to repack instead of "-A", so
that packed unreachable objects will be removed.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-gc.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 23ad2b6..779245b 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -26,7 +26,7 @@ static int gc_auto_pack_limit = 20;
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
-static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
+static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
@@ -143,8 +143,6 @@ static int too_many_packs(void)
 
 static int need_to_gc(void)
 {
-	int ac = 0;
-
 	/*
 	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
 	 * disable the automatic gc.
@@ -158,14 +156,10 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	argv_repack[ac++] = "repack";
 	if (too_many_packs())
-		argv_repack[ac++] = "-A";
+		append_option(argv_repack, "-A", MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
-	argv_repack[ac++] = "-d";
-	argv_repack[ac++] = "-l";
-	argv_repack[ac++] = NULL;
 	return 1;
 }
 
@@ -211,6 +205,16 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		prune = 0;
 		if (!need_to_gc())
 			return 0;
+	} else {
+		/*
+		 * Use safer (for shared repos) "-A" option to
+		 * repack when not pruning. Auto-gc makes its
+                 * own decision.
+		 */
+		if (prune)
+			append_option(argv_repack, "-a", MAX_ADD);
+		else
+			append_option(argv_repack, "-A", MAX_ADD);
 	}
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
-- 
1.5.3.4.207.g00000
