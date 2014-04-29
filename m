From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 23/30] receive-pack.c: use a reference transaction for updating the refs
Date: Tue, 29 Apr 2014 15:19:08 -0700
Message-ID: <1398809955-32008-24-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:27:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGVD-0001nm-TU
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbaD2W1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:27:48 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:58885 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbaD2W1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:27:47 -0400
Received: by mail-yh0-f74.google.com with SMTP id i57so115716yha.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+XIkyrY+E0RRQ3X5k/eRSZP7QPoZ+li8N3WuzW6vXU=;
        b=m3Vgv0fQbj0J1OR980bjGboTqGlUURvbZz0UD+R3Gx+Lk7J+QEd4EVenyrkTaOFxOu
         K5RQZqhKWg9V2i7FOTqpv7x6BQfVO/37XXKbZoPZjFcLdErkxxUsT62A4jBpmNgKA2bb
         QCax6NwfxYzehm+qW5I8ddIdnUVskJf+vikbsowhm5i2H3W03HMdqP7S78Ad9GHaGQQd
         DpX5F3woT79N7fEEgUOxoqm/j6YyjL2eB0SVuelpFVXKv9KWeB+dZHcEaQ1Aw68BfQe1
         iOZVKrodjrKntd4AexiLmYu5mLBVbwldu++1qII7zBjeVKLPzd2fp7i8b1mJtvwMWutv
         xoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+XIkyrY+E0RRQ3X5k/eRSZP7QPoZ+li8N3WuzW6vXU=;
        b=Url7aVUM34sVejGcyEmUbWmhYvgcRSrC/PXn9+s6gNvYUCU2My5fyhMBRhWnhkhZa7
         dxMfwUTHylpZeAJxofm52PbDz5ucRm6WyHF1XX6/9kuulviBnNB4J3GYrnPiX6sQYIWJ
         iAExSBuGHXnEMzFP17GkPTFGkr4fsJ2IbNAG6ZUNOLZ2VpdWGUcrg6iwHkyYHBfu8GzL
         KKwa7wdZBu8JvxP2GeTv0B+w+Mr5nR/1ZxFt8mGtcdeJPBeD2zQEEPSq/fxiSfxZBQWl
         gwz5mP49KcKsTDQHvXJ4xY3JltOE/IV0HQqLUoPDFIwImpInkWq4gxCB2uE7vxDDY/g9
         tUyA==
X-Gm-Message-State: ALoCoQk93TbG3BPdl4qSXA2G3Coq2OjQVGGLjhMoveEsBXdT50Cle5vU4ZNDSmivbyClPwO9cojT4FQC4hg2OJpWFLeJivnSVu7H7Jxix21SzGNA5P09tuc4Eh2R6DQyBIkLjk7llJK1NCU9YEwFni7zjMwRfXUQ8WzUJ/BpglTFfCVx0AW0BFuNfzD0gnqft7VFbK9WOwV/
X-Received: by 10.58.105.105 with SMTP id gl9mr286919veb.17.1398809966930;
        Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si2739707yhe.3.2014.04.29.15.19.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C46B55A4121;
	Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 89A2AE0B2F; Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247659>

Wrap all the ref updates inside a transaction to make the update atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..d580176 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+struct strbuf err = STRBUF_INIT;
+struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
-		}
+		if (ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1))
+			return "failed to update";
 		return NULL; /* good */
 	}
 }
@@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
 	checked_connectivity = 1;
+	transaction = ref_transaction_begin();
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
+	if (ref_transaction_commit(transaction, "push", &err))
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
-- 
1.9.1.532.gf8485a6
