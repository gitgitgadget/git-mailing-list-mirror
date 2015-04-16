From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] refs.c: enable large transactions
Date: Thu, 16 Apr 2015 16:17:39 -0700
Message-ID: <1429226259-21622-4-git-send-email-sbeller@google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 17 01:18:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yit2v-00013M-8C
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 01:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbbDPXSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 19:18:06 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33133 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbDPXR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 19:17:59 -0400
Received: by iecrt8 with SMTP id rt8so50932873iec.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 16:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WlQT6D8IGUoHs3IkU4lacdaCm+2QnfbdP8I6bk08h3c=;
        b=NtkDvfsDRpa4T4t/NhNfItM4ZNHOmqjNjSI6hqznX/EyoZc15qZ/VicMapd/XM/ylt
         kIlNTduLc6L3f5imGmWlYQMcnNM1PSmPz6OF3KPsNEw52ZRPECIkCOVgA5s5g2j2juA7
         lHhLO5MrVGeXrKOee9G9ftu4U3UIGWlcqJTq/Pg3NVvzBucHjXowZQiGqbPtBRI4m7kS
         zoKwHxzQUqksO4hx45LK+XvQytk+cxkD3jIZMyd0t9xFcnGHTHBwIiewm70nMEJrc5iT
         nnOfsqSHy7PmxzCVIeOVWT41SU4EtRfW+mR9/ysbUdMoPwKrbNPI4cHoAv6qYVD3a64g
         /smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WlQT6D8IGUoHs3IkU4lacdaCm+2QnfbdP8I6bk08h3c=;
        b=eIXnHDjp8htnvbH/wl+PZZoqryq7Bxq36f9cNAVBD1GI/AvjedQsbhf5JQlQRw0i/0
         z1hGvuchkAnnyRBOmWNehhS/gKslmRruAh36S2RMCmTumv4HEDhj/3WfZEPnNSZaBvrq
         l4EGoX7SSznE6+DqnIsnK4YdTN3k4dX+wZ6RBbEdgFiQHeUCPybZroNq9yc/qRk/q5xB
         Dhze4RvTjQ6ZDGYQ3TUfBjDINfxi9tXdoBBYPzg4K3aW3Vy5MzEAqlfic4iLrZn9W7fe
         GSpZNkUF6eaSoci4ASOEmE44yGd1AfJzWQBK9kZfsGRiwNjFf/TdY0FvxIyYVXlFC5/V
         rzAw==
X-Gm-Message-State: ALoCoQnoZYVTjsPWCUvmDbehXo2/bqnNOBdQNc17pVXTx9ZCIEwiFG9flQPg09C0/RXWfUNlXW1O
X-Received: by 10.107.7.196 with SMTP id g65mr281762ioi.28.1429226279299;
        Thu, 16 Apr 2015 16:17:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:fdc7:e96c:1b25:2317])
        by mx.google.com with ESMTPSA id x9sm144505igl.2.2015.04.16.16.17.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 16:17:58 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1429226259-21622-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267343>

This is another attempt on enabling large transactions
(large in terms of open file descriptors). We keep track of how many
lock files are opened by the ref_transaction_commit function.
When more than a reasonable amount of files is open, we close
the file descriptors to make sure the transaction can continue.

Another idea I had during implementing this was to move this file
closing into the lock file API, such that only a certain amount of
lock files can be open at any given point in time and we'd be 'garbage
collecting' open fds when necessary in any relevant call to the lock
file API. This would have brought the advantage of having such
functionality available in other users of the lock file API as well.
The downside however is the over complication, you really need to always
check for (lock->fd != -1) all the time, which may slow down other parts
of the code, which did not ask for such a feature.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c                | 13 +++++++++++++
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4f495bd..44e0b15 100644
--- a/refs.c
+++ b/refs.c
@@ -3041,6 +3041,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
+	if (lock->lk->fd == -1)
+		reopen_lock_file(lock->lk);
 	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
@@ -3719,6 +3721,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	int ret = 0, i;
 	int n = transaction->nr;
+	/*
+	 * We may want to open many files in a large transaction, so come up with
+	 * a reasonable maximum, keep some spares for stdin/out and other open
+	 * files.
+	 */
+	int remaining_fds = get_max_fd_limit() - 8;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -3762,6 +3770,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		if (remaining_fds > 0) {
+			remaining_fds--;
+		} else {
+			close_lock_file(update->lock->lk);
+		}
 	}
 
 	/* Perform updates first so live commits remain referenced */
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7a69f1a..636d3a1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1071,7 +1071,7 @@ run_with_limited_open_files () {
 
 test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
@@ -1082,7 +1082,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
 )
 '
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
-- 
2.3.0.81.gc37f363
