From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 12/13] walker.c: use ref transaction for ref updates
Date: Mon, 21 Apr 2014 15:53:30 -0700
Message-ID: <1398120811-20284-13-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6u-00007R-8e
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbaDUWyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:40 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:39426 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbaDUWxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:46 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so1012049obb.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v9vUZxOk0f6KxqyOercsdAT7Ec+kfBbj3n06PULYHJE=;
        b=jrK1/wCoALNsDP2r3l+bAqiETFQ5JtNSmDH6baJKJN4bJC+z09t0TIqdnlA7XEFYob
         GoZsefZ4+hbibs2sE+jjbVwqT2woT/xhZkBE233Zg05F0u0HWKR84kE0i5DaxSLNafGB
         O4Y4d+YaptHltzPAM1xOhZLMgBYqBKroIts3ZveWYL0BthnzbnQDFrfnXWzvw6W+3jk1
         Ahv0WPJYdF0oAN7q3fb9WCY4vC06hAfccPjTM5JPdQYtDrXB5xcNfCTrCvS3KXkGXGVu
         OvaDwwN3IR/xdULVPqn2/7RsOf4urtXVGQqCMxtSMns1niccghllWd8axV9qfE9ymgNp
         GCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v9vUZxOk0f6KxqyOercsdAT7Ec+kfBbj3n06PULYHJE=;
        b=H1Lr3z8Tjy/6xWEOKiA9zht4qyFPpS1/myI1EiIUCGNHntUDCNKaVxme5IAwUVNHzc
         6y5kABuYwQ2VBRNgWNH3ucdmadtfJo1oi14psYLrPK5nSXVlJcUh7Yl1K9ZAKpsCRPMg
         7jpcLqKuHMWZggZ+Dpp4h5rthUx8rD4giXIJi1ZBkY882jw2zs6iHLRlJSSweIFSBckA
         F3UipMJxlVHHbcIHBNs4zizudJBCso+wmiuu9W8QqpXjPmmnclMkjG+d7BhA0S9hacXa
         eb0xwKzjbpv6kGCDRObiFQqKNsUGQAqspycA7Os3FbZEQjjZVFh2g/w2+u9ue73EOC7q
         sadg==
X-Gm-Message-State: ALoCoQkMylWMdLYbiCzLpDNmYWJNlNiSbwW/ZzcSwavVlT3JbIELjLzcdQDv9lZoLyu+WtFdwYOP7OBzPaT9ZKb66QisxNT2Sr5MoohCg2sfVgsTnujnt3xUUkyAFgi6zzkoLFBTSIRLWgqA6S5Z2VpTsq11e/mojw1pqjBqQzYRSTUZgMz9G/XYPCA73hHE5lz/OxdRc0J+
X-Received: by 10.50.79.197 with SMTP id l5mr11846651igx.0.1398120825974;
        Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1894222yhk.4.2014.04.21.15.53.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A16EA5A4207;
	Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6610BE06AA; Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246675>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

This changes the locking slightly for walker_fetch. Previously the code would
lock all refs before writing them but now we do not lock the refs until the
commit stage. There is thus a very short window where changes could be done
locally during the fetch which would be overwritten when the fetch completes
and commits its transaction. But this window should be reasonably short.
Even if this race does trigger, since both the old code and the new code
just overwrites the refs to the new values without checking or comparing
them with the previous value, this is not too dissimilar to a similar scenario
where you first do a ref change locally and then later do a fetch that
overwrites the local change. With this in mind I do not see the change in
locking semantics to be critical.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collissions that the previous locking would
protect against and cause the fetch to fail for to be even more rare.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 walker.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..fa02d09 100644
--- a/walker.c
+++ b/walker.c
@@ -251,24 +251,16 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	struct ref_transaction *transaction;
 	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
-	int ret;
+	char *msg = NULL;
 	int i;
 
 	save_commit_buffer = 0;
 
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-
-		lock[i] = lock_ref_sha1(write_ref[i], NULL);
-		if (!lock[i]) {
-			error("Can't lock ref %s", write_ref[i]);
-			goto unlock_and_fail;
-		}
-	}
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return -1;
 
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
@@ -276,14 +268,14 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 	}
 
 	if (loop(walker))
-		goto unlock_and_fail;
+		goto rollback_and_fail;
 
 	if (write_ref_log_details) {
 		msg = xmalloc(strlen(write_ref_log_details) + 12);
@@ -294,19 +286,22 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		if (ref_transaction_update(transaction, write_ref[i],
+					   &sha1[20 * i], NULL,
+					   0, 0))
+			goto rollback_and_fail;
 	}
-	free(msg);
 
+	if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
+				   UPDATE_REFS_QUIET_ON_ERR))
+		goto rollback_and_fail;
+
+	free(msg);
 	return 0;
 
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
+rollback_and_fail:
+	free(msg);
+	ref_transaction_rollback(transaction);
 
 	return -1;
 }
-- 
1.9.1.515.g3b87021
