From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 24/40] receive-pack.c: use a reference transaction for updating the refs
Date: Fri,  6 Jun 2014 15:29:02 -0700
Message-ID: <1402093758-3162-25-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2e5-0002R3-Cc
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbaFFW33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:29 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:33871 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so740919obc.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGhKcgAvclY7YKgUtjHXSmGsCnNrnkSKJLa2dySgvQw=;
        b=IH9fm35Mzt2Gz3urJ54Fu1FTwSLmBc0K0J48PXeYCMHpg3Yi81vW9VdVfk8xNoyCRp
         ktv45WT/+TQ4ZIGGo5FLNaXdJp69gTrZtl74Ot3uB4tUNnva+/R6aVoMkj9ehdzoTkdR
         tbOHiuH79ZEekbIpXudO52tqzjVMge9GBkvDxUbGNM+EwVCT+yDjr/91EqKP9YH0STaj
         TeGzjceN+m9+SjMb9yqDT3K08s0BBDVyd+T5Kro9uOUifrk9apMgN5PNH2dqaAMBTR9M
         XGOdkVBKsx7w6Q90FSV+lLvSIMQ0V7FnJfOHaZtZ5SAdTsB0QEd/Vo2s1Hu5xniRL42L
         lEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGhKcgAvclY7YKgUtjHXSmGsCnNrnkSKJLa2dySgvQw=;
        b=ccjKwSeOe6A1avRr4wqAw6LaIwFEpk1a59R36aQvS3felOOn7ZDub418sZgNZfUEpE
         PRaL0Xq/wzoRz2griw6lwFdGmRq1bek5mFQ7h3OMG0uCehjFyeGG17yVARpnxaOKneJl
         URXmnk2O9cOsnxVQ5RGL/ajJRAlNrqwqPzG4zcRkDD36ud1HohU5tW8KCYEYIEci02OZ
         PrI9fqv3nBsKVqXuwnbFp0YhvUngt/mERjhceEsdGC0NSJ71guPQ4vJulrsTpfTuY/gH
         idyfJKJxDcvhWja41x7roKd4uz6mdrlHvl8aivzbuwHn0n/cUYJbgnUUBAbnkz1dtO9Y
         iwzw==
X-Gm-Message-State: ALoCoQm7XqtManP4Iv5+8umPNkJwV0XerugwRES76YfmwaFspYZEEYm4gRD/m1HYhc8fY3n+VGsO
X-Received: by 10.182.20.17 with SMTP id j17mr4571583obe.24.1402093762578;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750434vdb.0.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5518931C62A;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3350FE047D; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250984>

Wrap all the ref updates inside a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..13f4a63 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,7 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+static struct string_list error_strings = STRING_LIST_INIT_DUP;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +476,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -576,19 +576,31 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
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
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1, &err) ||
+		    ref_transaction_commit(transaction, "push", &err)) {
+
+			const char *str;
+			string_list_append(&error_strings, err.buf);
+			str = error_strings.items[error_strings.nr - 1].string;
+			strbuf_release(&err);
+
+			ref_transaction_free(transaction);
+			rp_error("%s", str);
+			return str;
 		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
@@ -1215,5 +1227,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	string_list_clear(&error_strings, 0);
 	return 0;
 }
-- 
2.0.0.582.ge25c160
