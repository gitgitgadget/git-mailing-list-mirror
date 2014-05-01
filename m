From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 10/42] refs.c: ref_transaction_delete to check for error and return status
Date: Thu,  1 May 2014 13:37:10 -0700
Message-ID: <1398976662-6962-11-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxls-0002wG-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbaEAUhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:37:52 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:44754 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbaEAUht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:49 -0400
Received: by mail-ve0-f202.google.com with SMTP id sa20so429879veb.3
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=figqEXuIPMoGsN/f246S3tsBVYxGtpLYM99dju2WVZI=;
        b=fn+K2gjeK7b+ovdieyToeDcOjqhzHaXjLuCooKO/IgIyFu6TYbq70+61CdDFloAiIu
         C7zosL79KcKbht3sj2VUmBeixAB8hA0HdDLgELfHGkouWMcyDkFmFoE4gYtvYNnd/s0r
         d57PX9rZ4hwZLZ8cy1UlRFS+DdnCEOnMvZ9KxKG10fEcQqD2jjHOuDvqWAhDSkyjNDzR
         1vyUWmFrO65EyR7VSRUFe5KXKrDcKMF77LCl44eBB1kmYQ0Vsfa+1mCRlDnR9LQ5KQX5
         AYe8XSyqxTlMunG0e4DFsSVbtDdQXkTBV+YYUc0+QfIHHLPcy1lO606VNF3S01a83CRy
         i4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=figqEXuIPMoGsN/f246S3tsBVYxGtpLYM99dju2WVZI=;
        b=iMQcfJtKF8LYERybPqWbuk0bLEHw+thkGiscPOetMlKcql8PGLVvO62JD8CvYLM2E6
         ka2bnGHOxzTOsvqabgUIo0h78Cvox00eywIRdMOOT+m14PDjwOs9QvKLvQYlm6ZXOl3F
         O8kjGpL3/aPUx7S9kMgHWZ5S71dNAz/b8LfHIIErnkRRrnckLacLdxp3T8zyUYPDjmo2
         ks8wL9eIIT9hGB/9PKMiYDuhW5x2sSURw+xAFdSpMixETlSaDYQHiBPnOzp+7unTFg1Y
         L3LDqJdEoKBnuias30ZtAz03tLV2IU6CBKzWDbYvoLeqhixE+Y84ccZfznnWaaJlx3TL
         vSjg==
X-Gm-Message-State: ALoCoQkb4uGYvzC3Yxm9bnP1h6Z5Sg0BoxqXg4AtI2LddPcKeaKNLpqc+k9EKqzSv6k5VC4/GHHj
X-Received: by 10.52.61.197 with SMTP id s5mr5913809vdr.8.1398976669087;
        Thu, 01 May 2014 13:37:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si2198326yhh.0.2014.05.01.13.37.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EA3F931C1CC;
	Thu,  1 May 2014 13:37:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF78AE097F; Thu,  1 May 2014 13:37:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247863>

Change ref_transaction_delete() to do basic error checking and return
status. Update all callers to check the return for ref_transaction_delete()
There are currently no conditions in _delete that will return error but there
will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  8 ++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3fab810..fc3512f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,8 +257,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
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
index 27db737..0a4e28e 100644
--- a/refs.c
+++ b/refs.c
@@ -3372,19 +3372,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
+		die("have_old is true but old_sha1 is NULL");
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
index 01d773c..5eb500e 100644
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
2.0.0.rc1.351.g4d2c8e4
