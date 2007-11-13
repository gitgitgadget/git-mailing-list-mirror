From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 08/11] Close files opened by lock_file() before unlinking.
Date: Tue, 13 Nov 2007 21:05:03 +0100
Message-ID: <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21E-0001Be-22
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761317AbXKMUF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761196AbXKMUF0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:26 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49204 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762240AbXKMUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:11 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 4978110AD30;
	Tue, 13 Nov 2007 21:05:09 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64848>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This is needed on Windows since open files cannot be unlinked.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

	This was authored by Dscho, but carries only my sign-off.
	Is this ok?

 cache.h    |    1 +
 lockfile.c |   17 ++++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index f0a25c7..28870c5 100644
--- a/cache.h
+++ b/cache.h
@@ -284,6 +284,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const char **
 
 struct lock_file {
 	struct lock_file *next;
+	int fd;
 	pid_t owner;
 	char on_list;
 	char filename[PATH_MAX];
diff --git a/lockfile.c b/lockfile.c
index 9a1f64d..258fb3f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -12,8 +12,10 @@ static void remove_lock_file(void)
 
 	while (lock_file_list) {
 		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0])
+		    lock_file_list->filename[0]) {
+			close(lock_file_list->fd);
 			unlink(lock_file_list->filename);
+		}
 		lock_file_list = lock_file_list->next;
 	}
 }
@@ -120,8 +122,6 @@ static char *resolve_symlink(char *p, size_t s)
 
 static int lock_file(struct lock_file *lk, const char *path)
 {
-	int fd;
-
 	if (strlen(path) >= sizeof(lk->filename)) return -1;
 	strcpy(lk->filename, path);
 	/*
@@ -130,8 +130,8 @@ static int lock_file(struct lock_file *lk, const char *path)
 	 */
 	resolve_symlink(lk->filename, sizeof(lk->filename)-5);
 	strcat(lk->filename, ".lock");
-	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (0 <= fd) {
+	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+	if (0 <= lk->fd) {
 		if (!lock_file_list) {
 			signal(SIGINT, remove_lock_file_on_signal);
 			atexit(remove_lock_file);
@@ -148,7 +148,7 @@ static int lock_file(struct lock_file *lk, const char *path)
 	}
 	else
 		lk->filename[0] = 0;
-	return fd;
+	return lk->fd;
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on_error)
@@ -163,6 +163,7 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 	int i;
+	close(lk->fd);
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
 	result_file[i] = 0;
@@ -194,7 +195,9 @@ int commit_locked_index(struct lock_file *lk)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0])
+	if (lk->filename[0]) {
+		close(lk->fd);
 		unlink(lk->filename);
+	}
 	lk->filename[0] = 0;
 }
-- 
1.5.3.5.1592.g0d6db
