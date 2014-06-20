From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 02/48] refs.c: ref_transaction_commit should not free the transaction
Date: Fri, 20 Jun 2014 07:42:43 -0700
Message-ID: <1403275409-28173-3-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02W-0000uF-4l
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbaFTOnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:51789 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbaFTOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:32 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so192229obb.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uutlcwBh8y7XMw4C80eYZ5Hd1WF8qLQdfdaPs+jrSxI=;
        b=PggBcQtq6jXJMMWf2o6yxL0PD0JrLcnzNfddW1huv19gHeDRe2Gn3vmzM8xCiQwXqA
         72V6bYxCGHQks0g1662AsqZ+Uc4S5bscItW7XJrtecLm9nWZHa98l+G7Ao2RsuKO8mvS
         vCucErhBJdruetrywHYz1SyvWAs8zsrRibCC7x4Pwau0BDPvEwHFKf8es89qVcXdOpSp
         8TNapKQ2WnG7lYeB7UM0xNOfNqAnMTpWghpfWZofr0LtJmVe+g9XVblOjamgjcCP3FUM
         rtvpGZffKcmCkZtqakB2gnh5b9vRJEs2nsSlonrDMZmxj5uNiaG1TfZrSdtJZNvZdMcz
         nGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uutlcwBh8y7XMw4C80eYZ5Hd1WF8qLQdfdaPs+jrSxI=;
        b=G9hF1JZ/agydZ71BkxxF1mu0r/LyeQuETx1zySZAGE2LaewhQeLh3KIkKZ7C8W2FVt
         BB+FLg2t7irFZES+kjRAVe0mQIOMhYNpxD/E+kR/Q/tad/upYsnEhMS3C5PFJSOKiFkQ
         bsmDj3/xsRJCBdnNelOsxI0SARrbjRDLqeOBOxkCvKFM4jHbIWEGOC5uzhgqAPBouD00
         0MBhzpJQih2gELeMzl8E5rXkcskyxpFbjZyxIse8wlmawj/ZTBergAUqxx7AMZbQez/m
         j7KOa2NL/FMbNu3fzV7C7w7lo4dtoT+IpCVjWvtNLZlq7JBr8D+u2fsyZkY86TK2PUA/
         cSZg==
X-Gm-Message-State: ALoCoQndGGOZbR8HeXf3a39mev4OYyOA3xSW546P+DjbDp6tS8BltHDYP7urmyzcwK0tEqulVgkV
X-Received: by 10.43.103.136 with SMTP id di8mr1285591icc.14.1403275411981;
        Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si665228yhi.1.2014.06.20.07.43.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C792731C6B4;
	Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 72F83E0651; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252227>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 1 +
 refs.c               | 1 -
 refs.h               | 5 ++---
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..1fd7a89 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -369,6 +369,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = ref_transaction_commit(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
+		ref_transaction_free(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 6d841a0..d9cac6d 100644
--- a/refs.c
+++ b/refs.c
@@ -3509,7 +3509,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index cfd1832..7d946f6 100644
--- a/refs.h
+++ b/refs.h
@@ -219,8 +219,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -268,7 +267,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.420.g181e020.dirty
