From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 08/15] refs.c: add a flag to allow reflog updates to truncate the log
Date: Mon,  3 Nov 2014 08:55:50 -0800
Message-ID: <1415033757-9539-9-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 18:01:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlL0P-0004Z6-5g
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 18:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbaKCRBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 12:01:18 -0500
Received: from mail-qa0-f74.google.com ([209.85.216.74]:43851 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbaKCRBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 12:01:06 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2014 12:01:06 EST
Received: by mail-qa0-f74.google.com with SMTP id u7so827787qaz.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqDpRL4vD6vgTX/4MSwpAgzzPSeQh/ycv3ReY+5WtT4=;
        b=BBg35C48mHq9vHfuYfzllH3vYqbomUwaJ8Cqrn5/acfgOGLkYETz7ry71tIkk1m/2r
         U7smDkyYNbWDI9dvZ2ZHLWBwSvUqoGQkUg5/hJ42ILmvmsIgQUjUO6yZmOJwrlWvGURY
         senjz985Zp5go/TMwQ2sEAvZo3e4Wdh+6IeRen4tMQ6zha6yR10z1Z1QMNupPFG2QPGk
         YcCjV7QF2m1yTsDj3cMkY9tiCDgorthi70Rr/+bmdyus4/GhRnkXPtDcaaXKpzrdBJLl
         jN+rOyMhNcUHwu5QxFAcdZyeYomW1i47rQl6b0XLq6uV2BldlnXqTtzCgy1gLETvb16G
         wCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqDpRL4vD6vgTX/4MSwpAgzzPSeQh/ycv3ReY+5WtT4=;
        b=AiSpzblZ6/0FdsuzeWRnW9m+aGVI1SUCHRbHbKDqONkW8WmxgLWRqME34TWlidoktd
         WODTXU4qWDJrsKTTDaJ2r1UOEtNNaff7DaxvoHu3cZJQ92A3tXiZsFDI6/Hm0alBRnWV
         XF4lEHJ9cN9/Tc6zxjs2EvCg5EaBh1SGbYeC2ZLyt+PaKOcntCYIDhVgQIs2abX8X3zn
         1lenl/4Pwm2BbPZguIV09OqYQ2DzV8mZoNygpK6lcJMfyOiKy4owa6fsYeepv88264W3
         Ql4R52fqyDR+NcbKZXEQONuweRkvAHt8PfkPNZywBHhdWzFe1gaNvAUD+HW7LppO2gpW
         CbXw==
X-Gm-Message-State: ALoCoQmyiH8s9SlWpbnt70fAu4ElXxc1eZXZpmvAXLR3Wx1WggtpZA9lYkKWDOLYOoLz1lPIt47j
X-Received: by 10.236.209.194 with SMTP id s42mr26511445yho.42.1415033763582;
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si959285yhf.0.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id w7NlcWZ8.1; Mon, 03 Nov 2014 08:56:03 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 30491E0F37; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a flag that allows us to truncate the reflog before we write the
update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 17 +++++++++++++++--
 refs.h | 10 +++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 100b3a3..d54c3b9 100644
--- a/refs.c
+++ b/refs.c
@@ -3873,7 +3873,12 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	/* Update all reflog files */
+	/*
+	 * Update all reflog files
+	 * We have already done all ref updates and deletes.
+	 * There is not much we can do here if there are any reflog
+	 * update errors other than complain.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3881,7 +3886,15 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		if (update->reflog_fd == -1)
 			continue;
-
+		if (update->flags & REFLOG_TRUNCATE)
+			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
+				ftruncate(update->reflog_fd, 0)) {
+				error("Could not truncate reflog: %s. %s",
+				      update->refname, strerror(errno));
+				rollback_lock_file(&update->reflog_lock);
+				update->reflog_fd = -1;
+				continue;
+			}
 		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
 				     update->new_sha1,
 				     update->committer, update->msg)) {
diff --git a/refs.h b/refs.h
index 8220d18..5075073 100644
--- a/refs.h
+++ b/refs.h
@@ -328,7 +328,15 @@ int transaction_delete_ref(struct transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Append a reflog entry for refname.
+ * Flags controlling transaction_update_reflog().
+ * REFLOG_TRUNCATE: Truncate the reflog.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
+#define REFLOG_TRUNCATE 0x01
+/*
+ * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
+ * this update will first truncate the reflog before writing the entry.
  */
 int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
-- 
2.1.0.rc2.206.gedb03e5
