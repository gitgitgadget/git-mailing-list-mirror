From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 22/27] fetch.c: use a single ref transaction for all ref updates
Date: Mon, 28 Apr 2014 15:54:37 -0700
Message-ID: <1398725682-30782-23-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSL-0006Ao-Nr
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbaD1WzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:19 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:48456 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbaD1Wyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:55 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so1612377obc.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+VjuYk5Vbk5KhjyiD9RbFPjMdjXWJU+1Euf33+0Yzq0=;
        b=NMGEM04XFTvho63RQa5+rMtn2+wa9eHz8/dY0a5tbFXDNB7gVqJ0NP7i6M8u+TJ6O+
         hQFhMHsiR+4vLKAKRVkuD2h1pKPcPfMoUZFnYt7+8NH+WtkEL5BkrRWl/Le43VB4gkuv
         OQ2LqgkubDX8BKV6dp7GWyhLsr9L5G4mUZs/Ci4Zm6nfO3tihgCI3e4EEOW/xQrnak1G
         BRmm+Mb652te/I9I13b1UpmHoq64RdU3DrlXlMZScEt1RgjU8yS1fDIcTUM1c44pHrQY
         OiIzWiBYg0XyXMhT7PtADHthSgAU+0cisPc0Bs7wLw9OvEFWFpGyKN0YOoOcfIfqqfKC
         1NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+VjuYk5Vbk5KhjyiD9RbFPjMdjXWJU+1Euf33+0Yzq0=;
        b=LfvUck8hshKdfpPJeFugqhevhFzWmfnq2Rh4jbzoNdeK5HcVsDegWrvA5XV+Ujo7ua
         Wync8f2MaNzFMnNpvGTZ2HvZ0Ykk2yiaD48gVa/l2GQ21T0fZ2Ip1MyU1OEBZQu5MHf1
         AElCnqJ+IPYbU1r52l4L0EBV/ekOCQY0UXR0PeBcRPXS8v03UVLhqeXXvD5k4IrFxCyT
         oe3L+1PD2ECJC6LkqgqOBMDVvocspcsHy747DOu1RgOtYIxWDjNyLM/HJr2FYeOtY2Dy
         6MFLfxvyipNTqfRRA3JsVVRgNKeuDodg1Cu7I67fc9cgga4grPavvsqr1wfltpVuZ3UO
         9mlA==
X-Gm-Message-State: ALoCoQlUuS3zkTQwv1bUdhm3nHV3DGB/695QUFgKzeTwewwNHOS8kvpMkYbRHb4OhDlBjV7kuaGBxkmpYt2ygRZ2rnEJ9QYPTW+ldiyQomKRYKBnkNFYokeTa7QtY5pJUW+Lr0QOn5eIZgmibJRNneqa3SJllkWysBsK2TQ+xR3/JqY9DxQPw+T2OOrGmMMhXxVth58ZzbA9
X-Received: by 10.43.163.199 with SMTP id mp7mr12512521icc.6.1398725695482;
        Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2351154yhe.3.2014.04.28.15.54.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3567D31C20B;
	Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B92C6E08C1; Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247471>

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
 builtin/fetch.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b41d7b7..8f974a2 100644
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
@@ -676,6 +670,11 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
+	if (ref_transaction_commit(transaction, "fetch_ref transaction",
+				   UPDATE_REFS_MSG_ON_ERR))
+		rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
+		  STORE_REF_ERROR_OTHER;
+	ref_transaction_free(transaction);
 
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-- 
1.9.1.528.g98b8868.dirty
