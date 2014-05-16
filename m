From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 23/44] fetch.c: change s_update_ref to use a ref transaction
Date: Fri, 16 May 2014 10:37:11 -0700
Message-ID: <1400261852-31303-24-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5v-0000p5-U8
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895AbaEPRiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:50 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:35784 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757917AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so490841veb.3
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9A+f779gQxj5/PwHEEjwnAyI+TiZU5OGVcbPxlxQ9I=;
        b=Wdz0hhYImEG8C1QyN+cTFf0XuPNgvSlZT8OP8VTWb2c6OeD0fAurlPUipnJ/ikyZuv
         uR00v/1Ny4HkiNoiKaV2JF2doiU1aLJvbV1DwUozbTYIsxqUnGDoqYfFU8mdTGz81kRJ
         Fc29Nj9guydYeWWoJg0bLvxOvuaetNPJYqc0JPHr6HLX4X2jEJGPN49X50G3rLw/aW/E
         jdpgofa9m2HQjYgaHeBRSOW+w9WU3x3bjxt5Ter6HsQpsijfnfSkc/P52Ai279ISca3z
         VrrMfTH8x1E+mo8W9+TQCHPmLcS0A390hwN4QG3l5sYG1lzRmxxZYwehmFdh3W3/EgB0
         yNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9A+f779gQxj5/PwHEEjwnAyI+TiZU5OGVcbPxlxQ9I=;
        b=H/qttWaIBz5ONS1yD2EmdD66bdrlJfCLLpf9M2cyIlLzgBP1fGqSEGyuI0AUWAGEaE
         tse6Uv+vuHMe5AidLKP58hKhmNXDLXKgTkjGYaoL3G+5btWthswEPN1jvSlSdIeZ8gul
         ICfXML3Y7ioiaPRE+5ZvemFahCLww+vfBCnxx5ka5UPGrYWBDJ1uXG85tdI5vno6WhuQ
         Gt7VIGLQtMxHfywSBTThKloifIsoXFiiQ8uBLEcCWoJuzSyfPNOVj6tOk4XEhWJbG+6S
         2bn/O2A/9f/ERT2/+BIhcz1BP97HuUMwKvNPsFJHUaTXI+y3oroDWkyqkJnWXb/ZKhc4
         RZ+Q==
X-Gm-Message-State: ALoCoQnhqNahhiiC/BKVHZeN/6x5CRDcCDaCjIXXngxQeaSdIF0uGrBG4L1esm0Fe7LLnRqgjNWO
X-Received: by 10.236.36.33 with SMTP id v21mr7437181yha.53.1400261857663;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si441218yhl.7.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 84B655A4292;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 604B1E0F5D; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249374>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a93c893..8cf70cd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
 	if (dry_run)
 		return 0;
@@ -384,15 +384,16 @@ static int s_update_ref(const char *action,
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
 	errno = 0;
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, NULL) ||
+	    ref_transaction_commit(transaction, msg, NULL)) {
+		ref_transaction_free(transaction);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.510.g20c254b
