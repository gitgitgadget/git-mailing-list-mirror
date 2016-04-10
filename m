From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 6/6] builtin/merge.c: Fix a bug with trivial merges
Date: Sat,  9 Apr 2016 23:13:40 -0700
Message-ID: <1460268820-8308-7-git-send-email-newren@gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dK-00049x-EM
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbcDJGN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:13:57 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35553 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcDJGNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:55 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so12010373pac.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjf3x0IEsr1v0FCHJIAs5818DGT34E3jcIfNtOvYf0s=;
        b=A64s8xr3emN9DBPO4qwn0Va4zLqK8N8gx86kA7MQBcg9Nz1SidUNdX4EZpef7G2WGg
         4t32mcjDZxwqB8wQnlx5vPnQPGcahx+RY1i3ZxLBDtzaij6yLcus6BtO+CVsh49nc3kd
         jKMkao8BeJubqLVoNWVWHWLu4vQrsn4OlJ2JK12iww+iHjPJGFHwZT2W9ZrMAfKBj9FU
         9/I4EdAPk7Hh+F1bTO2Qh2eiWi7t+LqVDu/D6PVshndW/RGAgFNj7jvtpH1RK7UgJ2Kt
         rU9uMI3nWqhReJVCadW5R4Nf8mkfugc6EOwg8ygjUsD6RuN6i9Lf05ylhQD46JL0rStC
         zguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjf3x0IEsr1v0FCHJIAs5818DGT34E3jcIfNtOvYf0s=;
        b=RXfQIJY5yF2O1Agli9I0HNAC1BIV5tio7UEePAo0hm2qv2Cok4YjpGDm/zCHbp3HN5
         7T2cSEJrea69naT58JTxKwoz9/yAVTTlyWBPNl7ipC4J1mUCWiYdcFwv1rkpR36hepDA
         FDWkKyex54rBIHjtYmxmeSs2uwfk87FHGiDbe36adf+X4ji9PK9bWnfnVN/4Yoakk+6O
         rr/lWWf689YseetBc7SQux20X34DFKyWApa028e7Xc5SZY14cVHOEq7nIcIclSEu43gE
         dtxe8rHtDU83DN9odQwuAk1Z9ew8EVyZqtEyOZ0Z1ug8p762L3pTUUUbXOv9Ur6UxZ3O
         hjtA==
X-Gm-Message-State: AD7BkJL2fuO/vXhyC6x1GVFPDH2kHRC91Q43RY91SXrBeNMNEqJTyiDcOFEGGzvAjRbCCg==
X-Received: by 10.66.221.167 with SMTP id qf7mr24165662pac.94.1460268834646;
        Sat, 09 Apr 2016 23:13:54 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291142>

If read_tree_trivial succeeds and produces a tree that is already in the
object store, then the index is not written to disk, leaving it
out-of-sync with both HEAD and the working tree.

In order to write the index back out to disk after a merge,
write_index_locked() needs to be called.  For most merge strategies, this
is done from try_merge_strategy().  For fast forward updates, this is
done from checkout_fast_forward().  When trivial merges work, the call to
write_index_locked() is buried a little deeper:
  merge_trivial()
  -> write_tree_trivial()
     -> write_cache_as_tree()
        -> write_index_as_tree()
           -> write_locked_index()
However, it is only called when !cache_tree_fully_valid(), which is how
this bug is triggered.  But that also shows why this bug doesn't affect
any other merge strategies or cases.

Add a direct call to write_index_locked() from merge_trivial() to fix
this issue.  Since the indirect call to write_locked_index() was
conditional on cache_tree_fully_valid(), it won't be written twice.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c          | 8 ++++++++
 t/t7605-merge-resolve.sh | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..8615343 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -819,6 +819,14 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	unsigned char result_tree[20], result_commit[20];
 	struct commit_list *parents, **pptr = &parents;
+	static struct lock_file lock;
+
+	hold_locked_index(&lock, 1);
+	refresh_cache(REFRESH_QUIET);
+	if (active_cache_changed &&
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
+		return error(_("Unable to write index."));
+	rollback_lock_file(&lock);
 
 	write_tree_trivial(result_tree);
 	printf(_("Wonderful.\n"));
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 2f80037..5d56c38 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -43,7 +43,7 @@ merge_c1_to_c2_cmds='
 
 test_expect_success 'merge c1 to c2'        "$merge_c1_to_c2_cmds"
 
-test_expect_failure 'merge c1 to c2, again' "$merge_c1_to_c2_cmds"
+test_expect_success 'merge c1 to c2, again' "$merge_c1_to_c2_cmds"
 
 test_expect_success 'merge c2 to c3 (fails)' '
 	git reset --hard c2 &&
-- 
2.8.0.21.g229f62a
