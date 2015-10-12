From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 19/44] refs: add a backend method structure with transaction functions
Date: Mon, 12 Oct 2015 17:51:39 -0400
Message-ID: <1444686725-27660-20-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2h-0005nc-NI
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbJLVwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:37 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33115 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbJLVwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:33 -0400
Received: by qkas79 with SMTP id s79so63028568qka.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KJN/tjCHVpyEXd9CALKuS3g7xCiN6oh2Si+ERsaQPPo=;
        b=NoCJoSku+GYOTsM0NP8AJlMu95A0vyhcvYZe3E4KSz7G99UgkVQxdibFGKKH3R+we1
         b2tAZbh10PhHB1A20m88xEqLPLw4pjZfiXnh4cYwojQe9/OxMBSAOzAX9GAEo3GdXe6q
         LrBU9YP57fSXrpmzaAlsmqrSFQmHSw/jj1yvwktSkJETmhG0HUOaoTOzqybVEVsIiaLp
         jRKatNV1/sDuW4Ki7KnAq67he0DMS/d+TcqqNcNgWWpgBb42uBofQxY4GNqucMnPH/XA
         aED3nl4L+k1G5bR6SjOiRfJyFd1YFSU67PJhyBA3Ibpv4kBYwdG+/MFUjNIoTNMbYYrh
         yETg==
X-Gm-Message-State: ALoCoQmg4Jh/crfXLtSEuIlyN3APt/nbkEzBcv7/6mJ5YEJaUwXTtk2KN2Mn669ZgEI/bMmV64SU
X-Received: by 10.55.33.35 with SMTP id h35mr34883859qkh.71.1444686752817;
        Mon, 12 Oct 2015 14:52:32 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279456>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for backend methods. Start by adding a method pointer
for the transaction commit function.

Add a function set_refs_backend to switch between backends. The files
based backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 10 ++++++++--
 refs.c          | 30 ++++++++++++++++++++++++++++++
 refs.h          | 15 +++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 1308955..3050f1d 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3225,8 +3225,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3612,3 +3612,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_commit,
+};
diff --git a/refs.c b/refs.c
index 25ad3b5..f930fe0 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,29 @@
 #include "cache.h"
 #include "refs.h"
 #include "lockfile.h"
+/*
+ * We always have a files backend and it is the default.
+ */
+struct ref_be *the_refs_backend = &refs_be_files;
+/*
+ * List of all available backends
+ */
+struct ref_be *refs_backends = &refs_be_files;
+
+/*
+ * This function is used to switch to an alternate backend.
+ */
+int set_refs_backend(const char *name)
+{
+	struct ref_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 0;
+		}
+	return 1;
+}
 
 static int is_per_worktree_ref(const char *refname)
 {
@@ -985,3 +1008,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      NULL, old_sha1,
 				      flags, NULL, err);
 }
+
+/* backend functions */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_commit(transaction, err);
+}
diff --git a/refs.h b/refs.h
index 4940ae9..419abf4 100644
--- a/refs.h
+++ b/refs.h
@@ -619,4 +619,19 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/* refs backends */
+typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct strbuf *err);
+typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
+
+struct ref_be {
+	struct ref_be *next;
+	const char *name;
+	ref_transaction_commit_fn *transaction_commit;
+};
+
+
+extern struct ref_be refs_be_files;
+int set_refs_backend(const char *name);
+
 #endif /* REFS_H */
-- 
2.4.2.644.g97b850b-twtrsrc
