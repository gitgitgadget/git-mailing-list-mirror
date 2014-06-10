From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 40/48] refs.c: make delete_ref use a transaction
Date: Tue, 10 Jun 2014 15:29:28 -0700
Message-ID: <1402439376-25839-41-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZU-0005nz-8R
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbaFJWbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:04 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:35161 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so603575pbb.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdrNkJc7mnLsD4/1co9sSZTcekSOcKGVKmhHe53Faoo=;
        b=WuIjvy+EaGMpwpwSmBBufe1xy22+8BNmZtG+rPUSOj1lyTmzFfjr/Dd43Ke8Ri/dN7
         LZdczNLo4WVQxJxzZ0k6BRHRVj1W8ACROQmwsVMinMkD/7zDEH4i1hNFpEeJCt4jb0sw
         C1A/Dt6/5MascWlDZkiaBTbT3Z9b6H+ntQMz81s/1HM8zFi61ngfpvFJQEmmAPF6KUYG
         ACeumNSKSTk/77S2RCqcBOC6gK9VVpXlbCgQV3ijO7hzIBOWbTTKwyKah0Rn6SU296WM
         TVIRmZwOzkQXAC4StoqfIvK1yN2SpW1f162SUhXma0fw0cdeWMIq9V024MMdljbEdcvf
         +2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdrNkJc7mnLsD4/1co9sSZTcekSOcKGVKmhHe53Faoo=;
        b=CCa5Eb7wdTaNbj5ZYV2rgmpn5B+0td5LMnvDKi6eTpM5X2H1SVLPT7FAtSXmWDVsdf
         Y13AdWWV6PLf2RZK/jBvofruiXzk+x/kP/Xq2ii3ufBjVWPWI0E54Hq1GBujau7tngBm
         1J1aZvlWIGVH5BdLEXneg69STWkuXlo5/ZLaLU3b4Bm8Ip8fOcnhOmJjekR6r+KRC0FK
         u/awABX/YmuSVJax+RWBXwtYCnPmqxLNe9OqKdKTXhJrsiuTqWe5H6Q2clvkSZArnGJH
         PGNV2HhmDhjo1KmHV6vJH1HSetToxJPEdrZ0vEMZlwoe6rWsKsoS7fDhsu4XIe/9vmVv
         uUsQ==
X-Gm-Message-State: ALoCoQl16xYa6StuPZzAc5J2qGL2sWY5qWc2ZA7IB9EzOcy9JNaLUGTMNk3NlYiaBw6UwBwe5djt
X-Received: by 10.66.169.231 with SMTP id ah7mr3868310pac.40.1402439381930;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1394556yhl.7.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BB4FC31C741;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 984BCE0A0A; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251310>

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
index 568bf9e..d422ac3 100644
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
2.0.0.574.g30c2c5e
