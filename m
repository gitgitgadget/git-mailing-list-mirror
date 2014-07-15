From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/20] refs.c: change update_ref to use a transaction
Date: Tue, 15 Jul 2014 16:34:09 -0700
Message-ID: <1405467258-24102-12-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFo-0003aH-22
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbaGOXfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:12 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:54224 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934315AbaGOXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:24 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so40113pde.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Ss3eGQHm+dflZQA5VgOXusZ7Uov5yK7kpD58Yz8wJ0=;
        b=e2wtbViR/eyWTNkvnbRIlBEJ/I1gPSo++3crLEeqHYO0zawkr07DM6wpXyw/MZJNZe
         CsM5X8bhi1SIijbElPr/pxGOggQsKhk4Sjm9UXbAIDZjdRO0t7Hkai3TR4uupmKaaX6L
         2/sRE+cuN/0wUMQazK5nHFES8OBACMPK1HQt6H8raQszfM8b2fxPXVmToz08E5wiiiJu
         1n00jVxrx8jqKMaroUw5hUNW5SEdKZZVZB44fipW0g3YWg3ikyi2h6d0oTYDoecP2UUq
         KxV97J2GWgupXD5faIcZdkC2VbFqHySlhuZ1Ugkuii6agubxAcANTXr/tJRLw3ViigJx
         2v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Ss3eGQHm+dflZQA5VgOXusZ7Uov5yK7kpD58Yz8wJ0=;
        b=PHi6sQIgJnLXmdcAWfhKbaKuTXPBsuiF5Pq0YwbmZtw6QEcEekZAWJvts1S4ZSU8vm
         /M/9+Srjj4MVE80+miHr3J3Qf5RLDd8cVslZaMVdkCaQcufyXRJvdREwVvHzmGmR+Z4n
         FOm6z6gmclq3hZNKZXQkrPCFVbQpGNhfojCd+9tsyV1B/ej2ZuJLX4JT3th29oniD350
         wy3PK4kj3Xw1YFS94xi/QcGuBpuAYpkzkwvHcQQxTOHUw4RlLCCAnrQhpqlCvKoSP9i+
         tY31GP5Tz6EVR3OkwhYZ1l3L9SSoeolKb4sLieV48pPRoN7qTKhUi5u4mGwx/uSyD5Av
         6DJA==
X-Gm-Message-State: ALoCoQlCY7hjkTle/KKkwu3ejqKK/PGzlZCC8Wd2HP2yvHEQ6h7hbKkT5lqFaH60gWaudva/8A6o
X-Received: by 10.66.182.170 with SMTP id ef10mr12977828pac.0.1405467264389;
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1060588yhb.3.2014.07.15.16.34.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 37E6D31C2D7;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ED5A0E0C77; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253636>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index d015285..ff4e799 100644
--- a/refs.c
+++ b/refs.c
@@ -3523,11 +3523,31 @@ int update_ref(const char *action, const char *refname,
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
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.1.442.g7fe6834.dirty
