From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 25/41] fast-import.c: use a ref transaction when dumping tags
Date: Tue,  3 Jun 2014 14:37:43 -0700
Message-ID: <1401831479-3388-26-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSR-0007P1-OF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405AbaFCVlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:19 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:45225 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934270AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so1535477obc.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RblR0W0kp18OftwZnbd58f73GAVCGXCBCxY6dUxR7iE=;
        b=hGKr7qCoj4VtJh1NaY8ky3CgZvqYZdNG3wJp4PQa03fv9959Du4EqmoYZIdKp8r3Ef
         jLKWJZ2zt5FqHsH33N2Hu0A7ZZfMZgHyAmq14Az66VZezKPSHToaW2ntH5veDF9kfuJ6
         27HuHVLzceyc3PaD0kpRlTOBwz+omZP6dst0o90JFELPC6QBnCO7IjRTVQ6cXO84Q2ID
         MbOBcgMB/54uMeRdO74U+OXTBi8Ogf2U5AldfD1MrfEyaFlG8wYENo1ddnuszD6BUeXl
         RoutTU9QXR/engzRZ/9cbWkNN06gMu/93E3zkDIn8ypEcY+8e08UPyRytc0R/uFJYPKr
         rjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RblR0W0kp18OftwZnbd58f73GAVCGXCBCxY6dUxR7iE=;
        b=XfESCJ1Mjqh1ibEL9V2GKYqcPQBzAWkjpkAB87QmWr1yirQpmIG2OAeofBpEbJqeyB
         m09GCLzVSD3CYOvPC0qppADnnviiriOk/Vi0WdgJAyD0ufaj3U9/J0BrBJQPIGqJI0gr
         S7seD+ta8Gi2ZpHUIsyzd15k92bjwwtABCRfskq/G/y+VKnlqolnpkaLtCLPk5yW5KmQ
         50HwQLWBGUQZRFK2NbVhzYAH7dGEOf/DxpB03YGPUpdq55lhyKleDeTUrmVimti0lfZK
         qn3niB6qVS7S+XpLtN6pVOWBREbyRic3bAoNsrtQkbzfYour8EO1VzpCHjGmj1JwXINI
         Tl3Q==
X-Gm-Message-State: ALoCoQlrIlLQXza+7/az0rBZkZH9h0mZ6IecgMTjjT74uNaBatqMOMJzM3EhZ8fFqpVPQoE04b3z
X-Received: by 10.42.185.1 with SMTP id cm1mr17419127icb.10.1401831488095;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si28758yhp.6.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E85155A43C6;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4B1EE06DA; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250671>

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
2.0.0.567.g64a7adf
