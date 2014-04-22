From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/3] fetch.c: use a single ref transaction for all ref updates
Date: Tue, 22 Apr 2014 11:45:27 -0700
Message-ID: <1398192327-21302-4-git-send-email-sahlberg@google.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfi5-0000rq-06
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbaDVSpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:45:43 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:43939 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbaDVSpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:45:35 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so993048qac.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FB9Q/okRk6yrOicx6fPQpiNZ8uF4KpLRXPK96vJ4YgQ=;
        b=eiwfbzujzNR3lDGzmKNldghRY/zvcEcleBMXuRmfiJsN5lJ/UOwHAjJj+fvb9L+m7D
         VwESFZWhRAXa/Y/245KcxIebytPv2iSBDI7+JcbLGkpG5C7kaVBn8gfzWO4Amj+criyg
         tbvocpAIMHde1TxrQWtkh/mUlfokYzbLlrZYuIU7HImyZ9tsG+1DraJOvZn51pc8P/Pu
         lwES7fAqNnAnYvyxG1WqBY/4snGdE2cXnn4+D3WS30dN6tRqDedMm5kmS1KmBvPT+bHT
         CIXAZBWHtbDMROEz02gFvafo/HxGKMZGmyAOhCOJ34QGOx086TgEWtSw9qd8Qti3GXIL
         Ix3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FB9Q/okRk6yrOicx6fPQpiNZ8uF4KpLRXPK96vJ4YgQ=;
        b=ITaPocoY1hqFko+vr6Wt/gwjOPJPge/KAC02M+RA5k6lwWMIvdWGXfxuj/Y4H/zAm8
         +l8DipOKnLtpZ+NC7P2jQVbzLzdzh7bCihHEJMk8pLAIPhDMBdtp60TSAmq4pGKRYUSi
         NdkAjHFdXoSPFM8E2yINY5golCyLTvfNjB5YeFeP1d3cEoVzGfY9lP3VoLW7inMCeeJQ
         PeAkuEWaDUR2bsDCVGf+ku1tbX+Ne6EA5aTpi47foCAmQbyfNlDPTYAqABmPqUH8tjBj
         ICYbNMZLYYIFc5nBCsJGa1H0bdNTWO1pf+5IkE5ixFtf0VaSpNEexKM30ajdHOvuraLa
         sLpg==
X-Gm-Message-State: ALoCoQm7+9f0ehzz7L4oa1L2EY7ZKDE5SqsuiNRUlzcMdKiERHz8b2d4fnRiHDH2nw+zJwdGgDok9Y+oPRhR0ytCxOjgCYOqf4+8QD6XKNH0gFdEuYmg28d8F45DGHWIacih2pYmfPl21a1SnDLSBgtNJIA6XtEATxjh4pPE+rfWHof+DXOrj831D9QMTiEScbFHsGseD9nC
X-Received: by 10.224.95.9 with SMTP id b9mr21198573qan.2.1398192334300;
        Tue, 22 Apr 2014 11:45:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si5707394yhe.3.2014.04.22.11.45.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 11:45:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1476631C15E;
	Tue, 22 Apr 2014 11:45:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CCA65E0BB8; Tue, 22 Apr 2014 11:45:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.518.g16976cb.dirty
In-Reply-To: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246766>

Change store_updated_refs to use a single ref transaction for all refs that
are updated during the fetch. This makes the fetch more atomic when update
failures occur.

Since ref update failures will now no longer occur in the code path for
updating a single ref in s_update_ref, we no longer have as detailed error
message logging the exact reference and the ref log action as in the old code.
Instead since we fail the entire transaction we log a much more generic
message. But since we commit the transaction using MSG_ON_ERR we will log
an error containing the ref name if either locking of writing the ref would
so the regression in the log message is minor.

This will also change the order in which errors are checked for and logged
which may alter which error will be logged if there are multiple errors
occuring during a fetch.

For example, assuming we have a fetch for two refs that both would fail.
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

In the old code sicne we would update the refs one ref at a time we would
first fail the ENOTDIR and then fail the second update of HEAD as well.
But since the first ref failed with ENOTDIR we would eventually fail the whole
fetch with STORE_REF_ERROR_DF_CONFLICT

In the new code, since we defer committing the transaction until all refs
has been processed, we would now detect that the second ref was bad and
rollback the transaction before we would even try start writing the update to
disk and thus we would not return STORE_REF_ERROR_DF_CONFLICT for this case.

I think this new behaviour is more correct, since if there was a problem
we would not even try to commit the transaction but need to highlight this
change in how/what errors are reported.
This change in what error is returned only occurs if there are multiple
refs that fail to update and only some, but not all, of them fail due to
ENOTDIR.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5c15584..97c6b9a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -45,6 +45,7 @@ static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 static int shown_url;
+struct ref_transaction *transaction;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -373,24 +374,12 @@ static int s_update_ref(const char *action,
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
-	    ref_transaction_commit(transaction, msg, UPDATE_REFS_QUIET_ON_ERR))
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
+	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
+			       ref->old_sha1, 0, check_old))
+		return STORE_REF_ERROR_OTHER;
 
 	return 0;
 }
@@ -563,6 +552,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
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
@@ -674,6 +670,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
+	if (rc)
+		ref_transaction_rollback(transaction);
+	else {
+		if (ref_transaction_commit(transaction, "fetch_ref transaction",
+					   UPDATE_REFS_MSG_ON_ERR))
+			rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
+					  STORE_REF_ERROR_OTHER;
+	}
 
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-- 
1.9.1.518.g16976cb.dirty
