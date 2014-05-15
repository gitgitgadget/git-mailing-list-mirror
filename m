From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 19/44] refs.c: change update_ref to use a transaction
Date: Thu, 15 May 2014 16:15:16 -0700
Message-ID: <1400195741-22996-20-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uO-0000IV-Rx
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbaEOXRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:37 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:62946 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so346266pbb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6KhBuAFDzNDLncx1pMvEw8REwYXeBftWfk6q17ID44=;
        b=nxrs6Dtky9qkniMzeMIx2sFEdnbWxvAH1QS9pa8ZPBHVMYcCpgmqbMIE5lzu1Qpl5B
         gl6HBNqxX4Xu18X5WFM1Br1mNzq0RKOM5FyZLoM2XHyPTUvXT32s1AD7jKL5OSfnIki3
         dyPLnqWF4t+V4epGxGOZe7Kmd8h2Z6HmeW9MaHFda0uNw40PLldPiQY4D0G4FsJKxPVw
         2OtKo6c2VkyBCMPaDYZYLwP9F59IsjLqnGCACkj5/4qqct/Y6G2Y3/n5FDDLuNn8Zbrn
         C5UbG1E/lE11+bQ5xLw3de07D7N7mpUrr1oBGEwYIq2SvnhTC8fvJ5MNn9knK019zgc4
         PDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6KhBuAFDzNDLncx1pMvEw8REwYXeBftWfk6q17ID44=;
        b=bEncJ4+WqD2LvnTe6qvf3rYpvQ8ll3DjYXUE2EXgym+CGwlzNGllYq+zNEj9TLYFbc
         XJvNmhF6sL4hbljhr414K91mNFqcM+3jqYG+Wup9NO3czEJ7F1HlItyTVeiZbRqykWZM
         oxkmcpLMRAS+b7GzEl3gbiNhH8SxJYQLCw867n6vzhGklx01p9SI0n+Lhm0RVf/UwlzJ
         RmaKm9gNaQ5jPcaM4b7rWtX5zDQ6Wdcm1ED9NswUSzlvGAXDO3M5OizOr3hmLTR9v4xw
         CuKUx/9IAs3RHXM6hQBUYc6hehPTqDB8MkbwwbjS2+wZvsbt+65VR7dKotX9lzvel1ok
         3QXA==
X-Gm-Message-State: ALoCoQkr/+go8P6cZXw0dRHsDyriM2Bz5liCqgsFI75to93wJ9wE1tfATm79qcQ9D0eKvxBYoipK
X-Received: by 10.66.163.33 with SMTP id yf1mr4158540pab.19.1400195745203;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si67809yhe.1.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 09C4731C2BF;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DBB77E103B; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249259>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7276b9f..5e82695 100644
--- a/refs.c
+++ b/refs.c
@@ -3447,11 +3447,28 @@ int update_ref(const char *action, const char *refname,
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
+				   !!oldval, &err)) ||
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
2.0.0.rc3.477.gffe78a2
