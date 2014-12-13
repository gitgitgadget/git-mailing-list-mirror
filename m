From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] win32: syslog: prevent potential realloc memory leak
Date: Sat, 13 Dec 2014 15:11:16 +0530
Message-ID: <1418463676-1753-1-git-send-email-arjun024@gmail.com>
To: git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 10:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzjCo-0008BP-OK
	for gcvg-git-2@plane.gmane.org; Sat, 13 Dec 2014 10:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966335AbaLMJlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2014 04:41:36 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60253 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966332AbaLMJld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2014 04:41:33 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so8754250pab.7
        for <git@vger.kernel.org>; Sat, 13 Dec 2014 01:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=o4zaw0g94YBIKxm7bySV9MK04c0erPuriB8wHeXvj+A=;
        b=GpSxkoKKpatpLy89Y76WMHkJDpccGnH3Q686aFma4RUwgc3/vKhxE7/HYxuvwvco0c
         AnTd87kza3VIc64jSJL2CSBK7vHg94qVX77xeNJGdt5RRfJbeH5R2PhOdH6c7WCf4Wts
         HfAVb1msapmnxZg+9JGtzatoQwqv0k1c+9IH9Zx/zZYVrOHmFKAc35R9Cvd+6A4Zk9BE
         uF2bvse6oG20LQjJ1fdUfud11E+iUBspLbpBtNE+fxU/nSEAISRY4ztI/b+rIAbRubJK
         8LeARB2uOBatmhMYNawvWS4vwkoQhEkXlimzQwHsoAOPRAx/7RckgeL2eisVqMgGner8
         bZZA==
X-Received: by 10.66.179.75 with SMTP id de11mr33166355pac.24.1418463693085;
        Sat, 13 Dec 2014 01:41:33 -0800 (PST)
Received: from localhost.localdomain ([117.217.228.196])
        by mx.google.com with ESMTPSA id r1sm3692346pdp.83.2014.12.13.01.41.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Dec 2014 01:41:32 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261392>

use a temporary variable to free the memory in case
realloc() fails.

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 compat/win32/syslog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index d015e43..3409e43 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -16,7 +16,7 @@ void openlog(const char *ident, int logopt, int facility)
 void syslog(int priority, const char *fmt, ...)
 {
 	WORD logtype;
-	char *str, *pos;
+	char *str, *str_temp, *pos;
 	int str_len;
 	va_list ap;
 
@@ -43,9 +43,11 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
 
 	while ((pos = strstr(str, "%1")) != NULL) {
+		str_temp = str;
 		str = realloc(str, ++str_len + 1);
 		if (!str) {
 			warning("realloc failed: '%s'", strerror(errno));
+			free(str_temp);
 			return;
 		}
 		memmove(pos + 2, pos + 1, strlen(pos));
-- 
1.8.1.msysgit.1
