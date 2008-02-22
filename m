From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] git-reflog: add option --updateref to write the last
 reflog sha1 into the ref
Date: Fri, 22 Feb 2008 13:04:12 -0600
Message-ID: <47BF1CAC.5000009@nrlssc.navy.mil>
References: <47BF18DF.6050100@nrlssc.navy.mil> <1203706541-21719-1-git-send-email-casey@nrlssc.navy.mil> <1203706541-21719-2-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdDQ-0002Tg-Nq
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbYBVTEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbYBVTEz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:04:55 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52896 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYBVTEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:04:53 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1MJ4DLb027479;
	Fri, 22 Feb 2008 13:04:13 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 13:04:12 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1203706541-21719-2-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Feb 2008 19:04:12.0348 (UTC) FILETIME=[B5EEB7C0:01C87585]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--14.169700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY2OC0xNTAx?=
	=?us-ascii?B?MjUtMTIxNjI0LTcwMjYzOC03MDE5MjctNzA3NzUwLTcwMzc4OC03?=
	=?us-ascii?B?MDQ0MjUtNzA1MTAyLTcwMTczNS03MDIxNDMtNzAwMTYwLTEzNzcx?=
	=?us-ascii?B?Ny03MDAzOTgtNzA4Nzk3LTcwMTYxOC03MDczOTUtNzA0NzkzLTcw?=
	=?us-ascii?B?MjAxMC03MDA5NDItNzA0MjU3LTE4ODAxOS03MDYyOTAtNzA0NzQ3?=
	=?us-ascii?B?LTcwNjI0OS03MDkwMjEtNzA1MTc4LTEyMTcwOS03MDI2MDktNzAz?=
	=?us-ascii?B?NDQwLTcwMjEzNC03MDEzMzktMTIxNTg4LTcwMTMwNS03MDA5NzEt?=
	=?us-ascii?B?MTA1NjMwLTcwMjExOC0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74749>

Certain sanity checks on the reflog assume that the sha1 of the top reflog
entry will be equal to the sha1 stored in the ref.

When reflog entries are deleted, this assumption may not hold. This patch
adds a new option to git-reflog which causes the subcommands "expire" and
"delete" to update the ref with the sha1 of the top-most reflog entry.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This sucks in close_ref() and commit_ref() from refs.c. The changes to
expire_reflog() implement some of what write_ref_sha1() does. I guess
a new function in refs.c could have been made which instead of a logmsg
takes an updated reflog filename, but that seemed too contrived. We're
already modifying the reflog directly anyway, so maybe it's ok to modify
the ref directly too.

-brandon


 builtin-reflog.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index f685d76..280e24e 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -15,7 +15,7 @@
 static const char reflog_expire_usage[] =
 "git-reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =
-"git-reflog delete [--verbose] [--dry-run] [--rewrite] <refs>...";
+"git-reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -25,6 +25,7 @@ struct cmd_reflog_expire_cb {
 	int dry_run;
 	int stalefix;
 	int rewrite;
+	int updateref;
 	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
@@ -292,10 +293,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 			status |= error("%s: %s", strerror(errno),
 					newlog_path);
 			unlink(newlog_path);
+		} else if (cmd->updateref &&
+			(write_in_full(lock->lock_fd,
+				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+			 write_in_full(lock->lock_fd, "\n", 1) != 1 ||
+			 close_ref(lock) < 0)) {
+			status |= error("Couldn't write %s",
+				lock->lk->filename);
+			unlink(newlog_path);
 		} else if (rename(newlog_path, log_file)) {
 			status |= error("cannot rename %s to %s",
 					newlog_path, log_file);
 			unlink(newlog_path);
+		} else if (cmd->updateref && commit_ref(lock)) {
+			status |= error("Couldn't set %s", lock->ref_name);
 		}
 	}
 	free(newlog_path);
@@ -372,6 +383,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			cb.stalefix = 1;
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
+		else if (!strcmp(arg, "--updateref"))
+			cb.updateref = 1;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
 		else if (!strcmp(arg, "--verbose"))
@@ -443,6 +456,8 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.dry_run = 1;
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
+		else if (!strcmp(arg, "--updateref"))
+			cb.updateref = 1;
 		else if (!strcmp(arg, "--verbose"))
 			cb.verbose = 1;
 		else if (!strcmp(arg, "--")) {
-- 
1.5.4.2.267.g38ea
