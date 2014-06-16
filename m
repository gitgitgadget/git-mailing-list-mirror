From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 40/48] refs.c: make delete_ref use a transaction
Date: Mon, 16 Jun 2014 11:04:11 -0700
Message-ID: <1402941859-29354-41-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbI5-0004n2-3C
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbaFPSF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:26 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:52394 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so1153582iec.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K0iKbVBRFIMBBm9btma8SkycNiB33pylk7MWaLccXP8=;
        b=liNJtMalMl+w/dSWQN4Rka+iZTXuUkOYQwTPRjYnBYfr1fU/tO7JnRDfKEcX1Q9EGO
         LgkhWslZF/rdUWh8TLtaCwR4f9d13NtmSqqsC2ZBhmAsAFmjAru0LAKZN5Yw55JWBVba
         E+r1Mn5Ay+B+6WmLnIjlM24J5oXmfqiY+TAuIVBBZenyzrU5xd/fo9aRKT62X/DSp/mh
         Kh0DbpniQzTJZxdITQSDUKGy2axdUomfBdmxwJMQXPfK0U5f2NH+kHyWTg19TYOHXoFV
         6oWCZGlZiUzCx9qpmiioHYAXmKif6SSSXY2XKu3PU18ItaUUowYkZcFw9ExMVoUNrhJs
         63Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K0iKbVBRFIMBBm9btma8SkycNiB33pylk7MWaLccXP8=;
        b=iTVkLFiswHy+FqbKwIXc5WV2ij4I/J14j+mCFlsoLZ9dzzPelElGDt1BlZPZSaOz/V
         5+c1bN8ezIAN8UxrU/SGp5Mk80K/tLQVCzj4a45UwNiAy3EV+RSMNJ+QFDiUSCMrDyYh
         joja0eIopXiZclkKOi9Wn/hAIw7ib5lDbHUG7yaCDPfCzyQQZn53wRj0yAV5ZqQ9p1GC
         KMdp1tlGemGMKpPPoDNN+Q6mD58+cM8WiJ27/BJMZpCaMihwkFjBTF2ojGFoXwLCQbkl
         ausKlKyyR9irLXpKWRClS8Jk+CvovUNXgERtlxXkmMKdOZTpdJsNQQgcLzqg8MJvXGDo
         BZXw==
X-Gm-Message-State: ALoCoQlGohPTT5p6KbcYqaztJqPN2/OD9i+9JcFyHuXbnl3aBFQc5d3TxNtkXBV6Hj2PRDI/1FDu
X-Received: by 10.42.27.18 with SMTP id h18mr327611icc.25.1402941863843;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si998551yhm.0.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ABD1B5A4913;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8C692E0F37; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251755>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Change delete_ref to return 0 on success and 1 on failure instead of the
previous 0 on success either 1 or -1 on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 94fda74..34383ba 100644
--- a/refs.c
+++ b/refs.c
@@ -2518,11 +2518,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int add_err_if_unremovable(const char *op, const char *file,
 				  struct strbuf *e, int rc)
 {
@@ -2562,24 +2557,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 1;
-	ret |= delete_ref_loose(lock, flag, NULL);
-
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(lock->ref_name);
-
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
-	return ret;
+	}
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 /*
-- 
2.0.0.282.g3799eda.dirty
