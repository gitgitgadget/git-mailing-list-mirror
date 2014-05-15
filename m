From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 17/44] fast-import.c: change update_branch to use ref transactions
Date: Thu, 15 May 2014 10:29:32 -0700
Message-ID: <1400174999-26786-18-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUf-00086L-4G
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbaEORa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:27 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:42400 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so241400veb.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrH7xxfulTmZ9sswtmkpppUMftIz46WnbWWRO+4bees=;
        b=VK/GhQOjfYXZj/jAsMD2tyEakdu3sktNzQMXToepFjvtZpaJ8M/LLvwxPMmYzBKAP3
         jaZagfvozlARv7EB+t5Tv6P8NY13ByRsqr0OC+46Ul23iGwoee1+iq/b9jO+R7S8tkQs
         PO9EVlGquk+m3VlP/49sje/PjP1S0GrqD3/Jtk48ZcDKSLXYTW+TZz265Fpuij2nTdZ9
         6cYHq8tolI6lBJAywOPmzP5XzWV/M4YNGrdVplU39wUo/+4GXC04gph3eUCtTlO+fqlJ
         dldsQ6UFfu+RDdzVZWlk6jO4Oi00MSKdXrSY/7JETFxp5KtsUd9wf7eUfkix2/Tb8eIM
         psSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrH7xxfulTmZ9sswtmkpppUMftIz46WnbWWRO+4bees=;
        b=WBSlUOcA3bowQVzxBgyLxaJ6o14sLrsnjDOszq7IorypBpegMbtaNZ99aR/KhL9Pip
         0mHpVubxnlxe/7BiTsDg9oNswcNGXpzJmVdvVe/VM0+DKea0n+KplFEG5cLWv7qLdy8T
         PTpcx+lDa3aKsv1xuggQVFlJDC6/6fNjoZkABMG0EG4IngyuxCbigUeci8wCklacmpMo
         wCcLuEMR6eAkM9FiHes9Nx+/stCjr0wuAeKflj8PoU59ZgUme1lY+df1lJ2sryaXHO/W
         hbLdcp9jGggZ69LmBMdZt7vr1IBmKKO12nz2BijBoBMKXrr+xNpUPlwAj2tCQeqvCwU/
         qhAA==
X-Gm-Message-State: ALoCoQmgBEWUSzNWK0ulhtEZv4tW9uk13bVixeeh2tYAx0TNeEjdwJH0TnlOsgiG789rDfZVtDwl
X-Received: by 10.224.147.72 with SMTP id k8mr4732432qav.5.1400175006497;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si273447yhq.3.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5BD565A4320;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 38509E1530; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249132>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..79d219b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,39 +1679,45 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
+
 	if (is_null_sha1(b->sha1)) {
 		if (b->delete)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
 			return error("Branch %s is missing commits.", b->name);
 		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1)) ||
+	    (ref_transaction_commit(transaction, msg, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error("Unable to update branch %s: %s", b->name, err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.0.0.rc3.477.g0f8edf7
