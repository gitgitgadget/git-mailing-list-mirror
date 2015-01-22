From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] refs.c: remove unlock_ref from write_ref_sha1
Date: Thu, 22 Jan 2015 15:11:34 -0800
Message-ID: <1421968297-25407-3-git-send-email-sbeller@google.com>
References: <54C0DDE7.8030708@alum.mit.edu>
 <1421968297-25407-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org, ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jan 23 00:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQui-0001Qd-LI
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbAVXLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:11:45 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:50972 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbAVXLo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:11:44 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so3289565igj.4
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wmsaau7pOF6+r7TvEAQdaMwr4wKlv9ET0FoFgtc7kew=;
        b=SefgnUW25S6J6kMo6nvQZFf7TOAkJVZZmjkaJYj+g4OWhPOnn+3bBhufXqRyeXFK5F
         fTWS/vpCUeTaMfbc30f3njBNosYLQWUpLzzr8RnBboWoLmnoI3zB8IMjXGNx95lVCWM+
         A6gBI0gduUZx8dNG/Ixe4M4ku3TXdT0rcYc2mUzO2ocfB8PGsJSBZKwPr2HK+bzv0bLo
         OCHTAddzs+nYmGczyh6J5pmKAqNPF3hRKOfChrOVcW91LTWjAxm0EVNz3Mpmo/28TdM5
         +q3Be4VeOKFcxrDEWbOAJXehXgjhO43iqL3oOiI1u8sXlINZtWYv3Tjlo0W5FmDPITUv
         iLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wmsaau7pOF6+r7TvEAQdaMwr4wKlv9ET0FoFgtc7kew=;
        b=Ihw4wkCU+1ah05kBTOaKck+d3FPW4FieGQfYYbdwaGTfiKTpNiyWUiOmrhgHVkuVsz
         jYJh0SHlIOBQ4cywI3VhuxIN/fIJKKnEW5AE2jJdf6ZlvgaU/4DHoN7AiXdzNa34r2cG
         wN4fdXNwyIB78rXou31AxrcrcDRrOSi1H2pPe3Ibtw+z6qbppbsQvT1QJqyijECd5sKR
         GjHCCVmjuoDR6meY+/binSAf3sOVnlOLBzN3lfGC8RnPu6bhonQg2MXciVab8o8K7iFV
         mKQRfgyPHft/0065wohDDPPsMg46dr/YUf9Hf/krtT1ul15laoqhAEK4oy56XlXr9Kou
         /7hQ==
X-Gm-Message-State: ALoCoQmXGaggDCSkiuVFmUf9eA3kfInhmpaQ0yqqSjof3eiosSEcWTR20LFFkFNpPSFqmVOVHzOJ
X-Received: by 10.107.155.9 with SMTP id d9mr754306ioe.29.1421968303168;
        Thu, 22 Jan 2015 15:11:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e0f4:42de:391f:3cc5])
        by mx.google.com with ESMTPSA id 185sm241814iof.43.2015.01.22.15.11.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 15:11:42 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421968297-25407-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262887>

Instead of calling unlock_ref before each return in write_ref_sha1
we can call this after the call. This is a first step to split up
write_ref_sha1 into the write and commit phase which is done in a
later patch.

There is a call in each code path after write_ref_sha1 now. Even in
the last hunk in the error case, the 'goto cleanup;' will make sure
there is a call to unlock_ref.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index aae3b66..4580919 100644
--- a/refs.c
+++ b/refs.c
@@ -2866,9 +2866,11 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+		unlock_ref(lock);
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
+	unlock_ref(lock);
 
 	return 0;
 
@@ -2884,6 +2886,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	log_all_ref_updates = 0;
 	if (write_ref_sha1(lock, orig_sha1, NULL))
 		error("unable to write current sha1 into %s", oldrefname);
+	unlock_ref(lock);
 	log_all_ref_updates = flag;
 
  rollbacklog:
@@ -3083,22 +3086,19 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
+	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
 		return 0;
-	}
+
 	o = parse_object(sha1);
 	if (!o) {
 		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
-		unlock_ref(lock);
 		errno = EINVAL;
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		error("Trying to write non-commit object %s to branch %s",
 			sha1_to_hex(sha1), lock->ref_name);
-		unlock_ref(lock);
 		errno = EINVAL;
 		return -1;
 	}
@@ -3106,7 +3106,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
-		unlock_ref(lock);
 		errno = save_errno;
 		return -1;
 	}
@@ -3114,7 +3113,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-		unlock_ref(lock);
 		return -1;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
@@ -3141,10 +3139,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 	}
 	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
-		unlock_ref(lock);
 		return -1;
 	}
-	unlock_ref(lock);
 	return 0;
 }
 
@@ -3770,7 +3766,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		/* Do not keep all lock files open at the same time. */
-		close_lock_file(update->lock->lk);
+		close_ref(update->lock);
 	}
 
 	/* Perform updates first so live commits remain referenced */
@@ -3780,13 +3776,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
-				update->lock = NULL; /* freed by write_ref_sha1 */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
-			update->lock = NULL; /* freed by write_ref_sha1 */
+			unlock_ref(update->lock);
+			update->lock = NULL;
 		}
 	}
 
-- 
2.2.1.62.g3f15098
