From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 32/41] refs.c: make delete_ref use a transaction
Date: Tue, 27 May 2014 13:25:51 -0700
Message-ID: <1401222360-21175-33-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxV-0002p8-4M
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbaE0U0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:36 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:32944 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1919180obc.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=03a3qjQalLqJCYvnHdpopPY7kiizlGkeahDuB5FB/Uo=;
        b=WAPsfI65s842hIkdLoH2TgU9o4JFJUdutrmANrCX68hAU53HtXqWgfAx6RrqRobY7A
         nEFfsTJiq5VuiedjAGTAgmFOa6UCjFtqSBoPnpWTmV8cMF4guPkWHrJNt3BLRdqeyZI/
         guERbYWn5urQYrh3h+qT1o4DNwXjan/WsVqoft1jVtcVILJzLbLMWonnwG9xb1pVD/bV
         GL2O1NlxKALLxyqh0bj0SrnmHYiOvANvSxShVDbUWtW2b8qxlayvD45xZqNXKHkcJNN1
         v91j1vxWkdmIXAKjKjYooHRLfqCKZkboeXay//b31Y11bXM6ETnnCrem9MYZoqRdMoxC
         8JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03a3qjQalLqJCYvnHdpopPY7kiizlGkeahDuB5FB/Uo=;
        b=SRXBUPOMSyxxCmps9pXn5d7khh2CCno4y1LxB1qIX7suaO5dbkbpSqS3GT8nPLNOGF
         RxwyKqwhPRm7JfnFjHEXA1CHfgGGt5PV+eKwZzkYYmaH7HXE17V/GC3kW0OXB5SEeb0W
         LmqkbgaVWw1l1ZG21+eiIqTuDQ+bjbjTzw7YY8Surd0RYDfG8Y9FnS6chWTMLM0tSNap
         zNw5STQcEexFEP0kOpQT7Pr5fviQIbKicGlwm+025aROkWG/i3XbvuHCSyqb1IJOUj/b
         jIw3eSJONhF1GkRfSQw2vs5kZ/gS0AyKwLGV5Jdj1oG+tSGA/505L68mSj9L/1aj8xHX
         Wq0Q==
X-Gm-Message-State: ALoCoQkKryKQTGG1UlMkO+FWSWWk9ND9VnblaaGsLKBFt5zpL97AxJ6zaJYPuOVB92jssKMq8tLo
X-Received: by 10.42.19.73 with SMTP id a9mr12052720icb.31.1401222365142;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1573754yhl.7.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id F3504370577;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CF6C8E1565; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250206>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 1819434..88e7bb6 100644
--- a/refs.c
+++ b/refs.c
@@ -2494,11 +2494,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int add_err_if_unremovable(const char *op, const char *file,
 				  struct strbuf *e, int rc)
 {
@@ -2542,24 +2537,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 1;
-	ret |= delete_ref_loose(lock, flag, NULL);
-
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(lock->ref_name);
-
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
-	return ret;
+	}
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 /*
-- 
2.0.0.rc3.474.g0203784
