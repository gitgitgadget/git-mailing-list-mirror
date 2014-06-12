From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 33/48] fast-import.c: use a ref transaction when dumping tags
Date: Thu, 12 Jun 2014 10:21:24 -0700
Message-ID: <1402593699-13983-34-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8jb-0000k6-Qi
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933633AbaFLRX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:28 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:51636 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so186198pab.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROfogJMWQs+03QJUlwVPHRxno2eNGWi5HR1XFBcv5fU=;
        b=ezQVevVX7Kn+R1zglVEYL4a77TYXQs/MWKxgZw59SgsbZT1cy0XIiRQhDHh+N0w+Vh
         0YHeI9R+pKNeZqdN9MXbDG3eNV95L5zorwc+fQeXbPPNg+3/LjWeAIl06tU5Oy23If5R
         QspysLI2mQ+kBdo1kBH/5ZRsp4Ghlvs9VIjFHWvaaBRx7MX+l74nSgoCPFOKq9V88fu5
         ttCuxz5p6m4PN9CihmpA7jBq2u5cOnA6z1h6MegJ2nw4MZOhkbfMALUC2PD9cmDSHeQ4
         CtQ5NOw1KxfAJZsjiyPBaNW2qXMYODtoE9AwspojtqHKJ6GrE0FiXMA944gDhrJi6+7E
         eHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROfogJMWQs+03QJUlwVPHRxno2eNGWi5HR1XFBcv5fU=;
        b=GX82wjfZAenQ1q9AQ6vXXZFdQq65IKR/b4+Zk5V7yKUaJSL/Jb2ob7qiOcE1wzcav1
         BsGqa8FR+ZwJ0uAYbFzZltav655V08rPkRVSxBp1uGDHGvF/6BNdNX1i5xuIS9CvSDPM
         ODp9slTLCsBZIy7mAZcjMuy09HsVRVRzEi/XXVCiv0irHVgSbxYhqa9Au55CNx7CIw2q
         morjD/+eC0TJhwn59nSbQrJqeq3uVX3QklKsbx03YdfMnQj0EYN1Y19GEP4HtAVsVnw1
         wtYSQ4iV0lQ5X89Yuw0uvT26CwYn9UGUfTAw0t+RoDQnRKn3qqGMa/K/lbjdWpROHx06
         j2eg==
X-Gm-Message-State: ALoCoQkBjiO5X1l7iJ5KuNubucHzggara2+6mYBCP0MA/8zhVeOXlNelBFlq3joIVSK1j5Xb6R9/
X-Received: by 10.68.137.99 with SMTP id qh3mr5186605pbb.2.1402593704592;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si113018yhb.3.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 62DE05A4749;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 216D3E0C3E; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251456>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4a7b196..587ef4a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,32 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.599.g83ced0e
