From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 22/48] refs.c: update ref_transaction_delete to check for error and return status
Date: Tue, 17 Jun 2014 08:53:36 -0700
Message-ID: <1403020442-31049-23-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvjw-0005ko-M7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbaFQPz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:56 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:46325 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so880934qcv.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CjJ9O1lmA/jI9JEe9IpCVbHYdDaPm/5IRGQy3CyIlE4=;
        b=aR6AdWbUVWVdd6VcOpAhNMmSs8kTWNJyCmnuyX8WvImoHwwI3xagc8gTlk+uqMphsG
         IDmRfiLNZwzAdt4mSCuzWkbiCZJ/rEm3haJYa3MHuyht5z4MruOf2T5DC+I3WEo4I5ub
         qiEQ+e+iogFV8iORbBFddEii64NmiuDkd6rEen05l8mPA7dA9z/oXVC9TmyjN6imVYWU
         G0sDCZOu7ojOpBsm735sVFZNlodGX6TXpBIV/9Lbtr8Bf3q4kgFBP/A6greviI9aEhxw
         ebJrY79YGfOIDdsh7OE0HaxZMDhUhVGLhfOBbQZIlvQ8PsjPhxlSOvkaK0duFaxFfFy/
         D3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CjJ9O1lmA/jI9JEe9IpCVbHYdDaPm/5IRGQy3CyIlE4=;
        b=CIwS6DF/aWKTL9+pQHfdFx4QgqObmBgaGIVTAwQ/LHGaHG1UNlkUJaJ0/IdYi1LZNA
         vpcgN1D5cdZbAnJME8q8lqXuD5CzVJ23wdJmWRkBo4v5afUALCBt/+FFt3vhMInNqBba
         UzGQNlOQ5n/s3xrIvTdeJmxuFiNcKlNwNGsllLg4ob7y5SN/YciDZDJtSk1QFNhdJC8/
         w0+wgBT7IlxurM7areL5xRVHK+USO67lbRTQ3mfvcr/RUkVl0cMvAima+tIgRlQBIQRB
         g4eSpNSn4x0lkXjG6QCX+RGyejspA6iQCy5Fa69YFEdj1Ga+CQToEWiDuNXON/zy9LwD
         b00Q==
X-Gm-Message-State: ALoCoQnTYF6iLKB16P5fIAyP2Cfv/bomiXtSZz3wA60fxKTvNdcVdzvoU/3Wy9zeukl4GKB2xCie
X-Received: by 10.58.160.72 with SMTP id xi8mr1642470veb.15.1403020445151;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1208588yhj.5.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EC4E031C76E;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C85F2E148C; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251896>

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
index 78ae4f0..93edb69 100644
--- a/refs.c
+++ b/refs.c
@@ -3492,19 +3492,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index d1ba4e8..3bc58a6 100644
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
2.0.0.438.gec92e5c
