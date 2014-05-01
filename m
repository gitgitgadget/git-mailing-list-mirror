From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 08/42] refs.c: change ref_transaction_update() to do error checking and return status
Date: Thu,  1 May 2014 13:37:08 -0700
Message-ID: <1398976662-6962-9-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxmR-0003e7-VD
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbaEAUkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:25 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:36255 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaEAUhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:48 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so797849obb.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Ld6dkhwvj4alliN7kvRhqzNZY6BC04KKJyBXsYiiKk=;
        b=nkScGfxVwwVxNcnDTk7qnq4L0Fjo1iCcjQoM1VyuCtikSymSWwvmij5zVWnCLU4uay
         gxhL6e7/FTNa/PBjgzQ8y79B2+ddZp6mOIAGDz3CuwUZlUhJJUGGaWXLNJiy1UgIDAP7
         h6PnHpUmbXgj0hhfSO5D1FJGC3N2W6zEVfd1/ji/r8+eyK2PjatTbWR+181GvY4gj5Q3
         b03cNilBtJAiZkhY7DA0DNm7nITLEj/l745YwRSZPa1bgX4ZDZiP+v6V1aBVlRO2RnH/
         qhzdT581hREX3KEpElkXBG2UnjZ0/qHuLpyQHpgwdCYlReSZlQ2mp8BC1Vk1Ix6FMl+I
         ha8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Ld6dkhwvj4alliN7kvRhqzNZY6BC04KKJyBXsYiiKk=;
        b=TpdQu+f5RyOW+biV0u+nHIHYZ9ihPZR6icBiFI2VrZ7Kv5NVH9u26/QSpB8vsz3fVh
         45idje1ejsuzJQnb9grF0cuzo+nwDn624FAz8QvWZyAdcC48PJ2RCl+Pc7FFnDytTxGF
         fu0pQfNfE+ncQMKLK/8QXdQB/gcXpGxFYEq1+5Fx66oIvk0KSSpCklQHrvdaOCUPw30C
         Ee15Y1CcoN/1knctkA1zV9e6KT75HRz2JD5mrAG8ZGRCj4YR/ZHPsMxpyVs7Y596Z7db
         3LJFClHiIgB9QWTJ0HoLS70NOH/0FlyRM21Y/TVkIS45gA7Bt2GZS7b/djGrUoMjmCXh
         9g7w==
X-Gm-Message-State: ALoCoQkP5q3DdkvEU6nB3EM80KluNd97nhYInrZU2AEm3bpwq7uGjLMThJ27XYOh1X/zx9JHQZV9
X-Received: by 10.42.155.137 with SMTP id u9mr6104542icw.12.1398976668243;
        Thu, 01 May 2014 13:37:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538022yhe.3.2014.05.01.13.37.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0E70031C1CC;
	Thu,  1 May 2014 13:37:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C51EFE097F; Thu,  1 May 2014 13:37:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247872>

Update ref_transaction_update() do some basic error checking and return
true on error. Update all callers to check ref_transaction_update() for error.
There are currently no conditions in _update that will return error but there
will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 10 +++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2bef2a0..59c4d6b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("update %s: failed", refname);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 308e13e..1a903fb 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
+int ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index bc7715e..0364a3e 100644
--- a/refs.h
+++ b/refs.h
@@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
2.0.0.rc1.351.g4d2c8e4
