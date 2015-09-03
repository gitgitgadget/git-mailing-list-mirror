From: David Turner <dturner@twopensource.com>
Subject: [PATCH 33/43] refs.c: make struct ref_transaction generic
Date: Wed,  2 Sep 2015 21:55:03 -0400
Message-ID: <1441245313-11907-34-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlr-0006tn-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbbICB4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:54 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34471 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389AbbICB4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:16 -0400
Received: by qgez77 with SMTP id z77so18754094qge.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IqxlKZs60BjOWHFaVmOI5lASnuWR0L4VbfVNf81Py2I=;
        b=MwpBMCPxPn/AdHrejfUttkkY8TDipKYJmCusbzkPlE8CdTCgQMw4HhvUBujCehG4vP
         V/2LzlW4IStBc3bhOBiG22GGPZP9WBTyfN2XHRH2unBjH0FaPCpx16C/qmiJnLhdj6EK
         iEu9TrWYhkZYgzF3mI/2C6Dqu0m1+V/QAi4LMvdBYZBKSVp+PJ9c+HSosvQPrIuyNvFY
         K9vEseT1X+yGPYTIaccTVSg0ipmVO4dru7cZkphwRPfoWQrVDB7SzBSlrt2a8ffI9cmg
         lQlly31tCdIzwnKcr00mPqslm2D06mvZtTeBAI7isjte3zRD4ona+JxXxWPsn1hHND32
         jXpg==
X-Gm-Message-State: ALoCoQkmB3L+pIVm7Gf+kMM+1GRz7lGbWDR+YRTcMfMeqDuMDd9kwiot1GILjATtcWWZvEOMCY+v
X-Received: by 10.140.34.33 with SMTP id k30mr2336122qgk.56.1441245376239;
        Wed, 02 Sep 2015 18:56:16 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277164>

Alternate ref backends might need different data for transactions.  Make
struct ref_transaction an empty struct, and let backends define their
own structs which extend it.

Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 20 +++++++++++++-------
 refs.h          |  8 ++++++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index acf35b5..af99666 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3202,7 +3202,8 @@ enum ref_transaction_state {
  * consist of checks and updates to multiple references, carried out
  * as atomically as possible.  This structure is opaque to callers.
  */
-struct ref_transaction {
+struct files_ref_transaction {
+	struct ref_transaction base;
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
@@ -3213,13 +3214,15 @@ static struct ref_transaction *files_transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
-	return xcalloc(1, sizeof(struct ref_transaction));
+	return xcalloc(1, sizeof(struct files_ref_transaction));
 }
 
-static void files_transaction_free(struct ref_transaction *transaction)
+static void files_transaction_free(struct ref_transaction *trans)
 {
 	int i;
 
+	struct files_ref_transaction *transaction = (struct files_ref_transaction *)trans;
+
 	if (!transaction)
 		return;
 
@@ -3231,7 +3234,7 @@ static void files_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-static struct ref_update *add_update(struct ref_transaction *transaction,
+static struct ref_update *add_update(struct files_ref_transaction *transaction,
 				     const char *refname)
 {
 	size_t len = strlen(refname);
@@ -3243,7 +3246,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-static int files_transaction_update(struct ref_transaction *transaction,
+static int files_transaction_update(struct ref_transaction *trans,
 				  const char *refname,
 				  const unsigned char *new_sha1,
 				  const unsigned char *old_sha1,
@@ -3251,6 +3254,7 @@ static int files_transaction_update(struct ref_transaction *transaction,
 				  struct strbuf *err)
 {
 	struct ref_update *update;
+	struct files_ref_transaction *transaction = (struct files_ref_transaction *)trans;
 
 	assert(err);
 
@@ -3334,10 +3338,11 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-static int files_transaction_commit(struct ref_transaction *transaction,
+static int files_transaction_commit(struct ref_transaction *trans,
 				  struct strbuf *err)
 {
 	int ret = 0, i;
+	struct files_ref_transaction *transaction = (struct files_ref_transaction *)trans;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
@@ -3501,10 +3506,11 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-static int files_initial_transaction_commit(struct ref_transaction *transaction,
+static int files_initial_transaction_commit(struct ref_transaction *trans,
 					    struct strbuf *err)
 {
 	int ret = 0, i;
+	struct files_ref_transaction *transaction = (struct files_ref_transaction *)trans;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
diff --git a/refs.h b/refs.h
index 3134a28..e64d3c4 100644
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
@@ -622,6 +625,7 @@ typedef int (*create_reflog_fn)(const char *refname, int force_create, struct st
 typedef int (*delete_reflog_fn)(const char *refname);
 
 /* resolution functions */
+typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
 					     int resolve_flags,
 					     unsigned char *sha1, int *flags);
-- 
2.0.4.315.gad8727a-twtrsrc
