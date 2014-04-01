From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/22] lockfile: also keep track of the filename of the file being locked
Date: Tue,  1 Apr 2014 17:58:26 +0200
Message-ID: <1396367910-7299-19-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15q-0006X1-UC
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbaDAP7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:07 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54276 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbaDAP7E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:04 -0400
X-AuditID: 12074412-f79d46d000002e58-2f-533ae2473f0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 82.4C.11864.742EA335; Tue,  1 Apr 2014 11:59:03 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbM027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:59:02 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqOv+yCrYoOeqpUXXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7YM/s0S8Eb/Yo5l9rYGhinqHUxcnJICJhInN11lh3CFpO4cG89WxcjF4eQwGVGicuv
	/rFAOMeYJLbemMcEUsUmoCuxqKcZzBYRUJOY2HaIBcRmFkiRePV3F5gtLBApcW7mFjYQm0VA
	VeJaz3VWEJtXwEXi9MvrjBDb5CSm/F4AtpkTKH7pwR6wGiEBZ4nTbxYzT2DkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJKiEdjCuPyl3iFGAg1GJh/fAeatgIdbE
	suLK3EOMkhxMSqK8P+4ChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwzroJlONNSaysSi3Kh0lJ
	c7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuCVfwjUKFiUmp5akZaZU4KQZuLgBBnOJSVS
	nJqXklqUWFqSEQ+KjfhiYHSApHiA9iqCtPMWFyTmAkUhWk8xKkqJ87I8AEoIgCQySvPgxsJS
	xStGcaAvhXl1Qdp5gGkGrvsV0GAmoMHc68AGlyQipKQaGBdkBfLH/Tun6j/Pd3Kcp+Xsl9/Y
	481251Tf+7f2rOHKEyeZ282uPfskbJO1atFh/R/vaqR9jk2tbOuW0l7rnHfWv0Nter4cY8OX
	tem/HB4/TE6QyL/fcSS3y0Xx996p+51u3Z0d0eiRzcGe6CYrEBP0ZoOnUO/JVxtC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245597>

This reduces the amount of string editing gyrations and makes it
unnecessary for callers to know how to derive the filename from the
lock_filename.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  1 +
 lockfile.c | 57 ++++++++++++++++++++++++++++++++-------------------------
 refs.c     | 10 ++--------
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/cache.h b/cache.h
index 3d0a835..0fefc66 100644
--- a/cache.h
+++ b/cache.h
@@ -538,6 +538,7 @@ struct lock_file {
 	int fd;
 	pid_t owner;
 	unsigned char flags;
+	struct strbuf filename;
 	struct strbuf lock_filename;
 };
 #define LOCK_DIE_ON_ERROR 1
diff --git a/lockfile.c b/lockfile.c
index 87b40c4..07b5c21 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -35,24 +35,26 @@
  *
  * - Uninitialized.  In this state the object's flags field must be
  *   zero but the rest of the contents need not be initialized.  In
- *   particular, the lock_filename strbuf should *not* be initialized
- *   externally.  The first time the object is used in any way, it is
- *   initialized, permanently registered in the lock_file_list, and
- *   flags & LOCK_FLAGS_ON_LIST is set.
+ *   particular, the filename and lock_filename strbufs should *not*
+ *   be initialized externally.  The first time the object is used in
+ *   any way, it is initialized, permanently registered in the
+ *   lock_file_list, and flags & LOCK_FLAGS_ON_LIST is set.
  *
  * - Locked, lockfile open (after hold_lock_file_for_update() or
  *   hold_lock_file_for_append()).  In this state, the lockfile
- *   exists, lock_filename holds the filename of the lockfile, fd
- *   holds a file descriptor open for writing to the lockfile, and
- *   owner holds the PID of the process that locked the file.
+ *   exists, filename holds the filename of the locked file,
+ *   lock_filename holds the filename of the lockfile, fd holds a file
+ *   descriptor open for writing to the lockfile, and owner holds the
+ *   PID of the process that locked the file.
  *
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
  * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state, lock_filename is the
- *   empty string and fd is -1.  The object is left registered in the
- *   lock_file_list, and flags & LOCK_FLAGS_ON_LIST is set.
+ *   failed attempt to lock).  In this state, filename and
+ *   lock_filename are the empty string and fd is -1.  The object is
+ *   left registered in the lock_file_list, and flags &
+ *   LOCK_FLAGS_ON_LIST is set.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -164,25 +166,30 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 
 	lk->owner = getpid();
 	if (lk->flags & LOCK_FLAGS_ON_LIST) {
-		assert(!lk->lock_filename.len); /* object not already in use */
-		if (strbuf_avail(&lk->lock_filename) < path_len + LOCK_SUFFIX_LEN)
-			strbuf_grow(&lk->lock_filename, path_len + LOCK_SUFFIX_LEN);
+		/* Sanity check that object is not already in use: */
+		assert(!lk->filename.len);
+		assert(!lk->lock_filename.len);
 	} else {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
 		lk->flags |= LOCK_FLAGS_ON_LIST;
-		strbuf_init(&lk->lock_filename, path_len + LOCK_SUFFIX_LEN);
+		strbuf_init(&lk->filename, path_len);
+		strbuf_init(&lk->lock_filename, 0);
 		lk->next = lock_file_list;
 		lock_file_list = lk;
 	}
 
-	strbuf_add(&lk->lock_filename, path, path_len);
+	strbuf_add(&lk->filename, path, path_len);
 	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(&lk->lock_filename);
+		resolve_symlink(&lk->filename);
+
+	strbuf_grow(&lk->lock_filename, lk->filename.len + LOCK_SUFFIX_LEN);
+	strbuf_addbuf(&lk->lock_filename, &lk->filename);
 	strbuf_addstr(&lk->lock_filename, ".lock");
 
 	lk->fd = open(lk->lock_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
+		strbuf_setlen(&lk->filename, 0);
 		strbuf_setlen(&lk->lock_filename, 0);
 		return -1;
 	}
@@ -269,18 +276,16 @@ int close_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char *result_file;
-	size_t path_len = lk->lock_filename.len - LOCK_SUFFIX_LEN;
 	int err = 0;
 
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
-	result_file = xmemdupz(lk->lock_filename.buf, path_len);
-	if (rename(lk->lock_filename.buf, result_file))
+	if (rename(lk->lock_filename.buf, lk->filename.buf)) {
 		err = -1;
-	else
+	} else {
+		strbuf_setlen(&lk->filename, 0);
 		strbuf_setlen(&lk->lock_filename, 0);
-	free(result_file);
+	}
 	return err;
 }
 
@@ -304,19 +309,21 @@ int commit_locked_index(struct lock_file *lk)
 			return -1;
 		if (rename(lk->lock_filename.buf, alternate_index_output))
 			return -1;
+		strbuf_setlen(&lk->filename, 0);
 		strbuf_setlen(&lk->lock_filename, 0);
 		return 0;
-	}
-	else
+	} else {
 		return commit_lock_file(lk);
+	}
 }
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->lock_filename.len) {
+	if (lk->filename.len) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
 		unlink_or_warn(lk->lock_filename.buf);
+		strbuf_setlen(&lk->filename, 0);
 		strbuf_setlen(&lk->lock_filename, 0);
 	}
 }
diff --git a/refs.c b/refs.c
index 93abc94..85967e7 100644
--- a/refs.c
+++ b/refs.c
@@ -2485,14 +2485,8 @@ static int repack_without_ref(const char *refname)
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/*
-		 * loose.  The loose file name is the same as the
-		 * lockfile name, minus ".lock":
-		 */
-		char *loose_filename = xmemdupz(lock->lk->lock_filename.buf,
-						lock->lk->lock_filename.len - 5);
-		int err = unlink_or_warn(loose_filename);
-		free(loose_filename);
+		/* loose */
+		int err = unlink_or_warn(lock->lk->filename.buf);
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
1.9.0
