From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/15] remote.c: use a transaction for deleting refs
Date: Tue, 21 Oct 2014 13:36:54 -0700
Message-ID: <1413923820-14457-10-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBg-0000wA-13
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350AbaJUUhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:38 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:56298 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065AbaJUUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:04 -0400
Received: by mail-pa0-f73.google.com with SMTP id et14so366984pad.4
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pekoGYARJhZEduCm+btpV6FUZidjIZ/OXMOcSHLfmx0=;
        b=RinpLnXetHf8oNDXVO8n+Qoeu7rLOhyllE/y2ZckteLHzXKHxpnoxJKs+x1DQTDrRS
         u421PD7RbOhgaHu3sHDp9SA7vrqsTHA61IJfL+OnhgLZqy5o0eCjkNBZsJxClzukYfCP
         4f7ImDdd+RqbAXP6iHNhd5BWnZ7prteoJblKNEbrgsWBDaFm8PSM071s7MzEjKWlkAwT
         /JV0mC29Cyvrmif9ialRFWJ6AMfXXKsPg+CMhb6g3yoQWKLNdC2rjeMCPW88oNTV+S5C
         9paxh9CBqV1l3wldqoGxiVKevZjtfN5t+w/52pRUtBm8ZNAqmUxvACmiWnDz9vRxymVI
         w84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pekoGYARJhZEduCm+btpV6FUZidjIZ/OXMOcSHLfmx0=;
        b=PovuVb3GXyho7W4VlCOw10Za5/oLeUFT97r5Bh/MESeDYu/sHH1I0Rsz68/wqVsMhm
         sJO6E674OoPAZfpa/mRCPx8sUpSiGXDcPduxDmb8Q+dlb8len9rrGL+E5SNLxZaiToFS
         SS99LtBS+lB7A9LkjvWwV7sBZ8R5qh79chgE6ESnlGFL2osBx0V5Nfec/60w5i+6BqMM
         8D+hvcUQ+NKeHqM+y9T1/Dt6ZbY/mer16wg/3AE+YcQrCP+XLwWnclKJCu/DAkfifNKE
         5TA3XzIplikrzqsHzLQ90TftfeJDmclsMnTZ4gPofPqg9R++PjiOKcN+piRbM3ZldQKQ
         BeGg==
X-Gm-Message-State: ALoCoQma7vajhsGT9K7E0TXVoKxIl0n1i/9HMZAfHm0+G6TtGU5y6z+OliSUf/Kfrfvc9y5Ho4b5
X-Received: by 10.66.250.134 with SMTP id zc6mr24254331pac.30.1413923823960;
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si594003yho.5.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id CplX6k1l.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D4C5EE1006; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Transactions now use packed refs when deleting multiple refs so there is no
need to do it manually from remote.c any more.

Change-Id: I50cf9c4ab0c190b99e2c6c4e2f05abe260b0fe62
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
