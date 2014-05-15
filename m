From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 23/44] fetch.c: change s_update_ref to use a ref transaction
Date: Thu, 15 May 2014 10:29:38 -0700
Message-ID: <1400174999-26786-24-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVh-000206-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbaEORbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:48 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:52427 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so241456veb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ViaCWW+3TS6OtTjSOpxqcpqNHbTdgxpHIlOYXC/fxC8=;
        b=og9o7k59vyAMCVwCU2uZimqlkONXfEfLhkR5tcZvVn2CvEd8H0rhbP+5u/QHJhw/0h
         GxVDkwsZ1rJ4kyyVXGLf2b2T2FCZRmXIcHcfdhatZ+LCIp0x2wKHm3INGdiBB8XUo2ha
         8ik4kEzbUR84ntBPDysKc/RVqCwxXPUuRScmZBnGxLzclZkxL2r+58XBDWGiGg8KFwqQ
         VE0TjEejHBWGIPIOVOFxewNUGvh2cXnbH8nd9YDRojpFYMXKlwJyAWh8F151ckYKeams
         RVux59wYgmcZTrwP9vbF3SOUbkPg6K3VuQpBYpI+sgCjYrUm06pvBPAfvIP+DqTJ2/r1
         oqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ViaCWW+3TS6OtTjSOpxqcpqNHbTdgxpHIlOYXC/fxC8=;
        b=AX7JSlLxL8mUPI33KyD+wn25r79iwXlKOC9Do/CaT46anWps/GYM/TzNiVjjWdYW6V
         ZID/NHvWL5IzA6kUIIUKBP3BgjFYMM6V0csoBJa52U7RHzt0TQAmnCUAG7IssI+SUjWX
         JEQMmUvBXNhPnT0dvVKge++vwHMQBE7qnn+HTaEgcG1URjdS5mU1gXMgrfYVWRO05uDK
         wRkeYTibLpOh2UORclM/7P/MSWLVVBI21H3Hw8xINUrZyoMtIIXdIhRkABegou8LkWsR
         wj0ar14DZG4HxHiZcf9six1anQp5rfc7QaiPvRzkH7ooWrvNWB0VgG0hZcnB6Wy444V8
         8IYg==
X-Gm-Message-State: ALoCoQl6Vv/Ap2wA3+sPPWjvtlUQII6sBZNXYXme3XbgS3BteMIC9pnCJ/7xlXE4GPTdFNXXzgNl
X-Received: by 10.58.161.175 with SMTP id xt15mr5611767veb.19.1400175006775;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si273166yhk.4.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9EC1931C2D6;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7AF7AE0B2F; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249152>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a93c893..b41d7b7 100644
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
+				   ref->old_sha1, 0, check_old) ||
+	    ref_transaction_commit(transaction, msg, NULL)) {
+		ref_transaction_rollback(transaction);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.477.g0f8edf7
