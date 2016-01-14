From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 06/20] refs: add method for initial ref transaction commit
Date: Thu, 14 Jan 2016 11:26:03 -0500
Message-ID: <1452788777-24954-7-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkK-0002pO-T1
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbcANQ11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:27 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35251 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609AbcANQ0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:38 -0500
Received: by mail-qg0-f45.google.com with SMTP id o11so486488831qge.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZN4EgECgk893Yqv1+vYyK2RQZjAMUFwdqlfBPjYxAxQ=;
        b=rg7sUNEUWzbiLtVYp9v5nPs91IE1e6NbHEPsaF6T18gQKmSXSrBcsyqj+wwHVS3rhK
         7NE1iLuyh2i69bfVnzfVJyVJbbC8U+sSwMQ6SqfyA1zEImsElhuSkMFjJLwZWabnvWHE
         WM551PW3xIC9OCgPRSO62PU93DiMaKSrVQquoTWKj9RepFY2GX43RD7z0RjtQD028so+
         ktu6GjK9pMYy75Mq+/NQHR7U44xnoEbhJzi7dkT+N5hfSt1Bbu1LZyrgr7SOHWjS/VvM
         oLdqLTAeu+SvafJQje2Q02oYrOMKDKYTPFB9a+q/Hkbs8EpF1wsJMppBvNp8yPkBgz7d
         QJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZN4EgECgk893Yqv1+vYyK2RQZjAMUFwdqlfBPjYxAxQ=;
        b=hcC4XZNm7dU1MwKiuSCmHGjhDrWyMUbCmc4Qc0l4qB4XDs2FyOQr9lnvs/hIEDxdqz
         C836dilCiHyUgD8+TqiHPCnmoqR06g9hjeY4rpsoOlr9YOqIQqw8WedOnixXrWpUWwnP
         VRwYY8bzSV/6cYF18VfcPxB7qsXOps1bnSlMMqWvNg2X6N0viIrAGCJl7Q/G8rgolByO
         5i+5DHkAK9x9hO+2dzCg7H5YuYIfgggN8M34KUBU4LC1QowbTXqD4sVvSHno+XnLciR5
         XLSFVRI5pD10pfooyBCMLGMBWOVwf2i+OOG3KofiGRD+I+QrCO0ppDmHFlEtFo+lVnlO
         6eZw==
X-Gm-Message-State: AG10YOT/T+JT5JSyBcIOgpmIerz/RDf92qVEO1Z+NO8dqfcHgqOI5MiCIJ4C6NOwneCckQ==
X-Received: by 10.140.224.199 with SMTP id u190mr2779203qhb.33.1452788797922;
        Thu, 14 Jan 2016 08:26:37 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284051>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 36b4666..f492fa3 100644
--- a/refs.c
+++ b/refs.c
@@ -1247,3 +1247,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f13b111..748993f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3319,8 +3319,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3544,6 +3544,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 87f2274..26b707e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -267,6 +267,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
-- 
2.4.2.749.g730654d-twtrsrc
