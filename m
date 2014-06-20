From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 47/48] fetch.c: change s_update_ref to use a ref transaction
Date: Fri, 20 Jun 2014 07:43:28 -0700
Message-ID: <1403275409-28173-48-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03E-0001eH-Hq
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbaFTOoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:15 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:35155 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so978411iec.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ig8V4VANqc1/gYpUnrtMF/AN3xtcz4Rh24gBk5w/wRA=;
        b=V7E+JVauObg1PGBUGYGUZ8kB0dfvj7cqNSPF/F7RVJcXAfWV/ntqJhDEntwv6hYW5j
         OmyrvdRxbxbi8T3PU1WkG+Yj3XjtEjufZa41KtSZ0CghL2WfCvrbDZJ6JN1OR+2LiiGC
         eJUsU2b6uOhyqJQaFYppenBxfizPxcYLgsVCwnu0JB9lyj/lngQ9FaJsiAtVI1S4gFEw
         KrAq9snqX1npmFvyWQUQ1d/2g/fJmHY1/HAluAv7GnUkCBM3zWPUl+X0rARniPIeILcB
         n7I7AtSFSrNzdDBOTJjYdoE2UPYy5ewjmKgBhTQ42eYUKkDOSaJHgCUji34BJD9wzQy/
         Ngqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ig8V4VANqc1/gYpUnrtMF/AN3xtcz4Rh24gBk5w/wRA=;
        b=EWObsweqhmCbuTQ7AbnOIKwkEfgciXV/skj13Jvx003IgTXPfSMRc1gw6DxYkZE2v/
         k0VFnPIgFLEiO+9ACjddzagRHu4LbqyeMJFTr/9OZVAIG1Ngw4KWrZvbH9gg47ygJ1p0
         FCr9qe5nxWC1A+zLES9BGVdO8gYVTpz3a6bR4YGoVpQa5EV+/NO05dVbNIY4jKrYFqFt
         hVgbmdAQqlfafMWgkmemrLyFjgumoxPHEjZ+ZujQPGiixMIrQDz27YNtVdAEedXpfZa2
         oseoVUmlQuqLesuKfhcBrPJJXUuFno0x03E6KcxzcmHKWaeh46MPZ/FJ1ktJk1f5yQ2E
         rN/g==
X-Gm-Message-State: ALoCoQkW3q/JDJlRktN4U3UamBu3eGz9r2RWYOFdVAwSMAFuwKYP1cjApQQVr04fpFRUt0uWWHh6
X-Received: by 10.182.47.199 with SMTP id f7mr1486445obn.6.1403275414210;
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si664715yhb.3.2014.06.20.07.43.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 02EBE5A44A6;
	Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D9612E0769; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252242>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..52f1ebc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,23 +375,36 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
 	if (dry_run)
 		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
+
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
+
+	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
-- 
2.0.0.420.g181e020.dirty
