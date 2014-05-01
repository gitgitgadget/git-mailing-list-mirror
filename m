From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 14/42] sequencer.c: use ref transactions for all ref updates
Date: Thu,  1 May 2014 13:37:14 -0700
Message-ID: <1398976662-6962-15-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxmI-0003Qk-2e
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaEAUkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:01 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:36214 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbaEAUhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:51 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so545652qcv.3
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B0ZNTgvK1r9HflAOhkyJVK4/H0TVe/Z6MuDjV08BJaE=;
        b=dFHvCJGn7V2uPbturbsLBnVTPdhiKDixtE8ptmj2SaZ6GFtxXr4HEW+wUNZcOtSkI8
         YT6DAosYdirv0lCK7OFMFuYpBVdcgjcKHTvLtu/2NZCnF+f78PMTyv39aIMUkGWV/MWn
         yvO4XV7vJwQlxnXzfcg7URHkTrlp2l2jzGiCAIoQfKYhhKuqQpdS78iHXYr9rYxEGnzJ
         5AHyiZdtzRzr0ulVTVwvXbCz1ke4Oru9P78ksxPT+oc9exmLDMkKw95sDmEwdkDWeMLc
         sINcRZ55jOPSYGAu9HJuUtpx4FnAvqQEmR4t/6usk8RotfGBgYOJ6K4eKKnvaKSdmnKJ
         Y2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B0ZNTgvK1r9HflAOhkyJVK4/H0TVe/Z6MuDjV08BJaE=;
        b=PimRNhIEA7fUGWf2Gd/jbBmJ+kE3pebVCj+qR8/nVd+A3E6IHj3pThIYhxOlqV5+og
         GeuN6erSSuKBAtuk4XBMb/YGJgORX6zRSiLqRSheKfR9nla5AuA1hgBXNTR56rXJBGkD
         DseBhXfuc6D/eZSaTi7COKHhx3xAtH+qyAhhFdu17ieBqwoXbAh6a5hAgBDjFskh179g
         eF4YxYuiT7dDm5lvQiGSJ3N8Im9moIt9+KAzw5//xoggMJZAJDN6N+9Uq01z3wC15Dr2
         3ypWrXgiaL33IZyl2h0wQZebKkX0bbDuUGASrpFMwqkOl5ibMyV6AkvuVAKhgnInOLZf
         cHpw==
X-Gm-Message-State: ALoCoQl9Roybg69RvLPeVJYv+rMnNxX2UIjGdFRaCgoMRpa9xpX4fp8vSEp71nQqAHmQ+cPUxSeu
X-Received: by 10.236.84.141 with SMTP id s13mr6644694yhe.5.1398976670824;
        Thu, 01 May 2014 13:37:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si2198339yhh.0.2014.05.01.13.37.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AB6AF31C2C1;
	Thu,  1 May 2014 13:37:50 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6B215E097F; Thu,  1 May 2014 13:37:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247870>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..9282a12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) ||
+	    (ref_transaction_commit(transaction, sb.buf, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.0.rc1.351.g4d2c8e4
