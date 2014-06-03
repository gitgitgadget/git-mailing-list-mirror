From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 23/41] refs.c: change update_ref to use a transaction
Date: Tue,  3 Jun 2014 14:37:41 -0700
Message-ID: <1401831479-3388-24-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSc-0007Xw-MY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965411AbaFCVlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:22 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:49146 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934221AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so1534877obc.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2cTFDB0hy0otxoRtueou3BAUpiWy1gV0b+yL4UepTA=;
        b=ZLjBT78YwKpVDQp7H8FgOkuM+IubOCagHFlyID64vuhZp9jtX79QCe5trZr5cOf/mH
         wf3GOCbV6tUq/ZJmylLnrbgSfQzR2O9dCn4eiaqt/7pJBVpblyD9rkznRUTP4PPDApF2
         5lPpc+FsAQ17vssrLL/mBJh4rRNG3xfEeqkAXKuqQ15gQ5pIiiexIJNpHdGXvPNqpL9C
         /KPLZJIO8ajXgYeBWy5rAW5ZQBitXrxPxe7USIoY3hpS/qJzl3WpCTad7ITWPvMfx3wM
         hMPxSARVX0lzUHeHTd3zoPC+I/uInk+RFT90G0k2qa4muHmEsSCce33gJok84TeV7qmn
         l2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b2cTFDB0hy0otxoRtueou3BAUpiWy1gV0b+yL4UepTA=;
        b=kGY99kWPr2WmW4x3OrYvPsZlgaOr4weEyfWMZr7pu5SykKzKrNCbfc51Lq0jmvgh9e
         xMLGodNVxiBtBPO+z7y++dxNZzXMKZt6JU7roOJX6/bRNBbychHGfHDfGnqxUBxVmgF/
         ljuQRUWNuZ6Fiegx3QB9f74bDT2xFaE4ZMB5bq0v4Zt/SgUunIEqiqC6m1Kcu9bw+5D6
         9ZIUk1RYZaEveICxakt5Hod2nlVYGH5C/ZxvNcKxldZCJ3lI5t6AEjaoZjqrpw50JbXb
         6AZ9JmIG/Q0prvphDcHJKvaBE1mcb8JYpxh0+2eX0yPHJ1qF/ktZpaP27ceY+iXAYgHK
         iOOA==
X-Gm-Message-State: ALoCoQloaZZqiZigCczMu0FAJdtBWrkYerz6q5l8Dg+KEAzujlG7uxXHVK/jOLDj8FZ8jfM+OHYd
X-Received: by 10.42.89.69 with SMTP id f5mr17697860icm.28.1401831487858;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si30646yhe.1.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AA7585A43CF;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 869FBE0887; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250672>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index dd98202..6d2caf7 100644
--- a/refs.c
+++ b/refs.c
@@ -3514,11 +3514,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if (!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_free(t);
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
2.0.0.567.g64a7adf
