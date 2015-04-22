From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] refs.c: enable large transactions
Date: Wed, 22 Apr 2015 14:30:27 -0700
Message-ID: <1429738227-2985-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, gitster@pobox.com, git@vger.kernel.org,
	peff@peff.net
X-From: git-owner@vger.kernel.org Wed Apr 22 23:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl2EM-0002rO-0b
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 23:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbbDVVaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 17:30:39 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36951 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbbDVVah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 17:30:37 -0400
Received: by igblo3 with SMTP id lo3so8231123igb.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PtkWSgJXiXZL6raK0+5RJ3nU0P0IQ21WOvhSQK2zg98=;
        b=d+tmBuOke77ksYgQ9gAi9pG63f0Ob3SySirxgDzHL82TT8e7BFHlpPfi9IXoQWJT62
         us7m0UmDUPUJa5mOH7h6yLVKpRYJJSiT6QMFG7mzxw1j1QjTF8dyQViwgJaV8UU4LcXW
         nJOJaF41onpoKH62nHoNZTRSKAvlGtAqzui85pOJLxckFKc4IE9V/1hHg8Y2vQOCxffj
         wB9JnnzwcKXeVTiW3mBBVrf7ZMh5eahD0EvcrmiWXFMFlBAfTBjIqsbE5bqcDwexO4UH
         f5+otVcKudWSjW2GH5aVPvuAWNulj4UN8agAtSyznS+pM+tuNMds2qcJ+Sp007Ds2Nnc
         5P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PtkWSgJXiXZL6raK0+5RJ3nU0P0IQ21WOvhSQK2zg98=;
        b=haUzlSuSGJoF2Cg4UgR0kuNPfBcP5x3mgnbsL2Ga4IusWmXOIrTIOCV/hsBm6WSw3j
         ZMINoBiGIzOuZaFqy5GKwjptqEwkgF0ne1yRcjvUm1N8f51bvf2n00/eXqCgtnPxlmYt
         qwFjh2Lw7zFNXe3ir8gUoSwS1h/6eLv3nf9oPi23CqbdDLSxea3ndASRPwzf+5S6+J5p
         TaUPlAVEQTMvhbWR0aJuLeaTbW1igwT2oMBGvzkdT1kNr5Pznv2xHaV7ccXXiRbfHiNa
         2EGo6mXS58Oi8RFmbVWYGh9VhR+1nxNJGRqXR4fyFZIIv9FKxY+zbyAjSuBDLnMS5+RN
         lYXw==
X-Gm-Message-State: ALoCoQkqcmgTar9OCuEswoE3jySY6v1dmzJd2JKVTzBQ2HSc9i0GZex2Y88VNdGEPNV82hYBSV5j
X-Received: by 10.50.25.225 with SMTP id f1mr63883igg.29.1429738230044;
        Wed, 22 Apr 2015 14:30:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e838:9fb1:8131:6475])
        by mx.google.com with ESMTPSA id o196sm3910025ioe.26.2015.04.22.14.30.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Apr 2015 14:30:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g4c2045b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267643>

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

Notes:
    * Added error checking when reopening the lock
    
    * Only call close_lock_file when needed.
      (This makes the code a bit harder to read, but
       might be worth it nevertheless. close_lock_file would
       return early anyway, so we're trading off a function call
       to some additional check (!(flags & REF_HAVE_NEW) ||is_null_sha1(update->new_sha1))
    
    * tuned the number of spare fd to be 25 as in the other occurence.
      At least we want to be consistent with our made up ballpark numbers.
    
    * This replaces the latest patch on origin/sb/remove-fd-from-ref-lock

 refs.c                | 28 ++++++++++++++++++++++++++++
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4f495bd..7ce7b97 100644
--- a/refs.c
+++ b/refs.c
@@ -3041,6 +3041,13 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
+	if (lock->lk->fd == -1 && reopen_lock_file(lock->lk) == -1) {
+		int save_errno = errno;
+		error("Couldn't reopen %s", lock->lk->filename.buf);
+		unlock_ref(lock);
+		errno = save_errno;
+		return -1;
+	}
 	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
@@ -3718,6 +3725,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, i;
+	unsigned int remaining_fds;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
@@ -3733,6 +3741,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
+	/*
+	 * We need to open many files in a large transaction, so come up with
+	 * a reasonable maximum. We still keep some spares for stdin/out and
+	 * other open files. Experiments determined we need more fds when
+	 * running inside our test suite than directly in the shell. It's
+	 * unclear where these fds come from. 25 should be a reasonable large
+	 * number though.
+	 */
+	remaining_fds = get_max_fd_limit();
+	if (remaining_fds > 25)
+		remaining_fds -= 25;
+	else
+		remaining_fds = 0;
+
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3762,6 +3784,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		if (!(flags & REF_HAVE_NEW) ||
+		    is_null_sha1(update->new_sha1) ||
+		    remaining_fds == 0)
+			close_lock_file(update->lock->lk);
+		else
+			remaining_fds--;
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
