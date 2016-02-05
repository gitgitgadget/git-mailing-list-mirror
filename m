From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 14/21] refs: always handle non-normal refs in files backend
Date: Fri,  5 Feb 2016 14:44:15 -0500
Message-ID: <1454701462-3817-15-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJj-0001Xn-Ml
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbcBETpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:45:12 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36046 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbcBETpA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:45:00 -0500
Received: by mail-qg0-f53.google.com with SMTP id y9so71847433qgd.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwSDOws+L4jIOd+yNMGDPafCEFran/RN98GWIba1dSQ=;
        b=sziId2F+Q1FYVygeQGO2kQKnLwJkeL00Pu5CbS4YYbrwrwF18fSr3ILXKMOPdUJ8EN
         Szk+1BnitqEkIPJiiaV+toL4U6EwWHO41FVBMvj76bfHaG+oXcqD0eo+9NIqfscnrbpf
         C4fhYoHVms63ifthBWMzfG/IjyZL8PTSXS8gkHJv1n/abrBVci54hygpfy6/3+rwtVDm
         qQlCYh/slvMbpcoLq60GJD3li0Xoze2silUGXXt58n3538mO5bx946YSrcWgpYq0AbYd
         zvUb6V9TpqBC96OnQTSFa4nIySB9kUmpS0G0KhrQSP6Ws9nN5dQkbhNVKQ2UArROPeRS
         a05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwSDOws+L4jIOd+yNMGDPafCEFran/RN98GWIba1dSQ=;
        b=A0mTyYJBsHHgO6038pJDHP52nTyuKuxzMYBEIVvlqnduQV0vbeBMNjbLuzW72A5jJR
         Upqz9IcCSBamWV9EnqlH7eeulpLVFAZ/fUffOkoBr5fwdbqopAnuXJf2o+h2sJby5AXz
         mHl2pmhCIL3696KE6iMPChEe4EPElR53H18aAnX/kcQKsP6DtVW2N3XHRg8SxXnwnz6v
         xwGiODixpD0j33jD71qw+KNvW0lq615xZzJ+bGdTuCkv3yNCjKRpgf/GdfhkB2dYnzYb
         AaFUsmAzUJ8HeIS4ax53YRHUrqigYw0yQ6WxLPuNVlkXCvPBxDttIA/Mzdt3KFWInnyb
         Y+bw==
X-Gm-Message-State: AG10YOQUluHoiWRZHxgsSR59m9f5fjbgZqfscTLajT0i+tFys2NYsPMJGo3R1w2q2kRvCw==
X-Received: by 10.140.236.68 with SMTP id h65mr19906943qhc.13.1454701499122;
        Fri, 05 Feb 2016 11:44:59 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:58 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285612>

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
 refs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 227c018..18ba356 100644
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
 
@@ -1217,11 +1228,38 @@ static int dereference_symrefs(struct ref_transaction *transaction,
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
 
@@ -1237,6 +1275,26 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -1244,8 +1302,24 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
 
@@ -1285,6 +1359,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
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
2.4.2.749.g730654d-twtrsrc
