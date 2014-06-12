From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 11/48] refs.c: make remove_empty_directories alwasy set errno to something sane
Date: Thu, 12 Jun 2014 10:21:02 -0700
Message-ID: <1402593699-13983-12-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:25:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8kJ-0001Xh-AV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407AbaFLRYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:50 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:65058 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so185901pbb.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ac8EoZ+DcrDGtfySbti7Y0ZQ7KnrMVoshtai6+vq1oQ=;
        b=WdM2ARYmb5FFroR5bcp4rD9nZuStuPYNLwKloPMRv+B5O8/zGx5g/w54i3Kst6klbi
         hZ2+NA2I5iNhB08fjamJHjCFkxAvSWuKWuOWkxa4Zd4JUeJ3+ohqN7LSlIb3xa0S/3RD
         STfgAn+Nptf15XSb7aTGtx22jOELp/VRaQBzunZ8t4djycWiQG/say98qbE39V5Zr2GV
         cCYFpj51WmmyBTUL7xIkJr9ZaurXZGhsD5d53ItnemFt2vL3ZEEroA711H/EJhr9xjix
         IG7tsgg7QWzm8yVI95oUcA2HPiYm35mipsozON7lruGeE+3kEJad5FtN3GfC/XFlcPYK
         CLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ac8EoZ+DcrDGtfySbti7Y0ZQ7KnrMVoshtai6+vq1oQ=;
        b=T7zW2QC7tGpR9rSUJXaaa3oz52RHrjtlaWFuFi8qNETiROWWY5GiLnv4ZU6GpvCxW2
         WT4yvrsIpL14Z7iTKK8kBzx35d/cG1KDnaVND0xiPs3AW0nmw4/IxSvkNqWFxXkvSJb2
         J9Jvna0qtLnl3fw91cQIZGZyePQ00zb16e2vi47FPAE7wdRlM0YKDD9EmRHm+SKqOkmE
         ORX4kMTrQewhZ8PKLs1NmjUwlCOrDW0XJ+qzK6UhIL6RSGSNxP3xzTceNNQMPmUyFejb
         GuVcXzJuNfyUG8WewZyvd7P9WZlz5TBobHXaxRFUCwDCGJSisM+liQapy7n5kIZNc6Tr
         IEcw==
X-Gm-Message-State: ALoCoQlg7AwWPaZ7nbaHIga0UtVNlyl8wbJJeFAcP7eoO64LK7cp7VlQjohwm5GsyW46w8RKfpXE
X-Received: by 10.68.135.200 with SMTP id pu8mr19091887pbb.9.1402593703312;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si113767yhm.0.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 242F131C66C;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D21F0E0A0A; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251463>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3631a3b..dd28214 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,14 +1932,16 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
 	strbuf_release(&path);
+	errno = save_errno;
 
 	return result;
 }
@@ -2028,6 +2030,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
-- 
2.0.0.599.g83ced0e
