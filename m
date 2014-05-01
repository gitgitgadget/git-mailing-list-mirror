From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 13/42] commit.c: use ref transactions for updates
Date: Thu,  1 May 2014 13:37:13 -0700
Message-ID: <1398976662-6962-14-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxm3-0003BI-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbaEAUkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:03 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:50012 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbaEAUhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:51 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so667598pab.2
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5sWHPMtWUAFtc0/CtVWbp0TUUlfGY2mDh6Xnm8LomLw=;
        b=edWah/V4aZyXF4N+9m3FOphDAjpsElHLTUuZR+kzDAqPBlrpYCnPF9tqHYH1j/eK9w
         Zl9GpvEvLWuRfN0zzQV9Cyr2wtOXqah6s/s9qZ/RbwDkT3rmTG8A2lOv2sw0QTjEjfPh
         ClC86xvn9N/QWLNLpyKfZku0ztyjkTBiQ/3OHyGy6BN+w81rIVEnWnu1i5AlmvBOMhvn
         wguVWY5Qeo87DLMgwXunh1GsjZzHH5tzbFfqwlNlfqKJ56EXfIbNAW+5B0kPEaOCXKYz
         lXAG2CRqBbOwqWkgopoaW0MihAvEDvW+L2Hs1kx09PO93Scx69PGIAqE7DEBTfbn0pM+
         ZIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5sWHPMtWUAFtc0/CtVWbp0TUUlfGY2mDh6Xnm8LomLw=;
        b=j94kWXgo4VmAatGFGIP1v8n4GaLIIhiDXbO3aNxJ0i6KCh49LrMgly6Getgcv+xrys
         YVEVE0XuXVJ6QJ4ME6Jv59zB8Izilutw7Q+VdkHRrhGKUDDR5velxCRz5Et6nTosupe6
         MwJaCpnSAjw0tNhxmSHFyiWA+VKUuHScXcUHr0U1U6AgzrW3isbQh6ptEbhRsh9PYAVf
         W75LPrYk2Gmhk7eXIua8SKB1tX6EmW6eM+NXqsKTkFqk82r20H+JNMAkPFfh1sIZvU2U
         KgG/kOjNvdT8dv+MJd56kjqwNdoMGxl6z8KfkphfFlD1IqRYXQN0SspAD0eei5+ndJ55
         U6bA==
X-Gm-Message-State: ALoCoQlNXZUjoJLy6eSVGPiFE9TGXnRXSAryx4JQ8V+lSegt03rIUIeORszloKPkW5ZERlNiT6G9
X-Received: by 10.66.190.202 with SMTP id gs10mr6856343pac.0.1398976670426;
        Thu, 01 May 2014 13:37:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si3104368yhj.2.2014.05.01.13.37.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 41CDE31C1CC;
	Thu,  1 May 2014 13:37:50 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 052D8E097F; Thu,  1 May 2014 13:37:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247867>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f0b7906..6117123 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1541,11 +1541,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1667,16 +1668,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1685,9 +1676,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ?
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die(_("HEAD: cannot update ref: %s"), err.buf);
 	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
-- 
2.0.0.rc1.351.g4d2c8e4
