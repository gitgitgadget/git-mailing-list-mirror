From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] lockfile: remove function "hold_lock_file_for_append"
Date: Fri, 28 Aug 2015 18:55:52 +0200
Message-ID: <1440780952-5859-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 18:56:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVMwd-0002yS-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 18:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbbH1Qz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 12:55:59 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34003 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbbH1Qz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 12:55:58 -0400
Received: by wiyy7 with SMTP id y7so4872590wiy.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XaPdtV9lduO7ftFo9LwMllXYJ/Y3v2/1pIuOaLGRIFY=;
        b=k9430IpIEpPpSNQxerP7Z8sxczS6UHU9bxui5+8R5Qys7ESEzwJU6aSa5OB24IO0SF
         c93TB1WUinNMXi6pcbqe+wf6vzioa5xKKzzy3LIU6B5yHmdsmbJlyTPADjd0roJBR8xg
         FEiqWzSX3I7//m67TkGpvx50HxrXjfNq/Hj3SD12w5zJAzGjuxJLaEOEo7IaQ93WtYcc
         swc/Q4mCNwX1kG6UNLzrU6fGBoLyPTQ8fQaDToRhABs9BrSGXgiYOtQ0g5JE2lJR54oF
         tEiP9WfPu2+QbOa9NDtKJ7mlZCI+D/qUiZryTn6UPDw6tb9N1mvmJmaoqFK89KLEjXMp
         C7Tg==
X-Received: by 10.180.214.70 with SMTP id ny6mr5509297wic.20.1440780956979;
        Fri, 28 Aug 2015 09:55:56 -0700 (PDT)
Received: from localhost (cable-86-56-73-136.cust.telecolumbus.net. [86.56.73.136])
        by smtp.gmail.com with ESMTPSA id im10sm8837824wjb.40.2015.08.28.09.55.55
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 09:55:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.614.g6f325f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276729>

With 77b9b1d (add_to_alternates_file: don't add duplicate entries,
2015-08-10) the last caller of function "hold_lock_file_for_append"
has been removed, so we can remove the function as well.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
This is the second bullet point in
http://git-blame.blogspot.de/p/leftover-bits.html

 lockfile.c | 38 --------------------------------------
 lockfile.h | 26 +++++++-------------------
 2 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 637b8cf..80d056d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -177,44 +177,6 @@ int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
 	return fd;
 }
 
-int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
-{
-	int fd, orig_fd;
-
-	fd = lock_file(lk, path, flags);
-	if (fd < 0) {
-		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_die(path, errno);
-		return fd;
-	}
-
-	orig_fd = open(path, O_RDONLY);
-	if (orig_fd < 0) {
-		if (errno != ENOENT) {
-			int save_errno = errno;
-
-			if (flags & LOCK_DIE_ON_ERROR)
-				die("cannot open '%s' for copying", path);
-			rollback_lock_file(lk);
-			error("cannot open '%s' for copying", path);
-			errno = save_errno;
-			return -1;
-		}
-	} else if (copy_fd(orig_fd, fd)) {
-		int save_errno = errno;
-
-		if (flags & LOCK_DIE_ON_ERROR)
-			die("failed to prepare '%s' for appending", path);
-		close(orig_fd);
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	} else {
-		close(orig_fd);
-	}
-	return fd;
-}
-
 char *get_locked_file_path(struct lock_file *lk)
 {
 	struct strbuf ret = STRBUF_INIT;
diff --git a/lockfile.h b/lockfile.h
index 8131fa3..3d30193 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -44,8 +44,7 @@
  *   throughout the life of the program (i.e. you cannot use an
  *   on-stack variable to hold this structure).
  *
- * * Attempts to create a lockfile by calling
- *   `hold_lock_file_for_update()` or `hold_lock_file_for_append()`.
+ * * Attempts to create a lockfile by calling `hold_lock_file_for_update()`.
  *
  * * Writes new content for the destination file by either:
  *
@@ -73,7 +72,7 @@
  * Even after the lockfile is committed or rolled back, the
  * `lock_file` object must not be freed or altered by the caller.
  * However, it may be reused; just pass it to another call of
- * `hold_lock_file_for_update()` or `hold_lock_file_for_append()`.
+ * `hold_lock_file_for_update()`.
  *
  * If the program exits before `commit_lock_file()`,
  * `commit_lock_file_to()`, or `rollback_lock_file()` is called, the
@@ -120,8 +119,7 @@ struct lock_file {
  * Flags
  * -----
  *
- * The following flags can be passed to `hold_lock_file_for_update()`
- * or `hold_lock_file_for_append()`.
+ * The following flags can be passed to `hold_lock_file_for_update()`.
  */
 
 /*
@@ -168,27 +166,17 @@ static inline int hold_lock_file_for_update(
 }
 
 /*
- * Like `hold_lock_file_for_update()`, but before returning copy the
- * existing contents of the file (if any) to the lockfile and position
- * its write pointer at the end of the file. The flags argument and
- * error handling are described above.
- */
-extern int hold_lock_file_for_append(struct lock_file *lk,
-				     const char *path, int flags);
-
-/*
  * Append an appropriate error message to `buf` following the failure
- * of `hold_lock_file_for_update()` or `hold_lock_file_for_append()`
- * to lock `path`. `err` should be the `errno` set by the failing
- * call.
+ * of `hold_lock_file_for_update()` to lock `path`. `err` should be the
+ * `errno` set by the failing call.
  */
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 
 /*
  * Emit an appropriate error message and `die()` following the failure
- * of `hold_lock_file_for_update()` or `hold_lock_file_for_append()`
- * to lock `path`. `err` should be the `errno` set by the failing
+ * of `hold_lock_file_for_update()` to lock `path`. `err` should be the
+ * `errno` set by the failing
  * call.
  */
 extern NORETURN void unable_to_lock_die(const char *path, int err);
-- 
2.5.0.614.g6f325f9
