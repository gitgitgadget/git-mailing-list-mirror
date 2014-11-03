From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 09/17] refs.c: move reflog updates into its own function
Date: Mon,  3 Nov 2014 11:02:11 -0800
Message-ID: <1415041339-18450-10-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:03:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMuE-0001m8-Em
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbaKCTCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:46 -0500
Received: from mail-yh0-f74.google.com ([209.85.213.74]:35667 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaKCTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:25 -0500
Received: by mail-yh0-f74.google.com with SMTP id 29so732086yhl.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0q2oYma2T281aeCDti593EWTu2ppvOw7rzcK5jUElsI=;
        b=G6U3Yku4Y4n59vRSqcAEGuCvbGDqdcdn/UjFwZbNAl6BCURw4wRxKcYXsc/mpWOQ6m
         0fPLmcMC9w8MRLvLQp5NYRLN8pIayDvfaz5IhalAIErBZkGbdDUDizJ4zxpwbiZpIRQ9
         2VwlHARUNF9ayTjvZHWSmeH/6aWIse6U4j67I+7pND6p+XIeaSO+4B0Y3+lbkowdizU1
         oKsvBTrDHL8S2cAX6+8uPfB/BdqiixNTd7LtuANr3+fuKWaLeQj49jEBer/NgTl5PAD2
         ZZvRmER++99lxrxqzYg9qSk8a6GpaQ6lbP6z99b8LKqmz5VPY+XOkA+h3IZjVVOZ8pg4
         6FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0q2oYma2T281aeCDti593EWTu2ppvOw7rzcK5jUElsI=;
        b=Ra0/OZGzQ9swGW1Iu9ieLVPT7tksc4+KxxhiWtJrdudqzoZdcPb6mHd9izm8LvSLaA
         YDbGRv20eoJRqbdpIxap4gSPVQM3T1nC0SOlATeC+y8Hh2f0+Ola8kEKVI0rPQ4cqNW8
         sosQNID8bD8zqcjT1HYL7TJcWjnk380tq1Ihqzc4Lr2YIpHXtk564Y99S2dpl3owGumO
         a4oSLDB9CbscyND6yd6J4xvbYBDki1XCZAbEA18GxZ8tH32reu7upIrPxzj/GH3wG9bW
         uUFLs2ofx3SXYbIYIuN+xvGNjZ1nOXrPuqBfQYvr1bPq2i0CIr9nbbIBUXa9gbYT+glC
         9u6w==
X-Gm-Message-State: ALoCoQmNaoQv+PWDfCQmgNHnC8ig8VfedMtbM+hysy26mynqkalbuuAF7PWeXsyRdamkZc2R2aAy
X-Received: by 10.236.63.41 with SMTP id z29mr27421967yhc.15.1415041344383;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 5si167260yhd.6.2014.11.03.11.02.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id udQDNYw3.1; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9C39E0FF5; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
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

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index becf188..a3815d1 100644
--- a/refs.c
+++ b/refs.c
@@ -3033,6 +3033,40 @@ int is_branch(const char *refname)
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
@@ -3076,34 +3110,10 @@ static int write_ref_sha1(struct ref_lock *lock,
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
