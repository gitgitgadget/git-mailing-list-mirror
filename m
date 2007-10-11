From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-gc: by default use safer "-A" option to repack when
 not --prune'ing
Date: Wed, 10 Oct 2007 19:59:19 -0500
Message-ID: <470D7567.6010208@nrlssc.navy.mil>
References: <470D6509.5020607@nrlssc.navy.mil> <Pine.LNX.4.64.0710110106160.4174@racer.site> <Pine.LNX.4.64.0710101918060.30020@torch.nrlssc.navy.mil> <Pine.LNX.4.64.0710110149100.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 03:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfmPZ-0002Hc-O6
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 03:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbXJKBAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 21:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757250AbXJKBAQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 21:00:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42678 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181AbXJKBAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 21:00:14 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9B0xJuG005469;
	Wed, 10 Oct 2007 19:59:20 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Oct 2007 19:59:19 -0500
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <Pine.LNX.4.64.0710110149100.4174@racer.site>
X-OriginalArrivalTime: 11 Oct 2007 00:59:19.0254 (UTC) FILETIME=[F4124F60:01C80BA1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--8.712200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ2MDA4LTE1MDU2Ny0xNTA2?=
	=?us-ascii?B?NzMtNzAyMzU4LTcwNDQyNS03MDUxMDItNzA4NTU4LTcwNDkyNy03?=
	=?us-ascii?B?MDExNjMtNzAwNjkzLTcwODY1NS03MDM3ODgtNzExOTUzLTcwNjE1?=
	=?us-ascii?B?MC03MDE5MTQtMTA2NDIwLTcwMDE2MC03MDQyNTctMTg4MDE5LTcw?=
	=?us-ascii?B?NjI5MC03MDQ0MjEtNzA0NzQ3LTcwMDMyNC03MDE3MzUtNzAyMTE4?=
	=?us-ascii?B?LTcwMDc3MS03MDE3MTktNzA2NTM4LTcwNjI0OS03MDc0NTEtNzEx?=
	=?us-ascii?B?MTA5LTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60576>

This makes use of repack's new "-A" option which does not drop packed
unreachable objects. This makes git-gc safe to call at any time,
particularly when a repository is referenced as an alternate by
another repository.

git-gc --prune will use the "-a" option to repack instead of "-A", so
that packed unreachable objects will be removed.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-gc.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 23ad2b6..6323e0d 100644
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
 
@@ -211,6 +211,16 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		prune = 0;
 		if (!need_to_gc())
 			return 0;
+	} else {
+		/*
+		 * Use safer (for shared repos) "-A" option to
+		 * repack when not pruning. Auto-gc makes its
+		 * own decision.
+		 */
+		if (prune)
+			append_option(argv_repack, "-a", MAX_ADD);
+		else
+			append_option(argv_repack, "-A", MAX_ADD);
 	}
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
-- 
1.5.3.4.208.g729c0
