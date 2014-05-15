From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 26/44] fast-import.c: use a ref transaction when dumping tags
Date: Thu, 15 May 2014 10:29:41 -0700
Message-ID: <1400174999-26786-27-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUq-0000B0-IA
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbaEORaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:20 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:49674 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so257135pbb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OfPMm+BBnnJ5vcp4xR5ay4clHmVY52eJ/uMFXYX6hoA=;
        b=MJXT8TYZlZJq15Wvrw9Ajo6Nr50HCddMo8n4ikgtDveiHJxWiA3sDahDPUuPb4YY7N
         3H6djFjh+z6XOC2vUp8/FVQ1uz1juQDamJRu33x/9A5qngIxfc41k0hMkfa7H9hPEQEB
         brSQBq/vKXeEZG9pMfcgzu8xqRko8aHQSYVsFZMls68Or3uAYse/5gIjLH7uqS+cSbgp
         Mr07zsIJs2Y1jGcQDFMOKYzlAgH/B3YvfUQUuX0C59odERnwsNVNwC8MpzHAwekC+VTd
         5Vkyx1brsQDffBj+eHoOUVojJk3kcV3G5wJxauLXE/mWSEgnrjfdBKc5xacyyH/yLR0J
         mhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OfPMm+BBnnJ5vcp4xR5ay4clHmVY52eJ/uMFXYX6hoA=;
        b=jZzkPH1srZmKSS82SrC/CVHmXjMKqT/OrKLblC/WH2lmuFoFbAhMiXrjfUDdRumP8F
         VnPEre512BEiEtAwvHA5Sw/p2yUjB5l3qWtxBiC95lOiOeDYvb3Y64T906TgyWoPbNom
         aEM2mxYsO/Tdw6nIFboGINkYdszbFPVPxtwVwLpu1JSZzk9ilm4R84x2slXBWmZ467A4
         gEwfAamPxvhMhbUXy2dZwhFuTG0MHsXFhsBICtZ5bCGzVqmpywz6WC9mSNat10PHNKzZ
         CgYFOnqzNLSix7zXnIKRl0xNj5N21NJ5I0ueYjDWWbmHoJ/ZWNIfO7eWICvyXYTVSx53
         8yAA==
X-Gm-Message-State: ALoCoQnoc+8yk640RObMrcrqna3tiGt2xyNAvs2+3vmsQyRvXn9roi8hl6z7PelYkbvdKTFQLgwn
X-Received: by 10.66.121.195 with SMTP id lm3mr5753793pab.24.1400175006866;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si273665yhj.2.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ABA7C5A4263;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8767FE1747; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249135>

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
2.0.0.rc3.477.g0f8edf7
