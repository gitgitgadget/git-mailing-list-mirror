From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: enable large transactions
Date: Mon, 20 Apr 2015 17:35:06 -0700
Message-ID: <1429576506-10790-1-git-send-email-sbeller@google.com>
References: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 02:35:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkM9j-0000L9-FS
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 02:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbbDUAfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 20:35:10 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37573 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbbDUAfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 20:35:10 -0400
Received: by igblo3 with SMTP id lo3so3144649igb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HlqngmYhuV3/0yawGVt+uM1CoLjdU8elF0QNjP47Oi4=;
        b=ocofAN0YBjLJBcxpp6X+jCdescFnbMZdS/a7Q6AbZpavUIpSk5y0nvO9chC3vnsCyE
         H12jvngwK6ov7v1qj2kmtySQQ7Lccl7PCNGfP40PpQTOUTopyukOCLYPlgNk3V+sY3Ld
         ufHQ1c7RdSIKlYPW+19uHdQvv2mjca+CJMskshBg2n1TjG6M3JBvlHaPG/Y9kzyDSckf
         3Yp6hhCnNPvzNX14DYuDyMcpQ81cnkiWu+Ha6KigBsNb57OrPGTdlYFSjoisgm920n3a
         nM1ctujQ2Q4FXClN9eZP8kaUjEf0mKgJyOAjopiRR/HxdHTs+9eF1qwLwGc9abFkmfea
         b+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HlqngmYhuV3/0yawGVt+uM1CoLjdU8elF0QNjP47Oi4=;
        b=Puez7yuW5YxPa0oTvuTzAojb1FTUZvVoVbqTpfeoumsplFgBNp0kqTKW3YEfP/koTr
         6EBpiqhRiCZ/klMC/hIFDzGe9yFGujW2sqr4LVhfonVcHK0hvZikHl6IskL4px5CCSlw
         z7/rigSBnCxcTB4yGTAMQI7jn+LGTBGzYOK/OvVFE7ntrbOZrOzPdKhtOAq4h3bLI22b
         dSkiPnUnRZ2U+eo3hoRy7lz5bH0PeXBJ57UJcza4s+hVySbYqmBY76gsoSpTU2qIBamy
         VpfTkAauUyGGBpKYxKKcz7g1mz9pLxtqfMGD6BJ5hmgb4eV39MHwLdgepj/+/YKse5QV
         VSeg==
X-Gm-Message-State: ALoCoQnJPy9cg3OagM6NKJOxSxhD8Kx6hwe5SMVV86akH4ElQvpOU+hcwBHw0H2y56aDTqIvyxEv
X-Received: by 10.43.60.14 with SMTP id wq14mr523118icb.60.1429576509222;
        Mon, 20 Apr 2015 17:35:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:f4b8:f7b6:d035:2ad4])
        by mx.google.com with ESMTPSA id n5sm372775igp.10.2015.04.20.17.35.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Apr 2015 17:35:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g4c2045b.dirty
In-Reply-To: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267514>

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

This replaces the latest patch on origin/sb/remove-fd-from-ref-lock
The test suite passes now

 refs.c                | 13 +++++++++++++
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4f495bd..1e8cb16 100644
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
+	int remaining_fds = get_max_fd_limit() - 32;
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
2.4.0.rc2.5.g4c2045b.dirty
