From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/5] refs.c: enable large transactions
Date: Wed, 21 Jan 2015 18:32:09 -0800
Message-ID: <1421893929-7447-6-git-send-email-sbeller@google.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 03:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE7Zd-00084O-KJ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 03:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbbAVCcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 21:32:35 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35680 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbbAVCcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 21:32:25 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so4628672igb.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 18:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRdsWf1Wv4UAi8Hf7C3724xXMfKzSkaFelA1gUrsCrc=;
        b=BKJzr2vB16R8JMtWroc6kOZyLxE4DRB4ibi37UPotvAksQCIXU2w344rintF2Ts/P8
         813oTRdAn8AlTEsX70Zx3f0BgAFfnZDjZ7a9MVvgM4M8fY0ZhYpsyLn4Xv+SdJsUnpjd
         qwTfqo6y//l13Zb2l+RVhTBjcvr0HhsaoMnDEMZZ+1jHeNrK4Werd6O9hI31DwhG7ss/
         5tVTRbGIwY4oNUsOPzmMkqdCjsRGOKlhriHYTBxf4mm2FH3yV2I8ngt9bwiqn90FO+wR
         K5Zr4MjZ6s4pdKSfvxo291T0y6soC65Iq1f//hkgH/34FG1NqOG6LyyLPKxcY7prznUJ
         ezOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRdsWf1Wv4UAi8Hf7C3724xXMfKzSkaFelA1gUrsCrc=;
        b=bIc1hbhohsUKP7VQUGGCGzZcdsGHduzUzNrRcF3u/rjhYU5swd6MCx5RqcCxftW+FR
         z5SiiRF43NniuaVfsEZbbG7BFP5Abf5XjJB+/6yUkfB+uQ3dFxRoeTBmvBcbnoErbCfa
         +zrLyDnYKq/SYBDYveXwAcHKAT4j6/I3HBBiAqb9Ci9t/pNL91fSXdRj1Uvo/l4d9U9M
         PdyNs73wgoNUyIWCN/nzEtBvJm+4PywC6cJywoN2dZJ/ABbHEz2mLkF4chWLbQBGsUZ7
         INb2N3Rmfrwz7HVSE4MqIiZIdH6Yz7JHsf+o6oOdWHTr9ruGaPpprNJzUP1E47HjOkhF
         KSlg==
X-Gm-Message-State: ALoCoQmi4vy/shsktCoapBmezTgyNgZ6DWDfZrDD3cdkEuZT7PH5Nm3d95R8c/Y6tCbYW04l230D
X-Received: by 10.50.254.4 with SMTP id ae4mr380171igd.10.1421893938875;
        Wed, 21 Jan 2015 18:32:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id mi3sm1165281igb.13.2015.01.21.18.32.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 18:32:18 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421893929-7447-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262794>

By closing the file descriptors after creating the lock file we are not
limiting the size of the transaction by the number of available file
descriptors.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c                | 17 +++++++++++++----
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 2013d37..9d01102 100644
--- a/refs.c
+++ b/refs.c
@@ -3055,11 +3055,18 @@ int is_branch(const char *refname)
 static int write_sha1_to_lock_file(struct ref_lock *lock,
 				   const unsigned char *sha1)
 {
-	if (fdopen_lock_file(lock->lk, "w") < 0
-	    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
+	if (lock->lk->fd == -1) {
+		if (reopen_lock_file(lock->lk) < 0
+		    || fdopen_lock_file(lock->lk, "w") < 0
+		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41
+		    || close_lock_file(lock->lk) < 0)
+		    return -1;
+	} else {
+		if (fdopen_lock_file(lock->lk, "w") < 0
+		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
 		return -1;
-	else
-		return 0;
+	}
+	return 0;
 }
 
 /*
@@ -3761,6 +3768,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		/* Do not keep all lock files open at the same time. */
+		close_lock_file(update->lock->lk);
 	}
 
 	/* Perform updates first so live commits remain referenced */
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 47d2fe9..c593a1d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -979,7 +979,7 @@ run_with_limited_open_files () {
 
 test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
@@ -990,7 +990,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
 )
 '
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
-- 
2.2.1.62.g3f15098
