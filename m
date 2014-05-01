From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 24/42] fast-import.c: use a ref transaction when dumping tags
Date: Thu,  1 May 2014 13:37:24 -0700
Message-ID: <1398976662-6962-25-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxlg-0002fU-0I
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbaEAUjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:39:40 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:58878 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbaEAUhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:55 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so665216oah.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sl+ChriClu3ISzDraOlX8WJenuKFJi1ah/vzGJaV8O8=;
        b=UAhvfJiFP39he3MNX84RLcwD/PG+QxjOgo0y0YKKCClbl4efcc9zTRQvujR80HHoq1
         eYolusHE+tnjSyZ4UEv+plr6k6mbj27xZOyl8kaEKBshlDg7c2z+xxKK6OdG9Zjr9a47
         2foxFwxSDhGzl5AmPaK/IYD99QYF/3R3zjt/W8QmoDeLWVVohWjel0l27CIFK/tMrt+l
         ws/kSYd7iA6I6kEt9pEtVOE1+zuk6Bsd33SqcKyF5TbMMnejrp6MuWVPn+90lQ3rXTCS
         PY/iT2Lu/GKDjSZVp9jCcml4fT/0t/lUU9XkTww9LekrypnuvfRbWUmhnkOoAANrOtI7
         7TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sl+ChriClu3ISzDraOlX8WJenuKFJi1ah/vzGJaV8O8=;
        b=fDtBFw6mEDeISYHWvCPt+dkMdhGPHSZoSGTimq5zM03HYK8p461orxA0Tw4kC2JH2E
         poaDLQIkTjK4SJCBoYAzES2pwZq87iVVmC2ttDMEnlsbA2dkiOJWUFsv8vRnldFoDa20
         Gk9euf41AHETMJ6ietUMCQTRjR/id7RSwgeiOFhKKd9woA6MNgBkfVUn6pWWpBabpYSK
         Ls6EVyvqrbSFm0WnT+FOzZh6D5EM30viu9odCZcOdVwOLtXGxcwvD0vYDPcSlKmsMMIc
         JWlI07tOqS49iuRZEtpbUlRe17frrSmmLSTNrBx+kgZbaspTny0ixpeoTcvw8yYIXpfE
         DxLw==
X-Gm-Message-State: ALoCoQnAwWvY9gPcYNS5fmBj44Cb8O0FWB6nrtNoMcJdMwqOuxCXBNEwGlKVPV8NlxN4Yi9hCXDL
X-Received: by 10.182.28.99 with SMTP id a3mr7025674obh.40.1398976674856;
        Thu, 01 May 2014 13:37:54 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si3536892yhb.6.2014.05.01.13.37.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:54 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B0B2331C1CC;
	Thu,  1 May 2014 13:37:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 758CDE097F; Thu,  1 May 2014 13:37:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247861>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3e356da..5587cf6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1736,15 +1736,22 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
 	char ref_name[PATH_MAX];
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin();
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		sprintf(ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name, t->sha1,
+					   NULL, 0, 0))
+			failure |= error("Unable to update %s", err.buf);
 	}
+	if (failure || ref_transaction_commit(transaction, msg, &err))
+		failure |= error("Unable to update %s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.rc1.351.g4d2c8e4
