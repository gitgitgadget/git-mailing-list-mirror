From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 20/20] refs.c: make delete_ref use a transaction
Date: Tue, 15 Jul 2014 16:34:18 -0700
Message-ID: <1405467258-24102-21-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFm-0003aH-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbaGOXfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:04 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:60715 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934320AbaGOXeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:25 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so40336pde.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hODkxJT0/WBmYYT8yNXyXLUlOe80+2jB3hZvsy2el/s=;
        b=S2Yfd8JhHChRSQxL5PcGuNJ7MMqwAr914b33SxmElrU8lZnld8E7A9p1XMW0BJvuKz
         gBhay7lyU6XfSqKjNNHJXXeXEJ0BaoqG5uRSpAZDnIZQb3Mhi+3AUnAiXKQEfYONBANo
         S3s/r8VRPZFHJDP4SgAA1pSp4HPFt1ekvDAVfISJ8r4VEyv76BqWHa4Hqqo2INaDkptG
         TkQaRl0ZHVP2U7wMwNkBiYRWKWp9OMZF1f+vQcXJUADYKl09PdWZhJ0GcIeLjiUwMWt5
         2vBGyBhoFaJFApGjhaFj5Cv/XuPXJyrwf3JZ9IHlUy3dOs+tQHA6eKYLiQJ1L3huIv+G
         w2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hODkxJT0/WBmYYT8yNXyXLUlOe80+2jB3hZvsy2el/s=;
        b=NNnR36lCfqPviEsJccLX920rlt9v0d57AvyiImxORT61gBrVU7r9VQvuKaO+hMHm6B
         w1bbPov2nKRjUBiD7t33gKQxjWrK+8ZIDDcpYMIFgOwMfTg2aRXBNx0l/K8e+GDzhu0d
         ogU/GDysUisVA5Zhqe8cs4x2dgzy2g9fFM3H/c9HWFLLZreidUCdteYDNPBIfMcliE9C
         HFklcsudCj4Hu3oMa4TgsPiA92mIXcqkUIMe67ApNuL/qATXAVspK08oZlnK8Ti0bpns
         kpXE9UsNuedLPOpcGINLTnE8konXjI8BF5jEoSesXCUeRH/x0an8CPQxZsy+slIIUb6W
         lVbA==
X-Gm-Message-State: ALoCoQlK2pi2Ugt0jPbZKt5qPNhCub/6nO6yQ2Zkphu6EH1BMtTpxyt6c8CjyDiKAqe+4fY+o27T
X-Received: by 10.66.144.228 with SMTP id sp4mr12647962pab.5.1405467265194;
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si950903yhv.0.2014.07.15.16.34.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 080D231C2F1;
	Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D2CDBE0A98; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253640>

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
index 186df37..0017d9c 100644
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
2.0.1.442.g7fe6834.dirty
