From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/20] replace.c: use the ref transaction functions for updates
Date: Tue, 15 Jul 2014 16:34:04 -0700
Message-ID: <1405467258-24102-7-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFN-0003Pj-MB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934358AbaGOXeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:37 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:51668 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934246AbaGOXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:24 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so20927yhl.5
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p2z1n13u3KGQeJ4KYoCDy3lRbHOhTuOt834D3zUDqWE=;
        b=asrS374EfSSsfMzAlcAMAObHFScwSmM1RueyDe6PHpmp5PWxr8WOqbKlf2oRMWyUZP
         V0PKDnFx3zlOB5Q/IJ6emr1hxshtuK8wWHBuBjWEl7Z5g094AlDbkK5x9Plmtf3VQSdq
         ata1cShGyqedm7wWV4y82ZOgxRflEu+/VTGMmP6VFrsjI2FIwk96xWiNjfv4nDKT5K3C
         xyY/M+Bqa/wdycA6SfjsRLyHBFIQyLsSGSMeAlim0/z7M4F/5jN51pl7gmTfmm0EC/sI
         l8wj2bONwzavUc9RyPAiNF+GPTQ4/qzhRLVeVLUCrv9EJcOIUhfK/IIvsfGlqlTHkmLr
         BUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p2z1n13u3KGQeJ4KYoCDy3lRbHOhTuOt834D3zUDqWE=;
        b=iYuC9H9RXNTPt4CC49I3TGy9hxYqPLYjs/QSsagdbT8Q8AmPQbQ2+qSqR4vohbdCun
         /4jjlRN8YEv6ZeOUB975gAW5k4Zdhs3J+Tx6C0+AKj38kRtzvzVZO7yw/Ij7OG8oAyoe
         51xDO0/amL5FEeDlYbHCT6vUbhp53ZqGw8a5Mre59qC+Lu2Fiv8fJgjBQeuFwNSHt83h
         DJhe2awkvACUHqY6dKr1iPm78pclrAxgFZfjJMVsPDI/15QS2QtzZTill1UpDJeOSbhI
         jEDUhKxVcXQKEa4hZpRc9CgEKV23OJ6vU6uUmgzxMLMrhL3PS3s8jHel7lXTk5TRMuGY
         XW6A==
X-Gm-Message-State: ALoCoQmZKSiaOVQwarrGaYYkvLir1Oa5VMUC2YrYB/VGy8Z+Rcft/GuXGhlkIIzL4B91AyUwEmjO
X-Received: by 10.236.228.98 with SMTP id e92mr843783yhq.58.1405467263442;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si1059797yhh.5.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 49D2931C2EA;
	Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 12643E0DBC; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253633>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..7528f3d 100644
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
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.1.442.g7fe6834.dirty
