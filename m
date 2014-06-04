From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/11] lockfile.c: make hold_lock_file_for_append preserve meaningful errno
Date: Wed,  4 Jun 2014 11:57:47 -0700
Message-ID: <1401908272-7600-7-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOY-0008BH-VM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaFDS61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:27 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:62697 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaFDS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:07 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1706923yha.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jo6U0lcDq/aIDujml+IqNTQn8mi0JMYJAxC++4MW9ts=;
        b=aoTjzrhlfwWpO4qsEsrBf8GmNSzLnmIPg3nB92Kli7wsSkq5LxkY3vOZ5e11wOkrcs
         QUNRmDBaX0uSScfHNWRLS/ZGWJrkXvlEcLUjtKbfs7OM3kH+Wr/ghGbr0xmh5kfQ6fsu
         cfNxhNkcz8O/jjQYCnxGNr8U0TXjvnoJYMSqNJz/dK72qN9zN7X45vhHF4vgdkl5GmwR
         Lh1PI2oq/6LxCM/S6gm1JoexA2Mao2qTu4TFr3g/dt1UxESzwktBrk6pTZgZBcOqAOZq
         QXqk68pi8xS6xgP3Z6deaAU0Q5jtfWe0tMNWPftU305ccK0J+Dozb/4qK6C1Y9IzC9hP
         v/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jo6U0lcDq/aIDujml+IqNTQn8mi0JMYJAxC++4MW9ts=;
        b=K77yHjQbacO8VF0fkiM0X/W/BbAJD7W6/TFhr3Ve+Wz95gt19umi2uz0MCs4J+x+X5
         JNeNUde2jJJ/SuDJTpGIVIEA33p9ZSaUZTh3JryWhoPQ61AVZWXZqP7U9wvdO2u4JxGV
         0jdUl6SkmNc8tfI0bkLtE7+k8CWTMC3Oq4S+SWx89DX1gOAvnzmQArzWEgiX9oA2a05T
         fvXPBWQY/zAf3eCdyJWwU+LVYlGKtUjVPax0mieraVOFVJ2lM2bmfNmlXdtOpALyHefN
         FqzisSJZoy8lw7pCq96U1vyvR8AbZrc4wTZzDdeUPHWjLn1+Wj7BC+OG9lwmcXdxnDji
         movQ==
X-Gm-Message-State: ALoCoQnAz5sKmi74SeACqobJ52kwQLpCKQlCVYyrZvVlZnIZxhVTcztRo26Nw7ym207Lcur65xiK
X-Received: by 10.236.99.7 with SMTP id w7mr20354763yhf.4.1401908286946;
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si330903yhp.6.2014.06.04.11.58.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C731E31DB2C;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7CEB6E0D74; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250766>

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
index f5da18c..97414b0 100644
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
2.0.0.578.gb9e379f
