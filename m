From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 19/44] refs.c: change update_ref to use a transaction
Date: Fri, 16 May 2014 10:37:07 -0700
Message-ID: <1400261852-31303-20-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM4y-0006gW-1k
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbaEPRhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:52 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:44093 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757892AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so521091pab.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+GcBui8cavp9AEyt+IBnh8/+xEP0VDXYmen6nMGNGI=;
        b=es88C9RBi/9WUMOomajJicSy6IanCP/Bkt9U/lSG9w2raXNKGF/dSJC97cuGLEWsfL
         WCZ3mrkE8A7T7pDRR4cgOdE8SogcxdyE1OgU28aicva5PP+yf4Oq9WNAM5xfJOJkT8tX
         p3yg4qJAUVIRqYRoYCJiHK7fVCcfo/Q11XXLyMsqXs/GD9kF9ddcxtdZtjqQ/ixDmUzD
         //NViAo4ovePRclpDNXU0SVDN9yUYQg+PaQjvK68P7uHmEHZrG+bgPhk2iT8G1PzaACH
         fACq2FCAskxi0IATJaDYWs4TJdY6GgYMxBZlUxUofECfkvXW1pRppQyVQi3YmiG/TRQT
         x+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+GcBui8cavp9AEyt+IBnh8/+xEP0VDXYmen6nMGNGI=;
        b=a7YzBEUMh68LhHNBg+Rl23lYrUrkcVoIjw2at63asKlRvszv4PxwwXVU7J3EkQwNjv
         737qiGKE6bczd3Le0N9EWT74LTUHlPWPWpIROIGl08l2Ax94OQqBejfwx7PGCZN9v4jh
         apnCmoa0Re3jN/yk2oRTq6XPcLBjBDReDuFaTJsjYreJXAhudlE38tQ4QQgvpY2YRZvR
         P4MJvQ9gpNnbCNGVJDsZzO1gsj4wtcAgk1L5Im2Q6ImpPC9H6x4AdFKrey+nQcjpKbmv
         i1PdL8MsfhxM5uBr6kxCUZEIxRPNsLk8zUAYhWLTdygqrZ+9AIo38rQJsuS7TLBAD+Wo
         Bmkw==
X-Gm-Message-State: ALoCoQniuPZb/+bA72o5sMFvzQLKW6pdOtWzlw9i3W56NyxT/s8L0CitB/SChKwCkxAmoXutyjds
X-Received: by 10.66.252.198 with SMTP id zu6mr6108393pac.25.1400261857599;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si441754yhb.6.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 694C831C211;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 47049E13DD; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249358>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index a588194..78312b5 100644
--- a/refs.c
+++ b/refs.c
@@ -3442,11 +3442,28 @@ int update_ref(const char *action, const char *refname,
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
+				   !!oldval, &err)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
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
2.0.0.rc3.510.g20c254b
