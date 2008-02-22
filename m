From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] reflog-delete: parse standard reflog options
Date: Fri, 22 Feb 2008 15:08:59 -0600
Message-ID: <47BF39EB.5040603@nrlssc.navy.mil>
References: <47BF1AF2.8070506@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 22:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSf9W-0000uN-EK
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 22:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbYBVVJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 16:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755685AbYBVVJR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 16:09:17 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51486 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbYBVVJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 16:09:17 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1ML90bc029686;
	Fri, 22 Feb 2008 15:09:00 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 15:08:59 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47BF1AF2.8070506@nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Feb 2008 21:08:59.0801 (UTC) FILETIME=[24CD6090:01C87597]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--16.354000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNDQyMS03MDY1?=
	=?us-ascii?B?NjEtNzA2MjQ5LTcwMDE2MC03MDIwMTYtNzAyNjM4LTcwMDk0OS03?=
	=?us-ascii?B?MDQyNTctMTg4MDE5LTcwNjI5MC03MDQ3NDctNzAxNzM1LTcwOTAy?=
	=?us-ascii?B?MS03MDUxNzgtMTIxNzA5LTcwMjYwOS03MDIxMTgtNzA5MTM3LTE4?=
	=?us-ascii?B?ODE5OS03MDIwMzgtMTIxNjI0LTcwNzc1MC0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74760>

Add support for some standard reflog options such as --dry-run and
--verbose to the reflog delete subcommand.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Oops.
I forgot to send this patch. The reflog patch set I sent should be
applied on top of this one. Sorry.

-brandon


 builtin-reflog.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 8af75bc..77f70a6 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -14,6 +14,8 @@
 
 static const char reflog_expire_usage[] =
 "git-reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
+static const char reflog_delete_usage[] =
+"git-reflog delete [--verbose] [--dry-run] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -425,12 +427,28 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	struct cmd_reflog_expire_cb cb;
 	int i, status = 0;
 
-	if (argc < 2)
-		return error("Nothing to delete?");
-
 	memset(&cb, 0, sizeof(cb));
 
 	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
+			cb.dry_run = 1;
+		else if (!strcmp(arg, "--verbose"))
+			cb.verbose = 1;
+		else if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_delete_usage);
+		else
+			break;
+	}
+
+	if (argc - i < 1)
+		return error("Nothing to delete?");
+
+	for ( ; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
 		unsigned char sha1[20];
 		char *ep, *ref;
-- 
1.5.4.2.267.g38ea
