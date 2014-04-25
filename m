From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 03/19] refs.c: make ref_transaction_commit return an error string
Date: Fri, 25 Apr 2014 09:14:38 -0700
Message-ID: <1398442494-23438-4-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdio8-0000rj-3Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbaDYQQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:46 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:46272 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbaDYQPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:00 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so633289qab.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6hBjQ1w6d0qfvWHxCupcvJP0C1jbo3MglPGvMI3fHnY=;
        b=S/075FhVLZcXwBKQqINhO8a3QQr04BKyPkESeG3jR3wxytHSdUTjROs7084skv7Q5h
         o7gJ89JJpuvXTpuRF8+fljWXuFybtPZS89Ogj+7uB8eLPHsI8dWheP75J2K8zmbJvl8n
         qejqx+66VxM5NKHm2ui1t/bUNsXyFqtzRNnjAwRN55taVdvM/ZSCLUQNK7gGqZB7Ggr0
         BUuL1Ac/jaHw9dKTE5VkPHYSmkekXIYeBtatmU7MDi37Pq8X/BZxM33HqWeMS44ZyLMD
         OaOBumLxUwuOhtcqxfw6nNvOI4k8M80eZjoTEMCmQj1eZsgIysvC0GdDJ+d/W0zVu753
         nGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6hBjQ1w6d0qfvWHxCupcvJP0C1jbo3MglPGvMI3fHnY=;
        b=bWtNNNKWVOzKn15nAClxBZxPABz7sIeENFOAq/wCi3+QaV28wBrmbVZvMGPRy1YTgy
         3CPyApALrLBdDQDX/OkZGgLEIwV03KFKXLAil0wOfkIIDSkK+a2Y654qRsvOlUgWYiai
         FKqKULCEHL0aRLsS14KFSCm29h0g+NkW91Mnu8/icaFSWzwNR/njdOkCANgLzNaS3PxG
         uv35b5/8ve5oD7ODJLshrstT/FqEXUCJU03AZ5k1bYHhgSy9To0T3vxftqV2aY+ap/Ou
         zN2fs8UcZmPMD6QIvt7gX4lx7UsJISTlom9oLjnTrmC4rcT5I9WF3zic2P/7yzOmrLaK
         cnTA==
X-Gm-Message-State: ALoCoQmjU0/VuEEYeLT+kJ36xIC1gGRj/y6Az18RFUVgVGjSGMviydpmxvOv6A2UhGrK12N7kSM98lLyrg4ILYCtPAGp+lf1v1yRiLMveSFHJSExnfs5jTP5Se06UvN+nmd4/lO8tO4zN48LpWeUqAbhrJkrhAIeSex3dtZYXMOFB3fAcp0xh7Ins6L0rKFBygq/4CVjRkt+
X-Received: by 10.58.77.138 with SMTP id s10mr5396440vew.40.1398442499826;
        Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si617512yhj.2.2014.04.25.09.14.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A221831C028;
	Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4DED5E0855; Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247062>

Let ref_transaction_commit return an optional error string that describes
the transaction failure. Start by returning the same error as update_ref_lock
returns, modulo the initial error:/fatal: preamble.

This will make it easier for callers to craft better error messages when
a transaction call fails.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  2 +-
 refs.c               | 12 +++++++++++-
 refs.h               |  5 ++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

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
index 2d83ef6..0712912 100644
--- a/refs.c
+++ b/refs.c
@@ -3414,7 +3414,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, char **err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3424,6 +3425,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	if (!n)
 		return 0;
 
+	if (err)
+		*err = NULL;
+
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
 
@@ -3443,6 +3447,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err) {
+				const char *str = "Cannot lock the ref '%s'.";
+				*err = xmalloc(PATH_MAX + 24);
+				snprintf(*err, PATH_MAX + 24, str,
+					 update->refname);
+			}
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 892c5b6..615c73d 100644
--- a/refs.h
+++ b/refs.h
@@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.  The ref_transaction is freed by this function.
+ * If error is non-NULL it will return an error string that describes
+ * why a commit failed. This string must be free()ed by the caller.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, char **err,
+			   enum action_on_err onerr);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
1.9.1.521.g5dc89fa
