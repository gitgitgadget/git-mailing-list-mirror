From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/15] lockfile.c: make hold_lock_file_for_append preserve meaningful errno
Date: Wed, 23 Jul 2014 10:03:46 -0700
Message-ID: <1406135035-26441-7-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxw-0004WJ-7K
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbaGWREH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:07 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:64200 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so418580ieb.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlwlI7Aau+Y09RUzdbRsnVD7dvYgPNyqHp6LqFnGdKg=;
        b=m81tCt5ELt4aPCQizFbS3LDGrNk4MG5hbAAuWQR5ive/wxSaaeOeKVC+RGdYJ+sxhd
         xLHPKK+5A98hrbS7J7ks0VXim7WzEpoAvUmhdTHclTiKESB3lpIo/eB4PrYgqwIPaEkg
         iiJZpifCX6W2+rK2Y8wx1+58CtjoKmfCaDoImQGNCoSA/3rVKPszMQCeuz24s99gZ7qA
         0Q9YeHAmQTcMCuhyPaumxui81b13LledvtQcFfAQJHvUi2CHxQaUG0g8ZTnSF+Ceg32Z
         3NVBD1D/vCccI4Gl1lmjbCA8JTmnvDmS14vXK04ySF3JW6UKMNSWiL46KKhpXu8AMen6
         mabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nlwlI7Aau+Y09RUzdbRsnVD7dvYgPNyqHp6LqFnGdKg=;
        b=DopRDAWkCNQ7q+IIXK+zKruiBiHLkezvjxhtGOEMuq5+djr2mIzquW0j3XNQyr6GAd
         psqb3F5T7VXT/zA0RI32+Lth+zczC2H63w563CFdmxH7KJ9Tx78hJ9nhJ1dG2In8JPs4
         7QrJwLl6b7pUdWqv1MHXWhdaCtphNrtgXUKX1zMLscMxLdyfzDADp5JNwa2lf5uHuYq1
         Y4EQa0QcwMTN9cJWEktt8J97DmE6ZC+rdhWJi7d2QJeH0czSYWHhRAuX0V5jlidOqzdt
         8ZP2v//CJ+5/3XSzASa7RC3rZrRB1BgPfyHxoBLYK7CgLqGCGZpOLEjRTQlpYP7yXdF4
         4O/g==
X-Gm-Message-State: ALoCoQkxkQWtUE4douMPIsU0iLidPlV0QNWlsetEAPB4GxCCXtxyHdbEn35EqbQeJHumkskB9gB/
X-Received: by 10.42.207.146 with SMTP id fy18mr1415382icb.12.1406135038755;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si487006yhv.0.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 95E2231C350;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4FF2CE03D9; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254083>

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
2.0.1.508.g763ab16
