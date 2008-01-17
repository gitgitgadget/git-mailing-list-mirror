From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 16 Jan 2008 18:07:53 -0600
Message-ID: <478E9C59.9070008@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:14:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIP1-0007fF-IF
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYAQAOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbYAQAOL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:14:11 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36186 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYAQAOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:14:10 -0500
Received: from earthquake.mgeo.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0H0EBAU001081;
	Wed, 16 Jan 2008 18:14:11 -0600
Received: from starfish.gems.nrlssc.navy.mil ([128.160.50.76]) by earthquake.mgeo.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 18:16:36 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 18:07:53 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 17 Jan 2008 00:07:53.0287 (UTC) FILETIME=[012C9D70:01C8589D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--8.831200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDE2MC03MDkw?=
	=?us-ascii?B?NjUtNzA5MDUwLTEyMTU4OC03MDEyMzItNzAzMTc2LTcwMDk3MS03?=
	=?us-ascii?B?MDYyNDktNzA3ODAwLTcwMDQ3Ni03MDQyNTctMTg4MDE5LTcwNjI5?=
	=?us-ascii?B?MC0zMDAwMTUtNzA0NDczLTcwNTcxOC03MDM3MTItNzA5MTM3LTcx?=
	=?us-ascii?B?MTYyNC03MDEzODQtNzA0NzQ3LTcwMjExOC03MDEwNTMtNzAwMzk4?=
	=?us-ascii?B?LTcwNDQyNS03MDAzMjQtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70781>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Shouldn't we be doing this? I think if quiet is set,
then a failed rename will go undetected since we
won't enter print_summary to have lookup_commit fail.

rerere() die()'s on a failure, but also returns zero
if it can't create a lock file.

run_hook also is not checked for failure. I guess it
should at least print an error message on failure, but
I've never used hooks.

-brandon


 builtin-commit.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a764053..d7db7b3 100644
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
@@ -912,7 +916,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 
-	commit_index_files();
+	if (commit_index_files())
+		die("unable to write new_index file");
 
 	rerere();
 	run_hook(get_index_file(), "post-commit", NULL);
-- 
1.5.4.rc3.17.gb63a4
