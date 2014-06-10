From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 33/48] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 10 Jun 2014 15:29:21 -0700
Message-ID: <1402439376-25839-34-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZf-0005yY-L1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbaFJWbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:00 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:59435 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so206453iec.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+epwu/XF4B4Veo1e5Iq5emHXO1NsvhFnV+WmCJRwXwM=;
        b=CtipVcYe2O30wQ911i8j7hSZ4LXuPLqtrIpj/bbfdjskG8ZOOtVGnKZbSFMq+XuyM7
         27T/kZ/Z/QI4F+3hYxABSwmiZz4sPfbnNhLtXv5gmvme1elCLIKKqJLRbHRannl9t1Ft
         aJF5aOBT8H1Ue5mqK2pVnuBD0lJ+osdyTy0fqUAcN1JZSdgg2dSn3vi9jTYXiEI+gyP6
         yTt0yFkBELgtflQEO7Gd/PJd55HsZq71TpImItu6xd0iqvtH2jVwiymDgUbcCPQx2FtO
         zf3EkOav6K81t47dKEj5PRu8I/6k2HHkUDvRphqlIWR+GzcEVbMhHwmpiwh8UajmYcs4
         M+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+epwu/XF4B4Veo1e5Iq5emHXO1NsvhFnV+WmCJRwXwM=;
        b=JPSF0ggQyxMlIsMjPTRezA0Vvw/BrCn/C04JTI4gD+jIPCMQDw76OJW8MlnpY5kpzB
         6z4zEs0RV6PPe/z3965quZLqFVe5EBSBhj2mTqS0+MCKO84ytfcOmrimoTRn8UQqitP7
         pJP1v1LUbaIVHQ75vMV8Q7Rg6fjJ5eIzjLWEbTaMtW08p2k/ndGTK5o5tAVq6vab8iLB
         Yt5J7kk9nn7vUWQrRAKuLszGt+4aqBPg+Xu94HJvKN1pU+gQ8rMBk7WZrInwJ2kFYLX/
         OTC9hpXcNNZ5046iy/0/tzDejqxw1H2yoHjcZ1Qy/1CoFwSmQ1A+F/THUvegAYyKLCIn
         XZfA==
X-Gm-Message-State: ALoCoQkMCLIO8+/ZnFq/6KXzpWFxAOzEtB1lXM1bZ/G/MJ5+GVi37USXn55bXqgzrXnpbkTpgG7B
X-Received: by 10.43.66.6 with SMTP id xo6mr5010124icb.33.1402439381572;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1395394yhk.4.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 692595A47F3;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 45987E0AA8; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251306>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4a7b196..587ef4a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,32 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.574.g30c2c5e
