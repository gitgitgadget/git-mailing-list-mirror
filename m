From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] refs.c: enable large transactions
Date: Tue, 21 Apr 2015 12:06:11 -0700
Message-ID: <1429643171-27530-1-git-send-email-sbeller@google.com>
References: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 21:06:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkdUy-0004OU-18
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 21:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbbDUTGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 15:06:15 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34970 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbbDUTGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 15:06:14 -0400
Received: by iejt8 with SMTP id t8so21231465iej.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axbJuGq5tnLezNJFCrMiILA8OGXRjtcd5KZ+25Ly6sM=;
        b=VfeSh7JUw6cg9Bz4kT8yRC1F12w2n1NwglXgGt0Er2M8zf6RM++k52sGSnVd7l1X9M
         TgK1UZSV6mFjRZTpS59MN5qbgDghKt7IHIjvwLtxIqI1chgUciW85QPAbXbcaMbN37cx
         H892t4W45HpMWx24vXeebXFVad9zrjlsdS2nv9xrS3XKlwDO4FzsFT+0CFZ8rZpzEM/I
         vEaY+AYixZhxMetyXmudOIVPgPVYQ2JUkH4pJ4he2Mtsd1RR302L+DSjRZepXY548lZh
         UUwKLUcb25YjdX90W5RiQ25f3orzaONxZVsTc88co+Z7Xy3sCnAaMdDPwERT0BjjutZ+
         l13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axbJuGq5tnLezNJFCrMiILA8OGXRjtcd5KZ+25Ly6sM=;
        b=XBw8hSSO5sQN1aaFuSQNr/PeUCW6OKz1tOPSybmT61JKmAF6sDNpiM0WXjFd8ouCfk
         z1ndG0JpTEgz+k2rsvW3D1hWdnNlZ7GPEy2D3CaYRIf/5oTiAhUJJIVrspt0abOUemyq
         Ikr6Z92T5L+6nVGvCBshKZYUESpSRRYbedhvsZdmCAkTr1NqdTwzxe8+BHrns6hb/Hb1
         vnpPxsuWCDJnkHRzxkhigVCdyC7QWASml0tvMDTpswk6uwUNvT/XRPx6QJl4kcwypVtz
         Ak7tX7dsz6mbWwqIhe2fq4cY2frGXih5F71NUZxMwoG2KQcm6JPtuVms8jngddYP4fHp
         Ic5Q==
X-Gm-Message-State: ALoCoQm+oKYbyOS138mVcHEU0kRiC9849TnKzSLezOivUcfX+EUtwGdlKcJLAnwpFJSDZnvfDIcL
X-Received: by 10.107.169.74 with SMTP id s71mr30863639ioe.46.1429643174126;
        Tue, 21 Apr 2015 12:06:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4566:60b8:9788:169f])
        by mx.google.com with ESMTPSA id y9sm8589047igl.6.2015.04.21.12.06.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 12:06:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g4c2045b.dirty
In-Reply-To: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267548>

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

* Removed unneeded braces in the condition to check if we want to close
  the lock file.
* made the counter for the remaining fds an unsigned int. That is what   
  get_max_fd_limit() returns, so there are no concerns for an overflow.
  Also it cannot go below 0 any more.
* moved the initialisation of the remaining_fds a bit down and added a comment  
  
 refs.c                | 21 +++++++++++++++++++++
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 23 insertions(+), 2 deletions(-)
 
 

diff --git a/refs.c b/refs.c
index 4f495bd..34cfcdf 100644
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
@@ -3718,6 +3720,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, i;
+	unsigned int remaining_fds;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
@@ -3733,6 +3736,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
+	/*
+	 * We need to open many files in a large transaction, so come up with
+	 * a reasonable maximum. We still keep some spares for stdin/out and
+	 * other open files. Experiments determined we need more fds when
+	 * running inside our test suite than directly in the shell. It's
+	 * unclear where these fds come from. 32 should be a reasonable large
+	 * number though.
+	 */
+	remaining_fds = get_max_fd_limit();
+	if (remaining_fds > 32)
+		remaining_fds -= 32;
+	else
+		remaining_fds = 0;
+
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3762,6 +3779,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		if (remaining_fds > 0)
+			remaining_fds--;
+		else
+			close_lock_file(update->lock->lk);
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
