From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 26/48] replace.c: use the ref transaction functions for updates
Date: Tue, 17 Jun 2014 08:53:40 -0700
Message-ID: <1403020442-31049-27-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvj0-0004XE-1B
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933437AbaFQPy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:57 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:40407 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so1065764veb.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMNEAMLzBebcm9SX+NlzCoC55m6Kt2Av2iWAqAl90YA=;
        b=Y4GvbzaoLa9RfNq/rkv/ckv9IDOyMzLbZyobLIQzpc9afBbVq73baUOY+Iu/Y1pxGG
         Zlvm2Cln/tZjONx1m9haoDVySF9bFsaQEOzixGO6wURuq5lXp38ACUG9dt4K1mhpL6og
         /YWRhhCtUyjYJiXJ51YYk/nZ06KtBbAr9+aIsUOrnpfiBY2vdsD9mD+QWH2HF7W626d5
         MpuEXGxJTc4xURn78KBGuWVsHlVdfIt+WtUS2Zwc1a2PDwmFRCePNgKaZsO9VwXrIzFc
         M44alD5LdVeZEXwmtGkOSFJs6GsGjqVsMptAXxEwntpUp/+OSZw5YbGkVqK3+Z7I/si/
         tRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMNEAMLzBebcm9SX+NlzCoC55m6Kt2Av2iWAqAl90YA=;
        b=U5k3ncsMIuRKaYujFKRzCFdGPLTZVAD9rguv06Jr6Z5eAy7+iScvUljmn8gKxXFrOf
         VyNzrqw3wtr7QVjIzvXG5v43LMKiFDVka2ipur6/dXd2rv/Y7wBTg3jONQm2sli6wU4+
         g5zcvzU3E5jYCYOmzig71ZXkergZl3tDi/N2F8ycuLNo+qh7HDOHMwBgNji6kgMPeXmr
         bxAPnaYmbpWhA29sKjqdCBDB+TeckLhwuVZTZ8cCApJmSeje+DoXwMTCkKicWGp3K46b
         UYPuyUVVNL46bv51WU5JcLOlSbBR8XrtpuVyaEhjnQXerzuZZqtkdLo8fF4oZJgKfIO6
         gh8Q==
X-Gm-Message-State: ALoCoQmal9W7CrZT/zwE50bD/o6LWSKPyND+LmrBvomLQ/8YZ1x9omSl+CupAyn+0yATYlePMjJa
X-Received: by 10.58.164.226 with SMTP id yt2mr1439346veb.7.1403020445287;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si1208001yhp.6.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 25D1431C76B;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 043CCE0EE0; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251887>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..054f5ef 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -153,7 +153,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -166,12 +167,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
-
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
+ 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.438.gec92e5c
