From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 03/42] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Thu,  1 May 2014 13:37:03 -0700
Message-ID: <1398976662-6962-4-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxmp-00045k-2T
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaEAUkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:52 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:62856 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbaEAUhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:46 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so799575iec.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4DfS+ENFFhOqJE6jb5mt+QuQWQ27Oci1DNFUGT8sXZE=;
        b=I2fbO2DkEZTRy5LzgwfO1LKT873fqpUQ9ikfQkSbqLDJudSqP/C4IgQsNiufr6rV9S
         Ip03WgFN+QErRE36th11YevAw03mvYgm5rO7wM59SSs8h7lU7GKNkhknD5VQV/P+BrW9
         omi1lzLIWNvhPoCgwsrSpnuM1BKq9pPsxF4mcPRvXO3LJtlEm4yH0FgkLAGDW1K8INO6
         +O3LY72o0VFyDBFpDO00bIy8InBE/EBhSfl1CylRcyPWhcZlI7tVzwDLnYEzC400+myA
         7I+mGEM7Au5d8ohx3/n1Rla1nQtewINaTySt9B7qxfqeKmgEclYq1jbVvh2tFRMJS4Dp
         tkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4DfS+ENFFhOqJE6jb5mt+QuQWQ27Oci1DNFUGT8sXZE=;
        b=mkQ4BrJetEGG5B4POrxUkzdVetpiLKPlNfoDPFAMrKmW4aj5VRdI/kzzfhwtzO8FRJ
         fuVgMZbDsFhn2cvEQlT3xmrIyTbzj95k+Qke7BrPSuQ+CeZUHSNfk1ER8HbBq607QF1m
         41r+Sxs4427a1BmTewUp8ez7DI6hiB/2LPFQzZnvyF/AE769HncM29Kg9BTdbP9rWjfg
         rroCXi+/A37QoFovBgVo5OegsXSbzj2TK95wegrsMOV9Ig8ctnTAmZs4WldMWlJMqvZk
         Gm0+alzMnyQxNlLKmi/VGukCnAwnNxVNrJy4eI2S3/xRjIUzNubX41NtVhitfWLA0DFX
         Hx3A==
X-Gm-Message-State: ALoCoQmep0LX+n5t6s+CyDDPMqyEzO5DsCkyyzg/sLhz2ObkyxONFdWu+6lhrc5Tde1p+uY7HuDz
X-Received: by 10.42.123.66 with SMTP id q2mr5651715icr.16.1398976665801;
        Thu, 01 May 2014 13:37:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si3536823yhb.6.2014.05.01.13.37.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A1A1831C2C7;
	Thu,  1 May 2014 13:37:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 66836E097F; Thu,  1 May 2014 13:37:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247879>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 6 +++++-
 refs.h               | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..aaa06aa 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -367,7 +367,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg,
+		ret = ref_transaction_commit(transaction, msg, NULL,
 					     UPDATE_REFS_DIE_ON_ERR);
 		return ret;
 	}
diff --git a/refs.c b/refs.c
index 2d83ef6..64e8feb 100644
--- a/refs.c
+++ b/refs.c
@@ -3414,7 +3414,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3443,6 +3444,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err)
+				strbuf_addf(err ,"Cannot lock the ref '%s'.",
+					    update->refname);
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 892c5b6..ff87e14 100644
--- a/refs.h
+++ b/refs.h
@@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.  The ref_transaction is freed by this function.
+ * If err is non-NULL we will add an error string to it to explain why
+ * the transaction failed.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
2.0.0.rc1.351.g4d2c8e4
