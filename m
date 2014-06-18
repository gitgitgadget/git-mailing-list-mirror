From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 06/14] lockfile.c: make hold_lock_file_for_append preserve meaningful errno
Date: Wed, 18 Jun 2014 10:08:58 -0700
Message-ID: <1403111346-18466-7-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMm-0007A7-Fr
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbaFRRJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:34 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:37407 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so127642pab.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9RRvXlzEzfUvmBN+V5uLSgnZW/spfyHAjbZDQB9mes=;
        b=ZXPjFA12CSA8KO7CN3EV5r6Tgr/Gd0Dw2UDJ6xxxwW1I6+XwKgc3HjDudi6slIg7mF
         YXvaev0dL1m6eKSs7Do82C+WBUZIhBdwX3yG2FuzNrz+dMGddj0QZYcDX3IKSVmL7eMp
         MrTTomxlmJjs4jSHLM4ruf7zw3lqtVSt+PF3XnqMOxbdGwR5OZtdXscWe2S2E1ba99ZM
         qOm6cuEYUtTh/OAmEaRyEhBRp2rbRWitU4vazDXhvQ6D3wKvJLkH8HZi1CF1Oa6tqzWv
         dk2Z+HH+V1AvjpOKDBUrsDQZMRzF67kjUehXo457p7vJ0xcJUqiD7vSQCJwJn1tcSkag
         x8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9RRvXlzEzfUvmBN+V5uLSgnZW/spfyHAjbZDQB9mes=;
        b=eargRg5o6nilz68WKwsB9dIKuonXIIEeVSGhYxejGV9NtdUoNX1jzYN7vZ8Z47VVz1
         27Gm8ftQvfyQLoyHo5F9HmipWwxiHiz9AH2vrT/5AqDo0vsTzkTXeXBCYmGYgs2MAMpz
         Mh/5SfInaofPguvax+1yXP5E44ybXSp0wgeXX1D+NkEge31TTP62zwUrZJrCKhi8rbNz
         0bok7RUBbaghbKLrhgGKxfWkVlW8fXo1UxvC90P7bsl3gapk8ZibY8vAWQgwCQml1L7e
         jt9Jl7VEeFuG203AOZn6TtewuWwWYC22BD3IohS78ifZsXM3lb3cl0KVYdtX8b5cZa5D
         pVow==
X-Gm-Message-State: ALoCoQkvWnvCPGELoKkI3Di2Pcc3E8smpCcfL7bgZ/upk3RNhbQy2TWpOW9on1iKJzSvWoWSXnEJ
X-Received: by 10.66.97.99 with SMTP id dz3mr1328005pab.24.1403111349998;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si172150yhl.7.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CBD9F5A4795;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 796FEE0ED7; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252002>

Update hold_lock_file_for_append and copy_fd to return a meaningful errno
on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 copy.c     | 20 +++++++++++++-------
 lockfile.c |  7 ++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/copy.c b/copy.c
index a7f58fd..5cb8679 100644
--- a/copy.c
+++ b/copy.c
@@ -9,10 +9,12 @@ int copy_fd(int ifd, int ofd)
 		if (!len)
 			break;
 		if (len < 0) {
-			int read_error = errno;
+			int save_errno = errno;
 			close(ifd);
-			return error("copy-fd: read returned %s",
-				     strerror(read_error));
+			error("copy-fd: read returned %s",
+			      strerror(save_errno));
+			errno = save_errno;
+			return -1;
 		}
 		while (len) {
 			int written = xwrite(ofd, buf, len);
@@ -22,12 +24,16 @@ int copy_fd(int ifd, int ofd)
 			}
 			else if (!written) {
 				close(ifd);
-				return error("copy-fd: write returned 0");
+				error("copy-fd: write returned 0");
+				errno = EAGAIN;
+				return -1;
 			} else {
-				int write_error = errno;
+				int save_errno = errno;
 				close(ifd);
-				return error("copy-fd: write returned %s",
-					     strerror(write_error));
+				error("copy-fd: write returned %s",
+				      strerror(save_errno));
+				errno = save_errno;
+				return -1;
 			}
 		}
 	}
diff --git a/lockfile.c b/lockfile.c
index a921d77..32f4681 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -217,15 +217,20 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
 		if (errno != ENOENT) {
+			int save_errno = errno;
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
 			close(fd);
-			return error("cannot open '%s' for copying", path);
+			error("cannot open '%s' for copying", path);
+			errno = save_errno;
+			return -1;
 		}
 	} else if (copy_fd(orig_fd, fd)) {
+		int save_errno = errno;
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
 		close(fd);
+		errno = save_errno;
 		return -1;
 	}
 	return fd;
-- 
2.0.0.467.g08c0633
