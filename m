From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 39/48] refs.c: make prune_ref use a transaction to delete the ref
Date: Thu, 12 Jun 2014 10:21:30 -0700
Message-ID: <1402593699-13983-40-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8i6-0007gA-MY
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbaFLRWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:22 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:61090 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so245439veb.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hY2330mDuKUsGOAchjDG+g0JoD43QaQni7wRKWaazps=;
        b=I+4ahArQ+o/UeUSUTDo1WpcpiehCzpkLZnchLaNVbP5leneeP6ZDrA2ncwkznFKDJ0
         MRz5UQ3IhRatzuCeghxkATY6gpefXSGOeA+QuwQpszmHibwpZme/D7mfmV3ympH8oB1P
         rQ9Y3p9vxHTqgv15eEEh7Pu1bAqAgNbG6seqmtF4JA6sFi0vmvbot6J8jS+CJxZ0VA6O
         L31mzKpiZ3cuEeWFRP+i2128usZci/rOLazOeOeVYPhsfj9mpRB1ew3MSWntWFBCTeLX
         Dz3TAvYgSBbw7B/8oPxDXvGjb4daONjh+vbcb5mO7cr3EKlwjaXU9y48m9uI5xsK72Ej
         Fgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hY2330mDuKUsGOAchjDG+g0JoD43QaQni7wRKWaazps=;
        b=OeAWY+RCpd01PAu89lGg2vgIb6/3s8w3cGl1WBmuFRpQKr+d4m7FeBs6FEBTi5WJiN
         k8w/qsdB9QL47QccMzz4tQRoBAI06Xel0XIvMAR+d/9uQe4qXYIou4i1wipLuemIt/+g
         2q3QPDpqIuYoriGiP6M9mriWSq06hwdv4m3SZk6MBwGDNFbGzTHzIE+N6ETmoYuEMwP5
         hXgO0qApfZqz6d+xW8XwX3k8HpnGS4LYk892Pp6nOeH4p7M8/zFXhChYHpuWk3+YJ4Hf
         7Gj/0Qo29sN+Ylf1i2cAPO77emuJHZ8oqE9X4bgAdjUuaxVmgWbdBgPM3Zawf0zsUW3e
         mLow==
X-Gm-Message-State: ALoCoQlstvwlQfDOZXN9TsQB+o5QFE4pyoEHcd3BmayEX/5iP0LKL+Kl2utXzTp3AWW/8ryCO+Kd
X-Received: by 10.236.197.226 with SMTP id t62mr10390960yhn.50.1402593704728;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si112268yhj.5.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 93B4131C66C;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 701A2E0E5C; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251433>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 +++++++++++++++++++++-------
 refs.h | 14 ++++++++++++--
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 1cb6ef6..d4e3442 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,12 @@ static inline int bad_ref_char(int ch)
 }
 
 /*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x0100
+
+/*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
  * legal.
@@ -2352,17 +2358,24 @@ static void try_remove_empty_parents(char *name)
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
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3593,9 +3606,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index 21ec3f9..b3c6fa6 100644
--- a/refs.h
+++ b/refs.h
@@ -173,9 +173,19 @@ extern int ref_exists(const char *);
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
2.0.0.599.g83ced0e
