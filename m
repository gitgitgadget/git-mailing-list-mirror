From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 28/43] refs.c: add ref backend init function
Date: Mon, 28 Sep 2015 18:02:03 -0400
Message-ID: <1443477738-32023-29-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWd-0001Ts-7e
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbbI1WDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:35 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34108 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbbI1WDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:25 -0400
Received: by qgez77 with SMTP id z77so134283776qge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jj8r2SLbQUgqzT+WWGtch7sI3VahxrpdX5oZuRZj4NI=;
        b=REabTxauoC03txm1dAWNyfug2k+UuDSGsTYjWHapg5c42YcYVy823ehTD5Zp0VVUvi
         LZLBTeBRj87wSNA+DJ5yOk8V2Vocclm9Xk5YpYI2/zkmDV5d8Qf4X5lew4PL7rNjYFGx
         MXLkgJlRCW14M6UEtqU0bsPwrcHwY5jhjMsQadElHz+vJRcMiVf/jGIxvaoBtl5hR94W
         /kwiYJjZWxudWwyqQLp8/xpwEWXrn2p8eNW809ECbBes1W4i9Jae6FMAiWN5GCpKt41R
         e1ULfVbn96qc/DAIyR4d1F1hrmX1kVKjlVpt31zTh1MIuqFn41Bk+bnTp5/luCefLCuz
         /mcw==
X-Gm-Message-State: ALoCoQnkvnFNdXw6jdV/UaTMtSmblc3ErXv3/L/Ks51rfUMF3O3DI/jpnVIPNF2KL+hAXd7xbud0
X-Received: by 10.140.239.133 with SMTP id k127mr25995252qhc.60.1443477805102;
        Mon, 28 Sep 2015 15:03:25 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278771>

The file backend doesn't need this function, but other backends might.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
---
 refs-be-files.c | 1 +
 refs.c          | 4 +++-
 refs.h          | 4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 37e244a..eaa74b6 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3737,6 +3737,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 struct ref_be refs_be_files = {
 	NULL,
 	"files",
+	NULL,
 	files_transaction_begin,
 	files_transaction_update,
 	files_transaction_create,
diff --git a/refs.c b/refs.c
index 769574d..9ce10b7 100644
--- a/refs.c
+++ b/refs.c
@@ -19,13 +19,15 @@ struct ref_be *refs_backends = &refs_be_files;
 /*
  * This function is used to switch to an alternate backend.
  */
-int set_refs_backend(const char *name)
+int set_refs_backend(const char *name, void *init_data)
 {
 	struct ref_be *be;
 
 	for (be = refs_backends; be; be = be->next)
 		if (!strcmp(be->name, name)) {
 			the_refs_backend = be;
+			if (be->init_backend)
+				be->init_backend(init_data);
 			return 0;
 		}
 	return 1;
diff --git a/refs.h b/refs.h
index 0b407b2..0dc626e 100644
--- a/refs.h
+++ b/refs.h
@@ -586,6 +586,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /* refs backends */
+typedef void (*ref_backend_init_fn)(void *data);
 typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
 typedef int (*ref_transaction_update_fn)(struct ref_transaction *transaction,
 		const char *refname, const unsigned char *new_sha1,
@@ -641,6 +642,7 @@ typedef int (*for_each_reftype_fullpath_fn)(each_ref_fn fn, char *type,
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
+	ref_backend_init_fn init_backend;
 	ref_transaction_begin_fn transaction_begin;
 	ref_transaction_update_fn transaction_update;
 	ref_transaction_create_fn transaction_create;
@@ -669,6 +671,6 @@ struct ref_be {
 
 
 extern struct ref_be refs_be_files;
-int set_refs_backend(const char *name);
+int set_refs_backend(const char *name, void *init_data);
 
 #endif /* REFS_H */
-- 
2.4.2.644.g97b850b-twtrsrc
