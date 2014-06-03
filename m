From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 26/41] walker.c: use ref transaction for ref updates
Date: Tue,  3 Jun 2014 14:37:44 -0700
Message-ID: <1401831479-3388-27-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:39:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwQZ-00069u-04
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbaFCVjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:19 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:43735 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934274AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so1410396veb.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r+8asUe0KfDTMy64owEzOfSNu1gTy/rY8Sy6dtFgk5U=;
        b=ex2CZYNrJtm/ba5HaZF912FhicVmUUQ7UgPLlOHY2R+ae81m7sWXUTP2UE9cPYKNyH
         OTRlzk/KiBiTpqiV52eIB3lHNtJtdE0ZmfnJuquC1iLD2SqoEFVPYtfE1wEv9aNBtvVc
         KV/YrjtVIr9siJs2U8+pjkM+GoDD2C6lwq2YhgNRtppoK5j76J4mnwHFTCv1OHQBERAc
         yHyhcFiSzbOuM/eN0uIEsuuDZfZg2RHldi4etM0EZUgPX2GeWykk9In38ypR+Cz9uP9p
         8F/ewxfUCTIObArmYMJbGkDW39SiX3GIeUCI40zm7bsQfWpjcCYHF2j4CtiOSYQleeIC
         jCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r+8asUe0KfDTMy64owEzOfSNu1gTy/rY8Sy6dtFgk5U=;
        b=dIzIyChv5mTErmYjL5lF6w5haZbCqe8fZoIWI6Zveqfa/aweZ8fW7DX00f68a/QNY1
         041I5Kk7EPToGs8lIRxLrcWynsYGU8cMzaRmhwwdPHwoy1Tuz84S+mFB4+NVJLZYjh6Z
         Fij20wnKHovb5/QM7C1QQ/QpDiifUFaOTFvMWTUh5cZcyL+t8wgUutZNkKzC2KgKr2sO
         qRAN58LFnVlrtz461Uj3PcVWisS3gKhEjgNF9k8ujg1WqkSKFI9uCluORDQzNrFmqAoy
         svWFi0oLOFyT+vuVlBAUHD63Tnnhi4evtg/fiMfYQxQOHbt/dHPDNaVqPnRhoxGIvDwU
         ODOw==
X-Gm-Message-State: ALoCoQnWOlYvyVMsjK8COTtZrXYwsPeo7T1PDI9f+D7xPe95nvPY7W6BxxJ1f1OYH1xBSGA/IU5h
X-Received: by 10.52.36.211 with SMTP id s19mr15671616vdj.7.1401831488067;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si28757yhp.6.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C2FC931C435;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9F6EFE043A; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250658>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collissions that the previous locking would
protect against and cause the fetch to fail for to be even more rare.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 walker.c | 59 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..60d9f9e 100644
--- a/walker.c
+++ b/walker.c
@@ -251,39 +251,36 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = NULL;
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
+	if (write_ref) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
 		}
 	}
-
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
 
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
@@ -294,19 +291,33 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, ref_name.buf,
+					   &sha1[20 * i], NULL, 0, 0,
+					   &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+	}
+	if (write_ref) {
+		if (ref_transaction_commit(transaction,
+					   msg ? msg : "fetch (unknown)",
+					   &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+		ref_transaction_free(transaction);
 	}
-	free(msg);
 
+	free(msg);
 	return 0;
 
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
+rollback_and_fail:
+	ref_transaction_free(transaction);
+	free(msg);
+	strbuf_release(&err);
+	strbuf_release(&ref_name);
 
 	return -1;
 }
-- 
2.0.0.567.g64a7adf
