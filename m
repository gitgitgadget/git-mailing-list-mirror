From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 02/48] refs.c: ref_transaction_commit should not free the transaction
Date: Tue, 10 Jun 2014 15:28:50 -0700
Message-ID: <1402439376-25839-3-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaZ-0006or-76
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbaFJW3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:48860 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbaFJW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:40 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so603568pbb.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2X9ldrXEVDDb4RIHW4klP0IViyT7rfmKosDUwTqhIU=;
        b=hn9LdqOJY2ib5BuqXll9SS7vRNyxPOnbqr2sUzn1uoZ8oYJlDHMascv1ACYmRTblLO
         ZxTu7ARNSm6htDXw9c7RibrBtPda2qEavDfStEW1RPcxAwkySlX7VvC2CPV1r1WTdDB4
         O58hamsTKRA6h6RylHwTmr6VPZGFSftJ4HQ1z8AXhj2dhzL1Vm5d8u1sO+DyasOpWzwo
         JP8YoWPBM0MYrKA+Z51Nrs75JEB3VwqNmKg3gb3HL7hoVKXhbCRwY/CIa5JNOatE36lh
         L2V/Txcy/bOBT4crD5CHogU1LIyr5OoKS1e8sYnw4orXbOzCNW6bhIke38q4m+7TE6EF
         gyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2X9ldrXEVDDb4RIHW4klP0IViyT7rfmKosDUwTqhIU=;
        b=K2ayXCgvfy4F0njocgAocUfPZ/wwAnhuWaenXXcxqTzhwH/7ozx4yKOLVkb+Dm4XdR
         dX6AYnDZ+RppJ75a/8ip+0AubkJT5uQtgtc/AeFPPsYTUlEWf8+1W4tUh8gto32zD6+8
         DU1VR6l0w5YC/f2cl2vQnjpXW4pi6uwCW9v4qu8LHXkbY1rWKIxsvgUFib8VSFp8gqGN
         EWkYhBhngsChqiIcaW7vUrhg6IaGNc+T385NA2Wf6az8x01HfTXQMvtqO2TEh6atClk7
         Ivdc5bmfNCA+q+AWN2GF2eHNfY+UiCgCiR7CQ6QhM3HKYOoS+P+WVvnrqS6LHREWHSPX
         cWlQ==
X-Gm-Message-State: ALoCoQm9BVEBDNDhMc0d/ENHsUt9eZw5UNlQFy66x5yrLouNHWQagMHHZoqZrXFBn2HqM647Vvy1
X-Received: by 10.66.144.228 with SMTP id sp4mr465304pab.5.1402439380147;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1395556yhj.5.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E94F131C741;
	Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 93636E06A0; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251295>

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
index 48573e3..33541f4 100644
--- a/refs.c
+++ b/refs.c
@@ -3483,7 +3483,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index a07a5d0..306d833 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -265,7 +264,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.574.g30c2c5e
