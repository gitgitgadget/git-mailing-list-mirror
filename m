From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 39/48] refs.c: make delete_ref use a transaction
Date: Fri, 20 Jun 2014 07:43:20 -0700
Message-ID: <1403275409-28173-40-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03F-0001eH-1l
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbaFTOoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:17 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:41389 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so978223ieb.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cyGdZKc5AoSIwZiEOMb+mJShZy2abgLgjjX8EH85LPg=;
        b=iHXwDmZK04yvLDXwWt9OxRP4GZfiF/yb6URmr5ONTiVvkoblRU1sdu/8IUnQU38dwD
         MsUBZHzQUMW1ie23YvJs7OUBlPhC4xR4DACAX+6YUrrZh9OV0Nvi6lIKJOQI8VZeWQL5
         qQ5cgDXHqqRXHSxQmX9o8YfXlWJG066xmS4oySwF6xzp+Yb5NT9EB9kF7qflAVbHKQlN
         rlecowXG+mr+NnNYD6o+JaHdaCFw1QmUGxEz47Ov0pLbuu1yw6yIP/8jbIz1b/BjUgj+
         wfzOb6pLkTvve+Fmc0gLlw3sH7KV/6US0dzraQ+cBHe3gFTLOQ3BmPyPWG6+nSejgyko
         fHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cyGdZKc5AoSIwZiEOMb+mJShZy2abgLgjjX8EH85LPg=;
        b=Vt+5OrZ8ClB/18kCayWawBisYouMyB17gqutJMiA3qplOB9Ko6y3riBN2xyJSgGjuO
         nP4m2Gq0OccmXqmWVgFvylP0G056xD42XJCdOQ8ncjhIZz8YuG+QuuhVjkaZLM6k16QI
         V3urMDP3zSUs2UR9p2AY9Ssa6Z9+fJAn/ZCeTF//WkygaKKFPrEF/ds7i6FSidNOLJWR
         N+PPQ9cQ1AMcTQZfmjI316jaYOidS5+e4XvpDNAERzpvWN0Fe2CmOdH++6jAl0iR5mzi
         9UDwE6d68J6AbCWyvZlAI3r/AQ0OTR5Uy0pkXzMWFX9x1wLUKd9OJST8oFUDdNBecSVZ
         RwQA==
X-Gm-Message-State: ALoCoQn0qwXBLMz88CEPH9iYSN4ORhysAVLehOaokBq/q+olfVUO8NRJI6pcYy61yjYeux4C+b4E
X-Received: by 10.182.60.40 with SMTP id e8mr1560531obr.7.1403275413827;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b39si187837yhj.0.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AA1E631C6B4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 88937E1207; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252240>

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
index 3d070d5..92a06d4 100644
--- a/refs.c
+++ b/refs.c
@@ -2544,11 +2544,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2566,24 +2561,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 
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
-	ret |= delete_ref_loose(lock, flag);
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
2.0.0.420.g181e020.dirty
