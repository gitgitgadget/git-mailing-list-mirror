From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/11] walker.c: use ref transaction for ref updates
Date: Thu, 17 Apr 2014 12:46:27 -0700
Message-ID: <1397763987-4453-12-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:52:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasLr-0004dh-S2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbaDQTwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:52:00 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:56802 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaDQTv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:51:58 -0400
Received: by mail-qg0-f74.google.com with SMTP id i50so42597qgf.3
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KVDQ/tfEsPF3C09lYXB0+s/MJaHuZ0pvh69iRmH1wjw=;
        b=dJ2wx85ILlRV112JF3sIKHXdsgVFXdAj0pW4M/HrCxNhi5F3RS2wRRZCbWN1+GwCz6
         bEMbTkyBBKeoK4sR5v9BEZRJiLIx6aBi41x1t/S2KMsZrdiX2Am1aQzdiDq86naIAS+U
         gXqGDxSZ3xyyV4v9QaL21122VEjhHIBmvt2KCXmhjsJ4NnNrQnu4HoNzD7p6FvkLa09h
         JJQxWvLADJbdfhyxRMWNBI+Sw0odtmhC5LBN7zTFVHGBZZVOIpXv6WPPe/D6x/6q+hSE
         bQLgIXnuKVsJVq5EPwJhGl7ENq2Z9PFJuZXHrXEN1GCqHyd7nKUw2hJWkOnz0LnfCo/0
         L3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KVDQ/tfEsPF3C09lYXB0+s/MJaHuZ0pvh69iRmH1wjw=;
        b=JTgandTcLf7dOuT2f6Oh2varf/jcW0mWUvAvw3f6SUA8LvJTrVAz0U5Kiz0k7iupFF
         FrpOnrHyNF/GmO1FG8Mq24fHz43BF6D426rSQ7Qn8NzHPPkJY/QdIwz0Wqus2LFXm3hD
         iXNn2ODF3EbJDMgv2zX5/jUzILALqlB/HPRNVJFM6gRhnkkogBd2GwiubPc8OjWnpvRR
         PZvTqfgx5VEWfcbzSdaFfWVLcPvCuQIbG7ClpjePnc2bMdj0R3vcdMDJIuUycKg+7YxV
         zrC21e/dVPjQDuv7SO17S9L7iH3YcK6/Liwn+mqVKxUsxgasZzPTOpPbZCoR7mmvK+8t
         PtPQ==
X-Gm-Message-State: ALoCoQkneM7A6AL6wFC/xPIoc0/WdLAmvL7+2nAXJg9IjTDVBWlHvj0SMFk+dKFKa9GYHU8UoVeDo33Qn7e2wT7/nI5G2bFACtmJ5Nu5sib3IqkuDuWG/qehXKmkzjeX7s3eVBNKw20iPyKHwFcrLrVs/E+4gwZQpZSQZlwz/jEhJtNsBnl/Ls+t5sxGW1BoUgaYXxqmCsp/
X-Received: by 10.236.94.238 with SMTP id n74mr6743504yhf.27.1397764008749;
        Thu, 17 Apr 2014 12:46:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id f65si3652302yhg.7.2014.04.17.12.46.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 983455A4252;
	Thu, 17 Apr 2014 12:46:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5C7C9E0967; Thu, 17 Apr 2014 12:46:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246447>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 walker.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..fa02d09 100644
--- a/walker.c
+++ b/walker.c
@@ -251,24 +251,16 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	struct ref_transaction *transaction;
 	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
-	int ret;
+	char *msg = NULL;
 	int i;
 
 	save_commit_buffer = 0;
 
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-
-		lock[i] = lock_ref_sha1(write_ref[i], NULL);
-		if (!lock[i]) {
-			error("Can't lock ref %s", write_ref[i]);
-			goto unlock_and_fail;
-		}
-	}
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return -1;
 
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
@@ -276,14 +268,14 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 	}
 
 	if (loop(walker))
-		goto unlock_and_fail;
+		goto rollback_and_fail;
 
 	if (write_ref_log_details) {
 		msg = xmalloc(strlen(write_ref_log_details) + 12);
@@ -294,19 +286,22 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		if (ref_transaction_update(transaction, write_ref[i],
+					   &sha1[20 * i], NULL,
+					   0, 0))
+			goto rollback_and_fail;
 	}
-	free(msg);
 
+	if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
+				   UPDATE_REFS_QUIET_ON_ERR))
+		goto rollback_and_fail;
+
+	free(msg);
 	return 0;
 
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
+rollback_and_fail:
+	free(msg);
+	ref_transaction_rollback(transaction);
 
 	return -1;
 }
-- 
1.9.1.513.gd486896
