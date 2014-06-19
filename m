From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 33/48] walker.c: use ref transaction for ref updates
Date: Thu, 19 Jun 2014 08:53:15 -0700
Message-ID: <1403193210-6028-34-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxegf-0008R7-A0
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbaFSPyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:52 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:49866 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so331522qcv.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhXtkG37Twf3pmtN1KJEURdxLPvZkCeeCdO2vHbpWGM=;
        b=WyaqRx55qmY17Bf6OAMsVbbJlIZcQqL3edqNdWERUSxwaNLNBdqOZidCdUv4XGnGoZ
         UK20XbitcGSEuVQjJw1bwAxN5aIVfTx4fCCeHlsnrlkagIPQ2lCZGVOBMIvA+i97AgUI
         XDh3RgIDhb8YyIkWPAAJG0K3f2AYDJeoXi5lyTr+gxrzUn7xqPJYPIm8Jk3eFIpPdmxD
         DNwrm7Gy/UPZCVEx6iwm7JcnPzRuFFU8NMXr/rWJJ9U/sMNpqIknUrmL3/Up4X0l3255
         cdK617b3Lyr5g4l3TQHtc4PhN3agyjJnE+c/QSiI524czdSfsCosdM9+teCwUFfXUnOi
         YYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhXtkG37Twf3pmtN1KJEURdxLPvZkCeeCdO2vHbpWGM=;
        b=FXHHPd31L2h9Z3Z004CrERM73p+KFhjoM5pDW8vBj0E+myA6sa2kFanXU1ocPpiKH2
         gDerKuC1FYSb0Ou20xheEasZAIl7GzlwldC19OlFCCwFFyJWEYVyfHrKOteX3UlMDVRw
         vbLrBcGdkIldOCZ1hay7pgXx0hdQW5T+MrVilqvwACwouQr/YyjvrUjWuiidw+qxhsFE
         X660iIIMZwiVP01NKPnMTGU9d5mAnhIbYfCHbfdo8HRmLndfxpuAZE8jY4px9buwJKNN
         ZVvrZprbuVV8bPTmp3PR3pHCfWtZHcE5ouPk6F9XxxzrDB/mA7EZHSelQE6/LPLNua+x
         jg7w==
X-Gm-Message-State: ALoCoQmL8jWNA52CGwAzWmO86KPCrI6L+IiraEFVZsXkyeUqJ4yE7ab2aqBUbN/+/Jx6mmnC2+nv
X-Received: by 10.58.195.162 with SMTP id if2mr2647981vec.21.1403193214270;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si419494yhk.4.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0346D31C3A6;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D3D5BE0ED7; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252145>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collissions that the previous locking would
protect against and cause the fetch to fail for to be even more rare.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.0.0.438.g337c581
