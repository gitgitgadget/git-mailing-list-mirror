From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/15] refs.c: move reflog updates into its own function
Date: Tue, 21 Oct 2014 13:36:52 -0700
Message-ID: <1413923820-14457-8-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBn-000100-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272AbaJUUhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:31 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:59501 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
X-Greylist: delayed 4349 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Oct 2014 16:37:05 EDT
Received: by mail-qg0-f74.google.com with SMTP id q108so200811qgd.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/BLuw5GH7pVz5Uqi5hHtf1ctL45j3jYtuOmGbYbv3Pw=;
        b=Qq0qvTb/MBJ/4uihCLLYcZUbY/qFpzedAiAdZi1SVf3jtaN/OYBfTwWNLYSZ7sqEoL
         v6Se6aW35o7sWHZO3qQDag5dgbP4hrzjzJn6Gk5g33Q86DNDUK+JI8nJPIpRrqTpxxLz
         u3rkp3dBNCMWhtiDyIk/WC0+3VYf+35bs0cmT2BXemPDv+g78FJPej9rKGgUviBfK+ho
         O2b1UjTJUGs/IRb6mPUVqx55gnAIV+7aRy/ZaCP9ewrBuswOvcyAHbjj0AFLvJZvQ3cZ
         5NUWrFYjjug4xiP29htC/w9pJ3VnkXaw+33ZbqVpNY+ywkVl6e0LJBT9nGF8s6j3vdnF
         Llqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/BLuw5GH7pVz5Uqi5hHtf1ctL45j3jYtuOmGbYbv3Pw=;
        b=kZncqLYq7L7GJ54QJQG6nx36SMuu1ZHRDuX7CdTWCJakG60Z5zuZ5fNoIkzaovd3BT
         7vmVYjTWNZeJgvChyid6Pg60Mf6bwu04ng9Bk720dOornjQaQ33DF1Pji5XLgl3z11w/
         jVoWPWLprmJSKrlJmZ3CbxScHrJDQTzuy3dQUjO0dKtJ4znuRoWv4qIq54y/EtREu6Jb
         W6jYko9oHLEy1bce27lrIAbL31otSReN3DzFSjvF9rqrX+Ug2CNnqBdmkNca/OiTYw3/
         9OuGcxq0/ZPuhQZfoBwvzKRSX3CmJPB1kTdR9LCafev3GG4xWkPHTqcXY+44n4Km2JNi
         kJqA==
X-Gm-Message-State: ALoCoQmnrD6QdcRnUg+Fa9RgAS2KTjsTx9T9rgAqrCUopjPnHzAHHEKWmOPxjgfz9lmoJGQsOeE1
X-Received: by 10.236.223.69 with SMTP id u65mr24559999yhp.43.1413923824091;
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si595901yhd.1.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id T6XwMEt4.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F18DBE10B8; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_ref_sha1 tries to update the reflog while updating the ref.
Move these reflog changes out into its own function so that we can do the
same thing if we write a sha1 ref differently, for example by writing a ref
to the packed refs file instead.

No functional changes intended. We only move some code out into a separate
function.

Change-Id: I5ef6b32d183455685f8966379767f8c6e1ec49c9
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 43df656..4eec7e4 100644
--- a/refs.c
+++ b/refs.c
@@ -3022,6 +3022,40 @@ int is_branch(const char *refname)
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
@@ -3065,34 +3099,10 @@ static int write_ref_sha1(struct ref_lock *lock,
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
2.1.0.rc2.206.gedb03e5
