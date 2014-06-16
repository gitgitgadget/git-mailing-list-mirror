From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 06/14] lockfile.c: make hold_lock_file_for_append preserve meaningful errno
Date: Mon, 16 Jun 2014 09:51:37 -0700
Message-ID: <1402937505-6091-7-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa8n-0002g5-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbaFPQwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:12 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:45803 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198AbaFPQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:51 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so163031pab.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3BP2+4W32hHHOwedez++DQCkrHccigMrhJpCrBAqh6w=;
        b=IKyoIqzn2e4qY+kYZZLZ6HEX8EzbbfALqOYLSjrYRa2r/CvdFzVoMkii2hzGry7R2W
         Qb6b1K0EUVbtuPrWduymfTeKwXQfITX5Wv+lYrEuT+54Uklwnejq4/6DSVQ+vnFI0z3V
         PR3o9l7/kqWcau6bUqVRhCZA+PTleK/6Ch2MpNI3qGlKYmdfdqddT9XiieZmBz0GLGE6
         gm9V6mvZ898GhoCkXwqCGMHDgrfNdfcZ7RmdHhPWOzI1gKZYTDJvX87h7Y+aEZVqNcMb
         0P62JnMbas7sMU7MCwR9yL84U8CKnD7r3yPq6vr621gaAPWnLSC0LOgWAtFnmJNB1q/9
         /V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3BP2+4W32hHHOwedez++DQCkrHccigMrhJpCrBAqh6w=;
        b=bRaK/rFmd7qeCRq3LHBmzZuGrFAPUw9iFkn1mYNmASbWUgu3fjARAit4xaSq61Ll1B
         WMmTMyd+IlvPIFIaYxOK3VHiXQuIyXSBCeA0WpgogeGEFTk/zhQOQkDFoW9R6t9bXltP
         OwUEnXUAC3whklRpFMeTohGBoFM7uGqqwfqkUOLQPUozm3tobW5CuLRJ7/GzLnYC5/hg
         MrNkzAKKhuKLe0l0V5uSXU/eANB5ee4HZH3Ccae/jPSdRs8yZOjY05VKnZ4wA1PnbF+P
         JF9+Y1Dy9pQTFl0AEozQx+D/ny10+L/aHBsIK3VtUjjOXtbEJ2x+DBq7nHlbLeno37x0
         uYEw==
X-Gm-Message-State: ALoCoQlYBRdQD/6klWOQAAcB5z6Oyt3VOIIgFpPBomVtRm+fqt47kSgMaHWUojTYxJSmG5c1fIXh
X-Received: by 10.68.180.132 with SMTP id do4mr2552323pbc.4.1402937509769;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si983254yhj.5.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 89A825A47A5;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 140FEE0A0A; Mon, 16 Jun 2014 09:51:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251721>

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
index 4899270..d29bedf 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -250,15 +250,20 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
 		if (errno != ENOENT) {
+			int save_errno = errno;
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
 			rollback_lock_file(lk);
-			return error("cannot open '%s' for copying", path);
+			error("cannot open '%s' for copying", path);
+			errno = save_errno;
+			return -1;
 		}
 	} else if (copy_fd(orig_fd, fd)) {
+		int save_errno = errno;
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
 		rollback_lock_file(lk);
+		errno = save_errno;
 		return -1;
 	}
 	return fd;
-- 
2.0.0.770.gd892650.dirty
