From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 32/40] refs.c: make delete_ref use a transaction
Date: Fri,  6 Jun 2014 15:29:10 -0700
Message-ID: <1402093758-3162-33-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2eI-0002Zm-2j
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbaFFWaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:03 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:44920 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so680737qaq.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5SzbuE4oCmhbX+D+TxnzZa7FNEvoGUr1QmqZ86JFJ1Y=;
        b=jkgoWYKoTT7jbVcukPFaOADfYn4Q8+x9/5x4A8vRNGus5cybtGtEyiDb40CF+u1tBc
         FpckNxPfy63bbWm25uyMnFQ9Jk+NukF5xqKdD0Gxp8jQr5NlIVyIfV33/updKCi8l0j9
         7E7zsEUdWgigs0inRO/tClqBc0yjrRNx3Tud0RJH8iV/WGwAGllSZ25/eIMfcGUX3I7S
         y9+H/IEK807nH7D0+1qAQ6yFjSyluZ64wZzq/aOfOwHgsfCAMPyX/NqXkA3mDOUPnKTh
         /98V12tjTUiWc/myvIP326cHwzXzcZY8r6GxVyvbj0cdtNWkJcXoL8gG+Y89EF3PRMeA
         IzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5SzbuE4oCmhbX+D+TxnzZa7FNEvoGUr1QmqZ86JFJ1Y=;
        b=W/0UwKYOgd8o0M1Oqhsrm8XBh4Cp91BJADsiccAoULz5L5rl5EYj/CMoPoJmvtPiMS
         RsRRO0SdRCTuWzuBSA6AopqxFUkjUAfvtWddfqE/cfN7v7cu802JSRd90EKC5DW9rg1y
         GfXSDoatZT2vtk5zS1Uv6+16dpbZNiwomZ+lWzsAuJocUYQQrJiYSDkQUqJ4w7lsLr/f
         Fd8cTt80BqjmxU9+UajTpU6oZlZ+Ea82hWpvfacpXP5R2FtfMNVrSqQCgbYLPaEjfOWt
         4FwAi3mBmaMDOXQs/2FaR269Yi5L4IV2EglOSunzBmmtUHy0L2Avs6tiClOcf+OsM2kI
         njyA==
X-Gm-Message-State: ALoCoQmS/Ps5jqpSABSirxMhKIwa5nTOdDBmExH8DurC/y3s0PaolEh/Hy5CboZJJgLg8+qtjp0y
X-Received: by 10.58.107.203 with SMTP id he11mr5347487veb.12.1402093762986;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id pr8si750962vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BC80B31C62B;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9CFACE0CFF; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250986>

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
index e19041a..4cdbc26 100644
--- a/refs.c
+++ b/refs.c
@@ -2513,11 +2513,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
@@ -2557,24 +2552,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
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
2.0.0.582.ge25c160
