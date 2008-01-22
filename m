From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Tue, 22 Jan 2008 13:26:40 -0600
Message-ID: <47964370.8010300@nrlssc.navy.mil>
References: <7v63xtmc9z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 20:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHOsi-00013u-SA
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 20:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYAVTd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYAVTdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 14:33:25 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42419 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYAVTdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 14:33:24 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0MJQe5L005667;
	Tue, 22 Jan 2008 13:26:40 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 22 Jan 2008 13:26:40 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v63xtmc9z.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Jan 2008 19:26:40.0613 (UTC) FILETIME=[B6C16150:01C85D2C]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15680001
X-TM-AS-Result: : Yes--9.180200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDA3NTYtNzAzNzg4LTcwNDQyNS0x?=
	=?us-ascii?B?MjE1ODgtNzAxNDU1LTEyMTY2NS03MDIwODQtNzA5NTg0LTcwMDE2?=
	=?us-ascii?B?My03MDA5NzEtNzAwOTQyLTcwNzIyNS03MDE0NTAtNzAwNDgxLTcw?=
	=?us-ascii?B?NDI1Ny0xODgwMTktNzA2MjkwLTMwMDAxNS03MDQ0NzMtNzA1NzE4?=
	=?us-ascii?B?LTcwMzcxMi03MDkxMzctNzExNjI0LTcwMTM4NC03MDQ3NDctNzAy?=
	=?us-ascii?B?MTE4LTcxMTk1My03MDI3MjYtNzAxNjE4LTcwMTA1My03MDAzOTgt?=
	=?us-ascii?B?MTA1MjUwLTcwNjI0OS03MDAzMjQtMTQ4MDM5LTE0ODA1MS0yMDA0?=
	=?us-ascii?B?Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71466>

---


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>>>  We would need to tell the user that the index is not where
>>> it is when we detect the error, though.
>> The new index we are trying to rename will be deleted.
>> Are you saying we should 
>>   warn the user that the index is now out of sync?
> 
> Yeah, something like that.  But I think that once this happens
> there is no easy and sane recovery path for the user, as the
> most likely cause of the failure there would be the user running
> out of quota, so "git reset HEAD" which may be the way to
> recover from that failure would not have enough room to create a
> new index file anyway.

If you're interested, here's a patch.

-brandon


 builtin-commit.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0227936..d8deb1a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -122,19 +122,23 @@ static void rollback_index_files(void)
 	}
 }
 
-static void commit_index_files(void)
+static int commit_index_files(void)
 {
+	int err = 0;
+
 	switch (commit_style) {
 	case COMMIT_AS_IS:
 		break; /* nothing to do */
 	case COMMIT_NORMAL:
-		commit_lock_file(&index_lock);
+		err = commit_lock_file(&index_lock);
 		break;
 	case COMMIT_PARTIAL:
-		commit_lock_file(&index_lock);
+		err = commit_lock_file(&index_lock);
 		rollback_lock_file(&false_lock);
 		break;
 	}
+
+	return err;
 }
 
 /*
@@ -926,7 +930,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 
-	commit_index_files();
+	if (commit_index_files())
+		die ("Repository has been updated, but unable to write\n"
+		     "new_index file. Check that disk is not full or quota is\n"
+		     "not exceeded, and then \"git reset HEAD\" to recover.");
 
 	rerere();
 	run_hook(get_index_file(), "post-commit", NULL);
-- 
1.5.4.rc4.16.gdd591
