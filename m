From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/5] remote.c: use a transaction for deleting refs
Date: Fri, 25 Jul 2014 10:55:24 -0700
Message-ID: <1406310926-4080-4-git-send-email-sahlberg@google.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjiq-0002S3-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934604AbaGYRzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:55:52 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:59628 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbaGYRza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:55:30 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so1310003ieb.2
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rndSDUXkAZYhPik4s6GQkSSTAfrp9UNL88367k+QI5g=;
        b=DG+Zxs2EJDZ2xh9gvSyw+XC+hZPaABk9J4J54Rl9SPyVOOv5D6LzfaPezfNa9MKt/8
         7QIQn/068h6Ys389Gtzs0/Ae8tQtvBeTYCch5DTnuIU2cWFT1jx/XW+MAS12jurKNmIE
         anhCWlCL9TiI+5IuxfMEBitqcK/Tg5GRX1rsmalcTnFy0//JGP4atGMYlscrSVrA3jEz
         qOBUFR71oXOWsM3VtPBGQCt8XvaDhNyAkGG+oXxA03bS77dW0ws9yzYpN1TXKBdbo35p
         G7wyMwXwYIXMmpAK/p8tm53Vrk67Loq47Lkvt2wrOmT+T3isN1a+rLdpJUoGMv0NiPhc
         QZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rndSDUXkAZYhPik4s6GQkSSTAfrp9UNL88367k+QI5g=;
        b=GRaSTxC15IfQQhsDfBs8uJOiBt1j84cf78nQ/zz5kkKLdPW+sNK1nivy9pADOmAnmp
         O91eePWHbUrFdzaCHq8wsI31pms/9UFEk/C9vMf5LoSz+S8I66PneLjkhq13XhN6Z61H
         cu9pEty7jthIH6fDhA+jtBDoWAjHZiBAMYMOnuCFjgrSRtllQvf1f5Yhsg274jVQVwcj
         sxKBmlMtXBoLoI0AQwhO1hcNbTNIKphwA8C9+WzzxxF6rVb8HuObwrBId6Wow/0Es6xC
         ywBf2lIckVibJE3XQRPkM69Y2gN4fNi3BedLHP/wE3O45G5fyCeMd7GmQf7keFPc9H+H
         HOuw==
X-Gm-Message-State: ALoCoQl3vdh/gzYHqdxU0EwzR+XT6mw9Gvn+Uw/nsG7da7FFc9b7YpvsVPDJLrvovNvn0Ifk3/qO
X-Received: by 10.42.94.69 with SMTP id a5mr9498015icn.29.1406310930090;
        Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i5si199748igg.0.2014.07.25.10.55.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7397931C654;
	Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0895AE0A73; Fri, 25 Jul 2014 10:55:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.518.g4f5a8ad
In-Reply-To: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254248>

Transactions now use packed refs when deleting multiple refs so there is no
need to do it manually from remote.c any more.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/remote.c | 70 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9a9cc92..3e6ef08 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,25 +750,27 @@ static int mv(int argc, const char **argv)
 
 static int remove_branches(struct string_list *branches)
 {
-	const char **branch_names;
 	int i, result = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
 
-	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
-		branch_names[i] = branches->items[i].string;
-	if (lock_packed_refs(0))
-		result |= unable_to_lock_error(git_path("packed-refs"), errno);
-	result |= repack_without_refs(branch_names, branches->nr, NULL);
-	free(branch_names);
-
-	for (i = 0; i < branches->nr; i++) {
-		struct string_list_item *item = branches->items + i;
-		const char *refname = item->string;
-
-		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
-	}
+		if (transaction_delete_sha1(transaction,
+					    branches->items[i].string, NULL,
+					    0, 0, "remote-branches", &err)) {
+			result |= error("%s", err.buf);
+			goto cleanup;
+		}
+	if (transaction_commit(transaction, &err))
+		result |= error("%s", err.buf);
 
+ cleanup:
+	strbuf_release(&err);
+	transaction_free(transaction);
 	return result;
 }
 
@@ -1317,10 +1319,11 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0, i;
 	struct ref_states states;
 	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
-	const char **delete_refs;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
@@ -1331,28 +1334,26 @@ static int prune_remote(const char *remote, int dry_run)
 		       states.remote->url_nr
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
-
-		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-		for (i = 0; i < states.stale.nr; i++)
-			delete_refs[i] = states.stale.items[i].util;
-		if (!dry_run) {
-			if (lock_packed_refs(0))
-				result |= unable_to_lock_error(
-					git_path("packed-refs"), errno);
-			else
-				result |= repack_without_refs(delete_refs,
-							states.stale.nr, NULL);
-		}
-		free(delete_refs);
 	}
 
+	if (!dry_run) {
+		transaction = transaction_begin(&err);
+		if (!transaction)
+			die("%s", err.buf);
+	}
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
 		string_list_insert(&delete_refs_list, refname);
 
-		if (!dry_run)
-			result |= delete_ref(refname, NULL, 0);
+		if (!dry_run) {
+			if (transaction_delete_sha1(transaction,
+					    refname, NULL,
+					    0, 0, "remote-branches", &err)) {
+				result |= error("%s", err.buf);
+				goto cleanup;
+			}
+		}
 
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1362,6 +1363,13 @@ static int prune_remote(const char *remote, int dry_run)
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
2.0.1.518.g4f5a8ad
