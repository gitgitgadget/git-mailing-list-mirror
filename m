From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 11/17] remote.c: use a transaction for deleting refs
Date: Mon,  3 Nov 2014 11:02:13 -0800
Message-ID: <1415041339-18450-12-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMtr-0001Xv-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbaKCTCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:39 -0500
Received: from mail-ig0-f202.google.com ([209.85.213.202]:42738 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaKCTC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:26 -0500
Received: by mail-ig0-f202.google.com with SMTP id r10so784915igi.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsIjdYA0GKK7w3BbuOi71zOC2bOvCrPAUEFtWgnctXU=;
        b=dPYBWcyvJaTqolrraZxh2wPBdFfq4dlNxuCC2pJ/NhTzCRsz4MnMTmWLxIinOZaeRj
         MJA6WLEzkaXuFWd8L3zvg+ljziF0cRB8gs/B6Ga4H4GUxS8aVhA5xSfIJJ7hMiSUztjv
         GRlegec/Gr1wUkhYHkKRBruNglsRlomaWS4qmdd4sNXfcFkZ1Y1HULnlAnO/kcym7Vvu
         KBJy8sTmsXhx/VtcV/P0m88q7uTtm065W+9RMu3B20qNTuMvGb4Vf77GItVEqTV/29FF
         Yoe/9LEtjUNu/vODvzQpt9JtsXal9BbUbxDwyIEQNZiNWjVSV3MAHcTfeYuiGU/69kkV
         9o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsIjdYA0GKK7w3BbuOi71zOC2bOvCrPAUEFtWgnctXU=;
        b=injMQeFsty1dmSPTu4vGmny2QEX3bpS5vE3NLCkMUora/lSYQx5GXYtxGXvklTkemz
         c1fiEca9kwpjeQnpirpAn8GvZF7+GXpMmNuqiWa9dfytuegLqd8W3Zg/rhtjmFVxgpHu
         x8VXaoZJ2KspdeML8y8rgrnVF7qTdgx/YNgNbs9+hojOrCzornegHNp/WzZPVgnFD8hd
         9pKoYuWixwkmbbYidL0q0EeTLqTQuK9A1j07oJ9KxgjFIpEukj5hkMXlMbeMWg3Q3AKO
         mzM9KXXnrh+TK2o125SyGYABgokyFRwris5ljkUbLlULDKRHR5Ppp+fZ4BxfW1OWsR4c
         3FDg==
X-Gm-Message-State: ALoCoQnrMhnBdPYtjtm5hAHtYV1Y1x2vUahtn+0ttm6NEH/hZeqDTKQe8sqKB29KHlR8YooyhD5t
X-Received: by 10.43.73.6 with SMTP id yq6mr19761858icb.14.1415041344436;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 5si167261yhd.6.2014.11.03.11.02.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ZOcXATcP.1; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 02063E1081; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
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
