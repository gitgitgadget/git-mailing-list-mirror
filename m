From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 08/16] refs.c: move reflog updates into its own function
Date: Fri,  7 Nov 2014 11:38:57 -0800
Message-ID: <1415389145-6391-9-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNm-0004FM-9V
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbaKGTjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:25 -0500
Received: from mail-ie0-f202.google.com ([209.85.223.202]:40100 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-ie0-f202.google.com with SMTP id tr6so843292ieb.5
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YBFpovx/s6RywFG5EaxrdcyPe+qrLBYAkyyoSksluVg=;
        b=JHR6EK6PxqZMZzTkEXn8yvr62u048fyKdHKTPgPiz/nLixRAge2jYxT9X2ZVo6VHmu
         Ceg4K8ndcYgfo8kxv8n90c6o6E+wpnhyasvwm/poMn1P+ZgQGZA6DpNZv9JYFdHhPS/X
         R3CkfFyDdkK9Lit56/53CaeBbI6gvJF9ELBXrTF+6K9bfY2Ar0HuNBc5To572QO0AXQ1
         /Us7YgHiLboktMrlXeSIK6c5iejtoCN4h2r+gYhtNhU8LakdS4ErOm8p+NcCQUHNjuSz
         KlxELkYXjzLZp5az9mAuLFk0V0fQitRx00jjgM3VT09kVWcRtUTc2xQkVX6pR0Dk5EaX
         Glbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YBFpovx/s6RywFG5EaxrdcyPe+qrLBYAkyyoSksluVg=;
        b=K8cclw1a9QN2JzrXsY5WBZ5PqrPnTZZ3kxlW2PSP/UUYGsSHHgl820geHEf7PPq9up
         3BoA2cLn0qv+tf4XBJZDxU3jmxoly4HGIuI8rNt2qs5pH9ye71djRkOzzbl0kyI0VfNA
         6Z0bcwIEO26qOHCd2FtiOsyztRyWn3uihU6YNki8xUFa2uS+8KWYYpetyyDyk9huVpsi
         LCMnfVH/h7LhmC9LL6gXSW+0Z8IFrGhbMv+SSi+HS+sDsQICzYyjGyiCsapeD9gVHFK3
         dnrh8uuDBEZZtitdRkD/rlmVOchjHS/TurjqjAuGbvJSKt9u/txuiHitOrroXRuvM5SM
         yC/w==
X-Gm-Message-State: ALoCoQlsk9ZZ6Jacc6QUVMp5zAdD0iY1jheHQR3thwhsfmDptdrMzyHEFHAxX/7snmO/jvfVXfJd
X-Received: by 10.182.168.114 with SMTP id zv18mr10237065obb.23.1415389151089;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si400509yho.7.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id nU2RkKYE.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B0D90E0B1A; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
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
index 5a8f3da..7f4b4cb 100644
--- a/refs.c
+++ b/refs.c
@@ -3028,6 +3028,40 @@ int is_branch(const char *refname)
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
@@ -3071,34 +3105,10 @@ static int write_ref_sha1(struct ref_lock *lock,
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
