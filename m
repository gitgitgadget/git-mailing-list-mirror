From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 6/6] refs.c: enable large transactions
Date: Fri, 23 Jan 2015 12:04:02 -0800
Message-ID: <1422043442-30676-7-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
 <1422043442-30676-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkTr-0007MZ-Gk
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbbAWUFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:20 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:53636 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbbAWUFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:13 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so3897194igb.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stppeNn2O8OtoEDuG4/rrSQAOC/uquxPuK5wfxiiaLg=;
        b=iDpps7FEATgCR/X3Ht+82Z2+IcsN9SIYnrQ+tEfDefAFSktWtOMTTeZ8Hska8O0vqQ
         TJZ8g7fU40E72wGzly9J7neWVpzRrluAs0cjacdnf4+mYn3XhuqISKOdYxUZcjE9DqjL
         axFDtqtOTspPTl2oK5vy9RWPfb+ANVbBhHp/KH6gH22ox2fV1L7dghaPhphTgrcjzNz/
         HNEAC04J/+vxCyZ8vq0qzAPx3AHbJJdr90C6EsAMkxlpd4w6AYvhzz+dDb1MkxviYiW+
         EIfgJ4xIot69/dIck7kh35b5iXMaTNXkI+TEHAUjzFqrTtA3JrhWlThB4SkRrvXpumFf
         JH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stppeNn2O8OtoEDuG4/rrSQAOC/uquxPuK5wfxiiaLg=;
        b=XZo91K4UV2VkL+mCCPBU4KG7xylf6Q9fDbbmB7iIgvH4EQKQaozaGgM7dwYV7Q0F0b
         dFIiqN8HHQo4KCNeufYME9p09aa3TxQdQWOXzgzStNMwAXNG6C42+kQseh0CNCnhyj2N
         xZuQvh+mRJfl3+76riZPYxV281JecpAhqGexLYEp4xzSbbq2+ydZJqHdOmOK3PEkQvaE
         eXN8hx0Ct717sz80crn/sEaFIvFV7qyPKJDsKv+kkxqu3tq67e1L0mbVL6aDuXCxqtkJ
         ihcQpOIa/I5T/YNxydZfBuUtu2qspLWGUJRd4qnVjkFJ1FySpDYwOhKp/7gleiuT24cA
         jOKg==
X-Gm-Message-State: ALoCoQlzyIjx5wRpbC0AoKXYUFaRWhj9hBU/DkKGgRLSNPx94ySp3M/4qoVDyzXuALbtJJVAOncg
X-Received: by 10.42.52.200 with SMTP id k8mr10290498icg.26.1422043512875;
        Fri, 23 Jan 2015 12:05:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id m5sm1173821ige.5.2015.01.23.12.05.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:12 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1422043442-30676-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262958>

By closing the file descriptors after creating the lock file we are not
limiting the size of the transaction by the number of available file
descriptors.

When closing the file descriptors early, we also need to write the values
in early, if we don't want to reopen the files.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    version3:
    * Do not reopen the files after closing them. Make sure we have
      written all necessary information before closing the file.
      Doing it that way enabled us to drop the patch "[PATCH 4/6]
      refs.c: Have a write_in_full_to_lock_file wrapping write_in_full"

 refs.c                | 15 ++++++++++++---
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 1bfc84b..2594b23 100644
--- a/refs.c
+++ b/refs.c
@@ -3752,6 +3752,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		if (!is_null_sha1(update->new_sha1)) {
+			if (write_ref_sha1(update->lock, update->new_sha1,
+					   update->msg)) {
+				strbuf_addf(err, "Cannot write to the ref lock '%s'.",
+					    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
+		}
+		/* Do not keep all lock files open at the same time. */
+		close_ref(update->lock);
 	}
 
 	/* Perform updates first so live commits remain referenced */
@@ -3759,9 +3770,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (write_ref_sha1(update->lock, update->new_sha1,
-					   update->msg)
-			    || commit_ref(update->lock, update->new_sha1)) {
+			if (commit_ref(update->lock, update->new_sha1)) {
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
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
