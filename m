From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 23 Jan 2008 11:21:22 -0600
Message-ID: <47977792.5080001@nrlssc.navy.mil>
References: <7vfxwpqvfg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjMH-0003Xl-1J
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbYAWRXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbYAWRXL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:23:11 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54219 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbYAWRXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 12:23:01 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0NHLMus018500;
	Wed, 23 Jan 2008 11:21:23 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jan 2008 11:21:23 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vfxwpqvfg.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 23 Jan 2008 17:21:23.0051 (UTC) FILETIME=[605A33B0:01C85DE4]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15680001
X-TM-AS-Result: : Yes--8.726000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMjE0My03MDgx?=
	=?us-ascii?B?NDMtNzAzNzg4LTcwMjA4NC03MDQ0MjUtNzAwOTcxLTEwNjQyMC03?=
	=?us-ascii?B?MTE5NTMtNzAwNzU4LTEyMTY2NS03MDA3NTYtNzAwMTYzLTcwNTg2?=
	=?us-ascii?B?MS03MDA3MDYtNzAwMTYwLTcwMDA3NS0xMzkwMTAtNzAzNzMxLTcw?=
	=?us-ascii?B?NzIyNS03MDE0NTAtNzAwNDgxLTcxMDA3OC03MDA3OTAtMTg3MDY3?=
	=?us-ascii?B?LTcwNjAyMy03MDEzMDUtNzAwNDc2LTcwMjY0MC03MDE0NTUtNzA0?=
	=?us-ascii?B?MjU3LTE4ODAxOS03MDYyOTAtMzAwMDE1LTcwNDQ3My03MDU3MTgt?=
	=?us-ascii?B?NzAzNzEyLTcwOTEzNy03MTE2MjQtNzAxMzg0LTcwNDc0Ny03MDIx?=
	=?us-ascii?B?MTgtNzAyNzI2LTcwMTYxOC03MDEwNTMtNzAwMzk4LTEwNTI1MC03?=
	=?us-ascii?B?MDYyNDktNzAwMzI0LTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71560>

In certain rare cases, the creation of the commit object
and update of HEAD can succeed, but then installing the
updated index will fail. This is most likely caused by a
full disk or exceeded disk quota. When this happens the
new index file will be removed, and the repository will
be left with the original now-out-of-sync index. The
user can recover with a "git reset HEAD" once the disk
space issue is resolved.

We should detect this failure and offer the user some
helpful guidance.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> If you're interested, here's a patch.
> 
> Looks Ok from a quick glance.  I am mired at day job this week
> so it may take a while for me to come up with a commit log
> message though.

Oh, I had /ASS/u/ME/d this was simple enough that the one-liner
was sufficient.

This patch includes a commit message that hopefully provides a better
base for you to modify.

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
1.5.4.rc4.17.g0830c
