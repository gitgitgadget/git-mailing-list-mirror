From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 02/19] refs.c: ref_transaction_commit should not free the transaction
Date: Mon, 14 Jul 2014 13:58:44 -0700
Message-ID: <1405371541-32121-3-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLC-0002qo-B6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbaGNU7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:09 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:46787 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbaGNU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:06 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so374568pab.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3U9wPwgYB4LYgaN/IYebvj/Br5NpFD6hHAV9FL6RyAI=;
        b=c1l7MGZQ9LnSkBNBNMAzWsyOdjiksVy2FVXJZGsanOzEhPQR5iYHAitGBGSlyqFs2l
         EQRxBYJ01bpH6de90dR/InlJ6qx+YyeYnqttnsK6NxdmMotg2280IrOXPP8oCIHtj4E1
         f2OQz5rx/CWImHT5wh2ODifdcYUs6qClEHMMkp83kderqRPpYhMJL17bQy1sK2tCcfyj
         aEllYykX0yI7X6WXSIY1oQ81B/n9kR3oIjeSTB4xlvWYt2UAjJN5HgljqmlZflxA1jVf
         Xmr+Imykn4ZSdOBJ00YpaBTd3WMwR6SK2FYGdA4jrn/joJPNRMTkh7vIMuXhF50PoP4J
         TtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3U9wPwgYB4LYgaN/IYebvj/Br5NpFD6hHAV9FL6RyAI=;
        b=SVA2Q/JGadFZil1rJMp8kCigbLfLQppJ1cPwWy/mr4KELqQJGrfw8Ys+e7NDmYPKsa
         kJnvyR6BtqmCSYoywpiOFqEEtFO5qokcLWeAy5QQS4BwDSWd871POS3W6VsJCLy/EGkH
         9/ptKiLJsBQErho/LzHxftF9LIOmOMfUU6W47IDr8yjZY6B/xxAsyhiKthahPt4zQX+Q
         vLOdY6dme7wLRrBwAb5ZHpHJqP1l3biM4mfPHRhc0ayQcO9V0mdPxLxqRifhaqngTXX8
         9b1ebPz0bFQSQj/WW+uHKKJBIR2AudS3b/YZd+FWS4hX+cub8pJEraouWNEJXIn0Tu9r
         F7UA==
X-Gm-Message-State: ALoCoQnKx79+H0JRKDIMadr69IfNAuCFNnJ76ubr5nKCxggcuyuAQn1DQOl7ieCGVydnyQOsL7nf
X-Received: by 10.70.24.163 with SMTP id v3mr2663144pdf.8.1405371545441;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si822281yhe.2.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 454CD5A4309;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E6A9BE0328; Mon, 14 Jul 2014 13:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253515>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
2.0.1.546.gf603308
