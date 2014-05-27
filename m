From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 31/41] refs.c: make prune_ref use a transaction to delete the ref
Date: Tue, 27 May 2014 13:25:50 -0700
Message-ID: <1401222360-21175-32-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxU-0002p8-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaE0U0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:35 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:42101 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1646813yha.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VI3TNVDEjpr3ELNIcmB6coivkxwWa9nxX1D3/GgNkcw=;
        b=FhIO5jHeawCjbiagL28Bg0nQS69TNRJvL84vErao9OmXbivKadkmqKXaOGycUMiF2E
         fgHC9UjYZ+NWSVTx9Aprkrqko0sZajxK4JF6dSrJ2a1SrvReaMsQ/7OCOnjRKv7fTIE5
         SU9ww9kklr4RpgRW+V6H76x60xMXNHZbZcYlr2X6WKEfDdb3GbAYwA01dt3i9jaXA4Th
         qsyCHSZ/2qpZ+wMiY7GleVfZyFvUB85P+W6/kgBuRlPKK6Zz7mlkdBGWQQxk/bysP6/y
         uWmm7SSNrxqfxvmCsmJqwCII3B/zi3FcH/tJG2vwMnXZx/IVm7xaJcJNAPv+7JPlMHLw
         oE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VI3TNVDEjpr3ELNIcmB6coivkxwWa9nxX1D3/GgNkcw=;
        b=fEl0GdpYFauhb7XUOOHiq9ceL9ZSMk4Bk7I0T8UJHYTdwKMlWvJdC2+KiTFt09h1hn
         YUFf+P4GlCyp+iK3qFCShJ/A0v4EauhcmPl1rMUCMEhmg6OoM1vPYDcldW295j9ub7Om
         4FwTJkz4Nea0GclcnR2HFxtjZNUYQMLl2zKuweFK925u66x1P/6X7qUEeyM5uCOy+ooP
         rQ9bFuKOL8S3yX6YHaTmw+j+6/WBOPV6YSNkzHVhiN/FBRoecmcXZxGxiNZP6Y/pjjom
         X2/wii2tPEVKgFqXvObZ/rsMrFhexDOMueW2juoLLW27fPbCDihObVZZhmIAwG3LELZM
         nY4Q==
X-Gm-Message-State: ALoCoQkHukVVpcJazcu8a4AnchY4IydVPE/wagmg0tj02rw4FMDymjQt/Q77u6CQFeSnsVNSEtQ2
X-Received: by 10.236.124.100 with SMTP id w64mr5933076yhh.57.1401222365206;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si1395214yhe.1.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0B4882F4ACE;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DBD35E0C28; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250210>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 +++++++++++++++++++++-------
 refs.h |  5 +++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 4ca84f7..1819434 100644
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
@@ -2328,17 +2334,24 @@ static void try_remove_empty_parents(char *name)
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
@@ -3546,9 +3559,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 1e25e1c..39c97f8 100644
--- a/refs.h
+++ b/refs.h
@@ -235,6 +235,11 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 
 /*
+ * ref_transaction_update ref_transaction_create and ref_transaction_delete
+ * all take a flag argument. Currently the only public flag is REF_NODEREF.
+ * Flag values >= 0x100 are reserved for internal use.
+ */
+/*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
-- 
2.0.0.rc3.474.g0203784
