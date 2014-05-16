From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 14/44] replace.c: use the ref transaction functions for updates
Date: Fri, 16 May 2014 10:37:02 -0700
Message-ID: <1400261852-31303-15-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM7E-0003yj-6q
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbaEPRjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:40 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:48184 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so886245vcb.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AlMPF8c6N1xfPzucBzx+Dp10EYZqLTUnrkh4r6d+LKI=;
        b=VGlVYGy43+7oJ8ZUmwLIYWA2B1JgxiR6I3A2V9wlSylfW5t5IsiwMRsCFZFJt7Dbvi
         K+gUuEOaVkvM55divbXeyl1Kba5Ty1RilxP4GhPHJfOKFqMZVyv7xLQyrcpbYAociAjw
         6VJ3fZPMU6gl7uouXcjtHJcXgHQgw6rc1XCUVfHFprKauz6drTHcLg8OKHPwLv48MIeT
         wuWG4NZtA92oE1CFMKQzLg/9opvuz8/+3kMKFRvAKtBwhXoTAB6a7kzRsQ4dyjXmZPGy
         LXmBVOKFIUHqk55cCuN1WfgnmjMFEYKGAH0E37U2SdZLyWB1k+Dok2mL4xpAbBzjDzv0
         vV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AlMPF8c6N1xfPzucBzx+Dp10EYZqLTUnrkh4r6d+LKI=;
        b=PkadvPOlVC1voLJylgYjSYVXtPh0nHnxl92k19BKSaMQ+KfxgB0le92a1fIh2L9Dkx
         VdeZ7pK+q3NFNC1UNTH2MMJQQNQKqb81Bt7PJAmotOqcVQyIEKPhEFsf18I6iBs8nSOd
         IjK9xBPzUiX829lt52K9CRpP20s/1aDZodmMoryNekCYEjCKhWyF7xQo6KYcs/o/3OCK
         uBei6BpY2Ya2Tb1Y+uCA5xJIy4dVXhVbUjFSzJSMG3r4JDVDJ3/zFYXtfT0+OBUl6p5D
         vI+yP7NwDusXqYagM2/XXSgluXusgJoxIwiCv/fS4mSGDZo6GeHYZi1pdfMO/m7o4abA
         QShw==
X-Gm-Message-State: ALoCoQmYmNOlkQqjWghFuris8N9S4MdLmMRWhBUbzL5OD+kFP7UXbCU0fYpjgx1HXCyEU8pqZ84T
X-Received: by 10.236.92.15 with SMTP id i15mr7498588yhf.8.1400261857316;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si442303yhk.4.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2BA345A40F6;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 070F5E18B3; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249398>

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
2.0.0.rc3.510.g20c254b
