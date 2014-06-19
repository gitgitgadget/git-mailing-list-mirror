From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 38/48] refs.c: make prune_ref use a transaction to delete the ref
Date: Thu, 19 Jun 2014 08:53:20 -0700
Message-ID: <1403193210-6028-39-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxef9-0006a7-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbaFSPx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:57 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:36546 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758078AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-pb0-f74.google.com with SMTP id rq2so294488pbb.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=my4gKHt9mxWlDXUQWz/unTTC5WS3Hpy01mfIC8EKk3Q=;
        b=EfouT2Suw0K0UBKxwxe7WQAHNziiDF4hn2yYbceJHAg9VunOOVgTsbeS3qYEuc+SyR
         mYA4S+llgPlayyNiCQ5zcxMEUIOMIq1F+mtb6cUpKbsJLz7L3Cs3lE359j1k+j7++7br
         6lxHMej3X9LTu7ztjvYNZSEDad2YEgVYwsuiYXmW+qDBZ/AyAJdYx10DOKoxhcBAlBze
         /Oe0wG6CRBjKnh3zAVb0yx+7bneIUKugKIDY9SKs61DkoopCZg7dHtVLNLtMfTt0u8TQ
         9PV9uV4HFT0EzYs1w/kERVtuZK8kl9riH3qiWOafMMi9qjB07vFPwBIb6ekR5Q39K/qy
         KCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=my4gKHt9mxWlDXUQWz/unTTC5WS3Hpy01mfIC8EKk3Q=;
        b=cCQ2Bf5iYUFeyP2ylO2Ya8p8Na/QF000cP38ZbzEPYtI1P0YsxmrtoC8ZQ68p9y/sf
         6qHBVIbB9AFr/PrG3QbYy+J0diHz/KHFT0Vz0mLt8089htDjDGqf/UdkT3gx7ITgrrK4
         RAoxGi19VqDt1UHjmIisJwzet6mJuzoV0yfhIIDeNI67UXjoQwPH+2CeG43+T8x6HUZ9
         XT3Vj0IqxATrpfUzmTOiNsT2NQTv6OTbcspXulpstZ6HZ+Gf82gY0/24Sko607dw00Mq
         enS2nkixjk9B9aAXiUkmqfLcswjULs+yu7A5rkdN9WRqf3cf0R+Ku3YDQveLLAhNJEVC
         l5xQ==
X-Gm-Message-State: ALoCoQkC9UpgjgtMqvjEtkE9305ETK/ZbNbNXK8F1FZ21yQkWgQxj3MRljxOUGZharm6AAIz8TbQ
X-Received: by 10.66.65.142 with SMTP id x14mr2730012pas.14.1403193214573;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si418321yhl.7.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4B6C35A4552;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 28102E094D; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252121>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 29 +++++++++++++++++++++--------
 refs.h | 14 ++++++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 441c0bc..7c46d13 100644
--- a/refs.c
+++ b/refs.c
@@ -25,6 +25,11 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x0100
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -2379,17 +2384,24 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
-	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
-		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
-	}
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return;
+ 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3596,8 +3608,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index 4ac4a7d..3b321c2 100644
--- a/refs.h
+++ b/refs.h
@@ -177,9 +177,19 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks any ref (for 'HEAD' type refs). */
+/*
+ * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
+ * ref_transaction_create(), etc.
+ * REF_NODEREF: act on the ref directly, instead of dereferencing
+ *              symbolic references.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
 #define REF_NODEREF	0x01
-/* errno is set to something meaningful on failure */
+/*
+ * Locks any ref (for 'HEAD' type refs) and sets errno to something
+ * meaningful on failure.
+ */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.438.g337c581
