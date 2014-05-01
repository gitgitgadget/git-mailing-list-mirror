From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 17/42] refs.c: change update_ref to use a transaction
Date: Thu,  1 May 2014 13:37:17 -0700
Message-ID: <1398976662-6962-18-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxlu-0002wG-E7
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbaEAUjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:39:46 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:59779 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbaEAUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:52 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so799975obc.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YRpcGCYLrUSLI75LLUaXgmNVH6u2TeXUDfAErXxnEfg=;
        b=aXKzeZ4pHEzX391/mLj6jBpSRsIKrylczUpmIkoHZJK7U/Mrf+6ZfFle9tb/njK+sf
         kT+dmca21JI8uEqQu+uJs0IYsCepSIR61jQgIQjioaRxGQ3zz02/DUbgwnAwRKfXEyQI
         rxxrw0iKO1p4TfhBJk9vvMCkAzQWeCHslUroj3odv+1QPtDjuZUsCGDJHtLwQKld0j3K
         K+2T9jDhzPso4HqTiWdsqsSbHXMM1ZsE3v6it29cS/v9QtR9YbGOSUTqaKxqrZkpGfcY
         b+3BZrXNMnaH5pGm09HylJEnJx8fSYsGUdSjeQq031yc1ORGJ3V+DwexY6Dq9MlR1LDZ
         U4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YRpcGCYLrUSLI75LLUaXgmNVH6u2TeXUDfAErXxnEfg=;
        b=j1MhE6EtunksoRn4JSCo9gqjili7BVNiNT0+8KgmZcop8bP1CIBbeZVCJ3gm9IaHV6
         Zp5LjkgLEaWKiuCOKWt/UXJoQpsflk72l7hBlfbf7MnMgCDTzriIExmVnl2FnTnXMTB7
         u5Y9Pb0+/dxQ7x5cXdjXfS4X581QK4vRjwchICQcDwfLk2MSJdMet9+yj4sARpiVpfYn
         675e7vMRnXqVzJGzdZnwwGrPmpUVRQZGA+SoIkimCk8ZJMDqDUXlcBqjrx1VKzgAdi+Z
         JyPpMgmxhJNL732I8QY35coNro7Cj5R3kGUb3u5IaLvKExzKt+stPrwegHXs388W0Kl1
         zZyw==
X-Gm-Message-State: ALoCoQm8UsW7EefRwDdKBrNFTqmyYbxz2Xtjl5Z8aKmeGZO1Q+hGNMldjCizROmz+6rc2eMH3sXl
X-Received: by 10.182.158.135 with SMTP id wu7mr6827106obb.19.1398976672075;
        Thu, 01 May 2014 13:37:52 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si2198345yhh.0.2014.05.01.13.37.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E7C0431C1CC;
	Thu,  1 May 2014 13:37:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AAC48E097F; Thu,  1 May 2014 13:37:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247866>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 0a4e28e..563f336 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,11 +3396,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin();
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_rollback(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.0.rc1.351.g4d2c8e4
