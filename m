From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 02/41] refs.c: ref_transaction_commit should not free the transaction
Date: Tue,  3 Jun 2014 14:37:20 -0700
Message-ID: <1401831479-3388-3-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPP-0005MX-8M
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934119AbaFCViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:46755 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbaFCViH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:07 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so1536714oag.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p38JjYdICcRasJFKqYeDcheRbgW6zpzZv3Mg4bDIKcA=;
        b=SUhdRoV3tTIHgaT01iKbkRdrWo/CKmEBkLWvIZ5LnaeyCfmCAL0hP8nbgmEI0eMnUQ
         1ZZzuEX6sZIT8wOCD8YKRiWcd4k82vRxGo4VgICweFtK4+uO27Kt/K/6+q5x9DdutGZ1
         1ddpWC7K61uNAtlZe2xudtFgsXlQLkY8p1lUeg0pP2RfS4J0802IKquh6dJ7+spp9SIp
         2QRnm2MvrciWXKZoryDTLWVeVTyvjSLrQ0XlAI2/06YHrVNP7sUhN+xvYC605s4p7jAf
         vH0t9kWQblmsOh69EkPlLVFzz7tyvkJeXfE46QHNxixVsdatCKjEtrTWEY00GLRUJ949
         J43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p38JjYdICcRasJFKqYeDcheRbgW6zpzZv3Mg4bDIKcA=;
        b=QgGOQ0m2kt6RX0lFkM+DhsSHJMr8SWtYx3U0pBtebyNWpgmZqNhdBliNKURHgk8K71
         79ePpOIcg6d7v8+GzZ8nkxN1ErOC/MGrS2AlL7NlwOev5ZGkJqzbvaURzwuiNkIob3+V
         CVrXkbBdVmcqCWUUNUPaGDnRLFF5DIK289zDZhxOmavoyqij08921MbJLa7GrGa7+yqR
         pzFzvA9yw3owRORg9pbpOp3A6nsdfQDt0v7euM9eghhEoLgASW2CfhD5QSTrnk7LYanj
         waPEj63S25NRxA1xPjOcmAg9kqpdxaQRyIh2UmPIRJjUos/x8MZA39ahAiHWSVyJiRI4
         n9IQ==
X-Gm-Message-State: ALoCoQkVJRGt/elYFw+/4TaWzRJyczzxcU5bMmaEQHjkT3hvKaPz+PMMsYUm54Zo1ptGF7f/6oTd
X-Received: by 10.50.6.45 with SMTP id x13mr10817459igx.4.1401831486788;
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si30036yhb.3.2014.06.03.14.38.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9DE485A43C6;
	Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4C9D5E00FA; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250648>

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
2.0.0.567.g64a7adf
