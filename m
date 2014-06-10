From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 17/48] refs.c: make update_ref_write update a strbuf on failure
Date: Tue, 10 Jun 2014 15:29:05 -0700
Message-ID: <1402439376-25839-18-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:40:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaI-0006ZG-J5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbaFJWbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:40 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:48438 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-pb0-f73.google.com with SMTP id md12so206165pbc.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBCeTnYVlzwwkkKCzxKqwR4S3gGSmx51xoOq/ULk4KI=;
        b=hiUbPS2tPJVoTyS4Zvb0RdmbNO5BowjWgaKGyxPPvQyxWK3I2/Xy4Vy29aR6EUGnH/
         RmzD+YCbgNe80wFUzlUiurmUWjmEzdcH7fgvhAvgQizFVN0YppZQRzk2mV6+4ECTpB49
         N4y9GzxJN2X4PyJZVImsVRxEVnbX31DoQWslImY1HnaLoVrzRj0U39mfCqAhrDsqAjLq
         dQsSJWXX1HpZOCgGFqS/Ilv52bCL2QzKWKiXGJz/reZAW3SgqLK5cIiu+OrocbRlSZxx
         JJ1XaxhrvpZY8ZLxW9oHt9x8yaDTwK+kruOgyITlxOW3z+ORokk8hcjuG7T8fTqJuFbv
         YPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nBCeTnYVlzwwkkKCzxKqwR4S3gGSmx51xoOq/ULk4KI=;
        b=jWi7AAmbIh+mzIFJ85iSWnULP9wFaS8QsekHJebL4SlGCR42QpylGqQqvyKF4CKEMY
         U2Bijbm5Uk7dIdkySzTKarE4UYXZFfPG+VBM5gFeD1e62VA3RLB5ZalWr3cZH3ZA3csJ
         PiDah/GoBbIcZ7y0Yu5fGj2sZZBXp++CGFV9uJqAzlhNpQtr3vhKQucpz8rmkm15rMbn
         S1sCGRqdnCtdupnoIgJZWlVywpLJ6WhvYL1t7PnxRTGAKRiadaMGtuLzC770wte+Ma2O
         RDaWXUChgtW84XBz6KnB2jgQtwbjQizKZcp3HAFE9AHzLzaWVbkiaXcGOF+DX5OTJS2s
         5ouQ==
X-Gm-Message-State: ALoCoQngvsCErC2DO0FB/G7op691GE27P9jUgmY0y2mRyJdnGlXEZ+N2ZR7Kktpa11Es+EThkMQP
X-Received: by 10.66.65.202 with SMTP id z10mr2521523pas.45.1402439380787;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1395560yhj.5.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 93D565A46F1;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 72C0BE0A0A; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251313>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index ff55670..1fe4dcb 100644
--- a/refs.c
+++ b/refs.c
@@ -3350,10 +3350,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3474,7 +3477,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3556,7 +3559,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.574.g30c2c5e
