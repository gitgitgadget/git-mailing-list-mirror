From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 21/48] refs.c: update ref_transaction_delete to check for error and return status
Date: Thu, 19 Jun 2014 08:53:03 -0700
Message-ID: <1403193210-6028-22-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxegt-0000Hk-8d
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707AbaFSPzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:49 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:46091 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so693195ieb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1pAGH6twvWm2p8QI2GlCW3GvOSL3DUg6yLP2zHwkk14=;
        b=ElAvxubLNrtxYHh8jHiIvHYf2U3fg5gNqL5ehLY3WQerg2+80YenL0eXKKw4fPau5V
         +BvIbtCukeBvZ7w1bVnuOaDtFEPA2uiD4FHiOiEUewWUcKuTDGW+A9ATpwV1qny+Fzco
         5edgg38pxtrplM/GraV5ucHiXWB7A2Q+XnxS2peBK97c/wvUvKg/QYYesAs4fODx40MV
         4wH0DQeM1ODDlILQPQclCpHgClCllESsFSU9T8op3s53dTJJjdhOe8CRC6UDBoOLaD1c
         XAS4jzaYR6R+9I3Am012AkoHsdpjqx7z0uGTfyNYkFGKXmwXe/LlxWSGwBwBcuOAJ9Ro
         LhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1pAGH6twvWm2p8QI2GlCW3GvOSL3DUg6yLP2zHwkk14=;
        b=aFTjEhj82DXaUqhWPbz2zH05OTIG0puzwJYVeS9YNOIxi3R8k9BNGDN6S2IgOs06FR
         rBa+gEbhet8Ty+vNcLSH1evghCz1fcoioo2/70D4dnWcwZd+m7uyx776oPPv9qlP2z8Y
         hKFHA+69uRDFqf/gyiO6CXTWSG2b4n7aBwmnigbSRaJEjYza6MnAWU29YiNFlqG73U3R
         a11fVXmZ5PzqBRFWZbufWVIqzvQa/UygfkN7PaHl+THloWLSnsSOCW2IoFYhyhtN30b9
         enjQYBs7UXMmgmDvvMHOie25AdYzIvfczzHrTQ+3B/yUaN/N0JLqJZyEITIafKSe7sR+
         eqgA==
X-Gm-Message-State: ALoCoQksjG39UAfKkIKfFun0rp7K26imgXbC6amy3XVmJwU4CL2PKMGho9b5kBNCwywD0F2hZXwy
X-Received: by 10.182.68.16 with SMTP id r16mr2633700obt.26.1403193213535;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si420405yhi.1.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6263331C2E6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3EAACE0AF7; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252149>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 16 +++++++++++-----
 refs.h               | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 41121fa..7c9c248 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index c49f1c6..40f04f4 100644
--- a/refs.c
+++ b/refs.c
@@ -3469,19 +3469,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
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
index 33b4383..eeababd 100644
--- a/refs.h
+++ b/refs.h
@@ -315,11 +315,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.438.g337c581
