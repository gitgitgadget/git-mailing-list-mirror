From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] lockfile.c: modify handling of rename failures and alternate_index_output
Date: Wed, 16 Jan 2008 13:13:38 -0600
Message-ID: <478E5762.8000007@nrlssc.navy.mil>
References: <1200510486-11438-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:16:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDkR-00057n-ED
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbYAPTPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYAPTPh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:15:37 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39775 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbYAPTPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:15:36 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GJDc1G027157;
	Wed, 16 Jan 2008 13:13:39 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 13:13:38 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1200510486-11438-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 16 Jan 2008 19:13:38.0442 (UTC) FILETIME=[E6110EA0:01C85873]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--10.774000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDk3MS0xMjE1?=
	=?us-ascii?B?ODgtMTM5NTA0LTEwNjQyMC03MDA2OTMtMTM3NzE3LTcwMzc4OC0x?=
	=?us-ascii?B?ODgwMTktNzAwMjY0LTcwNDc0Ny0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70727>

commit_lock_file(): if rename() fails, we should not
  truncate the name of the lockfile. This file should be deleted
  by rollback_lock_file() or remove_lock_file().

commit_locked_index(): call close_lock_file() when alternate_index_output
  is set and handle rename() failures like commit_lock_file().
---
 lockfile.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index bcc4786..e8e5dbb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -171,15 +171,16 @@ int close_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	int i;
+	size_t i;
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
 	result_file[i] = 0;
-	i = rename(lk->filename, result_file);
+	if (rename(lk->filename, result_file))
+		return -1;
 	lk->filename[0] = 0;
-	return i;
+	return 0;
 }
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
@@ -195,9 +196,12 @@ void set_alternate_index_output(const char *name)
 int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
-		int result = rename(lk->filename, alternate_index_output);
+		if (lk->fd >= 0 && close_lock_file(lk))
+			return -1;
+		if (rename(lk->filename, alternate_index_output))
+			return -1;
 		lk->filename[0] = 0;
-		return result;
+		return 0;
 	}
 	else
 		return commit_lock_file(lk);
-- 
1.5.4.rc3.14.g44397-dirty
