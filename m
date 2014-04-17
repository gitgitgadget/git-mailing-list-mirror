From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/11] refs.c: ref_transaction_delete to check for error and return status
Date: Thu, 17 Apr 2014 12:46:20 -0700
Message-ID: <1397763987-4453-5-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasGu-0003Te-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaDQTqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:46:50 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:34456 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaDQTqh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:37 -0400
Received: by mail-qc0-f202.google.com with SMTP id m20so126146qcx.3
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1kIQKzSrpi6jDx59oEjBknn5ARWnlGLgisW949XGbI=;
        b=HjUPMOv0fZ09X8olcka2RS56UvBzI3Zn04t9gWc+TOCrz0zqC/tQMrYIsVvtASqIkD
         lBe81zKLEkH/yCgEjk62XUV2wQPSNuAfr6WsF7XQzz83DexxN7Dnhfir495x1KGcRY6j
         y9MoucFkLUXbWu6UkdHu3bLyI7p9frvrn/TJ9jB5xKbtfdzxSNxrjYXSB2RV/K7sy4HD
         vS47qGrG/lkeRcgcqt5ze5TzzyW3VmhNFp/mjX/HnOPIcSFiIGJFMc7pWkm6U4DFSqpK
         gD+LD6M1VUNV6EnRrMUj2/RTcs1AHZqoTsMVfvQm/jgTl7WZuy+XXsdLt46jlcyztaYc
         ePSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y1kIQKzSrpi6jDx59oEjBknn5ARWnlGLgisW949XGbI=;
        b=fl6OF1KYlnDRUIS7E3VPLK5YlFFvk14r5xCXRy8JoZiW51xxpiK0DLBGinIZMONSVk
         IghjOA83TkLGRLEn1PDVifHuuLCiF/2yxcJzrBQy5czK2FR+7HBz/s7CMu72Cui2uBza
         SNBPbxUI73WXh9WYHBkp3OJ5dgCTb93lMt7g87sG1P3bGf3bBgrDBEmlvHkI7/sjjez8
         SN9srNhQjBhukWQhur6PL/leujSPoHWFjEx5F0KUCvnPWlTmYRbqobsI1RXc2EquoDzE
         X9egnopgbJzWLPj5tvfmtP5JLdxZBxSqNIq8izKC7msDTXlaiy3opR512jvlbYGlHyaU
         sBqg==
X-Gm-Message-State: ALoCoQnTrX9adAp+1FXQUMSsULUDfpmqoybAeBZdenGx3D/OuEZNy2ByUbl+jQjPgNgo7k4PWjRPP6xYPOOkJ6UGRVY3pvJP6ONmgktgY4Fh+vlBw9zi5gG8iCM1WPIUWxRc+s/O/V1+eN4mPdgJ2QClQkElrTBiVtgBP4f3V+OpaQLIXOJKHQgZFamdieEJCE+f5WFyd/tg
X-Received: by 10.58.141.200 with SMTP id rq8mr8457894veb.31.1397763996341;
        Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si3654325yhe.3.2014.04.17.12.46.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EF8655A4252;
	Thu, 17 Apr 2014 12:46:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B4400E0967; Thu, 17 Apr 2014 12:46:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246441>

Change ref_transaction_delete() to do basic error checking and return
status. Update all callers to check the return for ref_transaction_delete()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  8 ++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1b8a087..6ff8b86 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index c46249f..9cbcffa 100644
--- a/refs.c
+++ b/refs.c
@@ -3366,19 +3366,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		return error("have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 8799e15..7050da2 100644
--- a/refs.h
+++ b/refs.h
@@ -259,10 +259,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
1.9.1.513.gd486896
