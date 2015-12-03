From: David Turner <dturner@twopensource.com>
Subject: [PATCH 12/16] refs: always handle non-normal refs in files backend
Date: Wed,  2 Dec 2015 19:35:17 -0500
Message-ID: <1449102921-7707-13-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Ht5-0007bA-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbbLCAgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:22 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35275 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595AbbLCAfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:54 -0500
Received: by ioc74 with SMTP id 74so64531042ioc.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0IFsa3eazwBJ/l3a8jpesnzpyY6Acrvig8u9N7y7Ds=;
        b=m/iuO3eRZpy5j4z9kUZh9DnPfwfdVvBxqQFp/kpxQkrZdV5kpAL63fSRq6+ELTB4+F
         zHH1apDPSWvJ4Xc/jDGE5NETqxnt9K+mNztJJeYI6wAVNNUKvJuNcfLi8hjYtPfoOUZv
         oX5uTaBMYScfbZOQKCMVQvT1/2Pbx3sBiLWLJxX7G3Eal4boMvKa6iDNPOlrE9PDT3Jo
         bGl3J/s/bThmjWXuCB8M8F0OrcWJMd22oRNzYPe3cSLqvJ28cuIOT+tzFZIB1uN7rC89
         AhTeOs9hx4dwHOSlV6sPnLoSF1J3NZJZbbfaYxkUzyK6p02Ecyxab4XR72909qqyHj4w
         9ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0IFsa3eazwBJ/l3a8jpesnzpyY6Acrvig8u9N7y7Ds=;
        b=V8tNV1PGjUrMAilqo1SsEkF3TGZ+9C8XbXFzqPSXOSLhMDRe6w8/6dtrtRoFRcNvnQ
         Bduoz5ca/8ESrAboxrIPJUNrhYfEKQ3oOiVq1aT7RSfFJSYh2XUertJxO8/LamSklrz7
         D9xo+O590p1UKTReDZLFkXwRgb3HM5+2zf2v3rHFt7g2cmiAqjOIY3zwKo9Y9+v1aAnN
         1svjhgE5gBDnFjvpfdgBQBXYjtt+TBI78jczfdlU0dgVcIhXf8BtC0QYn1iD7w0HUZ3+
         R+bGCD1XHpjSTD+8+RIcCE3CEXWul1c4/GxwgmvHhdfzws77/j+PYkDHhnndJVcQcS3E
         AJpw==
X-Gm-Message-State: ALoCoQnAaSA5sWlwXccBRIyIerGDi/4dXGDyX7BWdmkTreYoHF7hO9Hn02LNm575TkwV58GqQbOF
X-Received: by 10.107.137.163 with SMTP id t35mr6072345ioi.61.1449102953890;
        Wed, 02 Dec 2015 16:35:53 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:53 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281934>

Always handle non-normal (per-worktree or pseudo) refs in the files
backend instead of alternate backends.

Sometimes a ref transaction will update both a per-worktree ref and a
normal ref.  For instance, an ordinary commit might update
refs/heads/master and HEAD (or at least HEAD's reflog).

We handle three cases here:

1. updates to normal refs continue to go through the chosen backend

2. updates to non-normal refs with REF_NODEREF or to non-symbolic refs
are moved to a separate files backend transaction.

3. updates to symbolic refs are dereferenced to their base ref.  The
update to the base ref then goes through the ordinary backend, while
the files backend is directly called to update the symref's reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 808053f..e48e43a 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,11 @@
 #include "object.h"
 #include "tag.h"
 
+const char split_transaction_fail_warning[] =
+	"A ref transaction was split across two refs backends.  Part of the "
+	"transaction succeeded, but then the update to the per-worktree refs "
+	"failed.  Your repository may be in an inconsistent state.";
+
 /*
  * We always have a files backend and it is the default.
  */
@@ -784,6 +789,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -791,8 +803,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
 
 	memcpy((char *)update->refname, refname, len); /* includes NUL */
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	add_update_obj(transaction, update);
 	return update;
 }
 
@@ -1130,11 +1141,87 @@ int refs_init_db(struct strbuf *err, int shared)
 	return the_refs_backend->init_db(err, shared);
 }
 
+/*
+ * Special case for non-normal refs.  For symbolic-refs when
+ * REF_NODEREF is not turned on, we dereference them here and replace
+ * updates to the symbolic refs with updates to the underlying ref.
+ * Then we do our own reflogging for the symbolic ref.
+ *
+ * We move other non-normal ref updates with into a specially-created
+ * files-backend transaction
+ */
+static int move_abnormal_ref_updates(struct ref_transaction *transaction,
+				     struct ref_transaction *files_transaction,
+				     struct string_list *symrefs)
+{
+	int i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		const char *resolved;
+		int flags = 0;
+		unsigned char sha1[20];
+
+		if (ref_type(update->refname) == REF_TYPE_NORMAL)
+			continue;
+
+		resolved = resolve_ref_unsafe(update->refname, 0, sha1, &flags);
+
+		if (update->flags & REF_NODEREF || !(flags & REF_ISSYMREF)) {
+			int last;
+
+			add_update_obj(files_transaction, update);
+			/*
+			 * Replace this transaction with the
+			 * last transaction, removing it from
+			 * the list of backend transactions
+			 */
+			last = --transaction->nr;
+			transaction->updates[i] = transaction->updates[last];
+			continue;
+		}
+
+		if (resolved) {
+			struct ref_update *new_update;
+			struct string_list_item *item;
+
+			if (ref_type(resolved) != REF_TYPE_NORMAL)
+				die("Non-normal symbolic ref `%s` points to non-normal ref `%s`", update->refname, resolved);
+
+			new_update = xmalloc(sizeof(*new_update) +
+					     strlen(resolved) + 1);
+			memcpy(new_update, update, sizeof(*update));
+
+			if (update->flags & REF_HAVE_OLD &&
+			    hashcmp(sha1, update->old_sha1)) {
+				/* consistency check failed */
+				free(new_update);
+				return -1;
+			} else {
+				hashcpy(update->old_sha1, sha1);
+			}
+
+			strcpy((char *)new_update->refname, resolved);
+			transaction->updates[i] = new_update;
+
+			item = string_list_append(symrefs, update->refname);
+			item->util = new_update;
+			free(update);
+		}
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
+	struct string_list symrefs = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct ref_transaction *files_transaction = NULL;
 
 	assert(err);
 
@@ -1146,6 +1233,26 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
+	if (the_refs_backend != &refs_be_files) {
+		files_transaction = ref_transaction_begin(err);
+		if (!files_transaction)
+			die("%s", err->buf);
+
+		ret = move_abnormal_ref_updates(transaction, files_transaction,
+						&symrefs);
+		if (ret)
+			goto done;
+
+		/* files backend commit */
+		if (ref_update_reject_duplicates(files_transaction,
+						 &files_affected_refnames,
+						 err)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto done;
+		}
+	}
+
+	/* main backend commit */
 	if (ref_update_reject_duplicates(transaction, &affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto done;
@@ -1153,8 +1260,35 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	ret = the_refs_backend->transaction_commit(transaction,
 						   &affected_refnames, err);
+	if (ret)
+		goto done;
+
+	if (the_refs_backend != &refs_be_files) {
+		ret = refs_be_files.transaction_commit(files_transaction,
+						       &files_affected_refnames,
+						       err);
+		if (ret) {
+			warning(split_transaction_fail_warning);
+			goto done;
+		}
+
+		/* reflogging for dereferenced symbolic refs */
+		for_each_string_list_item(item, &symrefs) {
+			struct ref_update *update = item->util;
+			if (files_log_ref_write(item->string, update->old_sha1,
+						update->new_sha1,
+						update->msg, update->flags, err))
+				warning("failed to log ref update for symref %s",
+					item->string);
+		}
+	}
+
 done:
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&files_affected_refnames, 0);
+	if (files_transaction)
+		ref_transaction_free(files_transaction);
+	string_list_clear(&symrefs, 0);
 	return ret;
 }
 
@@ -1210,6 +1344,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
+	if (ref_type(ref_target) != REF_TYPE_NORMAL)
+		return refs_be_files.create_symref(ref_target, refs_heads_master,
+						   logmsg);
 	return the_refs_backend->create_symref(ref_target, refs_heads_master,
 					       logmsg);
 }
-- 
2.4.2.749.g0ed01d8-twtrsrc
