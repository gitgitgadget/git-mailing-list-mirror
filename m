From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] git-reflog: add option --rewrite to update reflog entries
 while expiring
Date: Fri, 22 Feb 2008 12:56:50 -0600
Message-ID: <47BF1AF2.8070506@nrlssc.navy.mil>
References: <47BF18DF.6050100@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdCT-0002Ld-OP
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364AbYBVTEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757635AbYBVTEH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:04:07 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52873 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025AbYBVTEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:04:05 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1MIuocH027345;
	Fri, 22 Feb 2008 12:56:50 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 12:56:50 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47BF18DF.6050100@nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Feb 2008 18:56:50.0220 (UTC) FILETIME=[AE6756C0:01C87584]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--19.054300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY2OC03MDE5?=
	=?us-ascii?B?MzctMTIxNjI0LTcwNDQyNS03MDM3ODgtNzA1MTAyLTcwMTczNS03?=
	=?us-ascii?B?MDAxNjAtNzA0MjU3LTE4ODAxOS03MDYyOTAtNzA0NzQ3LTcwNjI0?=
	=?us-ascii?B?OS03MDkwMjEtNzA1MTc4LTEyMTcwOS03MDI2MDktNzAwMDU3LTcw?=
	=?us-ascii?B?MzQ0MC03MDc3NTAtNzAyMTM0LTcwMzY1Ny03MDAzMjQtNzAwNjE4?=
	=?us-ascii?B?LTcwMTY5Mi03MDA0NzYtNzAyMTE4LTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74747>

Certain sanity checks on the reflog assume that each entry will contain
a reference to the previous entry. i.e. that the "old" sha1 field of a
reflog entry will be equal to the "new" sha1 field of the previous entry.

When reflog entries are deleted, this assumption may not hold. This patch
adds a new option to git-reflog which causes the subcommands "expire" and
"delete" to rewrite the "old" sha1 field of each reflog entry so that it
points to the previous reflog entry.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-reflog.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 77f70a6..f685d76 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -15,7 +15,7 @@
 static const char reflog_expire_usage[] =
 "git-reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =
-"git-reflog delete [--verbose] [--dry-run] <refs>...";
+"git-reflog delete [--verbose] [--dry-run] [--rewrite] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -24,6 +24,7 @@ struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int dry_run;
 	int stalefix;
+	int rewrite;
 	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
@@ -35,6 +36,7 @@ struct expire_reflog_cb {
 	const char *ref;
 	struct commit *ref_commit;
 	struct cmd_reflog_expire_cb *cmd;
+	unsigned char last_kept_sha1[20];
 };
 
 struct collected_reflog {
@@ -216,6 +218,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (timestamp < cb->cmd->expire_total)
 		goto prune;
 
+	if (cb->cmd->rewrite)
+		osha1 = cb->last_kept_sha1;
+
 	old = new = NULL;
 	if (cb->cmd->stalefix &&
 	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
@@ -243,6 +248,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			sha1_to_hex(osha1), sha1_to_hex(nsha1),
 			email, timestamp, sign, zone,
 			message);
+		hashcpy(cb->last_kept_sha1, nsha1);
 	}
 	if (cb->cmd->verbose)
 		printf("keep %s", message);
@@ -364,6 +370,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			cb.expire_unreachable = approxidate(arg + 21);
 		else if (!strcmp(arg, "--stale-fix"))
 			cb.stalefix = 1;
+		else if (!strcmp(arg, "--rewrite"))
+			cb.rewrite = 1;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
 		else if (!strcmp(arg, "--verbose"))
@@ -433,6 +441,8 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
+		else if (!strcmp(arg, "--rewrite"))
+			cb.rewrite = 1;
 		else if (!strcmp(arg, "--verbose"))
 			cb.verbose = 1;
 		else if (!strcmp(arg, "--")) {
-- 
1.5.4.2.267.g38ea
