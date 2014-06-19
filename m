From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 25/48] replace.c: use the ref transaction functions for updates
Date: Thu, 19 Jun 2014 08:53:07 -0700
Message-ID: <1403193210-6028-26-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeet-0006GL-5k
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101AbaFSPxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:43 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:36337 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so296269pbc.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=odz+blmgX2tnLj+S90sqWE6DouQYXBKv0ZfnazSyujE=;
        b=OKUzK0Y9TcdzWrHkyYnQ+AdXfBQhrZiucXshXJrCYYRBoXwy5a77rhCFttaNHOEqlF
         zLJ7fuOzlE/Q1BS8hTxaYqzOF3czaHM1TqzevvJqung+fzr2sO3/5AN5x/jELjHWRvSv
         x03A2CLzhOMdny2giqMw7/4ujWTvi+jIqU8iKlQttQWiYgDfIoRCa5y9baPmVf4Jn+o4
         2uzIBal+yHli72QFgdLGE+7MiHTatXAo05ZX5plU/Sm4N8wmMFippzTM+foA7dJdo8GX
         6h5nGaU8XeuXwVp0kp0HPJB94IUF0z3a3HOM1D+dZXavTf8gfF3RXTgXHlTOuZCtVnd9
         pSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=odz+blmgX2tnLj+S90sqWE6DouQYXBKv0ZfnazSyujE=;
        b=h52kL57h6JCFOEO8E0gLkNTp3G8Rs/0mxeLUvlzPB5nE4lLi+uA2wF2wDr3+SM6mOh
         fSzckPZhI/7PNdUGQZFKF4j8vCyQI5zfItNLg74FveFWxtRyJWUwOzmP1wJKO1zj1GrU
         EmYi9enzcTxw2O3rZTj2i4ET+pMl2nuRnsNZOoGt66gjDJt/CPOC4HYzyJgSOcPp+Vdu
         3xuLGaSkrHvkflCZ7u0C1p4aYaKGwMVqUTDZCrp+z5Y72UMdmODqUezKkoE7M1SX1lHM
         pxmbT+Uyq6xd0Bo42+s5xEvQveDtM9A2UcjgPEUQdi06hbvNRbZWFlmfcKTRR1a91Igo
         IQeg==
X-Gm-Message-State: ALoCoQn7PqLlV6uvclRu7dKmccvBd0s0xdPRS9IbThPchXGNVu6bTUMw3ni+fTlDF5v4uKBzGVkw
X-Received: by 10.66.142.9 with SMTP id rs9mr2622539pab.47.1403193213700;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si418318yhl.7.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 837A931C485;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 61E15E0FFA; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252119>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..054f5ef 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -153,7 +153,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -166,12 +167,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
-
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
+ 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.438.g337c581
