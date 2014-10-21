From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/15] refs.c: add a flag to allow reflog updates to truncate the log
Date: Tue, 21 Oct 2014 12:24:15 -0700
Message-ID: <1413919462-3458-9-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf2w-0000LV-T9
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbaJUTYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:39 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:36984 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569AbaJUTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:36 -0400
Received: by mail-ob0-f201.google.com with SMTP id m8so281465obr.4
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cxv5pQqom/zWMNr+YzlPxqEI4lEjRI4LhNUaFKtXGss=;
        b=Gw6AFZ0tERiaGdNU4TgG+YquTplbaVmEk4d8H959QWcd+NriTk8O2lfbZ22LiLYvyg
         fHK3XSTc8IcdwDFfR3lrKCNIM1PidvtzahgrSTb5sGCbT8TQfxufXdi9XADMf7P4qCYF
         VX9cEvWgniz8CqkMH4nC5ojhfIBvwS3MF29QEsWjHoh+COxjsPW4ZyHdCGAyYC2SLaNz
         4DPrDOqMJOl4/m1XfLPtnirm7QGhlZ8BwtRIlDA3pE2PDDheBnCqzkGdBZuv9oujGWqj
         JxB4c5ltFmz1HIPLFGTO4otOKtSX2vzJGqyQ7LCxOKd4RsMYNdz1J2ljAEdyFIVzghn3
         O/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cxv5pQqom/zWMNr+YzlPxqEI4lEjRI4LhNUaFKtXGss=;
        b=mHQ1/l1QYq+gptY4IZgvnF6MNs2SzC61uOx81J6bfDkGuPxrzdB+DpDV451h1CTrtM
         RdfJrz2yS+RrghaLlr3L29ZEoaRDsXS4MBZnhTd+Ei9ljLC9X/P766JgPrsTcVUbWCA7
         jKXKCqL/NuIvD7QU54ajUOVs7eIvm1bW5Mzl/MuATFX907zJ+bBmG9xxqOwdtmEtR7R+
         sfAaFKsE2sifuW1uspf7+pD9WxzglU4hBrV9Ey3Iw9lqSPlFHLdlgkfO8nTavTmroCRi
         bEHd3nhfsMFM8Tb7PdANPHtttWV0oNU1Rqu4PusvYTpGNm0Euxps74yckuf2l3ZwCB1L
         oA9w==
X-Gm-Message-State: ALoCoQm64qON9jawnAkTOLhxKFd+jr3s0hJ44l/zNB/wm946r4lSkPk6klDKG/C4Y0Tt3D2yhxnA
X-Received: by 10.182.72.163 with SMTP id e3mr7529352obv.27.1413919475530;
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si583532yho.5.2014.10.21.12.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id ZQLnXLXF.1; Tue, 21 Oct 2014 12:24:35 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 799FEE11B0; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 8d0a342375fbd926ae6ae93f9be42a436a787fb6 upstream.

Add a flag that allows us to truncate the reflog before we write the
update.

Change-Id: I187b22e0910499b1976689b46866698b6fd46eb3
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
