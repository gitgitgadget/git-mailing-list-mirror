From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 08/16] refs.c: move reflog updates into its own function
Date: Mon, 17 Nov 2014 17:44:49 -0800
Message-ID: <1416275097-3616-9-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrE-0003pG-I3
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaKRBpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:22 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54372 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaKRBpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:12 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so2667019iec.30
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S/mIB/vUeA2CkiYpy5K++mUfiUMIUiizCUxEMOykkhE=;
        b=l8j3gWN9Kkqumas9v53CajE00yXrJPwP1Aj3jONNqdr45TtlSoQAtdBm6XBfBNa7Ny
         OHf+knR0Qx4RJrxrx6BXeS1UVDaR7CypZOAoSraWqQH9q4r1k6sQjWM9+0CNZJPsqCcc
         TKo1uKZZIS5KasxWplmAZFOTmOtWCEkOqDFwIRIZ8Dfp8ImwOX3sYSjZLjYRG97qUYzB
         nj+sFIMiikgX9Ks3+GeJm214Wc6Dh5OuQKsh8ga1P34RyFn7TyvjQ5rK/65HBPBFo3f6
         WG9MT4yBUCaa9K/B20kXS6ZSqKstrJddKHJi1PFydw0TG3648bCuDs7lFG47abe76BzY
         hNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S/mIB/vUeA2CkiYpy5K++mUfiUMIUiizCUxEMOykkhE=;
        b=Yp0+LhJ9croNygF6tlv6XztiA+1VMMC5XtyI/INJ/kACET+Ltj/IiCE1/uf7p6R4Ao
         MXQudtSeTO3qvVebKvbL16SZq551BTbieRP/Mbq7Yu8mMCThzLgs4io5lWOiWnLJPJiJ
         rpI+K/Idz+LwalU/xHaV6fGjB9hsJAZVummDu7lLw1AfaqOn+mwJXHGSoWdUTuurPJLE
         gVCEWlWE8mYyP1Q0IbCOxo8epACOMa8TAo1y16uyAfOMrMMd1sQTLCqAnTUtam32goDh
         1gqH2tz5y/nuf3uVf7Krw92smgMOXzd/d/xrG4BA1VO/l7oJkKQEswptVDfQdrqjFDV4
         /sGw==
X-Gm-Message-State: ALoCoQn4QZqusBWvvHWmyU3GM4y0nKZW4SmdKed3X/gz0OkecyTmE6Jp4YECXU4ZycwjzfVeezNv
X-Received: by 10.50.171.129 with SMTP id au1mr20753416igc.0.1416275111964;
        Mon, 17 Nov 2014 17:45:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id kk2sm6869983igb.14.2014.11.17.17.45.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:11 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
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
 refs.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 2db1dff..75c6d3b 100644
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
2.2.0.rc2.5.gf7b9fb2
