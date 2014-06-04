From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/11] refs.c: add a flag to allow reflog updates to truncate the log
Date: Wed,  4 Jun 2014 11:57:49 -0700
Message-ID: <1401908272-7600-9-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOB-0007zq-FH
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbaFDS6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:12 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:51661 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaFDS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:07 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1816213obc.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6J39itlA3/0nzm8PFxlyCKS/K/bUteHwzzEbFrUPhI=;
        b=hnD3dEl0VsQLcxwshf0WAk1vh+kD+0AmAznUzD91AGpUlma+2lvoC9x5lvTRYo7CtS
         JP2wHiIkcyoBHT7v374iE/9/QF7w+8LctKiRDf41BU954RXP79tYReX50uAIp/L0KdVz
         GKrh636IaKlRq6zIGxLnJaDJ+O38CyYox3LMnGX+rMaLerC7NezRWoFIqy3ycDjJnLyi
         +N2u46BQHGKPvD3LPH3EcRSfqy9MTpfCmB2MCyGjh6RcTmyf303CtdiMxCvZDubvzLPC
         5dKmzJPUxtoM5gMlHZ4b/Ayhdq1ZaH4Y02jbzvUR0GcM8vYobaztqrqnZB2rSn97Bx1p
         GEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6J39itlA3/0nzm8PFxlyCKS/K/bUteHwzzEbFrUPhI=;
        b=FtRQ0yHWmKpAm6qpd+tv8+QOTrkRQ91yLS8ASa5bJFDmKUrpneUuZ24sYiouHz0uWn
         C4aTjLzfbt1gUYp6f1a+aGdfUgzQE8u/hxJNhDrAxHmf/QX8E7Rko25vKyw/dnSz07El
         AxWNjNO6MdC1eHv9lxyluB65THZQ8fWbj7GwdCZXrgTT56pE/Lnk2DMIDL5BHKM1RuC9
         /WBFZMn5plRpGiDS51aQNnlqK0+r/9t+pdArPy0/vQJ1v7DVCw8IipdAUiZfHU/B+MBx
         NrmoeuKDj+c6TRC+zGe9MB16F3xxYHsaR01kTKFiAkHzRfJw2rvCcrEMijNVm0H4cL0j
         YwKQ==
X-Gm-Message-State: ALoCoQlGXqjmqtXpcBkCAqSqZeYY5dIH5PRwh8K1fEyk6HobZKwtrb3W88rW9WORjCOQ1s4OJ3/1
X-Received: by 10.182.28.102 with SMTP id a6mr24075053obh.44.1401908287019;
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si332152yhb.3.2014.06.04.11.58.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D6E3A31DC06;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 97C64E13DD; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250762>

Add a flag that allows us to truncate the reflog before we write the update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++++++++++++--
 refs.h |  4 +++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index b99fcd9..f2619e1 100644
--- a/refs.c
+++ b/refs.c
@@ -3714,7 +3714,12 @@ int transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3722,7 +3727,15 @@ int transaction_commit(struct ref_transaction *transaction,
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
index ae8a800..5748cde 100644
--- a/refs.h
+++ b/refs.h
@@ -317,8 +317,10 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    int flags, int have_old, const char *msg,
 			    struct strbuf *err);
 
+#define REFLOG_TRUNCATE 0x01
 /*
- * Append a reflog entry for refname.
+ * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
+ * this update will first truncate the reflog before writing the entry.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.578.gb9e379f
