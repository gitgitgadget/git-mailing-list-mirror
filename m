From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 08/14] refs.c: add a flag to allow reflog updates to truncate the log
Date: Wed, 18 Jun 2014 10:09:00 -0700
Message-ID: <1403111346-18466-9-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMU-0006uT-CP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbaFRRJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:15 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:64859 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so301179iec.4
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zlT0zRTW//vpnC3om1/hdfLO5j97oxnZiIXXqBdb1kk=;
        b=gDIlApDT8vRB14ILuSdO2Agtbb4jgKrj6cenGG4KdGzl0M8pI9L8QuototQfJ7vlMe
         vgd4lEmNfGYpbaiyVI2fgyIJ92O6uIF6hYDACCz0HLaKOKS1jth4OU8XUJGpAjm4iFwX
         Oc5cThSTwNG/VFukcK4/r5s7KDXZGuPW5maPDVwMFkPHCJAs7DjaoaSm4IlMP726W334
         pvi+iMUe8FYDJSYkZyZ2vruraOtfap508XDXx23GB888MrItCSU80YFVk3wVFWvWwOEQ
         jWDRRs33DcZFPe+BN4kmVV3zQ6c+5LNx1iJJdowTkW4NeCmqPhED5pXKo2tCxX/yo2JL
         Th6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zlT0zRTW//vpnC3om1/hdfLO5j97oxnZiIXXqBdb1kk=;
        b=HoZ38vGpLIcpZ1FhfueWwCIGFt0okywNAYKJB0jPJX4FmEw8R7WydWRJ2PvErm3W93
         YDb27uSsnpabSbhvdzc3GE0VZVQ+2oiDS3uuCnYkzuOVPaqj/cRCt+NY/zD9lXPFeZ0u
         7c3oSLXz2q6n2kZEi6EreTjRHMVce8gmeqG7mUMS2PN5lgkCJzIPUWklZY4znzfUMYKD
         ffFyERRUdYxkErA73RzdRxKJFkoSA3+Bja1kNxrbQeDFV/Q1w5xbCzK5ssRP70e0kynP
         L4ccSeDL67PFZPZKIAXE0SB/g/6lR5bFe//Dl9GhEevpr4QSmlA0PJVW+hhbH+q1cPu6
         H3UA==
X-Gm-Message-State: ALoCoQmA2+9EJNRkjPcMRhNZQKM1PYrgYu0R9V541EsXkIDYmLRqyE4JGmyzbbFTwhwXagRrvSXD
X-Received: by 10.182.249.115 with SMTP id yt19mr1361571obc.25.1403111349970;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si172151yhl.7.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CD48B5A4796;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 882D7E0966; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251995>

Add a flag that allows us to truncate the reflog before we write the
update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++++++++++++--
 refs.h | 10 +++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index d673a0f..c33d19e 100644
--- a/refs.c
+++ b/refs.c
@@ -3741,7 +3741,12 @@ int transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3749,7 +3754,15 @@ int transaction_commit(struct ref_transaction *transaction,
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
index bf52068..f14c8db 100644
--- a/refs.h
+++ b/refs.h
@@ -328,7 +328,15 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
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
2.0.0.467.g08c0633
