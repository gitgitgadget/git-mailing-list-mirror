From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 34/43] refs.c: make struct ref_transaction generic
Date: Mon, 28 Sep 2015 18:02:09 -0400
Message-ID: <1443477738-32023-35-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggX0-00020w-54
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbbI1WEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:16 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35101 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbbI1WDb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:31 -0400
Received: by qgt47 with SMTP id 47so133561893qgt.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t09uSWv6E1Qek7L4vv4eT9xrzkv8ozsPnk07WPgAG3I=;
        b=d9y21tp57pfIdOAQ03UMQM7hj5DCi6JZ1vAIBz52Dhex0tiHjxcq31AWBwyeBIPmBp
         ywBsxwXARMsWn4l3ZzArHWFGJAlUh+Foq+aDKn8Yve7OUhCFDec3SOWbjsUXybIXsYhk
         1WfC4/awU9mTFlsbup9ttOLOeIoEyuEvgknHbdkVUbndDa1Eu4/VH5DQNKQKOGiqcfMO
         qQTR73tCxyTEZ5BY6BWPFiIzWeaLdsOyrNCJvdumi5JdUBbCCfsKvI3v6m5AKXOCvhAb
         BP0FAqgXL0gH+S8Z2tUyIAQRdiGLh2iwZujYWmI2wNO0XqjLZboK+bZpH1dNvS7Kkpo1
         gDIQ==
X-Gm-Message-State: ALoCoQlpFhsbDduvqEaqX2Pf//1q+GtBKW2Mnm3Rj01hQNF2QmVq+cwQHLcOKWBB459pjZgjAAW9
X-Received: by 10.140.152.68 with SMTP id 65mr26302488qhy.16.1443477810899;
        Mon, 28 Sep 2015 15:03:30 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278780>

Alternate ref backends might need different data for transactions.  Make
struct ref_transaction an empty struct, and let backends define their
own structs which extend it.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 24 +++++++++++++++++-------
 refs.h          |  8 ++++++--
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 0a76c8e..3f2d194 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3218,7 +3218,8 @@ enum ref_transaction_state {
  * consist of checks and updates to multiple references, carried out
  * as atomically as possible.  This structure is opaque to callers.
  */
-struct ref_transaction {
+struct files_ref_transaction {
+	struct ref_transaction base;
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
@@ -3229,13 +3230,16 @@ static struct ref_transaction *files_transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
-	return xcalloc(1, sizeof(struct ref_transaction));
+	return xcalloc(1, sizeof(struct files_ref_transaction));
 }
 
-static void files_transaction_free(struct ref_transaction *transaction)
+static void files_transaction_free(struct ref_transaction *trans)
 {
 	int i;
 
+	struct files_ref_transaction *transaction =
+		(struct files_ref_transaction *)trans;
+
 	if (!transaction)
 		return;
 
@@ -3247,7 +3251,7 @@ static void files_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-static struct ref_update *add_update(struct ref_transaction *transaction,
+static struct ref_update *add_update(struct files_ref_transaction *transaction,
 				     const char *refname)
 {
 	size_t len = strlen(refname) + 1;
@@ -3259,7 +3263,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-static int files_transaction_update(struct ref_transaction *transaction,
+static int files_transaction_update(struct ref_transaction *trans,
 				  const char *refname,
 				  const unsigned char *new_sha1,
 				  const unsigned char *old_sha1,
@@ -3267,6 +3271,8 @@ static int files_transaction_update(struct ref_transaction *transaction,
 				  struct strbuf *err)
 {
 	struct ref_update *update;
+	struct files_ref_transaction *transaction =
+		(struct files_ref_transaction *)trans;
 
 	assert(err);
 
@@ -3350,10 +3356,12 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-static int files_transaction_commit(struct ref_transaction *transaction,
+static int files_transaction_commit(struct ref_transaction *trans,
 				  struct strbuf *err)
 {
 	int ret = 0, i;
+	struct files_ref_transaction *transaction =
+		(struct files_ref_transaction *)trans;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
@@ -3517,10 +3525,12 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-static int files_initial_transaction_commit(struct ref_transaction *transaction,
+static int files_initial_transaction_commit(struct ref_transaction *trans,
 					    struct strbuf *err)
 {
 	int ret = 0, i;
+	struct files_ref_transaction *transaction =
+		(struct files_ref_transaction *)trans;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
diff --git a/refs.h b/refs.h
index 64dba64..02001ef 100644
--- a/refs.h
+++ b/refs.h
@@ -130,7 +130,7 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  *
  * Calling sequence
  * ----------------
- * - Allocate and initialize a `struct ref_transaction` by calling
+ * - Allocate and initialize a transaction by calling
  *   `ref_transaction_begin()`.
  *
  * - List intended ref updates by calling functions like
@@ -156,7 +156,10 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  * The message is appended to err without first clearing err.
  * err will not be '\n' terminated.
  */
-struct ref_transaction;
+
+struct ref_transaction {
+	/* ref backends should extend this */
+};
 
 /*
  * Bit values set in the flags argument passed to each_ref_fn():
@@ -629,6 +632,7 @@ typedef int (*reflog_expire_fn)(const char *refname, const unsigned char *sha1,
 				void *policy_cb_data);
 
 /* resolution functions */
+typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
 					     int resolve_flags,
 					     unsigned char *sha1, int *flags);
-- 
2.4.2.644.g97b850b-twtrsrc
