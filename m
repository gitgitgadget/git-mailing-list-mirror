From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 12/30] replace.c: use the ref transaction functions for updates
Date: Tue, 29 Apr 2014 15:18:57 -0700
Message-ID: <1398809955-32008-13-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP8-0003nO-LB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbaD2WUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:34 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:37020 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965257AbaD2WTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:23 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so141278vcb.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZMYN+M09j6zpGGbrxemTd5X5CQGn1oCKLDMefUEN25c=;
        b=JssD7cB4UJtH5iUyB5H8x81bepKZhH+IM/vR4YdPJ+ZwCg4NeK7+12VLcHlqS690+J
         4iC1FQOs1oVCSKKyap96/Lw2bOxbA1+bU3Ij4ELTG/NfWRR9Qvf0EzvSt/1kTZAqT5Zo
         +IpU9yV8+zQSv9m4jeZCZIDcfRLX2Ds+8GHoE3HCUuftce8vlAIy9CvX1zroeqvLsKGd
         arKEVKkvYtrSO3KFy+T11/9wdY4LiKcqr5BH39W4bGxKBtBaEVn3Grhyy1DdP7CY8Ccc
         kS4/Xw2QSaBmQ3541AKZPf+sl1L5APGM+R+mQMQP88KAPMLG6VbTZitWR7NgCK+AAJIv
         9KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZMYN+M09j6zpGGbrxemTd5X5CQGn1oCKLDMefUEN25c=;
        b=luqFUJMWdq3lUr6oARhFGY6kEkCf4MZ1Yr5SvK2WRzhSnHq3Hy0pFzucMyTSo4F9YS
         vgnst3wqA6ilJi21R/J4Yrk/Ogd88zEzSbI7tUcIHZ6NiWJ2sioUQ8BLDasxHWZY+2dX
         0o8QxgLtHu8HjNDxBMv3QSia2oV/gMEs3PJ0yZMNRFNhZ7JMHfGspXjwYHiuCANX14Eg
         9QLpWkIy+PA6cWyi36PTTgGMV4r7IR9SHURQPYhaNH5bH8ZO5c+E6NJfcWbKM6Vr7+gc
         JuXa1lCjDVIekhS+IszrPnJKTlW+Mh0BGsoHnNmCUOtZft5ALYJT01WlqMfauPBvZt96
         2Yug==
X-Gm-Message-State: ALoCoQkz6GeGDthCzjU2jR2f+aiCouG++kZraiJY3k+6q7XE8m/z5ygKVk5BvCDyxYD/Myb69qHs2OT2VfOrLfnKfOnvqlOEZPIFoUzFrKjYpIvGrr1t6fuRhvYBL78+OIVsCFSLnqUqgfGb1QmVkP1rkIghhQsexx3LB7siq7k7jwKvNxGoRO8p/GQCF/7ypmeBBVeifEM6
X-Received: by 10.58.22.166 with SMTP id e6mr377791vef.6.1398809962697;
        Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2739680yhe.3.2014.04.29.15.19.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8552331C1D2;
	Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 45E8BE0A5B; Tue, 29 Apr 2014 15:19:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247649>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..b037b29 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
 	return 0;
 }
-- 
1.9.1.532.gf8485a6
