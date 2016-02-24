From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 22/32] refs: always handle non-normal refs in files backend
Date: Wed, 24 Feb 2016 17:58:54 -0500
Message-ID: <1456354744-8022-23-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQa-0004iM-A0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759265AbcBXXAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:00:51 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36106 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759185AbcBXW7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:39 -0500
Received: by mail-qg0-f49.google.com with SMTP id y9so27394957qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cejP78Z/QbYtRgzXwldOCihij1gGg+XgLcSLZZqAPkg=;
        b=Tm6OEG4AL+m9FGykySg7q37tIAtym/pG5okibHHT6jshK67xj4mGJnDZpz+3XV1faZ
         ihujRLFrYN2/AEJiYNW6eEuIe6T1/38mJu/24hamgoxE4SpHBtseuXXKJRBjNaENWvRn
         UEWM9NlYxeAqYdcCnqB5rKQH9ejPEghzZoVxfOpAEZRgo37DlY16dgKuPrq1jn5i5odB
         jlCeVJ2ueVRiglbaufzf9T0yQuy7gw7zy7Bd0GHLSPEj3DVV+k1D0LRj8GzjEViLiQtK
         PYkpbbIpiW6IzWjJncQXOJf3iDLaISLCNup+qr4HH1YjtEt5u7sRRrvd09f8JUYO5KfN
         L4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cejP78Z/QbYtRgzXwldOCihij1gGg+XgLcSLZZqAPkg=;
        b=H255BGAiNeT1yRicEvbToiR0dajwrorJOuQnJ1CC/y9AHFgpnoSNUfwAXL8wMlEjqU
         98dTbJ2y17t4rBUVotuYdhPK1MET+fgXZ9Yl6AYVer7AxvuZuaPpSKIxS0kBOPTr2kpw
         +Ag1B7AIrkImlO0b9b25217DOQd+dyYlKom7kucBKzrpNDz3MmS3HAueLbtvNz2wVjIb
         OYAEJuwLKuXDQb4rd+MrDpyPwc/QNU0DI129uadUU5EsvN6Zu8zCJKawq5Vxw8kYZhHi
         ojfgXYMEHyFt6lmY4Cy/pYI8lA7PQvwosbusr77iX9EoCPaiM87iRw7J5wyZQ4HKmHco
         Dokw==
X-Gm-Message-State: AG10YORpN4eIkSdmBjmYJpcmjtUxJYHR9rj6T6faNYKuqJSlpyEXBckNfBh65MbLfpWWlQ==
X-Received: by 10.140.131.17 with SMTP id 17mr55210752qhd.12.1456354778998;
        Wed, 24 Feb 2016 14:59:38 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287267>

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
index bdde808..b2acf0e 100644
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
 
@@ -1416,11 +1427,37 @@ static int dereference_symrefs(struct ref_transaction *transaction,
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
 
@@ -1436,18 +1473,60 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -1467,6 +1546,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
+	if (ref_type(ref_target) != REF_TYPE_NORMAL)
+		return refs_be_files.create_symref(ref_target, refs_heads_master,
+						   logmsg);
 	return the_refs_backend->create_symref(ref_target, refs_heads_master,
 					       logmsg);
 }
@@ -1526,20 +1608,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
