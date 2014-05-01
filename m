From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 23/42] receive-pack.c: use a reference transaction for updating the refs
Date: Thu,  1 May 2014 13:37:23 -0700
Message-ID: <1398976662-6962-24-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxkL-00011h-5e
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbaEAUiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:06 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:34646 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbaEAUhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:54 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so545446qcz.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKVp3V1zQW5HwWapoRVPv6CwjyKYpvu158H8tR9KoBA=;
        b=LF2Ya/y6uv+KS7w51JXYhDAoMo55pxUz32ZgxuIV26kG4N7mxI2/8EIXhUH614c/nY
         rxwUo5Ze2QH+A3GVC1ycV4a5W1l3UYrA3AFVQkx7BeOLwAZ0fEHIJmPNBzvi3oslEDJo
         /xwqITEU135JiVDVRUCT3fUvfmw0QIfUGT49k0Pl3wTIykTYBOK5/DhAXgbKQ+XXaREl
         IuetmekAni3Am9cGVk4OQQGSmq2WSZ0uro+ZdxP3p2MNhSP3CNkLAuL3i1wsb7YUVp78
         +d+tOHbgM9MrDOcmLKaSKE7/Fk80/50Nt30WAQx/+dKUzZ6+nxi+wvMPT/4l5q75JlwJ
         C59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SKVp3V1zQW5HwWapoRVPv6CwjyKYpvu158H8tR9KoBA=;
        b=f63qdNEzK8Zw0yqCiyCREs10PbHH63p9zLrJ4g/Z2nICnnTwj/PFOotJH00jbMmw3Y
         diebw6zh/PKoouc84V69/tOXhzSwsRfmWnsE90EA9JPGa/h3ycXZr9fj5KvHQ9p6hIvV
         GOzIXcsXX7wsa/6oSYvsdh+ZXlNpdK+Rh+6CArwpskOVUg2ltXIys7r332An/xOpggWF
         FzIhQqT4Rucf2k5omIo5JKemay1ng7XGBnWzSFkEUVnCUeO1DFZIrjUU2O3orEjqu09X
         5Ovn5yQUio9H7q8mTsc7oP1zV/82NricllGzFpbNr9QF7ugGw44oIA9VcW7R8YCqB43f
         3Cvw==
X-Gm-Message-State: ALoCoQk+CvMkSpf9VIEdi3EtvQ2Owqw0KzeGGjKcx/pIoFDlVF+eGI4LvIhvw4DRF38Ilig6QrNH
X-Received: by 10.236.159.39 with SMTP id r27mr6676067yhk.7.1398976674490;
        Thu, 01 May 2014 13:37:54 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si2611451yhl.7.2014.05.01.13.37.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:54 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5102D5A418D;
	Thu,  1 May 2014 13:37:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 15CBDE0A5B; Thu,  1 May 2014 13:37:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247844>

Wrap all the ref updates inside a transaction to make the update atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..d580176 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+struct strbuf err = STRBUF_INIT;
+struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
-		}
+		if (ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1))
+			return "failed to update";
 		return NULL; /* good */
 	}
 }
@@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
 	checked_connectivity = 1;
+	transaction = ref_transaction_begin();
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
+	if (ref_transaction_commit(transaction, "push", &err))
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
-- 
2.0.0.rc1.351.g4d2c8e4
