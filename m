From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/20] refs.c: update ref_transaction_delete to check for error and return status
Date: Tue, 15 Jul 2014 16:34:00 -0700
Message-ID: <1405467258-24102-3-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CEy-0003Ia-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934331AbaGOXe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:26 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:62528 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934032AbaGOXeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:23 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so40010pab.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Sa5M+LPdG3H5CTqeFtlZANyEy3D7IMcsncit9D8cdE=;
        b=SOIDpuw3RpER9mqhfPzNREQJiV8sXeiSGQLa4O2+xf3Ly/Wz4qa5xVKLeUwh1D67pC
         qD6VmX9dlHFt7FTGOMzgOFL1ND35uM65b+P5A3iSy6gsGEB5/shqhRh6rVX0T5n+onva
         jgrs9+b3NVCnqEXKszYcW5lkHGAnXoT4qezw1KfufKc4n0KZfvSBAlc81JkanExN/XIE
         8TIcYK8puDBIkp16vgWbXrcmWANz48zCfiP2HogmjJhA5ommuTSc1t8AxhufnLV0fs/Q
         ryT+a3PND0l8j1sG7mUUXhweJY9mhNy9xPhq3kn3DKo91ozIbjUChwO+I9fAwzfSgJuN
         P5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Sa5M+LPdG3H5CTqeFtlZANyEy3D7IMcsncit9D8cdE=;
        b=WaPogK9LYMk7ncLAwG6PnSykPxgjueHPcIBW96cjnUlXT9OttQYIWkHsHk87lbRXT0
         26TIL8vEmC/ZM3CEXRG7cr3D+FbUjerNL0+Z392N88mC1+GSgDldam9Wv0iW9dhjr9aR
         2QKYyzjI0zYsSvazm6eLSe7tGOfiyMaY6GFBiCZiRrN2t77Kgy1qtJo397rlMMCg38I2
         PGNmwXNNCNOT4F7qUCEvI4zewkGbww2ZExlIJ7uskorkYEQ1FX1GrRckC0xPo+acDrnn
         aBb/sY+NG0sifFkkZdmSQUSOJioyhd8ofZLQghtRaAA+BDl1DUxwmkzO/tnyCnPG70C+
         wAgw==
X-Gm-Message-State: ALoCoQlCHzf0gnuS3UQ/MAtKdMGXeD3Z7OR/we/5rhLzvWIKHlL9cuhVLhAw1VhX3oLTO16kJO5m
X-Received: by 10.66.197.163 with SMTP id iv3mr8240385pac.47.1405467262925;
        Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si1059793yhh.5.2014.07.15.16.34.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AE4CF5A425F;
	Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3BB55E0A98; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253625>

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
index b648819..71389a1 100644
--- a/refs.h
+++ b/refs.h
@@ -308,11 +308,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
2.0.1.442.g7fe6834.dirty
