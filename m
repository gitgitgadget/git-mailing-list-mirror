From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 31/44] refs.c: add method for initial ref transaction commit
Date: Mon, 12 Oct 2015 17:51:52 -0400
Message-ID: <1444686725-27660-33-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1c-0004jW-Th
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbJLVwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:50 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35604 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbbJLVws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:48 -0400
Received: by qgt47 with SMTP id 47so129535651qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vpWaWRvLeQ1XXBErH4sgbVOjmvPDhQ3S+03pAK3/rKM=;
        b=Aow3Y3AFv8sCVKJY3yrd67ZAImqDnRTrXHFkJnGuTw8gQhjq3LfgVHYcQolhVi/Gsr
         sybJQ4fkQSszczErqr9o/HovpifpoC3h9I67vjxwYl7bBGRvTyXqbokgGNf+GmPgajiJ
         B550PFSxxZnbI/Uhz7i88KFm4P/f/MJ5m3LgDiIf7xuV+oQrCNNA4aZHWJiejtb3qrB5
         zqlZTkeoJSBWM6oRb7cjLRWdsfSgSpjTiXLJjjP5vcTVRqXdt6MuIySG5+e0Yc/oumCy
         f0Xgo+LRmXUK5sb3aCSlCqvwHtgOovNRUXL6e8EO93j0jzcjHAPKp+xJmg7qY2bX+yZU
         XldQ==
X-Gm-Message-State: ALoCoQmg+2qJYzkINs7V8KKyl7cwpVcOR+x7slxW8TNq+bbSD8e+nEc6Dz/Jihy5+4ogqnUmzIir
X-Received: by 10.140.101.110 with SMTP id t101mr34895899qge.20.1444686767910;
        Mon, 12 Oct 2015 14:52:47 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279434>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 5 +++--
 refs.c          | 6 ++++++
 refs.h          | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 104e90f..7560a55 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3317,8 +3317,8 @@ void files_init_backend(void *data)
 	/* do nothing */
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3543,6 +3543,7 @@ struct ref_be refs_be_files = {
 	"files",
 	files_init_backend,
 	files_transaction_commit,
+	files_initial_transaction_commit,
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
 	files_for_each_reflog,
diff --git a/refs.c b/refs.c
index 304fead..6e41ed8 100644
--- a/refs.c
+++ b/refs.c
@@ -1250,3 +1250,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs.h b/refs.h
index 5888877..e3136ee 100644
--- a/refs.h
+++ b/refs.h
@@ -738,6 +738,7 @@ struct ref_be {
 	const char *name;
 	ref_backend_init_fn *init_backend;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
 	for_each_reflog_fn *for_each_reflog;
-- 
2.4.2.644.g97b850b-twtrsrc
