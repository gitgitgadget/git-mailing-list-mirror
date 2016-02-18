From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 19/27] refs: always handle non-normal refs in files backend
Date: Thu, 18 Feb 2016 00:17:42 -0500
Message-ID: <1455772670-21142-20-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:19:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzW-0001Uj-6k
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424937AbcBRFS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:57 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35229 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424922AbcBRFSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:54 -0500
Received: by mail-qg0-f52.google.com with SMTP id y89so29372354qge.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=km3imvutEVjYs/Wn/B3YlO/Pr3xRUGJ5q8VnMhkPhO8=;
        b=yDqSHxS+O+sqUy6AxheHtGEnGKS4/tmAuj5wxjbj/xK7VWH+eMVlQ4nAdXA7tMSRcr
         Wnito4lEsDf3rd8rMUW1fF3yy1wsuhZ3Yk00jOCA1irg/7crgH67Az4139wd6VHKSFPb
         6SA0IHD8oQlLsS9GNJwo6KtvDIk7yZEZNCbrQ/LdW1GgGCIqlnNqn3aXUTSZeaeswd+t
         TF0VJ08OmQkHWxAPM5aBm2a/Xp3yp3L0+qFTGFuyco8LP8Lk5V9lYvhsGLuUkodsHZc3
         ZbuHHLwY/Qmzo0La4/3TATyr8tUb3bmTaqXdHM76jZ8tWMKsVXWjxk7Uv/BXFxuuGcaV
         9wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=km3imvutEVjYs/Wn/B3YlO/Pr3xRUGJ5q8VnMhkPhO8=;
        b=hE333RIobzUqKr+XKsF29hjXnS/e9B8FhIYinK/GsXqvOgzEDmaXlzpEcb87If++JB
         rjbMp82mGc+3raQQu2TQUu3KgyZ9AYhMElkrQuf8vMhjbzOqgwnrA63xzvgcEdpE/0BY
         3bR4K3A9P0HSBBNfB9Yl4JOhSVTEezgYok+YYtDoc4rpp7VvMHf5KH3N0r0skbGb8kRu
         KaybRaSJBydN3tP6XT5txCpzZsd7CCuhRA6m4aSJU18MR3IMlkxpAkhEpZeAS0IQ0vvI
         UXlLJDsLnCr7lkljIoSw/tkRBwrAVCknmsI4t+GNErRJVIaeZeZ9B34pBMWZegP+/ia5
         BQsg==
X-Gm-Message-State: AG10YOTHQnhFis+aCbb9PyiJ64QlZFceyMrdkQd2qocyq79jdFE+GpJsTzJWmIbFjAhB4Q==
X-Received: by 10.140.194.4 with SMTP id p4mr7209999qha.30.1455772733390;
        Wed, 17 Feb 2016 21:18:53 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:52 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286582>

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
 refs.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 01cf6c3..85e1793 100644
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
@@ -791,6 +796,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -798,8 +810,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
 
 	memcpy((char *)update->refname, refname, len); /* includes NUL */
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	add_update_obj(transaction, update);
 	return update;
 }
 
@@ -1292,11 +1303,37 @@ static int dereference_symrefs(struct ref_transaction *transaction,
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
 
@@ -1312,18 +1349,60 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
@@ -1350,6 +1429,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
+	if (ref_type(ref_target) != REF_TYPE_NORMAL)
+		return refs_be_files.create_symref(ref_target, refs_heads_master,
+						   logmsg);
 	return the_refs_backend->create_symref(ref_target, refs_heads_master,
 					       logmsg);
 }
@@ -1417,20 +1499,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
