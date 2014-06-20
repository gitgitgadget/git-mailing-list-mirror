From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 21/48] refs.c: update ref_transaction_delete to check for error and return status
Date: Fri, 20 Jun 2014 07:43:02 -0700
Message-ID: <1403275409-28173-22-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05G-0003jx-6N
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbaFTOqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:14 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:35760 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so505980vcb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HOwN1paU7BOtttVaDB07VDCYmgkGCbI9FudvsoLeUus=;
        b=Qp05BmIboubK6/R8DE1mdLIBMnguyv8gcaQvJK09t/k0YQ7lJR7//RO7KHAB039IlE
         5w4NCk3KXTW2afB4AijL+zrF4QxOgPcV+vC2QS5XHpGGVzTd2HGLwi0pYXMbGWnFOEsX
         35MeaNYEkrFcNwrBwF0FXoh+fxOiqA2OXWwVatMFeZQIbv7cGrs5v4k1k80Jx6qvWwEs
         KhDEPcZrP7VSI2H9CzxEqe5tnseep6Da8XEi22NUz2fxe3iVcmPyZyNSLglPIX+FuTN6
         RwpVegmlHnrDDi+FbYe41Q9FCuSiX84+EfVZqdwJrlH5oqYC5exdbPLPbXcNrfLUt4e1
         sbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOwN1paU7BOtttVaDB07VDCYmgkGCbI9FudvsoLeUus=;
        b=Ush1Xn7NPyz2rPsOQ8mWlYOigrFsX3wmSgRwLGSsa7Wx9JLW4AYeH1QXhfDkzT0cTy
         Dsf/NdYCRZEHrJcqme4wRlsWAC6KBrJu8e3bncYgq99nGQoTH8vUnt6uNxkmbxT/gJLI
         wOmMSTNcJAUyzeurr/dxyY7gWglg9VblAw6Ys+EVO2gKe/n3NGyWonHx6majVVg0U5D5
         jusOyeNTEtK+9WJ4fAjVn6Fv83ggeOkHeJ4+U0BSaAtisNPS208bhuzka3rCGTVrXSiV
         cxCtVU5gFh8ttWA+2gz2gmB3lTwK6HUS/fjOq8M/l7s+Y3vWxlRJtGaA1gXdtUxth97e
         Ewew==
X-Gm-Message-State: ALoCoQkYzW6NG5eLq85ImBxxA1f39XeywJUeEcS7jn3/KXoPD5/V2tbqGcJtvfVXifIQvAS7FPti
X-Received: by 10.58.227.10 with SMTP id rw10mr1376560vec.39.1403275413008;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si432421yhh.5.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CEE695A40F4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AD030E0651; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252260>

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
2.0.0.420.g181e020.dirty
