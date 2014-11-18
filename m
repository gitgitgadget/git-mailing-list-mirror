From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 10/16] remote.c: use a transaction for deleting refs
Date: Mon, 17 Nov 2014 17:44:51 -0800
Message-ID: <1416275097-3616-11-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrh-00040h-JG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbaKRBpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:17 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54001 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbaKRBpP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:15 -0500
Received: by mail-ie0-f170.google.com with SMTP id tr6so4214470ieb.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ApJtTO4UmmhwzwBBvfoBL8d1TRHfDfQmLVpniM6PwLQ=;
        b=U7h8AjvSwuyBoMLQlJguwUGu8TZPneIYSxGf/LMEa6qTg+kJJR1FeM5gG2cnMW6IGR
         dOKS5rTQljoygH+KNtbgofkwApBJ1DKzwxHFij/kzyxEDl2nCWQc8M4oljzfnXrqBW1i
         QpZdfn5rHSyDCtcdtFVkPZPn9L0Ptrt0ZJOqEBZefLp75gdwwNX/Km9T63mzKroVI1fX
         tfykWw7PcXKKJO6OLhKxI5TByIIzDNOztKWRtsxFCO7bOCqTYoIgktGBIfh1sxOL6+Ht
         belTf2F2x8F8WygnDkG2WPtfC3PVPAXQWNoaTE8kK4vZDV6Dwe9G9UnI8xXqYRp6szyM
         tlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ApJtTO4UmmhwzwBBvfoBL8d1TRHfDfQmLVpniM6PwLQ=;
        b=BmLDgQKV+331I3JYqa/T1hgtCvl+fiGpoUiPpWk1TfozGIQu5rrqIoRpYiS0ws5MOB
         6XKoTexDWCZxfBRXGZJSbO/D9xoa4Dv11D2yEgOfajulX06sFqg+dAC1Ti2m20DI7NXK
         ZhJy8TEwJHPF3y/cSIdVEY2XGDLEiJTUE6/wPWApxSiOOis3jq/WbghZcEXSBI9FNkwt
         2rI+JHLNp3IPLgt9iKqQO/qzEZr+ut0flA3QkgB3i1RZkeBCtt4Uq1fxLdAloFc0qSYd
         Bl2KimhDJTFqYQiMg59qnDmECdROhDratPyeiGigLtE5rcTWnpPuyImDJOlEH6uaIiFJ
         y6YA==
X-Gm-Message-State: ALoCoQmp11UkdqBCsXmCBeoIfaATjO9Ix/pCqXfJT9IrpELOU+72KYdfvOUmM53zvVxSaQwqmQ9O
X-Received: by 10.50.25.100 with SMTP id b4mr29851060igg.17.1416275114509;
        Mon, 17 Nov 2014 17:45:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id xb4sm6877816igc.11.2014.11.17.17.45.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Transactions now use packed refs when deleting multiple refs so there is no
need to do it manually from remote.c any more.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.2.0.rc2.5.gf7b9fb2
