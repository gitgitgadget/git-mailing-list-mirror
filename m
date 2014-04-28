From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 21/27] fetch.c: change s_update_ref to use a ref transaction
Date: Mon, 28 Apr 2014 15:54:36 -0700
Message-ID: <1398725682-30782-22-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuS4-0005nE-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbaD1Wy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:58 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:36965 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbaD1Wyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:55 -0400
Received: by mail-qa0-f73.google.com with SMTP id m5so330952qaj.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2wVxitU0F0orlYYJHFBsf3Ig7tHzXFq/D4hLS/gVDvw=;
        b=Wl3XrMJG6RuJaJkVR2NCmgVBDxePQW78PQIzV4AkXtzr2bV1HowIoV3w4bAC636ua7
         EdOhJkUBQ0Sivp1tJ2agUBkehPGky+SR1Z71C2ExE6RRnT4B0edMXMGcbGI/dOSOHCcf
         J4Flw26Ok+Lt9jdKWg7GR1bu+7EaYsO2AvcHUmBiO6ymCVXpqq+PcmE61r8JFgb5uJ5z
         MzuztVRUAyPWKFtUq8XLWsibweIrsO+/flpb/T+1Umdl/AqnHDo43XZ2AX6zoss/fJ7w
         Jdd21Och4He4wE4kg4Gs5vOkqMcl1K/AvxY5yQPkOVGwIQijXXm07cePmVirBvdvdI1h
         ha7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2wVxitU0F0orlYYJHFBsf3Ig7tHzXFq/D4hLS/gVDvw=;
        b=BVF5Aoprk+i2A776aVRzJuMSD17/InKKfyh8tLvVINjEuW+biBjcF+ADfSX8kG8JLW
         7DJVWzzSaQ4fXrm3RSrZ+/K2JyI8VFaLkK6EiK+PxRw8JrwZmU8xCE0//YdQ2Sdbq3Z4
         vg/BpOJeUfuRQk+ZC0dkALuyuubxc48k8SVd7es18KD0t3zyg2xQwWQTrfXdMBhIW5hB
         w55xbdqKEAMYs9B3VZNXKih6GIgygYskXKH7ZRx17fAdb3IobKXoLHgxVyubwgA+45dR
         BepVfZlhjQBpFI5cuHNfQfVNy3YbOass58qMtTSeRfeYz6MkVF6g6qCESxOWalL0nuLl
         tj/Q==
X-Gm-Message-State: ALoCoQnG3d0BIIXHdjulT+lyYzqu8UWuAsytwSMWD3tS+5tfMyRLBa+URK18G/WGjXUCv89Nn62zXtl0/cbuuPaTq82YREqLlGY4RDTJAPsdYjFpvzDNRKiLLuro6ZKwAOiyXfeQ3WeoEtCGQ1NzZArQlMYVcIDXCjMV8z9aYoL5ET26umAqzfSq/dNq3hUZI+GM0O3QlJ5d
X-Received: by 10.224.29.129 with SMTP id q1mr14091493qac.3.1398725695025;
        Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si1917602yhj.2.2014.04.28.15.54.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CD51C31C20B;
	Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 606FEE080D; Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247467>

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
1.9.1.528.g98b8868.dirty
