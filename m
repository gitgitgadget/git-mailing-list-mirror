From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 12/42] replace.c: use the ref transaction functions for updates
Date: Thu,  1 May 2014 13:37:12 -0700
Message-ID: <1398976662-6962-13-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxmA-0003FZ-Bp
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbaEAUkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:04 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:39829 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaEAUhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:50 -0400
Received: by mail-ve0-f202.google.com with SMTP id sa20so429366veb.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vd/XuhD1ZRR71M0rk1VG9Ou3UDpio9sVJBNrtd3tALk=;
        b=FIjJWFVdg4XEE7y47pSf6zmU1lhSUqtQjmWHoIyO/v0eHSew5mf9w/KMqsQnbOEMLt
         lDEp1AfaX2O6g1PCMgVLzig0FhIg3Wf5wNexxW2b/NZWM/B70ukeKTi65hNy6eGnpqMM
         P8ZSPmKSioYXiUCmikQnJn8cMsqjmxNvi3fePRviH1Zuo5OvwHr6WSj8hZuvBhiD596V
         tPXszanVgYKrz9EMsTzpLCs57cET1+g/MVbc74c+AnjpEj7tgBAQ1H52rAWQ+w0QNrZC
         pZeaAgBKt9+SxqZfMPBuLGmnh7fglhOcU99eC9xx2nuZXsZuFO3HKhpj/iaWwASEYr1p
         Pr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vd/XuhD1ZRR71M0rk1VG9Ou3UDpio9sVJBNrtd3tALk=;
        b=KQc0NHN0AIiFW9Cb1wt8joY/1ZWTxNXXmZhiheeSYIwSPrLHOsoTttOSJSu1q4P45f
         CHbElgXMR32hrSWtTci2OQV8ROW/v6qPkoDjDFbZ7zkIJwtSdLNrMsW8tCl4hr1eyUK9
         4S3NEZswenjN0+l+gHxR2Hiz0QqnynR15bPZ9AlaW0fuOFOfGa57adUQ2xdB39wByhTP
         jEZUjC92UQLvjF+T19+SVli14H0Lb+zdkAc2h5CnagWYKrA+aq1dmWO9g+GERJt9Zp3Q
         2yMv80xm4qWcACZzI84+gEbWv4CeY43jCf7zV+bK5AwCGhYZMfcSRpU+FGeTLK140ZuA
         MuZA==
X-Gm-Message-State: ALoCoQmxW0iqEnsN/GXiA+Bqi0b8lWnHs7hlqTstVcz4P6h+pGwsJPH5Tnmvkv0FgSoYAnc3PpMu
X-Received: by 10.52.61.197 with SMTP id s5mr5913848vdr.8.1398976669992;
        Thu, 01 May 2014 13:37:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si2126353yho.1.2014.05.01.13.37.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CCDB231C1CC;
	Thu,  1 May 2014 13:37:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 915D2E097F; Thu,  1 May 2014 13:37:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247869>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..b037b29 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
 	return 0;
 }
-- 
2.0.0.rc1.351.g4d2c8e4
