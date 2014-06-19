From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 09/48] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Thu, 19 Jun 2014 08:52:51 -0700
Message-ID: <1403193210-6028-10-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehT-0000yz-M4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068AbaFSP43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:29 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:61056 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so330274yha.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJxqwwJHfWdcSbBSlgCMAKltJ0IVXA7W0T+oFFoMH0k=;
        b=djWZRgoBIwEp+M2KrOSBhP6ZSluW5QBtQcrU5mWZA2t/lKb5ocBK0lWpAiShmv5Q9y
         w3641sdvsM2VFK2T4jphLEYku61ldU2XNvpOABjTUloUTSQXv5HEyeLoZYBfikXw1c44
         bGxbpQLSJJQ9ZMVaM8e4xm0sq+EQyaUwaOFp0FPlH/iGKymzjxPvQZhn3io4cvdvZBQv
         b9gNN3ZwnVxVkG5Me2yj3bDI5b3i+LcceycMHxI7bh5GQ/39rBkrYGs4jkJeY2a0Z4Zk
         OC/LDKOvQrAiv2UdC53X2tM541D8EXJAxO8Ac+rfOs/U+/me68eGshCjjgZadXSKH8my
         Xa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJxqwwJHfWdcSbBSlgCMAKltJ0IVXA7W0T+oFFoMH0k=;
        b=GdOxs/eRwCMznRUeN1oiKHRa2L8dPGiSamuOql6qSaRnXTwchY+lP0cmjWTCCQBVKH
         YDns0tKKYpNz1OghdqJDr7uox7Xzxb2rnScM3Rz9GJ6Xz1fYgnaNemQYKDFVHQhdh3HJ
         YunJsMQyw/GmeIB4YIi05bHq/jUZdes5fpCp/0hxlMZkdzo5QbXAXosAI0jWB0YYApso
         rJ3pbtRrihlg0mj158QhGAsCAzl+5DnsiS5AGXaXxlcCFGPdN/mq24jY3vHjiBNIpgIy
         XL4S8W+HnnNBtIH/zp/26/Ti314g5BkdFaUHGQp529Bhz8yMSaBBAiykSMhLqnV6BQVE
         7eXQ==
X-Gm-Message-State: ALoCoQlCEHdJIUeeoG7Skz+Kdz4XF7gRrdIsH88/Wo4B/msiXTKXl+t8LrOtScwkfJaqEsqREQtu
X-Received: by 10.236.72.197 with SMTP id t45mr2329884yhd.44.1403193213224;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si418781yhp.6.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1869F5A42EE;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A979CE0FFA; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252159>

Making errno when returning from log_ref_setup() meaningful,

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 +++++++++++++++++++--------
 refs.h |  4 +++-
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 67a0217..9ea519c 100644
--- a/refs.c
+++ b/refs.c
@@ -2751,6 +2751,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+/* This function must set a meaningful errno on failure */
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
@@ -2761,9 +2762,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile) < 0)
-			return error("unable to create directory for %s",
-				     logfile);
+		if (safe_create_leading_directories(logfile) < 0) {
+			int save_errno = errno;
+			error("unable to create directory for %s", logfile);
+			errno = save_errno;
+			return -1;
+		}
 		oflags |= O_CREAT;
 	}
 
@@ -2774,15 +2778,22 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				return error("There are still logs under '%s'",
-					     logfile);
+				int save_errno = errno;
+				error("There are still logs under '%s'",
+				      logfile);
+				errno = save_errno;
+				return -1;
 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
-		if (logfd < 0)
-			return error("Unable to append to %s: %s",
-				     logfile, strerror(errno));
+		if (logfd < 0) {
+			int save_errno = errno;
+			error("Unable to append to %s: %s", logfile,
+			      strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
 	}
 
 	adjust_shared_perm(logfile);
diff --git a/refs.h b/refs.h
index 65f7637..82cc5cb 100644
--- a/refs.h
+++ b/refs.h
@@ -158,7 +158,9 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
-/** Setup reflog before using. **/
+/*
+ * Setup reflog before using. Set errno to something meaningful on failure.
+ */
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-- 
2.0.0.438.g337c581
