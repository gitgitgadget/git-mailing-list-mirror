From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 14/41] refs.c: update ref_transaction_delete to check for error and return status
Date: Tue, 27 May 2014 13:25:33 -0700
Message-ID: <1401222360-21175-15-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyU-0004YH-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbaE0U1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:45 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:61565 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so1921414obc.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZ4Vdip2y6wKfANyaZkZCUYY2Y0x6+khE2Ku/IhusVg=;
        b=Ev/pQEXr51DgLtXneLX9a1X+h5xCE/qdHQZ71JjIwgF0uKxr9fykB8LrYHulNqmuK3
         IRq9Hgm7zMA1pqVDAgxR/a6O4ugX0Mty1naJiXWUBijBZuY6/IVzEEJmwHiY01g2BV5d
         KQ1mCCmfR8PG1FrG70DF9UFdwxP2mhIodnbH8d7DWAoraNfd3zwshjmadXmzoRLldOvU
         NFrdpqRDjNjFWlcRZn2Eth1XChVtRhdiqq4pehjsjsGEW7/b6ak84gW+Mo0foT5IsbS4
         CGw5nnLSoq72QDVxB5c+uaNtNzW5evH8QJQvUhwtSMp71WLWnx9fZGRZGuIV2qQCHmoP
         KLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZ4Vdip2y6wKfANyaZkZCUYY2Y0x6+khE2Ku/IhusVg=;
        b=Ll5HtA9QgUPA07yu5Ej6At8s40uT00MOn45HDieFbLFDVrbrmsoMGxdesRwcFI92vZ
         1cA4caJaPvpI3VbXPkB3RCscr8zZizXycnlSVvKKqLO2VUkwggFzc+K1yj0h0UKEKLcV
         IEDqa/daDPc4vlJWhP8GF472bNuIKgr77yeOpDWVNNILtvni0/yQBsF+/fONKVujmm9J
         d+WnGQeAlZEPaDgD75YNnuIbnSMsV+k9IalNe6ORwnoZv5WXGbG9bjR5KRRhrprLJ+E2
         TAGpaJdSWicHV5D8zJpgMyOGzY4FbQmaCe+/rHWZMELPwPHSznhuOaB4P5tI45Z/gPDG
         SZxA==
X-Gm-Message-State: ALoCoQnN3SfdkxBiOKkdwfWcehCNyFtyHH26W7ebBTG6dtvP1c5le5XL62s9gN0rc4x6Wg5U1xMA
X-Received: by 10.50.119.164 with SMTP id kv4mr13911207igb.3.1401222364399;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1283650yhg.2.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3EDE12F4AE0;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 06340E0BB8; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250226>

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
index 709758d..beddce0 100644
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
index 22b8cc3..e0ab989 100644
--- a/refs.h
+++ b/refs.h
@@ -273,11 +273,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
2.0.0.rc3.474.g0203784
