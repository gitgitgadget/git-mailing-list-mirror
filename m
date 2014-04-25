From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 09/19] refs.c: change ref_transaction_create to do error checking and return status
Date: Fri, 25 Apr 2014 09:14:44 -0700
Message-ID: <1398442494-23438-10-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdinr-0000OR-GC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbaDYQPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:08 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:55549 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaDYQPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:04 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so632907veb.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ACG4vnvF/yfkjmUBnXyxk8RcgK0is7AYbmOKZHt7Fw=;
        b=TgkJTg+7WQbFgXtaDhVtOQ2BBHSV8+ge3qOPTNq+M22HFkpaulYGSjr/VcJemvGG+/
         nUrqumazttIEHZCtksr7C3FzjtlFUaUikxViQtwAnMDZcpXw87PlVX5IdmE4vavNLL7n
         r9aHcmwUOXxNITuzmTw/TbBXMYP6yJwievNGMPcV0iiAlARL+mcjBl3DS3j6KXZq6faf
         Qmq3Aum03YyQ8Fa4mFl2gnkNfEvkwj+0mbmcue3RbedkNwCalVkqpyLHCkdSpMgum5Im
         J2MJ4SgivWDlRh/8hNjN90+Y+OyjQbu+QxFam/8VoToSAkYwwqPiurIxoBSiIRbnxZu1
         QwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ACG4vnvF/yfkjmUBnXyxk8RcgK0is7AYbmOKZHt7Fw=;
        b=Bx1eszxMHHouXV7KmNyFVW98okrM27mnEJDgtAwipYokQ0bGqSw8JV9Hr9S/fBmujS
         UMhAtmZtkP7h30b8KAViAdZRPkdfQsaYF/V0BfQAAXFUwhKSz4VC1JcM11BKTRy7wWhm
         3+GX6vUO2doJ8es087TiwZ+NCaaGNs1i/3LR4Q7MU3lep9WoxGCVqp2hqX3djndW/XVV
         3qgUm52ZbmiRgPVtohHhSdu56yqoCcNihG7mRnCgKJXlZVRwqTZXkPEcMc+fJquEspxW
         DHimEFGywSZfHLra95jY/GZNTJqAjPzlabA/xBrwhA452C9IGU43OYViVB3tnu2MRl6F
         3oBw==
X-Gm-Message-State: ALoCoQkKEKXxhZXb4QROdStDVZNzqrEKnnkPYsqM37R+wIh/eNj5sQJsfCf+edBmVGuu1BTVxRxlbe0mHwoK6vCKxOOdqHxo9zXbbmXE7oedWflr89UaGFdHPX+Y2yqf8bgVHXDYyKI8w3BUG8LmoCoZVbLwNqH73fU4qN2VMnvuJPAyaDXg+BPE8Ae8llKEJj7EAiZZ8dX8
X-Received: by 10.236.92.15 with SMTP id i15mr4355505yhf.8.1398442503538;
        Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si1049873yhb.6.2014.04.25.09.15.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 64D7F31C028;
	Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1BBA1E0855; Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247059>

Do basic error checking in ref_transaction_create() and make it return
status. Update all callers to check the result of ref_transaction_create()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               |  8 ++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 13d094d..5f7dfc1 100644
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
index 65cf407..762be85 100644
--- a/refs.c
+++ b/refs.c
@@ -3354,18 +3354,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
index 6a361d7..e984267 100644
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
1.9.1.521.g5dc89fa
