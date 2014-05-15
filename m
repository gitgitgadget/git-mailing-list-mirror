From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 24/44] fetch.c: use a single ref transaction for all ref updates
Date: Thu, 15 May 2014 10:29:39 -0700
Message-ID: <1400174999-26786-25-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUX-0007eU-TN
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbaEORab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:31 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:48597 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so288868obc.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1GEQqdarU4/j6jm6kDlPhkdJn1Om+r//0bteX+5G60s=;
        b=NuyHO9z59+l2bdQX1xqk3upUK5n4mUgif+Q29gC2Us1Uxn2Q2xATiT+8kNAog5qN+C
         to2xXtJWH8exj983Dj2QqL8Gc39ivI/TAZ1+fpdmAL+SrvreULumMEfQXlkwVCYmxbtU
         C2H0NnS3iobmC1wcjMS6Xha5YuLFMOtQKetUVIO1yrsK2XP1XNZfG6HmBZIR2OMY5Qnd
         mXLh8wNzP+Ba4nGd3ey60BWoC0JLRiTrN2vfAfbDDqmHUOb8qz2/Lc4B4+LCUOxYhe4e
         +yews+Ln/508Vlht0szrdjliC5crOASWM1xT9eL8EShOxJB5fWMY06No2xQbO5teE7Cy
         RZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1GEQqdarU4/j6jm6kDlPhkdJn1Om+r//0bteX+5G60s=;
        b=Y3SiYp+HYLG2FQFH92T9lJJ8MW2otROBnCI9+8PMhcgjpOwf1NnZDyKFVvWVJGtOwZ
         H9Tv8qY5u77Zmfg86Epng+b+72Q4Z/6k0K7fQOz2hiDbhR+SdPxfiW71Ycu75fXJDbtG
         7nAS6OxQo3kEw4CMYop/Cjyyu+DlNHkuCNPOQ3OE3LMg3KtP2fQq8npGjxlL0q7OAeRl
         iKYeRcMDWkZyiD3nMt9TSQLCaHJ0hENuOj4pavajmcSkIipn1yqwLAJo+j682HJRbrvY
         19FGaso3n+AWNna5GsNwmNkiBWn09qGBukaD0K8sD0W899uE0eNyZZIggqdcGLis3uQb
         TBXw==
X-Gm-Message-State: ALoCoQmhK261+zs0E+n9OcBQELFTyrqYbz+dE281PwzoFhJCbdE9QHdQubdC3Y5ZfTbYRiGC+8R+
X-Received: by 10.182.28.136 with SMTP id b8mr5535059obh.19.1400175006784;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274178yhj.0.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 87FF55A428A;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 68133E11CC; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249129>

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
2.0.0.rc3.477.g0f8edf7
