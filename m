From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 33/48] fast-import.c: use a ref transaction when dumping tags
Date: Mon, 16 Jun 2014 11:04:04 -0700
Message-ID: <1402941859-29354-34-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbJ2-0005sy-I6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbaFPSGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:06:52 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:50852 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1129936oac.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8G2KR4w1h9xEyzqA1mmIrktQn7mqjJObaUgeX1TdJp0=;
        b=fGrcCTLf/X7zuLzvflOxhMOvNgu/T4onpiYpN97ZcQ2453uTEH+V6e25vJUR/PjYZR
         sSHQe6NVh5T7dDzx1xtcO8Eg8vqTNleuICZSJIYqSxpbIS27iYw1sHAT5FFaWfvbOSeC
         CZdKr4Gg/VPkbiMsOyyhaTh4Fj5kU/jfkp+NjLHbd9x35l6ZIuF2uU7nrKpwFn6xcLBx
         DF4zHo1tP4HdBF1UM5LkCycYkr8EnTJZgFxmpeKnEU+HOe+GuUVH8IWRikkqJZxs6kMW
         5yrt/PTq5bvd2sQGOL+LcGBlVHRR4hlv6tVgHpyKGMSI4iLtNYISdb7f5EF4hWrKGWFg
         FJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8G2KR4w1h9xEyzqA1mmIrktQn7mqjJObaUgeX1TdJp0=;
        b=fedW35i5c/MVN+eKqr4+EPsDn0qIUgPx5l2RCer0aA5R9UYIuViUNUa7flK0RvCycR
         u0RUKgT7GyDcPMFasQcRjv9EAv6EZWkDQhbB+XsZlLaIUEBG95vCn6NHYp5Q0r8gTRvm
         XNEAxaRrDYi3QuGykJ5vuKMHh3FfyrYIupH/As02lXLWRlvaEy0PI93DOen3MhyslWnf
         Mtq4dHPxGOFcl76StkQWTq9GuP7ra1hqUYcBGvp9pBQwKIPWvAsM0IM8dPHkfCs0YuWB
         /UY9E1lpnFg8g0lrT14hxTqZ8Jq/Pva3nzDIev/wJ06Jlbj9/PUV5ynyqDBiCARzNReJ
         8BcA==
X-Gm-Message-State: ALoCoQlU+hX10Z5aCr1FJH6oZQHfRoXgztWDqXK8/xlFmTNE9/2/3BGO68+xVSqz8SoB7BZn7HGG
X-Received: by 10.182.66.166 with SMTP id g6mr160505obt.12.1402941863676;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si998238yhe.1.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 865DA31C8AA;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 65033E0D03; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251764>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0752f0a..42a607d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1730,15 +1730,32 @@ static void dump_tags(void)
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
2.0.0.282.g3799eda.dirty
