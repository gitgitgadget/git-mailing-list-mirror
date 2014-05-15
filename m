From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 24/44] fetch.c: use a single ref transaction for all ref updates
Date: Thu, 15 May 2014 16:15:21 -0700
Message-ID: <1400195741-22996-25-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tb-0006Yi-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbaEOXQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:59 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:44164 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so325120qcv.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DiQWuKx9EUeg03Qi29TuyyZL70aAeR6SBgdT5ExSAEE=;
        b=iKRZUyBO45wGCSkKJmJ4exf1c+2JAjsVREppNhLps9K84lmGuqE2J9oC99Cmqh1Z+B
         ILhETmtGrA6HCEv4mZ9pl2DGfVxu4xiJYyBV6k9TdkXccYa9nvaQJwfmbA9ucZYDuedo
         kvX2gQoXvkV4Zg4EO8GqUPF2SQ1jsNq1gr0cTnKV9vkq4PpYFDCE+iDzm1R3pL04U68k
         0ol8a+EByfmXOgjDYvtRM2mMZn+BGJGhlqVwidZWpI15+SrDSK+Hs19S63jKS6oJFYLj
         n/xbIwasSby7kRM3ZA6kE1K1owTuTyGt+YcN3BkIJzhkYtyARbYtT4tP4g+MUA227oGM
         Zs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DiQWuKx9EUeg03Qi29TuyyZL70aAeR6SBgdT5ExSAEE=;
        b=LsNCBgiQy17cgh9ndc+3yi9gEJd0LxfhKzdp9sR51/Q59i0FIXH5x79px0TruRM4mH
         jTn3VG4u6G+YIds/6pPnzTVRBAAX0zdCeSNRGkWddW0hO2j15xRJi9oiAgLmfa9jE+Qy
         Ie52YG7pEcoM1NFt9m3wA+4j9bvbIumRPEIgZ63DAq9KG9F8vonpJ7FiBbFaevQrSd8J
         nrGCNi57qQxIsaoftoYxTrPgHx+t/3O4apF6XikruoRC9TzVxRBcd+CTJTHWS4q/qDYk
         fRXzVLVin5WoIs2NyZp3eFFqxQQzb6joutfm0aGI5551GpFwQcgzNYvMQZRekSJUc34q
         mYdA==
X-Gm-Message-State: ALoCoQklI33OJG1PEI/KDT30lKivacIMgp/5TZmj+HrdsROse+RY4OlNuZGT8AcG6QqiibX2bLeS
X-Received: by 10.236.77.194 with SMTP id d42mr5591814yhe.21.1400195745563;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244838yhj.5.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 53F7B31C1CD;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 30523E115F; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249244>

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
index c9b5954..5b0cc31 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -45,6 +45,7 @@ static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 static int shown_url;
+static struct ref_transaction *transaction;
 
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
-				   ref->old_sha1, 0, check_old, NULL) ||
-	    ref_transaction_commit(transaction, msg, NULL)) {
-		ref_transaction_rollback(transaction);
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	}
-	ref_transaction_free(transaction);
+	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, NULL))
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
2.0.0.rc3.477.gffe78a2
