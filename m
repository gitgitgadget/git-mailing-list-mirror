From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 24/42] fast-import.c: use a ref transaction when dumping tags
Date: Wed, 14 May 2014 14:16:58 -0700
Message-ID: <1400102236-30082-25-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgaq-0006qB-S7
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbaENVTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:55 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:54420 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaENVR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:28 -0400
Received: by mail-ie0-f202.google.com with SMTP id ar20so40666iec.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FveKRgJ7nC7eZ+NtxA75+dpHMRdy6eDTQCMlLlKfRHY=;
        b=VMV1YQGlN3o/y10UEVPWjWG4JgcntKfab6MBDs0ryYnhirOjR61/LYF1SAzCVKKn0l
         5VkaV9WTjWY+VpPLGVHO2zdm4R0iMY719aHzav0rANlyIpTO7e6F+rcH8UXPMRpG3Uhk
         Vst5eAlRGY1QeEne82BsusjvGDg8EUaDSBio+ghmOqdEqITQRi2KL7w9t7iuAo5HGXEB
         gO9eMl1ZgUVejiVwzh/XsQRlJI9Q9BTLWDOnsRMNrXX5jYUK4oERl4F0I4AGQk5j112K
         huhw2PA+W0iSHjmyqZqOfZkAvctVdaRUE5tvAt1T+37H8zA7VeExmgZ9VTw+Bdf3jvA1
         pJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FveKRgJ7nC7eZ+NtxA75+dpHMRdy6eDTQCMlLlKfRHY=;
        b=Tec9qowWnaaGo/h3r6WFzTuR93LRUrmMpWZw0J6nhwlF3lCTu83bjU27IEHuA1ZIiF
         v5E22+gVDRzOdThJyKd+DLevDMOJsed0D+evYH9sDkEBfD0rEbxYv/8WHwW+iSLYzLef
         YFybFCx9E7j1f0pRB80YG0CXsU8hsUFdlQCyQ4pINprsREbFG+Wg9e8qxCGa9cNWpmYq
         wN0cy3bQyaq8GtxCgib+fYoAcAqH3ZzguCE1nzM+VK2M11nGwCPIQOsAPEAcXJGi9IXn
         Anux/s4BYNSnilIsptaD5CF4mHeHWafSJzoOxIqwxgT/IGuSleli5m1c0RzlBVM9jf6t
         fu0A==
X-Gm-Message-State: ALoCoQldwKMlN+u10gWxCnedRYl7q3sziwaqKteVKIAsSJEc/Jz7855dDSYpPMOzVxdajxE2RPjl
X-Received: by 10.50.254.1 with SMTP id ae1mr18596529igd.6.1400102248129;
        Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si144570yhb.6.2014.05.14.14.17.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F1F375A42DA;
	Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B6A67E0973; Wed, 14 May 2014 14:17:27 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248976>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3e356da..5587cf6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1736,15 +1736,22 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
 	char ref_name[PATH_MAX];
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin();
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		sprintf(ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name, t->sha1,
+					   NULL, 0, 0))
+			failure |= error("Unable to update %s", err.buf);
 	}
+	if (failure || ref_transaction_commit(transaction, msg, &err))
+		failure |= error("Unable to update %s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.rc3.471.g2055d11.dirty
