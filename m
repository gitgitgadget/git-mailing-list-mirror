From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 22/42] fetch.c: use a single ref transaction for all ref updates
Date: Thu,  1 May 2014 13:37:22 -0700
Message-ID: <1398976662-6962-23-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxkJ-00011h-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbaEAUiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:01 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:33855 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbaEAUhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:54 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so797399oag.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PU/qtdiM/PO8HiLSOYrx2tu2jQNY0pVnnPizX+Kc/8=;
        b=paQG9q9qD3c96nv7R+Tox3vDvkeKRxEaty7nrdeUKFKAYdM8iJ+0ACHKWBPAo1kIql
         L4xa3xY4wLhL5A/5wR0lqcEhWN9Kd0ysHvFazzhF2rSRuuUtncd1wlkFF77lSD318pYF
         +ehbpEQDN0trf92YegZgaIniDbMwQYfbPQEfe4wV+KA7yE2w6/Y3eKSanb+ps73RVEkq
         UzTcXRQanXN0qjkvEValyv2T8N4Un+0P9XQn4rCmq5kG+w7VLvScoJdV0P3/rvduKT3W
         XmRNowH6MiipwjIkXXJpQ0AaNMHncgFzq/hHkoicT9RBzehCtnbljuCcL6lpsioxy9T1
         gaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PU/qtdiM/PO8HiLSOYrx2tu2jQNY0pVnnPizX+Kc/8=;
        b=gALqKuve30E9Xmdl+IIhF8nCLcLl8T6J3KA9Q+Og9oeRxW6ZZLLzEZq4WEN51/aeIR
         DdAywnesUN6dGGUDh0mLXyDBdF5BGgDog5oW0WPk6uz3NZhmx42cJx4XjKRXKOd3sTAt
         4cEql+ecehYrd13aoaRt+HHEwcKxHlzAOgVblMrMCJ8MA2OdBSiOBj7Aaq1u/hmB0bzZ
         VWskPW455xIWF9hPWdXigL55T/9Cq4lBn/yS3Xe/iTicvHDqpoyUpqjcJkdPqM5zYpeh
         w6a4OqB0KiiE5pR8DcW3v09bgy8DH88ZcKVsXtfjLGFRU7DFe6rS2c6OSSlqi3NBpCnf
         Ld4w==
X-Gm-Message-State: ALoCoQnRDlSOpD2rjWoIsEJRAASQ5URcYUg2Zk6mTjslxiLv8hPY/nHs4eIFP5y8yO0tuDjqinP1
X-Received: by 10.182.75.193 with SMTP id e1mr6802226obw.1.1398976674245;
        Thu, 01 May 2014 13:37:54 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538066yhe.3.2014.05.01.13.37.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:54 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ED9C131C1CC;
	Thu,  1 May 2014 13:37:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B2404E097F; Thu,  1 May 2014 13:37:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247843>

Change store_updated_refs to use a single ref transaction for all refs that
are updated during the fetch. This makes the fetch more atomic when update
failures occur.

Since ref update failures will now no longer occur in the code path for
updating a single ref in s_update_ref, we no longer have as detailed error
message logging the exact reference and the ref log action as in the old cod
Instead since we fail the entire transaction we log a much more generic
message. But since we commit the transaction using MSG_ON_ERR we will log
an error containing the ref name if either locking of writing the ref would
so the regression in the log message is minor.

This will also change the order in which errors are checked for and logged
which may alter which error will be logged if there are multiple errors
occuring during a fetch.

For example, assume we have a fetch for two refs that both would fail.
Where the first ref would fail with ENOTDIR due to a directory in the ref
path not existing, and the second ref in the fetch would fail due to
the check in update_logical_ref():
        if (current_branch &&
            !strcmp(ref->name, current_branch->name) &&
            !(update_head_ok || is_bare_repository()) &&
            !is_null_sha1(ref->old_sha1)) {
                /*
                 * If this is the head, and it's not okay to update
                 * the head, and the old value of the head isn't empty...
                 */

In the old code since we would update the refs one ref at a time we would
first fail the ENOTDIR and then fail the second update of HEAD as well.
But since the first ref failed with ENOTDIR we would eventually fail the who
fetch with STORE_REF_ERROR_DF_CONFLICT

In the new code, since we defer committing the transaction until all refs
have been processed, we would now detect that the second ref was bad and
rollback the transaction before we would even try start writing the update t
disk and thus we would not return STORE_REF_ERROR_DF_CONFLICT for this case.

I think this new behaviour is more correct, since if there was a problem
we would not even try to commit the transaction but need to highlight this
change in how/what errors are reported.
This change in what error is returned only occurs if there are multiple
refs that fail to update and only some, but not all, of them fail due to
ENOTDIR.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b41d7b7..5dbd0f0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -45,6 +45,7 @@ static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 static int shown_url;
+struct ref_transaction *transaction;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -373,27 +374,13 @@ static int s_update_ref(const char *action,
 			struct ref *ref,
 			int check_old)
 {
-	char msg[1024];
-	char *rla = getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *transaction;
-
 	if (dry_run)
 		return 0;
-	if (!rla)
-		rla = default_rla.buf;
-	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
-	errno = 0;
-	transaction = ref_transaction_begin();
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old) ||
-	    ref_transaction_commit(transaction, msg, NULL)) {
-		ref_transaction_rollback(transaction);
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	}
-	ref_transaction_free(transaction);
+	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
+			       ref->old_sha1, 0, check_old))
+		return STORE_REF_ERROR_OTHER;
+
 	return 0;
 }
 
@@ -565,6 +552,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		goto abort;
 	}
 
+	errno = 0;
+	transaction = ref_transaction_begin();
+	if (!transaction) {
+		rc = error(_("cannot start ref transaction\n"));
+		goto abort;
+	}
+
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, so
 	 * merged entries are written before not-for-merge. That lets readers
@@ -676,6 +670,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
+	if (ref_transaction_commit(transaction, "fetch_ref transaction", NULL))
+		rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
+		  STORE_REF_ERROR_OTHER;
+	ref_transaction_free(transaction);
 
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-- 
2.0.0.rc1.351.g4d2c8e4
