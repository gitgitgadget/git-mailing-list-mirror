From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 06/27] refs.c: make update_ref_write update a strbuf on failure
Date: Mon, 28 Apr 2014 15:54:21 -0700
Message-ID: <1398725682-30782-7-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuS3-0005nE-VD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbaD1Wyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:55 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:54437 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbaD1Wys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:48 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so349949yhl.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHDsIY965F9xEs/Sn4pz//mQOjQkV27lLNVC9TuznKg=;
        b=KJzVRIY0vnieX0EauHuJO1sZUmH7FccbZnuBJpHOvYKhCqrAH4l/q9JzrmQ9C/4r0h
         4pgq8jzrPobZ9FyTWKzVjdSwVjzxVknvl4Oh4kBi9Dtx5xFzTjhyeOTSKpsrDBHfxZv8
         Hs3ilGwVR2rb1nUpZghEANWORhk1YqJkJzyHECPBargEYbJZFnSUJ1lqUAbUTDMd501x
         /kMgzYqLnPi2zd4mcjJdI4fT12gRBNNr/ughYMo4JMy/+G9irR59/Mjw5bqJii9R7E8S
         uYVL0cIetYsMWQqAwS5lu3c3mBmIB5EEi/PGbLg9xWeKa/FauP/SPB1lDYEEBM4r3Krf
         BHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHDsIY965F9xEs/Sn4pz//mQOjQkV27lLNVC9TuznKg=;
        b=ETT2yj9cl+RUDQX7NBS34eRMK6d+CC9rb7n0Uz6o8eVzvWDTYDBUsySjLbiv0hE2Uj
         Cuy3610fDp4iXO89gRA8OPGTB1NzGTp4FDCA42lx1qFAJdJuIZzVZ2BmIzj3YcdVRtCK
         6zz8YIu+NBNKcNgMQ4clzHQkfGdg1gwTFiFrt7m7iP+vFl9nlucLyaRJr2VDUxDZV9vk
         s2NQPw/RdBeqcrMMp24mm+fsqJa+AK58pgkLRZQwLSn9Oi4e/FwPLs7rramQszCMZFCd
         9zNTMannqiba/Uwc3VACOzwfrMJzrGcIsc9sPLMRNkkNCQBUJ5Rpy7o4dZzF8fC2bbgd
         B9mg==
X-Gm-Message-State: ALoCoQkBKM6J/zEhrX+LOX4werkPSOXWd6f7I2svFFmKc3Sb0U/gFw8W7kayo4vf0+rPzV4ifvFUKAzMLIiX9Mj21EYGPVx+hXDezXKXeVOW2kRQ/wlonwI5BWDH5iOkb6LFlua3j+FsDRkJRsvSwOPJKRIYYZzNXvFSJGtLVJD6OGQYvNJLZWTfmJVMslxdXmrlnN7DxSwh
X-Received: by 10.58.228.201 with SMTP id sk9mr14700281vec.35.1398725688129;
        Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1424534yhl.7.2014.04.28.15.54.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E1F595A41EE;
	Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 549A0E08C1; Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247466>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 21a147b..5e06fd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3253,10 +3253,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3382,7 +3385,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3464,7 +3467,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
1.9.1.528.g98b8868.dirty
