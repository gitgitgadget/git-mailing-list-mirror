From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 14/20] refs: always handle non-normal refs in files backend
Date: Thu, 14 Jan 2016 11:26:11 -0500
Message-ID: <1452788777-24954-15-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjr-0002SK-GL
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbcANQ0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:50 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36358 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723AbcANQ0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:47 -0500
Received: by mail-qk0-f174.google.com with SMTP id q19so251875275qke.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=337aE7d9Vt4MCAtJ6+dFhSSN7Oy3DKbtxL0tnZA2b1M=;
        b=uuZx2hKIf6ue3qVpUk+ni5M9erQ0lPyZxsD8SdtND2hAZvmhMtszuZIMwBcvoTAetT
         xUwip2RCA9IG9hpL7Ai0r88Gko78Ztzq8MC54G0wu6kqrlfqyI3J3/5OW9pD8Jkt3S5Y
         HxcUz3dMXzQgvYJA1sxiJGMuXenkiofuSpg8VmMzs4y84lWFQ0dp0QnndpNMLLEOqSjA
         8KRbRBTLbMoEGtmacCKpPsFw6sH5gX+uoMgDTiShtsmEodsxOTGpXAPETeV8fICQVpZa
         KOs3ilRwOEC/3mr0Z2jvdUxtkM5LLliUl5sTgH8NnHJNW1dyKqtowc+hf2ArpU8ka5WC
         qfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=337aE7d9Vt4MCAtJ6+dFhSSN7Oy3DKbtxL0tnZA2b1M=;
        b=ltXpQ9QPkEXAgl4HbLdxLetuDumzD64OiBMwRNopJnmR3FUKUUK4LuKX/9mDRvP92R
         ui03loO2QOBid16GJ+lw2rOHXx6xpyhqhUqfszmVEHBXQjjlCcGaOjcxSGtdMpHTN6U9
         4gab+FGjjWNoqMoOp2sbPMGnZ/TGn9tjuxVFDlpNdKpO4PbkPdypxQSrS40G8w1wAO7l
         2oubsTTj7B+FoW7KP+putS4CX2Ao3HlyX8LKf8AA+ZIxZuIwarI1rnOgHR1+3zpPx6tv
         HswkIp+javmMnMWcFjfgTssxiFuos0P2JTVqhg3iqTjZ/jQTVZvrHSOcTpgWWTjYfAws
         095w==
X-Gm-Message-State: ALoCoQnZFB8MNjY0k344/XjdR80oENkfv77QlZljqW/G/D5hIGnXPnbeUgv7llg+V04k9QP7DuNiQR2KaEyBkD4M+NphFXcN1Q==
X-Received: by 10.55.24.73 with SMTP id j70mr6644399qkh.53.1452788806814;
        Thu, 14 Jan 2016 08:26:46 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:46 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284045>

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
 refs.c               | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs/refs-internal.h |  2 ++
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 11cd5d2..545823b 100644
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
@@ -780,6 +785,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -787,8 +799,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
 
 	memcpy((char *)update->refname, refname, len); /* includes NUL */
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	add_update_obj(transaction, update);
 	return update;
 }
 
@@ -1206,11 +1217,38 @@ static int dereference_symrefs(struct ref_transaction *transaction,
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
+		add_update_obj(files_transaction, update);
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
+	struct ref_transaction *files_transaction = NULL;
 
 	assert(err);
 
@@ -1226,6 +1264,26 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -1233,8 +1291,24 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
 
@@ -1274,6 +1348,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
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
index ed6fb22..75b4389 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -321,4 +321,6 @@ struct ref_storage_be {
 	for_each_replace_ref_fn *for_each_replace_ref;
 };
 
+extern struct ref_storage_be refs_be_files;
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g730654d-twtrsrc
