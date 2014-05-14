From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 21/42] fetch.c: change s_update_ref to use a ref transaction
Date: Wed, 14 May 2014 14:16:55 -0700
Message-ID: <1400102236-30082-22-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgar-0006qB-VW
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbaENVT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:56 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:49045 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbaENVR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:28 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so428195yhl.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ojHMw5RQF5myrHAUuMIVoTvRFImFl4dpLjWj/jr6/Bg=;
        b=PACxEwFLxKtze5bHn6hh11Pj06izu0E7Lg19cHsafz7x/644HLwchntfwMXVI1iJNQ
         feYvp6WJ0CAoOfgNQaXkhdpOuhLLFx2ZKqYVAfSel36AeGtI/YN/AZ5ndVV/rzKz+aAs
         sH1bzrLrgs3gpnFO7YtbpxSLHGyYauN9+N4ph07CcbR24d7rLHn+XWFZCxNqkhhM79kJ
         nwdL8y9vPMgsN79wLQG0eFqgux0X8bUt3Vxq+m2dt3YYnUXikr1/RNUHtlsQye0iqYsj
         i3vaArnJHElN9LFVDMDrOxz9fkMVeaHfa2Y7RX6MfmbUPXnTKFXr4os5+YSkBc7tKCCG
         f+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ojHMw5RQF5myrHAUuMIVoTvRFImFl4dpLjWj/jr6/Bg=;
        b=FOCz9bm2AZ0/nlaIyYRNG5e7DaBWQKwjaJ3WC4DZDnbM0XRH7spX8ZroQZGw3X9dIV
         P50ROvnMtU8SThS9CXt3+2yTiXVkZvthW7w+G6kn+DhcWGzRYZDUBR3ug46khOYDCjWo
         96ojb2YrhUsxYKrXDE5Pwur1DHnQpbnJSAVqXzpQQfW6UDZQlmV8JB2PwsEIidZsCw2K
         bp9OIHczRr9Nn45rU84GsIqjxCz2uWJLR4MVd2qhun7naILqTzaVHc8o39opzNwzh4WU
         jgX0K1WJNTpo+NY6lfgNOrkoKzW5GGibi1T8IBbINR8wfwV7qpb8cUxtBJSLL5RP/CFO
         oGFw==
X-Gm-Message-State: ALoCoQlqJsgAnIFWdCzkUtDAuFmTdXThBExS8OBPGdjUG1dD6dG4tvcPWaBvZ01eYkAPkeFh6eml
X-Received: by 10.58.195.202 with SMTP id ig10mr2948271vec.38.1400102247138;
        Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si145562yhq.3.2014.05.14.14.17.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 029AA31C1F8;
	Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B80F3E0CB6; Wed, 14 May 2014 14:17:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248975>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a93c893..b41d7b7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
 	if (dry_run)
 		return 0;
@@ -384,15 +384,16 @@ static int s_update_ref(const char *action,
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
 	errno = 0;
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old) ||
+	    ref_transaction_commit(transaction, msg, NULL)) {
+		ref_transaction_rollback(transaction);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.471.g2055d11.dirty
