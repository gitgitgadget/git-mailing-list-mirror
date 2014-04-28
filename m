From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 03/27] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Mon, 28 Apr 2014 15:54:18 -0700
Message-ID: <1398725682-30782-4-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTc-0007iM-4x
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbaD1W4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:33 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:52542 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbaD1Wyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:47 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so80674pab.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aU++zaPgfvzaIcE4o2JcjfhBd3X96OQJbheZWpOf/Ks=;
        b=CEA1Evpwi+2Xqm5IhKmmaw8yi4fblrmBK84OCYqLp+jHdleX7eN1nnqX4F8u0CcvRf
         YC/WYnhnBfzdwkZGdEwJnXX9+ZOk/odK8oj44e5doLg/EO9PoRIS0LsJY8c4DtVE2rPG
         xhllLCYQDU9GYe+rKPPkmaYdw22VOx8DMJTZqK6eP3qf/oVYMXMUw2DuOhduI6HnETCK
         yWZ0pSicuu4Mu85YfxBIbbE9lqvU1tBm5PXDkmH/aOEVmarVanKoG3KEZx1Nnkf3L9AO
         Zcx3+Syp5NVK/ry1NzcsIv438Wo670aWLJgcYO+ldpE9LLFavV7gqSbnlSgP3oHZ6qr4
         pNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aU++zaPgfvzaIcE4o2JcjfhBd3X96OQJbheZWpOf/Ks=;
        b=aYaTjBGr3VlbRcXl4FMc7UhDx6q7dD32pNVdcEs1r3pkTl8j72T8CThcEEM2A+MJp6
         OqoH0oPeSOpjZ55kKhFOIDQrB6+g/AmT8ascm1661Dj/cu7G71LiWu46Qd8HMvPRz6zK
         SJeh0P6igkXHYcZMxNygkxnKmUmQd4R/M9MGNpUGq9evKGBaS1LBjACrIlFrW5G3rFw0
         Q/G9iaNGEKLTRZdvehqP03agOR2Em0M4h99VLHPBy3TNedqXjQPQVNLpt/RUid34MMr/
         JqDwMNMh9Q+hZcUKPDvQkGU0H5ebjilFa8XF93RgZk2yXvQENDHm/RdadvE8sGcbnDRk
         4CeQ==
X-Gm-Message-State: ALoCoQkxSODVyrnnWQSvYWU6NHZQa2BDta/uEHfThh/r1nfQzx4h+eX7brK7vJ0ohk0w+1Ob88GLRKhdTBXIVl2jJ2zdwKzpYB+YCyi3vH6n05rthOBsqoPCBUZo03SYRQwKMsBTo0kZoWlwWG8wE79iVFMkMCqVlmhINpfDeIxuSTUKvtly7B8CJ6Ah2J6ilHRIWe6GE4oy
X-Received: by 10.66.159.36 with SMTP id wz4mr12896592pab.14.1398725686559;
        Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si2350106yhd.5.2014.04.28.15.54.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 606B45A41EE;
	Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DDD51E080D; Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247487>

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
1.9.1.528.g98b8868.dirty
