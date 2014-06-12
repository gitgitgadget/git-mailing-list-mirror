From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 26/48] replace.c: use the ref transaction functions for updates
Date: Thu, 12 Jun 2014 10:21:17 -0700
Message-ID: <1402593699-13983-27-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8jj-0000uD-2w
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933725AbaFLRYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:20 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:39343 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so310164obb.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mIPPTR9QC7tGzfX8pVaR/V4CaYgNAAL2fvArr1Z1a84=;
        b=SVHMr18xos0foXuLVRhFph2V++KGDpyCCH3W4TAhK8trJU8RNIDl21Jk0QgFIhzGTF
         hwQvJ5MV/o/zUm1UZObn/qtL5bDiDo+O14UXDZMeyAhr0SbzWv16REiyXKckBVpEeIpC
         V4s7iRmTxWhNcnfY3o7r6vk87JnZNmbkB/orwVNz4aIcytlvXe3qD6nafOmTb2eukNju
         238P2YZirh3PGlECKiI70UnbhaWx2gCQuK7pR0/ZY4fzUqo7CQ0avtxL0D/os5uR/Q/o
         NaZ2/fWV9VJRrr2coePqP8LXs6GA1vYAgYJwAktkn869Gavphg+3efJdru4WX0ERSXWS
         MotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mIPPTR9QC7tGzfX8pVaR/V4CaYgNAAL2fvArr1Z1a84=;
        b=M49/ZtQupjsIYy9B5e97RMUBKZAprYZIp5naoZqku4i2CUI6iDJiTGUriTKLVtgBG9
         QLSYSmwARKK39ZOz/vvFN3ecbZCjPIRU1bvALMg1O58CMNi5vYsjsGCU6c6JpAyKt1i/
         agZrkHUvKYxle2QnQwxhj3ZO5uI6nvbcAEX0C4xgM+RTMdJYMva3AoPcMbkOG5Ifz6Oo
         FdTCg4AcMmZ8v7S8wIqHg3P5kB99gN0yIgbMclJRvjU1Sks7mlPFHLqWxaQj0mFTq3Cg
         5/biPKPvSwfMvrRQOKa8JKCZ1Ek+wOJeu4Aerl8g3bPicx5x5HiEV4T6lu31cfHBx61f
         DWGw==
X-Gm-Message-State: ALoCoQn1ygFOdHr8TwtOeh/4sPt743emdxIa1dzgzAnx8gQqdoSF+Ux1CfBub6vdMhetDAPHdRoL
X-Received: by 10.182.29.1 with SMTP id f1mr7739199obh.23.1402593703804;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si112563yhk.4.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A02365A47FA;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C32BE0A0A; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251458>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 4b3705d..cf92e5d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -154,7 +154,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -167,12 +168,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.599.g83ced0e
