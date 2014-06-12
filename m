From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 31/48] refs.c: change update_ref to use a transaction
Date: Thu, 12 Jun 2014 10:21:22 -0700
Message-ID: <1402593699-13983-32-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8ia-00087X-TT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933589AbaFLRXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:03 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:40795 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so142824vcb.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKy+izdi3Ukhu2HAFzG+nr15eKxJDqXWdtQbKpflb4Q=;
        b=P1BpPhONZpHCiAwB1knOWzXgyz6xPkSI0TZPDWEcnvRmsF/qObOlEJmB2WHrbXD1MZ
         5IuB23GggDIhFheezSESxBlDyj2teYQdT/5PTOy8Axo+e/EZNkgiclf1cmL28YEaCPRx
         d0WRI5J538jot7zA5u5E51KVwr7uzoNA/K4CxfSeJdIzFl7TTz3ifEKgKYFPMj/tl/QB
         1LHfZX4HK01/r1gb7Oswl77zcz1XeF/wuXlu10i7EVWnRss/in6rSfgy1Zd97ILspcUm
         NjtY3KLt1lYsBa8SRxm+1Q5FeBeZ0+YmPfgrbq0ZZ44piZD2akV1S/8WDXzB7BPiIDhn
         kPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKy+izdi3Ukhu2HAFzG+nr15eKxJDqXWdtQbKpflb4Q=;
        b=ZTcw/XZAo+Argr8OBvkmHhr3vS/wQ1xWyNLDT3jlnw4fmcYZRSbFVQBTA5rAFs9Byi
         F2PuEd6dHF1HApoX85vjGbZr21nX/MhuGxbZz5ZsfJcB7czRD4nZLePFyrQ3aA3bIpTw
         kzjVVjg0gN3jERduH+b4E/YB/wSbKz4bMk52ow6pqaaSmQ2BRMaJTwv1tzt+eMGbNm2H
         CwBYLDyLXfuUfT3Ww1ErDfFChDXMq+58PQkKut1uKAVjnHWHoiFDWolzvpLDSAIR1Z5w
         PEFvXEFqKjz7u8p6kzNnqdlA3kNGBe7MFnaBT6pviqx+zB+xczLD/4VlQ7Fuz45cfw9+
         nXtQ==
X-Gm-Message-State: ALoCoQleFYFX3oiNQI8ZxKN1xzbiOJ2I1i2bLmMalSrWjXiujAAW91rD8WJb6YHCSCy+QDLU9tGc
X-Received: by 10.58.76.1 with SMTP id g1mr789147vew.35.1402593704077;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si111888yhp.6.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E868A31C65C;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AC2D3E064C; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251444>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8523c39..30b5db1 100644
--- a/refs.c
+++ b/refs.c
@@ -3521,11 +3521,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if (!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_free(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.0.599.g83ced0e
