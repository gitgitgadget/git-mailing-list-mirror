From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 14/44] replace.c: use the ref transaction functions for updates
Date: Thu, 15 May 2014 16:15:11 -0700
Message-ID: <1400195741-22996-15-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uP-0000IV-CI
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbaEOXRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:38 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:43053 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so388907obc.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HvRpv8LUKd7YS3hYc34s62b3C4ldVVXntSxtlItyh1A=;
        b=BUEgh5kfaJkIF2jiNIJgev1gusUWMYMzhWHavI1vgSA1WTqHI2wsr32JLEK00vRwTe
         wUblIihv27UmKLk73VrpSzi8SAYoMLxBeirc2N9eMmkGmw9b/rk0sp0nqmZ+old7eul7
         hFWFAXjbLx2Re6+q9U6RXZ+fVcadVkWyKCu/U34vlIkmTWdaZqFICW9iNQT7MjugkWo4
         IyiZ+EgAdVGY6GfFuRQb+9GYMJ0sCcfu8VA+XqakXxddG/7p6XNMqgQ6Mt8HmFvGslJH
         ddopcu+cZYhIVBYd6Mh4EJQjVsHTanNI1v7vbQ1O16BJ9V26T35j9uaT+FiNu8vMYfWh
         j+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HvRpv8LUKd7YS3hYc34s62b3C4ldVVXntSxtlItyh1A=;
        b=Ihux9Q2UhGeMBzq2vf5sjDVQhCwE7720YlqsxUyeHxRBDeXvpsqw7b9oKrTo8y8dSF
         DTMvVvCFFPOeNg/WmvhMqxbMN4u88UJHfrWRBXZXMkGdw9KQQ8fO3xN0VtDu7DyQQc1r
         LJoqg7vCQW/YjKnLFFJAW7E5cNA595fQwtxoJz74gMCfX45sPQxEKqDnHAtuFlLM4+aT
         nUbMDsfNp4xYCtAvRCBc8oYIze9QKDSiYfKtw6dU5kPXtBQW+4g4mOUq2F9kmxn0/c+T
         IrPMUOOdZmZiFGUarEkSRCIaonon6myKNfbcIdhxbcUS5NpGiSUc1u8WBjWHDhPXAa/z
         LR7Q==
X-Gm-Message-State: ALoCoQmhm/QqxD1OUJ4LzTAN1cQClwzf/EqiAxJiTbefLHrh/r4loarcJ2Vfpx4HnTzVOGg2LG0q
X-Received: by 10.182.121.232 with SMTP id ln8mr6622157obb.11.1400195745083;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si317563yhl.7.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E477A31C1CD;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C0A1AE0FBE; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249260>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3da1bae..e8932cd 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -133,7 +133,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (snprintf(ref, sizeof(ref),
 		     "refs/replace/%s",
@@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
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
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
 	return 0;
 }
-- 
2.0.0.rc3.477.gffe78a2
