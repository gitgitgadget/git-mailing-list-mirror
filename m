From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 40/48] refs.c: make delete_ref use a transaction
Date: Thu, 12 Jun 2014 10:21:31 -0700
Message-ID: <1402593699-13983-41-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8i7-0007gA-SP
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435AbaFLRW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:26 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:59060 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so232231yha.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyfZBGa7VCDa59E9+1h2z6rqZ/3LKGBndpf3EPvAoKs=;
        b=BOorwz6Sd5MD4nTPGYwBKkSv38hPjBuNaMIBu8E6Ilex5qIk0Lj4TmWG0tMU8O4Ku6
         NeRgLEfsUS9yIz/l/e8e0TRUmsKMbb7oUUUsj++B7I8cN76AANGckQZs4bhNlp8esbhJ
         u2wm/zqZ3Gwsj9/mVMDJi/nJWHamWytXhx9dkDs1peORAHfZfEAXR/4uj9/Sy3ozefI9
         czkTA9lcQiP+FYRMGsWmJxhvMwciKvTw0xDBLUorGlZIGUMrRuwgdIl/NcRPJ9bj7uaN
         NAC+T3+ZuJNh9UoH6kVKR81a6uu4Q8nbclqzBrEo8Zn0BZ+nd1wDeIau/t3l/N3WNHhp
         hLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyfZBGa7VCDa59E9+1h2z6rqZ/3LKGBndpf3EPvAoKs=;
        b=QI3Y7FHt5OQsp44N9oQ6eWmkWR2gDioqfzX9i/9ji1kpi3R2+23tAHz8X0Y1Fp0TT/
         qz82IQEza0BUTTnydpNGcQRPvZmR6+Wh4Fu+bhPlXqos2JpafSxzkB33sAPPvOjouWJb
         jRpe+9LNybb/7768BIOF1wSroa5vuDoXbpHr0J1ga9GHh3aLgIzo6lONwAKWmyNBOwaJ
         FER8Z+JH9Q3wWbpcN73MGFsxxyV15yaVElfIgfY11vocLbk1KPN0/z3lwCh5raoLozD0
         zMZ/fr5SN5HpzKClbNJcrRW47vcIV2fM7oktGV5EoHxEkYjnPY4sZWdGCIt8Wn52Sg32
         qMLg==
X-Gm-Message-State: ALoCoQnbY7uFZWnCGb5IkR9tneK9/+8I9F2yqvbQhrLiNAa7Fj5cuYdMrtjzJEFW2stE9pGee/6i
X-Received: by 10.58.1.133 with SMTP id 5mr1001575vem.32.1402593704688;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113146yhg.2.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 876AA5A4822;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 67C42E0D36; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251434>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Change delete_ref to return 0 on success and 1 on failure instead of the
previous 0 on success either 1 or -1 on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index d4e3442..15bb250 100644
--- a/refs.c
+++ b/refs.c
@@ -2518,11 +2518,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
@@ -2562,24 +2557,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
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
2.0.0.599.g83ced0e
