From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/6] refs.c: remove unlock_ref and commit_ref from write_ref_sha1
Date: Fri, 23 Jan 2015 12:04:01 -0800
Message-ID: <1422043442-30676-6-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
 <1422043442-30676-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkU2-0007fj-4J
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbbAWUF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:27 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34389 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbbAWUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:11 -0500
Received: by mail-ig0-f182.google.com with SMTP id r10so3878505igi.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F0koquulNOqdMEgQk2JaxeFJGdvniFzcmM9hnfZLFLc=;
        b=YPgu/AUce2D8Z9zYRnC0CuGni124vhy/jGSwIQgDVq1vYMXhDoARRGuXrwm4+Z+1i4
         6l+Sict6fEW4dq28pGkHTgV8bmIQrQiXGJUHEdSS/O4TVaATl2hFQKRfN0YW5ukTGdRP
         DZaNeelpuONQt11tIL1EZG28ZtSlLceKhyt3Flyv3OhCpf40ama7pd9JQXikHL/TzMD6
         /2ahArONclY+4k6SC3+zQXNVp+86jyBR5J5PebS2rO2ePxJdbD5oL4tNQjZDAZZT3dPY
         rLeb170kElSt/CD7hNUvCvpE9QxEc/ukMuWVdYX6P2/wDyV7+vIF5q0OdvOtlXq+7C5J
         9SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F0koquulNOqdMEgQk2JaxeFJGdvniFzcmM9hnfZLFLc=;
        b=EiJ1fv2dx1HsRHdpqwm9qOWro+lWAWnlD5hR5+CpfPsj/I6LswWVc/D42m4ieaEJ8T
         wG2eweoVeK+D3eEzOd1O7ZEJHfHsPZsxo7vj0b28ajTqFQiLJ2BtKwhJOj07NyBvOULp
         NvZG75DQCP683pAqJcMO5uAOgE7oDykpD6vA56hw/2q0sKQoD72k70DttiTRdFsfWrs6
         mcTKosNAz0bEE1QaBv3v4/V0TZRjEDaYV95ax1DAGs4k+nJIMEyBmx823Avr+nzY5qv2
         Cd7D2tVuLivsQz9RaDe0iVkd1vJkHOaSKtzv+ozO0G5CzIJaTCqHGJmLdWPfbVO4Zuu7
         nalg==
X-Gm-Message-State: ALoCoQk+MGKNPKikGAcAkDQb8xt4vuDY75mj2dLDQSbsokLsQXsL4/NDgDGdfmyJ51glQiyEveS5
X-Received: by 10.42.152.197 with SMTP id j5mr10390787icw.40.1422043510707;
        Fri, 23 Jan 2015 12:05:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id vk4sm1168468igc.11.2015.01.23.12.05.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:10 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1422043442-30676-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262959>

This makes write_ref_sha1 only write the the lock file, committing
needs to be done outside of that function. This will help us change
the ref_transaction_commit in a later patch.

Also instead of calling unlock_ref before each return in write_ref_sha1
we can call this after the call. This is a first step to split up
write_ref_sha1 into the write and commit phase which is done in a
later patch.

There is a call in each code path after write_ref_sha1 now. Even in
the last hunk in the error case, the 'goto cleanup;' will make sure
there is a call to unlock_ref.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    new in v3

 refs.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index f1eefc7..1bfc84b 100644
--- a/refs.c
+++ b/refs.c
@@ -2815,8 +2815,11 @@ static int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
 {
+	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
+		return 0;
+
 	if (commit_lock_file(lock->lk))
 		return -1;
 	return 0;
@@ -2879,10 +2882,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	}
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+	if (write_ref_sha1(lock, orig_sha1, logmsg)
+	    || commit_ref(lock, orig_sha1)) {
+		unlock_ref(lock);
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
+	unlock_ref(lock);
 
 	return 0;
 
@@ -2896,8 +2902,11 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
+	if (write_ref_sha1(lock, orig_sha1, NULL)
+	    || commit_ref(lock, orig_sha1))
 		error("unable to write current sha1 into %s", oldrefname);
+
+	unlock_ref(lock);
 	log_all_ref_updates = flag;
 
  rollbacklog:
@@ -3067,22 +3076,19 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3091,7 +3097,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
-		unlock_ref(lock);
 		errno = save_errno;
 		return -1;
 	}
@@ -3099,7 +3104,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-		unlock_ref(lock);
 		return -1;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
@@ -3124,12 +3128,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
 	}
-	if (commit_ref(lock)) {
-		error("Couldn't set %s", lock->ref_name);
-		unlock_ref(lock);
-		return -1;
-	}
-	unlock_ref(lock);
 	return 0;
 }
 
@@ -3762,14 +3760,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
-					   update->msg)) {
-				update->lock = NULL; /* freed by write_ref_sha1 */
+					   update->msg)
+			    || commit_ref(update->lock, update->new_sha1)) {
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
 
@@ -4053,7 +4052,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to commit reflog '%s' (%s)",
 					log_file, strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF)
+			    && commit_ref(lock, cb.last_kept_sha1)) {
 			status |= error("couldn't set %s", lock->ref_name);
 		}
 	}
-- 
2.2.1.62.g3f15098
