From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/6] Fix bug in large transactions
Date: Fri, 23 Jan 2015 12:03:56 -0800
Message-ID: <1422043442-30676-1-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkTf-000795-4T
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbbAWUFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:07 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55040 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbbAWUFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:05 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so3794980igk.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ViIxZjRUE4zdr/xukXhtlg+W5n+TQvv1riIFf3gPypM=;
        b=TkkwXQb0v1YGYzThYjUkwiBGsaBObxOoV+mJ2ZSqkXXzLgrxh4VDGYAuGQh7DaNYQ7
         bH3g53KURU0TGdc5s7sqCA79ap8unB82BU1ZKIdcuKIxDjXxFvRQyJwGzc4djG7v+r/x
         +paoeqZOaSkMMg7aeKNF3QEQjQEOk6JFV1O+pQZRHkZjlB9mdH19zjlluv/FIwTP45T/
         b117bpADWLYKQr3HMgIbpBY7/+xr7z30xdZ6wHF+9oY85z5frXjTtxIWFfTtpIjljGTA
         dYMUJ8E/FURNfYz36+QaD7x42qVP7TCCXJPExgkEEGGbPqBXLlfLIRTxyE72pouMlY8r
         qs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ViIxZjRUE4zdr/xukXhtlg+W5n+TQvv1riIFf3gPypM=;
        b=dubePzbKVgHG39rmV6p4gNo8CZj4222q9CgFsJxvnlB/vCrpmHbYrMS5Lo8/2jzHdX
         gOnm6TRBNfUSiSa/uLsTEuzODlyAUq+0F9eJsRunlsguUykh8dAwwLFJutGEGmJbAqZG
         8uYGVMzX+b3z9FsIGQfqI3PO4ns/OW/7Rd93PY27P+yzysnVCrAFiYDHs2NqwuBscD1R
         dz6SkIZVPz2A1wY+ocHDu7A32BD2t3oMUy4riqcbfDAm55UEjzK5qfXriXsSawJTgHtp
         337ZuCQyWVUsw9Ctzu9ZQ0ocqTJRsDdoy4OZjYefXDa8AOwDvvPFy1zaxaY2gfhUDQn6
         HItA==
X-Gm-Message-State: ALoCoQku48AQP2stwY4UUcqbvsR78EhlFrXk4diBTVmNBg/VzS/kPberJl4jAs2l+dbQL2s9NpsM
X-Received: by 10.50.36.103 with SMTP id p7mr3930262igj.20.1422043504520;
        Fri, 23 Jan 2015 12:05:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id e25sm1355826iod.35.2015.01.23.12.05.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:03 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <54C0E76D.5070104@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262953>

version3:
  patches 1,2,3 stayed completely as is, while patches 4,5 are new, patch 6 is 
  rewritten to first write the contents of the lock files before closing them.
  
  This combines the series "Enable large transactions v2" as sent out yesterday
  with the follow up series "[RFC PATCH 0/5] So you dislike the sequence of 
  system calls?"
  
  There is no write_in_full_to_lock_file wrapper any more, but write_ref_sha1
  was reduced in functionality in patch 5.
  
  This applies on top of origin/sb/atomic-push and results in a merge conflict
  when merging it to origin/jk/lock-ref-sha1-basic-return-errors which looks like
        
        $git checkout origin/jk/lock-ref-sha1-basic-return-errors
        $git merge enable_large_transactions
        CONFLICT (content): Merge conflict in refs.c
        $git diff
++<<<<<<< HEAD
 +      lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 +      if (lock->lock_fd < 0) {
++=======
+       if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
++>>>>>>> enable_large_transactions

which is best resolved as:
@@@ -2316,8 -2333,7 +2333,12 @@@ static struct ref_lock *lock_ref_sha1_b
                goto error_return;
        }
  
+        if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
                last_errno = errno;
                if (errno == ENOENT && --attempts_remaining > 0)
                        /*


version2:

* This applies on top of origin/sb/atomic-push though it will result in a one
  line merge conflict with origin/jk/lock-ref-sha1-basic-return-errors when
  merging to origin/next.

* It now uses the FILE* pointer instead of file descriptors. This
  results in a combination of the 2 former patches "refs.c: have
  a write_in_full_to_lock_file wrapper" and "refs.c: write to a
  lock file only once" as the wrapper function is more adapted to
  its consumers

* no need to dance around with char *pointers which may leak.

* another new patch sneaked into the series: Renaming ULIMIT in t7004
  to ULIMIT_STACK_SIZE

That said, only the first and third patch are updated from the first version
of the patches. The others are new in the sense that rewriting them was cheaper
than keeping notes in between.

version1:

(reported as: git update-ref --stdin : too many open files, 2014-12-20)

First a test case is introduced to demonstrate the failure,
the patches 2-6 are little refactoring and the last patch
fixes the bug and also marks the bugs as resolved in the
test suite.

Unfortunately this applies on top of origin/next.

Any feedback would be welcome!

Thanks,
Stefan

Stefan Beller (6):
  update-ref: test handling large transactions properly
  t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
  refs.c: remove lock_fd from struct ref_lock
  refs.c: move static functions to close and commit refs
  refs.c: remove unlock_ref and commit_ref from write_ref_sha1
  refs.c: enable large transactions

 refs.c                | 93 +++++++++++++++++++++++++++------------------------
 t/t1400-update-ref.sh | 28 ++++++++++++++++
 t/t7004-tag.sh        |  4 +--
 3 files changed, 79 insertions(+), 46 deletions(-)

-- 
2.2.1.62.g3f15098
