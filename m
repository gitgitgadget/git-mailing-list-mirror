From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 12/19] replace.c: use the ref transaction functions for updates
Date: Fri, 25 Apr 2014 09:14:47 -0700
Message-ID: <1398442494-23438-13-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:15:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdimu-00076U-JB
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaDYQPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:17 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:49008 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbaDYQPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:06 -0400
Received: by mail-pd0-f201.google.com with SMTP id fp1so156933pdb.4
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0oZzYT/2ZsXJfy2Gl54XK3Y6mo72n0aZmUjQKXzZYYE=;
        b=mokbAkFQOubf4pdC/RnUC5tPpivgMdgyVAZr9bWKr/wOIFiohxJLByVBsThnNuHGa5
         ZLd2E6n1/ujTrpxBAc6THOLTqb1JbLneumO0+ABGQvkx4AGb5fI1u8AYICPeBipAFedM
         wwV2gabmx4LIK5C1g0Wh/RsNvKVzbfpGnf/61vZJZOllKeODJVh9ucM6MLZgBChiTb35
         /lfWglUeOlJTS830/EeJSxGlGiXyyWSluveqEP6s4l1n9W65ARgsHs0CFGOvwjOpDS5Q
         66l7ljpX14KBKbPoOz5vgbGOw+YJXqDHqYkBFoFlaMp6yKzv2BD866NO+FFqCkmSykAJ
         tfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0oZzYT/2ZsXJfy2Gl54XK3Y6mo72n0aZmUjQKXzZYYE=;
        b=TfilcQeIbAGCZRNR+oT5bPDE91k69/gw4o5tE2SBHYFqnxmJLEjhub1S1QV9VyDCJA
         6hu9Cej3Z7WA0/ugOEQmk0LRMNQjFPIoJyUK1dO92Uqx8hXrIJCS2JgiGbLK9z67JI+Y
         htzVzEgwrSBnv0lGwB7Z5gk+/AXenOb9kIpFw/JgXjqfSP78ilVfzHjldmLcZl2m6uYY
         AAw8Gzou4WJmfONuFPcRqOwkMoZmHbqfXSvt8ZZ2Sjq3War87IU1ZnMg7+/BIWNio1BS
         lgzu0iH9nnfDehVAf+L6BC7vWSikK6akeOEa/OSz4u1o3lXH5gbnpp68MVMZHO2ffTf2
         LWaw==
X-Gm-Message-State: ALoCoQmdDm9ZyVGq6scfOeqJl0y4FKbLBL1/ijr1jjWsdq62Rfk+OAW+0deM2I7Lnc7AFDf3BP1wZ/bsO0+htfHNe1xdauL9ZOTmrnmiWqICs3By7vWxWEk7n9Bzk+fGAvmjHA488Ra2mP+zLr2+cdmXo2b+9oE0EqGdR7tWFii+QSBGA3+VyP/oMnx45oUPcLeNUZK3B/mt
X-Received: by 10.66.66.109 with SMTP id e13mr3638956pat.1.1398442505403;
        Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1050719yhk.4.2014.04.25.09.15.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3A50C31C29A;
	Fri, 25 Apr 2014 09:15:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D7D6FE0855; Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247054>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..cf0f56d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	char *err = NULL;
 
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
+	  die(_("%s: failed to replace ref: %s"), ref, err);
 
 	return 0;
 }
-- 
1.9.1.521.g5dc89fa
