From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 3/5] remote.c: use a transaction for deleting refs
Date: Wed, 30 Jul 2014 14:55:39 -0700
Message-ID: <1406757341-4096-4-git-send-email-sahlberg@google.com>
References: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:56:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbqo-00087L-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbaG3Vzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:55:48 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:50094 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbaG3Vzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:55:44 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so345366pdj.4
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Vymd5SzAdB0bU8sPU9KEcm6wPAsp9Vyy3NtHBIN6CQ=;
        b=i0TarHD2mYNtR/pp4RoMayqWIdNq58No/44Vusya3QefluBZYBSpaZOX7sjyMolJz8
         DiIRI4R/0U8FQzRJ5UzdEiZ4KnnK0M5203S3NOImm+9OOoJX16sOHr+ZNHOvmPzzHm5g
         U9ZL1Aprzdne0iY+3ye2QKW3zsr4FSWb8IJTK9OKLDyIwb5uDmeMuQEopzwUduiAmbFP
         21t4zhXk05dF2VoF8Dn2DKWpDIK3AIeAv6a7TcXjEUJZuS2UbMFEflEzTlunFI881tZf
         WdEY1Lmh4WwbLvmR3KcOdL4CN/s6LFleCZyFWMRGBw7XWH36KpOQdjguSyiPMatbwoew
         hYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Vymd5SzAdB0bU8sPU9KEcm6wPAsp9Vyy3NtHBIN6CQ=;
        b=D7o2AicxI9HZ0wP/5V5FrrVSloIicyF8UO5QRWvGD/PPfnXD6DeHX8oy7tICaD7vIu
         LlhlDayWVgTr9Ng6hxJnnxS4MWYGgditNAze+iHKxvBNqvZeaWUZLbn1d4ilpgIqZ6oH
         lJ7oFse+rbju1ySspOQ4mvbN5mG/7BrEgHhvT0L/5xGVRqBD+V12jXL/RbJ6FAKMwG6P
         fRBxtKPPX6s1uTVm4rdEOXMbpmN19wSJDT4QUd2RoGnI/OXXVZqWNemif+jiuo9pNCBk
         Fo+9GtjhPHw/V2frtH8yTh57sOcOyxn8xwm2ttBDdHhb1m25wRfRyXl3GHqm0jLg5oPz
         /6EQ==
X-Gm-Message-State: ALoCoQlh8heswnZidiTOul9Y5zHI32tLGyaFjlnPJL0KbAzF4v6zEs0XSHiFq+5D631Ag+txpemc
X-Received: by 10.69.31.75 with SMTP id kk11mr2916746pbd.8.1406757343436;
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si227393yhg.1.2014.07.30.14.55.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0EBE431C538;
	Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A640EE06CA; Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254525>

Transactions now use packed refs when deleting multiple refs so there is no
need to do it manually from remote.c any more.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/remote.c | 69 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index bfcc823..3e6ef08 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,26 +750,27 @@ static int mv(int argc, const char **argv)
 
 static int remove_branches(struct string_list *branches)
 {
-	const char **branch_names;
 	int i, result = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	if (lock_packed_refs(0))
-		return unable_to_lock_error(git_path("packed-refs"), errno);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
 
-	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
-		branch_names[i] = branches->items[i].string;
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
 
@@ -1318,10 +1319,11 @@ static int prune_remote(const char *remote, int dry_run)
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
@@ -1332,28 +1334,26 @@ static int prune_remote(const char *remote, int dry_run)
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
@@ -1363,6 +1363,13 @@ static int prune_remote(const char *remote, int dry_run)
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
2.0.1.523.g0041e8a
