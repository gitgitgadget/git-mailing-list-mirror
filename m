From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 07/19] lockfile.c: make lock_file return a meaningful errno on failure
Date: Mon, 14 Jul 2014 13:58:49 -0700
Message-ID: <1405371541-32121-8-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLQ-0002z1-Re
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbaGNU7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:22 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:46473 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-qa0-f74.google.com with SMTP id j15so819890qaq.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4yTyK+tKKrvYgiV7qvy8/fp+IIYPBy5+iBrNxP+E4Gg=;
        b=kEgGbU5YH3ZRXkAne9ZRoN2tUbQOXW92Qy8BIH1HEmlW2NK4s3BWqjgYId0pyZo5Wf
         0MRfmGetvX7eaJpyQK+u7JAdub5TrxEemA6GpUk7fzL18S82SGldA2tFUsSq8HHPP816
         SxWB9R/Ln52SCVwIDUaDbky+CCZ3CIoUvsFCTk4OHLNS1is9kfKMa6JJGzrDR8n4MzmP
         1SkY9XmCaIsUhtbxaJFSt1v5M0jCrGwCJYe6ACT6bgA+H2U8O2OvrBjald9L70uNMDSb
         QzFPxJiIpJPXooEjfIgaC4CX7Wyug3Yv0aUKABk7+zP7hMb1ebH2+HmdWDoNpZlQ1mUm
         moIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4yTyK+tKKrvYgiV7qvy8/fp+IIYPBy5+iBrNxP+E4Gg=;
        b=lXLH+/uyWfivgvJBm+6ykfK86yQx0fVw3q7zYGWu59BZVFIuyXJRkPAnNF1vrVpxe/
         LUNXw4NSnk1YWhhQQnH/ahLaf3UPdaTrAhtvfwsYooDWrel/x9HY1URZbeZJg+YWhBoG
         Kpo2SOt5g+TRwGij/l4J2X9Wya4fWRGuWIt4A0u+QbrCxB5LzuiWqS10jYB4+PYlAzXh
         VJP4NhuBsUz8KNxF2oyIfUFtsji/pi05zNTN/e81MNTDwptLfIMm1n91kvU9fhIsJvhd
         eniqZZ9vG1KGmAlpOcKscfTaoXbNlh/B1UkAq7Ud4F/Wvw4yd7Jgl7PBO7H1M1hV4mqd
         NoOQ==
X-Gm-Message-State: ALoCoQlt+R2iB1EDodvx5gxwi5NO0raVNyna3UlTJcHHxG23rmGcmL5BsnvXS/hgX/But3SMjMXF
X-Received: by 10.52.165.227 with SMTP id zb3mr7737145vdb.1.1405371545732;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j5si822632yhi.1.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 91D0B5A43D4;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 34BEAE0D03; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253518>

Making errno when returning from lock_file() meaningful, which should
fix

 * an existing almost-bug in lock_ref_sha1_basic where it assumes
   errno==ENOENT is meaningful and could waste some work on retries

 * an existing bug in repack_without_refs where it prints
   strerror(errno) and picks advice based on errno, despite errno
   potentially being zero and potentially having been clobbered by
   that point

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 17 ++++++++++++-----
 refs.c     |  1 +
 refs.h     |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 464031b..a921d77 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -121,7 +121,7 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
-
+/* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
@@ -130,8 +130,10 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	 */
 	static const size_t max_path_len = sizeof(lk->filename) - 5;
 
-	if (strlen(path) >= max_path_len)
+	if (strlen(path) >= max_path_len) {
+		errno = ENAMETOOLONG;
 		return -1;
+	}
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
@@ -148,9 +150,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			lock_file_list = lk;
 			lk->on_list = 1;
 		}
-		if (adjust_shared_perm(lk->filename))
-			return error("cannot fix permission bits on %s",
-				     lk->filename);
+		if (adjust_shared_perm(lk->filename)) {
+			int save_errno = errno;
+			error("cannot fix permission bits on %s",
+			      lk->filename);
+			errno = save_errno;
+			return -1;
+		}
 	}
 	else
 		lk->filename[0] = 0;
@@ -188,6 +194,7 @@ NORETURN void unable_to_lock_index_die(const char *path, int err)
 	die("%s", buf.buf);
 }
 
+/* This should return a meaningful errno on failure */
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
diff --git a/refs.c b/refs.c
index db05602..e9d53e4 100644
--- a/refs.c
+++ b/refs.c
@@ -2212,6 +2212,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+/* This should return a meaningful errno on failure */
 int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
diff --git a/refs.h b/refs.h
index 09d3564..64f25d9 100644
--- a/refs.h
+++ b/refs.h
@@ -82,6 +82,7 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 /*
  * Lock the packed-refs file for writing.  Flags is passed to
  * hold_lock_file_for_update().  Return 0 on success.
+ * Errno is set to something meaningful on error.
  */
 extern int lock_packed_refs(int flags);
 
-- 
2.0.1.546.gf603308
