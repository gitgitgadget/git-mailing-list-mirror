From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 36/42] refs.c: pack all refs before we start to rename a ref
Date: Thu,  1 May 2014 13:37:36 -0700
Message-ID: <1398976662-6962-37-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkg-0001Qi-CS
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbaEAUie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:34 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:37505 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbaEAUiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:00 -0400
Received: by mail-ig0-f201.google.com with SMTP id l13so72003iga.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/aqgYh92QtUFnQatr48DNkE0GMPlcCg5fkBVVEmhOp0=;
        b=TF6gR/P8aL5UmHlKUTuKuzV/KkrgKPG6FgqlcXVig12V2xG+zvYo8F4ExMH01WJ46m
         Wg/7eTD39fcm/8nc5d9W6xUK3Of5GBgvQrjBkaZj3YXGU6ACvdvSEkpsyU1cGAhBoHx1
         Q9l6W2MGekyMK9Vze9nWy+hDwRw4I5tKzjrd3LKvfqN9tjTx/TCY6BfnSOJSGb8iPlAp
         o4aOr+Q4+RFa+3ybQcEyCdTe+eBuHlojXlBAu6K3fN1xPDveQPkIOj1TQZTs1xPJV2Sj
         QBnZi/fvh5Sx6UJnKejLUrboQKwQvoGgwpTlGb0ibrpvyIaHnkrSdFskHRpZEY/4He1t
         GATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/aqgYh92QtUFnQatr48DNkE0GMPlcCg5fkBVVEmhOp0=;
        b=G7RmUW36+sZMwTER9x9rUdKvvt0EIoAFXwn9wX8laGxYRr2QJXAgXkkGaR6Udm3fia
         Ow/Un+B2r4yicI5InfIkzI3EzyFQG1CDfuTEIWu8I58ztvHZ3rnp5LGD++iN8uwxr4N8
         SUqZUqm0F44F7BSaKZ4ACbFzmNEYK+udvltXdJ6kHZiYAIiyQgyKluYO9itdv7kGrtgP
         YraqZwOBLeoOuo46Y93z36NNGRSBpvdp++MEeaHPKZYCxsum2omUyFrlFGSjvl6fAoeq
         dyLhj8mbiS+ts8qagOWm9DB5FabfaBc2lO1j7ztDcDX6lrc8VZ8RDm12RBur9D1qcOHj
         5yNA==
X-Gm-Message-State: ALoCoQni2u+IXNtV8emVYXcf5/BUtFk9eCrG1KvBtpnSdHTvxGbladuerNyAvp6/hnEjgA9bq0Pq
X-Received: by 10.50.136.198 with SMTP id qc6mr2458545igb.4.1398976679520;
        Thu, 01 May 2014 13:37:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si3537147yhd.5.2014.05.01.13.37.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5C0F131C1CC;
	Thu,  1 May 2014 13:37:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 20F19E097F; Thu,  1 May 2014 13:37:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247848>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e1f919e..14d1573 100644
--- a/refs.c
+++ b/refs.c
@@ -2595,6 +2595,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
+	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
+		return error("unable to pack refs");
+
 	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..fafd38a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -289,7 +289,7 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
-	test_path_is_file .git/refs/heads/master &&
+	test_path_is_missing .git/refs/heads/master &&
 	test_path_is_missing .git/refs/heads/master3
 '
 
-- 
2.0.0.rc1.351.g4d2c8e4
