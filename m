From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/11] refs.c: change ref_transaction_update() to do error checking and return status
Date: Thu, 17 Apr 2014 12:46:18 -0700
Message-ID: <1397763987-4453-3-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:46:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasGm-0003Jd-DC
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaDQTqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:46:43 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:33809 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaDQTqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:34 -0400
Received: by mail-ig0-f202.google.com with SMTP id uq10so85151igb.3
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jR6Kx1I3he8dELDhVz8wh/kTg8qiS0dHfir9Iz5vaEo=;
        b=A6PykXcMtNvpyOVy/OEe1EQxMQ20VmiL0KdC97/xC8BH71J8Z2YKC5o+wXmSNz3hm0
         TJIULYwsDYI5KZNDl9B7dg/ZNFZpW1XbxsiZF3XwI1A4jdFNulC3bSTtLwTEBtT+fQi1
         arKTEQy4+8qd2ZiRytWmTKb8hTDERRFSCr3HAOpXfzjNKYGB2pdRNU8lAvgPYSELi6wx
         C4cuC1x/HecVo/gZQoL5t2xD3zPeouEkimljV0/RuavW0oLmTa+maRhidtliM++gBQzH
         p6RPqV0TkG0+UA9eekbkt/kAyaIAOXef9GGJtrX93YY/7ZRYZ2Z1454T+L4ru5maXoYq
         ZdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jR6Kx1I3he8dELDhVz8wh/kTg8qiS0dHfir9Iz5vaEo=;
        b=fuEY0xPFaPGyIn8z6DMi1ZjmN7OHqYudqzQIKFa78WUm7vW1l8/TKpSJsHAh+zCfpS
         658I0rpT3lyhWrwEgGon9QgkrCtECp6Snnjb8z/LF5m+fR34exVGcd2yNEWTJ694TD1r
         YrOfpi929LkGfLrhUf7zUDbh+v184j4MGKzxGXS+xBVdh3qE1DDq2ZxaIVmZB8rs7e4i
         nppaS9x+ZhEAHtO47zqJmLIyj8RKBfAi2cGAG/tdOWleqG2GYgb7uk+TqZkqjowjtdnC
         VP27QU0D45YR13uCfnP5tayysU9BLk3WgdsNQzzPeN+a4pXbRf3VoZO8OJk3G9iUXOvD
         fF7g==
X-Gm-Message-State: ALoCoQkhv4NPl5gC+2mRtV0OQ8b5t3CcfAi9JPSovQjx0worptF4A24PFuTLNwdXTyXKXcb/cu3tzMJtoBMiH97P2amY1VUfZVdsDj7dPnGglkq5ISlKDhv5Nfordfq3KYsj4OQYfN9wQp6zEWmH8zh6OaZTpldl3E9In6LvpRsag/O15se9xMnboc8mLDF+3yYnDoXRLnwQ
X-Received: by 10.43.18.133 with SMTP id qg5mr5774048icb.13.1397763994469;
        Thu, 17 Apr 2014 12:46:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si3653224yhd.5.2014.04.17.12.46.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4CF1731C20C;
	Thu, 17 Apr 2014 12:46:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0D19BE0967; Thu, 17 Apr 2014 12:46:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246439>

Update ref_transaction_update() do some basic error checking and return
true on error. Update all callers to check ref_transaction_update() for error.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 11 +++++++----
 refs.c               |  9 +++++++--
 refs.h               | 10 +++++-----
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..12bfacc 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,10 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
+
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +288,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+			       update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 138ab70..da1761d 100644
--- a/refs.c
+++ b/refs.c
@@ -3327,19 +3327,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
+		return error("have_old is true but old_sha1 is NULL");
 
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
index 892c5b6..00e4f7b 100644
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
1.9.1.513.gd486896
