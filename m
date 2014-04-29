From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 21/30] fetch.c: change s_update_ref to use a ref transaction
Date: Tue, 29 Apr 2014 15:19:06 -0700
Message-ID: <1398809955-32008-22-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP7-0003nO-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbaD2WU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:28 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:58216 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965256AbaD2WT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:26 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so162969pab.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWZ9kUcYh+0Lpfd0xsOhE54Xdl+TbV1ffN36sJhGC6o=;
        b=lg0AoEnsuGHEh+g+Jic9uvTqNYKdmXxjjQ7I/ZAno2eAMEKChfh+yLzS3d2VM4Ub8H
         35AfpNITlhdI2OSQ/oajGpEW43vn3a3F6z3Vmkx4y1tGtRs2+wEjae8qfIlezsg26TVb
         l3NNhUzrAphxDF3nAC1aiGh4ASIJk6CH55K7C/+7i6OYqaHCQVq/sIlkbuexjEKoliFD
         /aArnSt7wb1iBiIB/b33vqi3lkP/ypa7iIK4QolqKn4v5Ya+9E3aBSCwOE7k+ECSodoC
         tMM/m9vVNB3z3TxtvOp83FG9kZxzg0eLLyyt3wmC8md2WzsHNekuspMqITUnYXLMe2Lb
         p4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cWZ9kUcYh+0Lpfd0xsOhE54Xdl+TbV1ffN36sJhGC6o=;
        b=gd4i/VkSFkQsj8ThKfLdFj3kjedLmJb7WK9yAYDOw4TtDAXvCxRQBoC0o/5TGODp1J
         gjYFLrnspcsdvfBgLRNTw+5xhhDS23v1Syq7wPsv/FK+FPqFmUIw4OjWVnkAzuWVJTcW
         FgllbDtF2PEdoi1XaUwEN1BsIFyPWjIigEK7CPvqp3Tm6bKkUnkQtlUUEm2wENl5wDAZ
         a1Ut+z9lHy4Flu+q9YJugI7wX7DbSnoFksZPltD0r08X+I1e0sSWRt1N/+VMB7Iq2DXr
         IFuPaPvZrF2dVCJGel88LKAi7HlnpDpoVqW1nSrZebkMekNo46yZR4PCfE4YU567RgeA
         whiw==
X-Gm-Message-State: ALoCoQn6XbTmZYD5tfOVpk9kqZCMTsyl4pyJSDg1IN8mUXZNErHe43aYd8Wo8GPYWvs9mcCSoVbpQVbgOaJxQBF4oQUgu0w+N5quUliePPW2Os3vU3bKcRYKDIYJuPuMvxa+fuK9yk+MuD+qPLLIOMkYqEyMJuhP+mTWjOslkRPUUawy4fvS5+4YzldmtotUtZgbkQxNRYfK
X-Received: by 10.66.148.10 with SMTP id to10mr354412pab.12.1398809966181;
        Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1813122yhl.7.2014.04.29.15.19.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0511431C1D2;
	Tue, 29 Apr 2014 15:19:26 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BE183E0A5B; Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247647>

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
1.9.1.532.gf8485a6
