From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] fast-import.c: don't try to commit marks file if write failed
Date: Thu, 17 Jan 2008 10:58:34 -0600
Message-ID: <478F893A.6050105@nrlssc.navy.mil>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYGX-0007wx-7M
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYAQRK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYAQRK0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:10:26 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49642 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYAQRKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:10:24 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0HGwYcT008461;
	Thu, 17 Jan 2008 10:58:35 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 17 Jan 2008 10:58:34 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2008 16:58:34.0668 (UTC) FILETIME=[324106C0:01C8592A]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--5.336300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDk3MS03MDE1?=
	=?us-ascii?B?NTktNzA1NTA4LTcwMTAwNS03MDAxNjAtNzA5NTg0LTcwNTY5NC0x?=
	=?us-ascii?B?Mzk1MDQtNzAwMzk4LTcwMjQ3NC0xODgwMTktNzA2MjkwLTMwMDAx?=
	=?us-ascii?B?NS03MDEwNTMtMTM3NzE3LTcwNzQ1MS0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70875>

We also move the assignment of -1 to the lock file descriptor
up, so that rollback_lock_file() can be called safely after a
possible attempt to fclose(). This matches the contents of
the 'if' statement just above testing success of fdopen().

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Since we forget the lock file descriptor there is a chance
that we will leave the file open if a write error occurs. We'll
still delete the file. I don't think it's worth bending
over backwards to make sure the file is closed on this failure.

-brandon


 fast-import.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3609c24..4cf5092 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1545,19 +1545,27 @@ static void dump_marks(void)
 		return;
 	}
 
-	dump_marks_helper(f, 0, marks);
-	if (ferror(f) || fclose(f))
-		failure |= error("Unable to write marks file %s: %s",
-			mark_file, strerror(errno));
 	/*
-	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
-	 * assign -1 to the lock file descriptor so that commit_lock_file()
+	 * Since the lock file was fdopen()'ed, it should not be close()'ed.
+	 * Assign -1 to the lock file descriptor so that commit_lock_file()
 	 * won't try to close() it.
 	 */
 	mark_lock.fd = -1;
-	if (commit_lock_file(&mark_lock))
-		failure |= error("Unable to write commit file %s: %s",
+
+	dump_marks_helper(f, 0, marks);
+	if (ferror(f) || fclose(f)) {
+		rollback_lock_file(&mark_lock);
+		failure |= error("Unable to write marks file %s: %s",
 			mark_file, strerror(errno));
+		return;
+	}
+
+	if (commit_lock_file(&mark_lock)) {
+		rollback_lock_file(&mark_lock);
+		failure |= error("Unable to commit marks file %s: %s",
+			mark_file, strerror(errno));
+		return;
+	}
 }
 
 static int read_next_command(void)
-- 
1.5.4.rc3.17.gb63a4
