From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 10/16] remote.c: use a transaction for deleting refs
Date: Fri,  7 Nov 2014 11:38:59 -0800
Message-ID: <1415389145-6391-11-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNk-0004FM-WD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbaKGTj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:27 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:52293 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-ie0-f201.google.com with SMTP id rd18so845480iec.4
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsIjdYA0GKK7w3BbuOi71zOC2bOvCrPAUEFtWgnctXU=;
        b=IFIDY7BNcJIDrzY9FuRU5sM7LtjhR1WH8s15NY25LockytI0byIjytiykfuAKYVda9
         tSuY+KLRueIJ4xf45QwAFZ/GBtQq6TfL0Fp+ktERrhWglcoPGjbPeDEu2iQ0oeeOXiUM
         mF58Xe1XykCJ16+9Cg3cSoIgqMJKSmywAm9c62IVPS8wHO4tBba0XzeLQKLD8e687yQo
         QaZ1RM+Y0ezfvtDpbAkSO5p6CFflxjX28VN/LwrptcUa+VEwpH4p7ZU1X87PREjkeMga
         h4yEyAHhK7pKgfAICMlEqQdFme/MjW27uyAyfRIZHT5xdb85+kx/B4os7b91RoHo8zAZ
         n00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsIjdYA0GKK7w3BbuOi71zOC2bOvCrPAUEFtWgnctXU=;
        b=DrdnRXn9Q+2EL2AtKsrcLe59aEZUmpvtE8RIDt9Wf8TyYv5VqLo0WbQnXSfA95FeEE
         VX6Fqs8LuzGdO7jvr0Tgtq/N4CFylWzEnLAcksO0u/FEdLWIPxH5IVI7H1yzYiGCj1SZ
         AejysD83TgZDhBn7hyl4DngmbLIx74/7SzGK2N4hWFHHKJJttWJaGzwOFAE+FpxdW5TJ
         L74kMTzNPOJR55VmEZLpCLGrrSQ5kNb+qKfM4mRugNAP+6es1Z9oqTKixTeji9laRxi8
         q1QGBaiz+ou2WdBTTCoV0v9igA8vVKmD+9KqYF3sOg552mq1DLKlKYrouZ6K9ku3aY2d
         Dv5g==
X-Gm-Message-State: ALoCoQkdqWqEihNgmWzNbekPE22zpbfKoWMPAbYbj2PgVjS92rNb7ssYsm0cd8VqTzwMUDI3fWo+
X-Received: by 10.182.216.168 with SMTP id or8mr3793103obc.1.1415389151141;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 5si402132yhd.6.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id vVk1qLwW.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C99BEE0B47; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Transactions now use packed refs when deleting multiple refs so there is no
need to do it manually from remote.c any more.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/remote.c | 80 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6806251..42702d7 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,30 +750,27 @@ static int mv(int argc, const char **argv)
 
 static int remove_branches(struct string_list *branches)
 {
-	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
+	struct transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	if (lock_packed_refs(0)) {
-		struct strbuf err = STRBUF_INIT;
-
-		unable_to_lock_message(git_path("packed-refs"), errno, &err);
-		error("%s", err.buf);
-		strbuf_release(&err);
-		return -1;
-	}
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
 
-	if (repack_without_refs(branches, &err))
+	for (i = 0; i < branches->nr; i++)
+		if (transaction_delete_ref(transaction,
+					   branches->items[i].string, NULL,
+					   0, 0, "remote-branches", &err)) {
+			result |= error("%s", err.buf);
+			goto cleanup;
+		}
+	if (transaction_commit(transaction, &err))
 		result |= error("%s", err.buf);
-	strbuf_release(&err);
-
-	for (i = 0; i < branches->nr; i++) {
-		struct string_list_item *item = branches->items + i;
-		const char *refname = item->string;
-
-		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
-	}
 
+ cleanup:
+	strbuf_release(&err);
+	transaction_free(transaction);
 	return result;
 }
 
@@ -1325,42 +1322,38 @@ static int prune_remote(const char *remote, int dry_run)
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
+	struct transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
-	for (i = 0; i < states.stale.nr; i++) {
-		string_list_insert(&delete_refs_list,
-				   states.stale.items[i].util);
-	}
-
 	if (states.stale.nr) {
 		printf_ln(_("Pruning %s"), remote);
 		printf_ln(_("URL: %s"),
 		       states.remote->url_nr
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
-
-		if (!dry_run) {
-			struct strbuf err = STRBUF_INIT;
-
-			if (lock_packed_refs(0)) {
-				unable_to_lock_message(git_path("packed-refs"),
-						       errno, &err);
-				result |= error("%s", err.buf);
-			} else
-				if (repack_without_refs(&delete_refs_list,
-							&err))
-					result |= error("%s", err.buf);
-			strbuf_release(&err);
-		}
 	}
 
+	if (!dry_run) {
+		transaction = transaction_begin(&err);
+		if (!transaction)
+			die("%s", err.buf);
+	}
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
-		if (!dry_run)
-			result |= delete_ref(refname, NULL, 0);
+		string_list_insert(&delete_refs_list, refname);
+
+		if (!dry_run) {
+			if (transaction_delete_ref(transaction,
+					   refname, NULL,
+					   0, 0, "remote-branches", &err)) {
+				result |= error("%s", err.buf);
+				goto cleanup;
+			}
+		}
 
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1370,6 +1363,13 @@ static int prune_remote(const char *remote, int dry_run)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
 
+	if (!dry_run)
+		if (transaction_commit(transaction, &err))
+			result |= error("%s", err.buf);
+
+ cleanup:
+	strbuf_release(&err);
+	transaction_free(transaction);
 	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
 	string_list_clear(&delete_refs_list, 0);
 
-- 
2.1.0.rc2.206.gedb03e5
