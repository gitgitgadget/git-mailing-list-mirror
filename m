From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 19/44] refs.c: change update_ref to use a transaction
Date: Thu, 15 May 2014 10:29:34 -0700
Message-ID: <1400174999-26786-20-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVg-000206-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790AbaEORbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:51 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:65094 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbaEORaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:08 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so257756pab.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZDSyisVJsz5RQSC5AharexG9xbTN+Dz7d7FOMyE+v0=;
        b=TOQKLAJETX9/kmNWkNEx+N9zS+0YY3Pd9DpCQzTsUkZLYHKnadq/SBe35cTTqyTC8p
         xbTaZe21qPByW+QGKFR6Ap6qFR7YAqTnl/flwb2wmoFXMUL9WtuuVz/m6BtcosE+3VXd
         ka7OkQYZrGBH117z8Qh8estxG6892kP2e7K1NrI8HnDcgNdGYzbekzRrjhk89RtD3UI3
         KnMVlm51mBsbNl2XlnjL81QBAVJ+HeaRFJCK1AvZnuyTyC2oAMsqMBXzu0j/EFvYamMi
         t5ki4RfuaF3rdEAyvh6upYIokxkK/wENjoJ55zXN5uZ21s3RMN9NQEGDPxGfV45yJixa
         DGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EZDSyisVJsz5RQSC5AharexG9xbTN+Dz7d7FOMyE+v0=;
        b=ZJbjgkUJGuCW7gj/vM0UTdSxgPG3S+ukuKLpeumOCz7LJGh3DxNuIvddJIjfx3xqME
         PGgIy2FyGWSKs0oWumTbzng71BFJsjUFJnEea4GEItcFmxFwXkKd4vaEd4Hg0Cz5MfME
         wSIFmccgv5ejYxcRjdZeOIFkC+F/fa2u23r28ZDJit14nRAza+5MDlKAuf0g70+QClXP
         nq+DDk0bayqZSaPMKuZFNX/6sTZCn0ikssVjf3BvbnCPHTKGrw38Mi7v1iUwlegGhFf3
         jz+ciQmPjlkS6zi7jUPKiIYFHlFMFqokYutcFVkNuQT5ylM1x2DHIvLJ7M/wLZ958u8+
         42hw==
X-Gm-Message-State: ALoCoQkJJ9IbkGxe+kfK/+3Dyz3+E7/rtXzfYUB99AHI6MG2s+h5vrlRG6XEDf70UTSBolU83eT3
X-Received: by 10.66.169.231 with SMTP id ah7mr5933068pac.40.1400175006621;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274177yhj.0.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7148A5A4263;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 51177E1797; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249148>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6e5e940..0476892 100644
--- a/refs.c
+++ b/refs.c
@@ -3416,11 +3416,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin();
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_rollback(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.0.rc3.477.g0f8edf7
