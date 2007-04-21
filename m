From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] lockfile: record the primary process.
Date: Sat, 21 Apr 2007 03:40:58 -0700
Message-ID: <1177152059809-git-send-email-junkio@cox.net>
References: <11771520591529-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 12:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfD1l-0004KC-75
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 12:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbXDUKlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 06:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbXDUKlI
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 06:41:08 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44251 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030622AbXDUKlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 06:41:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421104100.UJKO1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 21 Apr 2007 06:41:00 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pmgz1W00A1kojtg0000300; Sat, 21 Apr 2007 06:40:59 -0400
X-Mailer: git-send-email 1.5.1.1.948.g9f6f
In-Reply-To: <11771520591529-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45162>

The usual process flow is the main process opens and holds the lock to
the index, does its thing, perhaps spawning children during the course,
and then writes the resulting index out by releaseing the lock.

However, the lockfile interface uses atexit(3) to clean it up, without
regard to who actually created the lock.  This typically leads to a
confusing behaviour of lock being released too early when the child
exits, and then the parent process when it calls commit_lockfile()
finds that it cannot unlock it.

This fixes the problem by recording who created and holds the lock, and
upon atexit(3) handler, child simply ignores the lockfile the parent
created.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 cache.h    |    1 +
 lockfile.c |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 8c804cb..faddaf6 100644
--- a/cache.h
+++ b/cache.h
@@ -209,6 +209,7 @@ extern int refresh_cache(unsigned int flags);
 
 struct lock_file {
 	struct lock_file *next;
+	pid_t owner;
 	char on_list;
 	char filename[PATH_MAX];
 };
diff --git a/lockfile.c b/lockfile.c
index bed6b21..23db35a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -8,8 +8,11 @@ static const char *alternate_index_output;
 
 static void remove_lock_file(void)
 {
+	pid_t me = getpid();
+
 	while (lock_file_list) {
-		if (lock_file_list->filename[0])
+		if (lock_file_list->owner == me &&
+		    lock_file_list->filename[0])
 			unlink(lock_file_list->filename);
 		lock_file_list = lock_file_list->next;
 	}
@@ -28,6 +31,7 @@ static int lock_file(struct lock_file *lk, const char *path)
 	sprintf(lk->filename, "%s.lock", path);
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
+		lk->owner = getpid();
 		if (!lk->on_list) {
 			lk->next = lock_file_list;
 			lock_file_list = lk;
-- 
1.5.1.1.948.g9f6f
