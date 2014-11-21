From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: move reflog updates into its own function
Date: Thu, 20 Nov 2014 16:38:02 -0800
Message-ID: <1416530282-13192-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 01:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrcEn-0008Py-3t
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 01:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905AbaKUAiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 19:38:08 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:64235 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624AbaKUAiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 19:38:07 -0500
Received: by mail-ie0-f172.google.com with SMTP id ar1so3989392iec.3
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5yuKSsTIfhhgY/B5MSO8ORp77t/YGpZFf4P3IFWOGmM=;
        b=EX8Dte6GvewwyPRc0BX9f8/MWMIoqIc3MbYCTdLSs25HQKfd6BZ3ROyWY1SYXxg8eR
         Q2ynz9xLGVlQQXEhnKaRjuMDypsvkG3qzGEOBlS4rZUX5XFmTQpZfV+d7OD6Dsea4+ob
         hdC9une+X0MfT8sX7zKfQpdhi5J1Pz2J7d9JxCsS/+X4tNcgx6iKakg9W1bOyy0H+FFe
         pm8HYEEcxte0u9ZuYiRgIrGQridT32/JFAoYEg8MqYUW7pKboAxqYEx70Fm0EvyvjE4e
         BpF2VZvVvLWS0eUHw7Ett4pfW8Ggat9tJz36RJ+813N6nWgxhosHZfGvGNxP39YnONI3
         QFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5yuKSsTIfhhgY/B5MSO8ORp77t/YGpZFf4P3IFWOGmM=;
        b=HhwnGxCMmmGHDXLWfml/rnUU9i0TNPwbgrJue4mxzSyHHrRT+60dbtAggysF+QXb4z
         1cfoLtDpu3agOcbDE/ro4m9UkqesaDSdR7NHMXHY0hkf52KrKDkjcm7q/oyrPpK28LGV
         nt2DGkmojqElHF1N3J/gtNya0tZG7jshTnj/nbi7OMuBExv469ozZlTjw/e8XOi1THee
         fcTdXKygwmKEOlDBSOsZpJIMM1CLHPwGzBtCw4m5VtJ8SpfHmLnB0aB7Q6vVgJecR8bH
         boPUFdh2hN1B6UqkNty8vvGHEsp5iQvBpL3TrBuYpDsyd2Om2xXcKf6uw6QnsyBrhxQb
         YRiw==
X-Gm-Message-State: ALoCoQn829cJ3R3c9fSAM+ND9/KZk0Odv6ChZ2K+gTJzsiWRFMjK1PqFIP2Ab6eX/UwO5eqAP8zL
X-Received: by 10.107.165.19 with SMTP id o19mr1351896ioe.1.1416530285731;
        Thu, 20 Nov 2014 16:38:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:2878:9312:86d2:4f27])
        by mx.google.com with ESMTPSA id z9sm3358094igl.18.2014.11.20.16.38.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 16:38:05 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

write_ref_sha1 tries to update the reflog while updating the ref.
Move these reflog changes out into its own function so that we can do the
same thing if we write a sha1 ref differently, for example by writing a ref
to the packed refs file instead.

No functional changes intended. We only move some code out into a separate
function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Examining the refs-transaction-reflog series a bit closer, this seems to be 
 one of the last independant patches, which make sense to rip out on a per-patch 
 basis.
 
 
 refs.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 005eb18..6837367 100644
--- a/refs.c
+++ b/refs.c
@@ -3043,6 +3043,40 @@ int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
+static int write_sha1_update_reflog(struct ref_lock *lock,
+	const unsigned char *sha1, const char *logmsg)
+{
+	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
+	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+		unlock_ref(lock);
+		return -1;
+	}
+	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+		/*
+		 * Special hack: If a branch is updated directly and HEAD
+		 * points to it (may happen on the remote side of a push
+		 * for example) then logically the HEAD reflog should be
+		 * updated too.
+		 * A generic solution implies reverse symref information,
+		 * but finding all symrefs pointing to the given branch
+		 * would be rather costly for this rare event (the direct
+		 * update of a branch) to be worth it.  So let's cheat and
+		 * check with HEAD only which should cover 99% of all usage
+		 * scenarios (even 100% of the default ones).
+		 */
+		unsigned char head_sha1[20];
+		int head_flag;
+		const char *head_ref;
+		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+					      head_sha1, &head_flag);
+		if (head_ref && (head_flag & REF_ISSYMREF) &&
+		    !strcmp(head_ref, lock->ref_name))
+			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+	}
+	return 0;
+}
+
 /*
  * Write sha1 into the ref specified by the lock. Make sure that errno
  * is sane on error.
@@ -3086,34 +3120,10 @@ static int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
-	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+	if (write_sha1_update_reflog(lock, sha1, logmsg)) {
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
-		/*
-		 * Special hack: If a branch is updated directly and HEAD
-		 * points to it (may happen on the remote side of a push
-		 * for example) then logically the HEAD reflog should be
-		 * updated too.
-		 * A generic solution implies reverse symref information,
-		 * but finding all symrefs pointing to the given branch
-		 * would be rather costly for this rare event (the direct
-		 * update of a branch) to be worth it.  So let's cheat and
-		 * check with HEAD only which should cover 99% of all usage
-		 * scenarios (even 100% of the default ones).
-		 */
-		unsigned char head_sha1[20];
-		int head_flag;
-		const char *head_ref;
-		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-					      head_sha1, &head_flag);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
-	}
 	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
-- 
2.2.0.rc2.23.gca0107e
