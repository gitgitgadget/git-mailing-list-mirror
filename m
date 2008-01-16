From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] refs.c: rework ref_locks by abstracting from underlying struct
 lock_file
Date: Wed, 16 Jan 2008 13:14:30 -0600
Message-ID: <478E5796.7040001@nrlssc.navy.mil>
References: <1200510486-11438-1-git-send-email-casey@nrlssc.navy.mil> <1200510486-11438-2-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDjY-0004lv-PP
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbYAPTO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbYAPTO4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:14:56 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50876 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbYAPTOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:14:55 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GJEUhh027172;
	Wed, 16 Jan 2008 13:14:31 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 13:14:30 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1200510486-11438-2-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 16 Jan 2008 19:14:30.0772 (UTC) FILETIME=[0541FB40:01C85874]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--7.789500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTEzNzcxNy03MDA5?=
	=?us-ascii?B?NzEtNzA0NDIxLTcwNDQyNS03MDc3NTAtMTg4MDE5LTEyMTU4OC03?=
	=?us-ascii?B?MDQ3NDctNzA2MjkwLTEwNTYzMC03MDAzOTgtMTIxNjI0LTcwMTMz?=
	=?us-ascii?B?OS03MDEzMDUtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70726>

Instead of calling close_lock_file() and commit_lock_file() directly,
which take a struct lock_file argument, add two new functions:
close_ref() and commit_ref(), which handle calling the previous
lock_file functions and modifying the ref_lock structure.
---
 refs.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 2c78956..e705ed3 100644
--- a/refs.c
+++ b/refs.c
@@ -1018,6 +1018,22 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	return 1;
 }
 
+static int close_ref(struct ref_lock *lock)
+{
+	if (close_lock_file(lock->lk))
+		return -1;
+	lock->lock_fd = -1;
+	return 0;
+}
+
+static int commit_ref(struct ref_lock *lock)
+{
+	if (commit_lock_file(lock->lk))
+		return -1;
+	lock->lock_fd = -1;
+	return 0;
+}
+
 void unlock_ref(struct ref_lock *lock)
 {
         /* Do not free lock->lk -- atexit() still looks at them */
@@ -1128,7 +1144,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
-	    	|| close_lock_file(lock->lk) < 0) {
+	    	|| close_ref(lock) < 0) {
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
 		return -1;
@@ -1161,12 +1177,11 @@ int write_ref_sha1(struct ref_lock *lock,
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
 	}
-	if (commit_lock_file(lock->lk)) {
+	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
-	lock->lock_fd = -1;
 	unlock_ref(lock);
 	return 0;
 }
-- 
1.5.4.rc3.14.g44397-dirty
