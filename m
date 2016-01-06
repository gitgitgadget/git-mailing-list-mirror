From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC v2 3/3] refs: always handle non-normal refs in files backend
Date: Wed,  6 Jan 2016 18:41:59 -0500
Message-ID: <1452123719-22634-3-git-send-email-dturner@twopensource.com>
References: <567A5516.9070209@alum.mit.edu>
 <1452123719-22634-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 07 00:42:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGxix-0003G6-AH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 00:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbcAFXmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 18:42:33 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35531 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbcAFXm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 18:42:29 -0500
Received: by mail-qk0-f182.google.com with SMTP id n135so167966809qka.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 15:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+QujK+uyam9GUnzrgsGcvuwjW1oZbSqu5QlkHCTAqKI=;
        b=0grlxBJkGSMFTxgqjng+kVwa5zdWMBCYppcuotJxqPXLESv1JGA2Y99tZ0vzX3gO2D
         ACcZCvpXX5bLs2rdyQSM3A94r57aQ1yuvs4h7MK8uwxi3D1e5BNrIdEmgDFZnO419C81
         4VoElb6nqWqZRQVPnPwqe8ViVUjOVk77qOuqcOG+pC/d/WgBUUmKta4uOGkpFC+3wley
         alRPm5GZn0v1KVM9WFfofhgT8ikVJ4giOdf/BR/qDnnMGe0CwB9I2a2fY78ibVpSY8pp
         Fwk2T1Z6pWtkAQY/RwiFZpKeOGJAAF7alRSh6MzwR0iX4q9QAxJgXqnH1M8cZL8wUqJs
         SD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+QujK+uyam9GUnzrgsGcvuwjW1oZbSqu5QlkHCTAqKI=;
        b=Ub1SQwOHiDX6AGes54XXSi4/2N31TBjwGAdEht7FtCB5ceoxdwCapR1hHxeRJbpR9U
         6ShXfEh5+pgo5wyPM6yO9bpB/JIPLqKJGuunXp9L9l5lZEiI+GenTtjp4XaK74onjA8v
         HrvrG6h/yaC+ooMxS+UpMJInRZf2tU7yvXzLhHs+bE04/BhI9bp0oUiFH++Np8TBZZYu
         3H9KysIXDUoi0pvUctLDfFZ95+pk+F9KrRBsRz7OXdmCcUD+RPis6fbp3tfuXR4EnM9b
         qg6jWWZfCQX9baSSxLnRDvTlVGS/AtA/jBOrwIEucruVYhG46I9ASxbDGtxniHIMJxy1
         3FlA==
X-Gm-Message-State: ALoCoQki1y/LxljCWpfFsdzddXckAB0xbcfAN8QVVAtbijFkGJ0TDA0qyPA9trAkvgodhPcrz/9twOMr6GDLCLujE8FBbgmNQw==
X-Received: by 10.55.78.207 with SMTP id c198mr132172564qkb.34.1452123749023;
        Wed, 06 Jan 2016 15:42:29 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f132sm27113524qhe.6.2016.01.06.15.42.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 15:42:28 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452123719-22634-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283462>

Always handle non-normal (per-worktree or pseudo) refs in the files
backend instead of alternate backends.

Sometimes a ref transaction will update both a per-worktree ref and a
normal ref.  For instance, an ordinary commit might update
refs/heads/master and HEAD (or at least HEAD's reflog).

Updates to normal refs continue to go through the chosen backend.

Updates to non-normal refs are moved to a separate files backend
transaction.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs/refs-internal.h |  2 ++
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 2496b91..67b0280 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,11 @@
 #include "object.h"
 #include "tag.h"
 
+static const char split_transaction_fail_warning[] =
+	"A ref transaction was split across two refs backends.  Part of the "
+	"transaction succeeded, but then the update to the per-worktree refs "
+	"failed.  Your repository may be in an inconsistent state.";
+
 /*
  * We always have a files backend and it is the default.
  */
@@ -781,6 +786,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
+static void add_update_obj(struct ref_transaction *transaction,
+			   struct ref_update *update)
+{
+	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
+	transaction->updates[transaction->nr++] = update;
+}
+
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
@@ -788,8 +800,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
 
 	memcpy((char *)update->refname, refname, len); /* includes NUL */
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	add_update_obj(transaction, update);
 	return update;
 }
 
@@ -1192,11 +1203,39 @@ static int dereference_symrefs(struct ref_transaction *transaction,
 	return 0;
 }
 
+/*
+ * Move all non-normal ref updates into a specially-created
+ * files-backend transaction
+ */
+static int move_abnormal_ref_updates(struct ref_transaction *transaction,
+				     struct ref_transaction *files_transaction,
+				     struct strbuf *err)
+{
+	int i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		int last;
+		struct ref_update *update = transaction->updates[i];
+
+		if (ref_type(update->refname) == REF_TYPE_NORMAL)
+			continue;
+
+		last = --transaction->nr;
+		transaction->updates[i] = transaction->updates[last];
+		files_transaction->updates[files_transaction->nr++] = update;
+	}
+
+	return 0;
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = -1;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list files_affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+	struct ref_transaction *files_transaction = NULL;
 
 	assert(err);
 
@@ -1212,6 +1251,26 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	if (ret)
 		goto done;
 
+	if (the_refs_backend != &refs_be_files) {
+		files_transaction = ref_transaction_begin(err);
+		if (!files_transaction)
+			goto done;
+
+		ret = move_abnormal_ref_updates(transaction, files_transaction,
+						err);
+		if (ret)
+			goto done;
+
+		/* files backend commit */
+		if (get_affected_refnames(files_transaction,
+						 &files_affected_refnames,
+						 err)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto done;
+		}
+	}
+
+	/* main backend commit */
 	if (get_affected_refnames(transaction, &affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto done;
@@ -1219,8 +1278,24 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	ret = the_refs_backend->transaction_commit(transaction,
 						   &affected_refnames, err);
+	if (ret)
+		goto done;
+
+	if (files_transaction) {
+		ret = refs_be_files.transaction_commit(files_transaction,
+						       &files_affected_refnames,
+						       err);
+		if (ret) {
+			warning(split_transaction_fail_warning);
+			goto done;
+		}
+	}
+
 done:
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&files_affected_refnames, 0);
+	if (files_transaction)
+		ref_transaction_free(files_transaction);
 	return ret;
 }
 
@@ -1276,6 +1351,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
+	if (ref_type(ref_target) != REF_TYPE_NORMAL)
+		return refs_be_files.create_symref(ref_target, refs_heads_master,
+						   logmsg);
 	return the_refs_backend->create_symref(ref_target, refs_heads_master,
 					       logmsg);
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 971f450..dd035f5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -323,4 +323,6 @@ struct ref_storage_be {
 	for_each_replace_ref_fn *for_each_replace_ref;
 };
 
+extern struct ref_storage_be refs_be_files;
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g730654d-twtrsrc
