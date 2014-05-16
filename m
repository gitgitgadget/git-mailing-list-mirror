From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 12/44] refs.c: ref_transaction_delete to check for error and return status
Date: Fri, 16 May 2014 10:37:00 -0700
Message-ID: <1400261852-31303-13-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM75-0003XW-V5
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbaEPRjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:47 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:49224 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so586211obc.3
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PA7e/+YwcJ9d446Y8Ly0XvZP8hbVMdxcVOrLxstqQJw=;
        b=PgaaqL2Jid84et4KHihlG1hxrGCdejA1mw+vBBkMvLsKm6HsZ4rhtKQStdGmwrsG/P
         bFUW1NLkGpOKem4RritcWo3X/YcMckyd4C+GKG+//AMYPsYpSgf9v7eRdY6m1MJMfyZa
         fM2iIKHJ/Qprc3nrNb51eNgrRQLeaqhnxRPQAzWu6GJEslaSIaodq8pgKTD3DMOWH7tk
         gaMdp1LUWIXHsjhPN+8D6l2Lxz1YpliR/D1+pZQtE6mos0qrjzv57ce0u+f1Bto3rSYu
         xRTPE6HGQY1D/O77WGQLWeH/YvS9h8lVgvFw/+y5qjd888xrutFiO7/5KA6ukIz8Lbvf
         GSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PA7e/+YwcJ9d446Y8Ly0XvZP8hbVMdxcVOrLxstqQJw=;
        b=LOH8/RjtS2ZcD+TsdCbeu0Z2puUyy/IqSKs8XaEcDIj/kMnZIU0W+xHOxSNWIUeHlG
         vG06KdiK1YCUH2yNW7URYOmLP5TZuvWmJqbcQq97aqy8M5VEGKYf1mRgoNUZ6kue8KCv
         8Cq8vqSPQC8asc7fTYoJ1XSn62PO72ENPX2vrB73AugIMWlvoG6bRw7cBgTMhbh+OoX2
         dkN4vh99ymplhdEJ2+cfjPvzc/x6WrvHzFwNkmYt2mg9lg4pWVlnDfbhAdaFApxB2DMp
         jgtKgivWoZfN4az2bDpnZhZtRQy3HogZf6J0BvwRs1ZeteWHk83y75NZbxPK5D6pI8+Z
         8s8A==
X-Gm-Message-State: ALoCoQm3rny/Fzw6wsoL4168u5LwwOn8Zap2hu/cwrjBTTIH6VtowUDcCyrH45AnFAecGsVXeyXS
X-Received: by 10.182.28.102 with SMTP id a6mr7518135obh.44.1400261857211;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si442302yhk.4.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 07AC231C2A4;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1F5CE0F5D; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249397>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 16 +++++++++++-----
 refs.h               | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e9c216e..cdb71a8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old, NULL))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 06a4fed..a588194 100644
--- a/refs.c
+++ b/refs.c
@@ -3417,19 +3417,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index bcae348..9b978da 100644
--- a/refs.h
+++ b/refs.h
@@ -265,11 +265,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
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
2.0.0.rc3.510.g20c254b
