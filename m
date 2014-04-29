From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 24/30] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 29 Apr 2014 15:19:09 -0700
Message-ID: <1398809955-32008-25-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNw-0002Us-2w
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbaD2WUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:08 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:35210 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965287AbaD2WT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:27 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so201683iec.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60Qz9ZwW4oXJ9R2Bw2npeKEmYTSNGDZpfsqju8BlN6E=;
        b=IrqDBghfAj8bHZU9BMc/z9z93uT2tKYZs2My9tAKwexkPDU2cI2x8NPtiTWttFVo9s
         ZdEtpE+nZb8I92YOqCIl+MsAz5kneQ2lIT6IZDcL9a4tjwwatuTLMA+QDMZ/CzLAtZCq
         VBnNOAYmIU/vfsBMJkUFehKumX4utdlWbBFTYaX2hYNOMDNcOY+5k8TI4h4X7V+VJb8N
         I3wZEKDHSOAmUSfL/XQbmHZvODCPktRFVJ/qN3w1HyyVFwoOoGWN6v1HZXnHy/8zJ6Vn
         c2bdWfR65JIQuQ0FIFo8rpsXkBaeuj6hG38Yc/aYRc03EyvboJW0+bRuh69Xnhm/ZgQa
         qhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60Qz9ZwW4oXJ9R2Bw2npeKEmYTSNGDZpfsqju8BlN6E=;
        b=jSMItS+huQxO8p6qgPffsgu6pMDaSGls89q+MEmA13ri7osGHUyRuCJuNg9mWZQPjh
         3y40aDLOsidMfp4kUNtWBLUSn3kteJ9r9Od3vhJ99rw5vOClmtNMFM3PTUJlATVkI8PA
         23zmF44wcCMO+HSX5Fp3e2WJfQffA9XYYtc/UCrQqEU7+nnO5WPt/GN3LXXpSxGd6eHy
         obqaI+G99PQNV9waJqYYegiJj89c4QUvFB5GYKgJ5o5y+HTWdHEIdSApL6UaOrs/IoW4
         t+iBcqiaxpgFQf3s3v1ZPLz9ZXGBJkN4UzF38QT+2xNKECOi70foWic1yJFm1v/b3WWW
         kfcw==
X-Gm-Message-State: ALoCoQkP5VyMvTGfjEGrBPy2SdyuPMxj2M47/PZlX4Zta2uwSrx+b42uRVZhlo90foYIQgkPcAqD4mwK0MSHU1C9OZlzipKLnk50n5GgmoTwxiAxig1neKJT+uWxHrt0BYRoNMwTKC6FuszYQjvQtwkcp7m0FU2p5U0LNAX9LFaSxOfr533FMegryN1NgiuTVYAesbT7d1JL
X-Received: by 10.43.141.196 with SMTP id jf4mr284783icc.9.1398809967407;
        Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1813131yhl.7.2014.04.29.15.19.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 36D3D31C1D2;
	Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EF9C2E0A5B; Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247638>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b3c6a04..bd73a6d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1731,15 +1731,22 @@ static void dump_tags(void)
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
1.9.1.532.gf8485a6
