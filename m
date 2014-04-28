From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 09/27] refs.c: change ref_transaction_create to do error checking and return status
Date: Mon, 28 Apr 2014 15:54:24 -0700
Message-ID: <1398725682-30782-10-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuS3-0005nE-Dv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbaD1Wyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:54 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:61978 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbaD1Wyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:50 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so1130274qcz.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cO/1gQBH1F85c2ZA5b90ElaaJO8fNg1N4BLAvlcsySU=;
        b=IPakscOrIcIof15joyU2NO7ZlCKu6ix45LPsd8h+9cyHZZROp3LVfkcJrU0FVmV3ka
         76I1vNJtSzXTdTDHvglxItHtUimJ57/m2N3NWa+ofX7tc58QEUEjCmsRVP3vlmbUiIIE
         O+97KdRtO4+3EYitnrSSj8wk6wmV6NQNaTYOzNAT/C+yv0m7dJYJHP3zfd/ZqUVYGjVy
         WE1PGiwHtZNL0pLlGW790E5yRCcg+Lqw5SlzKdvYo4R9rfT+u1spQyi2Y2iTnUjioFxW
         PlK3g/bXcit7RuzwIfJDQ4LRF/LgSJKtH+f1ngoCj6RlegcSFgfBEjA8roMC7u49FtGJ
         55OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cO/1gQBH1F85c2ZA5b90ElaaJO8fNg1N4BLAvlcsySU=;
        b=blHMWClxwAl24mwkrYJxWZwRAIxRO7xR9l7nI3mEoNF7546vcvvWQVAMp0SkBtRhGy
         j94x9LDr74uAw/tvhvpcnHYlQB9arjHV+Kj6lqxZ9FhSkEJWu9p5xeJf4aKS0Il+aUQM
         bAkKrPOr35CuDl0126KysuuxWh3o7a5rqZmXl7IvoDuLvtZZqh/FWn7ofAIDaY4aXTFd
         1b8wKNEkAf9wGN2E1hZLapwx9BHa01qH4Xj2jBEhKG8m6zLYKyu4UBIhQ7xVxjXnH/Gm
         RNP4y7+OCPg7Zr9Q5hTNi4qjmd+IVUS5/Km9mmV5oKr2w4TEtOAzAP2Ms2HtHJjn9MGY
         lOVw==
X-Gm-Message-State: ALoCoQnY4ntN3D8GRPHXiy///zkRDHPzPKmUJgtLJ/eb0RNcsnaMFkZzOvgiGL7kt0rmsg81NbntKIXoht7/kY3ijZ2Vys85imzwpctmF6SSpF610J5elq6UQRGqqalc9c5VCV3hQiOZFgxW3gIEKJWaOQW6kI4gjZlrjC7KOFFbZVI/30p2RbSj1VofLRGQaVESqxsnJsFM
X-Received: by 10.224.167.8 with SMTP id o8mr14119562qay.0.1398725689264;
        Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si2350750yhk.4.2014.04.28.15.54.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1B59C31C20B;
	Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4F2AE08C1; Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247465>

Do basic error checking in ref_transaction_create() and make it return
status. Update all callers to check the result of ref_transaction_create()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               |  8 ++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 59c4d6b..3fab810 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags))
+		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 1a903fb..27db737 100644
--- a/refs.c
+++ b/refs.c
@@ -3353,18 +3353,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 0364a3e..01d773c 100644
--- a/refs.h
+++ b/refs.h
@@ -249,10 +249,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * null SHA-1.  It is verified that the reference does not exist
  * already.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
-- 
1.9.1.528.g98b8868.dirty
