From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/15] refs.c: add a flag to allow reflog updates to truncate the log
Date: Wed, 23 Jul 2014 10:03:48 -0700
Message-ID: <1406135035-26441-9-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxy-0004WJ-F0
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbaGWREF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:05 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:44465 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so293890oif.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4N/ch9O7DgNeWxyB31VjNV+h0bRtLSXx+vNJ0rQfpRg=;
        b=FwYk1DTusfE/MZo0jnU5odIi+X5N8Pl5W+5myu/kK0ZtbFgXoJ3j1DzT9an+T6s0A+
         QsxHscJb+Lops9RJV2m5uXFChJAJ9U9o1I5Vi6EYqR4OhqWstalUKKT5RTcf7J5+tnIW
         WLwQ+PIJyB+eEJFy3ze8il2omQMBcTd+3PEMyuVZA5nLxOTEqdl9M1dgGNVO8v/AhAYT
         KCDLRNkRvMLfoJdIXEkRaTJPp8eh5DIgtcAEIzGeZeSy0GpEGzvr8bgS8E3a32viCNd7
         hXUDIFRwG8xS4undAOBvIv2WJHClLLf7xJFhDw22yUp4oWCb/e9jACLcvwp7YiKP1ioJ
         KA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4N/ch9O7DgNeWxyB31VjNV+h0bRtLSXx+vNJ0rQfpRg=;
        b=a8bdKoHbHD3WWdB1xj/B0fT4ysRiYQ2Ciu18G1D7nqwRpJQElJiqN/qxeMPZrhYJdx
         PEzuyxh7+3NsfRF5ExY3ZOAmHcPkrcEhlyu0bzuupx4hsTbyDLFgYQ7d7juLGpo/3eLr
         +9D726hqLhgC94Kt+K3W0OfDn7e2xR3iLnOdt/ARZtojtTLNCcTDjFRXEigMIfZV1nGF
         eTxxCXbyQzb2oamTB/xN+4YM+77cU25mFSWz1Mp++aDYaV+8WLg8DpUcQukinwPufbmJ
         NmiAlmCqO8WekM34YFJB8+pEaXPcyw2WthkOqUxMzH+rv+Ok/CLs+znNW3T/NjcmTAn4
         4Q7w==
X-Gm-Message-State: ALoCoQmkkqZhrM8BiaHzr++zani13VBxAuR+dQnrM882vDhuEHhDz1HnzyQSEKgke8GjYNzUXjWA
X-Received: by 10.50.171.233 with SMTP id ax9mr1596989igc.6.1406135038592;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si487012yhb.3.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6DFDF31C34E;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2696DE0669; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254084>

Add a flag that allows us to truncate the reflog before we write the
update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++++++++++++--
 refs.h | 10 +++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index b010d6d..181c957 100644
--- a/refs.c
+++ b/refs.c
@@ -3747,7 +3747,12 @@ int transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3755,7 +3760,15 @@ int transaction_commit(struct ref_transaction *transaction,
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
index 32bc4ae..66cf38b 100644
--- a/refs.h
+++ b/refs.h
@@ -321,7 +321,15 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
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
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.1.508.g763ab16
