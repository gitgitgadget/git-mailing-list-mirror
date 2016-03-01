From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 23/33] refs: always handle non-normal refs in files backend
Date: Mon, 29 Feb 2016 19:52:56 -0500
Message-ID: <1456793586-22082-24-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZl-0007F1-C2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbcCAAyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:02 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34402 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbcCAAxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:54 -0500
Received: by mail-qk0-f176.google.com with SMTP id x1so63748903qkc.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prrtdgAXVESOU7iRi0n5+g1SvCyIimDEYkQzZ5dlgvM=;
        b=Zm94ComNwqCxQX9Ox1AX727JJjNlmGctmsF+BKss7KkhZF4w5S1n9InjOCy1+NGnNv
         aYmAEX+xtCgbr7+vuJ/ZJhNTstx2yCRkUMDZhgyKuGT+oPT13U8hXaZ90I1HdggNqQRV
         lKG9TkQLOLCQPC5coA2A74WiZiCSQ7QMrCax/ueoLQQ4LtlMobYx/MFR5rAe+rVaprea
         hBtImqE9uspN2HwhRXJu8fO9aDVVaWWe3JQbGqAFYGXsiYER1JrgCKrcbkBNO8Xt29bp
         /PRJE9U2M8rcMSRCOpBmRb4qr0i+/72nzbMZQ7Z6YT9IzwQdofu6JmMhT/l2iUxUHxpb
         0g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prrtdgAXVESOU7iRi0n5+g1SvCyIimDEYkQzZ5dlgvM=;
        b=GCQE117empBC3z895/0qFaSLvOoW2gxN+u8o410qrgPA8LwpfqDyYwr/+t1rbXeqYS
         pPPdGM9yKReMS8Rc9/vOM7Ue+iX15fOoqFFeGGAZasj9y7BywUQhY61TcMVXKjsPM6db
         oLXct+AwW+2U/XYAqQPpcx9WsOkGj3CZd4G983hGlxRsvv+drKi4GfDROdB06poLkMgN
         boq5yb69Oa3Oy5SXHfmLB5R2IWgtXixdXEcs+TCklG6965Rnt+sHJD9b72B7+HMMNpw/
         rOV1sff4muq8P7NZSHYcVrZw9x25iZydUQpvBZTif8IreXwfWqimIHW0G6Raay28bID9
         YaWw==
X-Gm-Message-State: AD7BkJLfPS1pZ/jlMvEvXJl90WHV/J4Wvtz5enh/0V7jm07KcS5AxA2zgFAX37lQDsla+A==
X-Received: by 10.55.71.143 with SMTP id u137mr23202995qka.1.1456793633744;
        Mon, 29 Feb 2016 16:53:53 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:52 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287961>

Always handle non-normal (per-worktree or pseudo) refs in the files
backend instead of alternate backends.

Sometimes a ref transaction will update both a per-worktree ref and a
normal ref.  For instance, an ordinary commit might update
refs/heads/master and HEAD (or at least HEAD's reflog).

Updates to normal refs continue to go through the chosen backend.

Updates to non-normal refs are moved to a separate files backend
transaction.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index eee8c37..6c05881 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,11 @@
 #include "object.h"
 #include "tag.h"
 
+static const char split_transaction_fail_warning[] = N_(
+	"A ref transaction was split across two refs backends.  Part of the "
+	"transaction succeeded, but then the update to the per-worktree refs "
+	"failed.  Your repository may be in an inconsistent state.");
+
 /*
  * We always have a files backend and it is the default.
  */
@@ -796,13 +801,19 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
 	struct ref_update *update;
 	FLEX_ALLOC_STR(update, refname, refname);
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	add_update_obj(transaction, update);
 	return update;
 }
 
@@ -1419,11 +1430,37 @@ static int dereference_symrefs(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+/*
+ * Move all non-normal ref updates into a specially-created
+ * files-backend transaction
+ */
+static int move_abnormal_ref_updates(struct ref_transaction *transaction,
+				     struct ref_transaction *files_transaction,
+				     struct strbuf *err)
+{
+	int i, normal_nr = 0;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if (ref_type(update->refname) == REF_TYPE_NORMAL)
+			transaction->updates[normal_nr++] = update;
+		else
+			add_update_obj(files_transaction, update);
+	}
+
+	transaction->nr = normal_nr;
+	return 0;
+}
+
+static int do_ref_transaction_commit(struct ref_transaction *transaction,
+				     struct strbuf *err,
+				     ref_transaction_commit_fn *commit_fn)
 {
 	int ret = -1;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list files_affected_refnames = STRING_LIST_INIT_NODUP;
+	struct ref_transaction *files_transaction = NULL;
 
 	assert(err);
 
@@ -1439,18 +1476,60 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
 	}
 
-	ret = the_refs_backend->transaction_commit(transaction,
-						   &affected_refnames, err);
+	ret = commit_fn(transaction, &affected_refnames, err);
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
 
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	return do_ref_transaction_commit(transaction, err,
+					 the_refs_backend->transaction_commit);
+}
+
 int verify_refname_available(const char *refname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err)
 {
@@ -1470,6 +1549,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
+	if (ref_type(ref_target) != REF_TYPE_NORMAL)
+		return refs_be_files.create_symref(ref_target, refs_heads_master,
+						   logmsg);
 	return the_refs_backend->create_symref(ref_target, refs_heads_master,
 					       logmsg);
 }
@@ -1529,20 +1611,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
-	int ret;
-
-	if (get_affected_refnames(transaction,
-				  &affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto done;
-	}
-	ret = the_refs_backend->initial_transaction_commit(transaction,
-							   &affected_refnames,
-							   err);
-done:
-	string_list_clear(&affected_refnames, 0);
-	return ret;
+	return do_ref_transaction_commit(transaction, err,
+					 the_refs_backend->initial_transaction_commit);
 }
 
 int delete_refs(struct string_list *refnames)
-- 
2.4.2.767.g62658d5-twtrsrc
