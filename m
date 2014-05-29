From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 25/41] fast-import.c: use a ref transaction when dumping tags
Date: Thu, 29 May 2014 09:07:47 -0700
Message-ID: <1401379676-9307-6-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sU-0006h9-CY
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517AbaE2QIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:04 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:58072 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so37819ykp.5
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JRfgtT1VUFlAQqrgO7gQFH0b5v33QlkzXERwh66jGk=;
        b=mDocr/1f6at5XRli2fSnFNhEzBUxSTE/uZd20rG8Z4lzq/FAQLGi5QRTTgwByxf4F2
         YM1/ho460UASqlVZfRjsdIEuj6DJanybeM32KFritHYHHf+Xrg93WopJx6TP469CWgNy
         NDmB1GhOuSJSNMmWiL8/FgWewxAFS3LHSggthfTvUG5YxGHV5vYZRslO7GkcQSjyA6HY
         aG1JZXf1OCMtbSJIZiuga5B2FSliAk96AzF/bcIHpWdKQfr0lJa4vVfRc53xBBNUoaTY
         qfkYZe5SetWCbD0n3JKYwOmJv6a6T6ZCfJQ/Kp0JpgoI7Ky+/F6CV7Di2U4YhLGMRWEC
         ffEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3JRfgtT1VUFlAQqrgO7gQFH0b5v33QlkzXERwh66jGk=;
        b=Odsi7SRsThAy4vr9CqxyoXTYPuRmuAlZATc8wrJYbkSLH2mlC2WeAwkhBunatO64Br
         +RSmeS+XdWfhe0w6vuvM3/sAhyDcD5GLBHr2k6oldUL7rzSyxZmP9Kvef+C5E6fr7GBS
         GzRmkysc4Ai0piNdaIJX0DFbhOUuT94nQ06/ZYlocYMv2N5aVha6owsVZ4okTAp3LNvO
         wtlrs2foxpEG2dLv1EkM08m4w5H1Jsdy3sWEbU2kzeFefk3lM8WSDeUTJ1+kRbfFcFUG
         sII28cpnJ039YD3kAMJrwL625sC6pYBADtwZheueoDR+j9cukQIg835U0zxHJ6FJPE0t
         k4HQ==
X-Gm-Message-State: ALoCoQn0Rvq9NCJyrLBPo2gPbVdzuW69v0UySTQutFz0w2ZOlwnyxfh5IwxxO7jPZ12oJFS9oVu4
X-Received: by 10.224.90.2 with SMTP id g2mr3069920qam.1.1401379679400;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si81363yhk.4.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 39BAD31C3FB;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DEFE0E0D62; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250379>

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
2.0.0.rc3.474.g3833130
