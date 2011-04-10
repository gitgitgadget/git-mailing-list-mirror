From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/11] usage: Introduce error_errno correspoding to die_errno
Date: Sun, 10 Apr 2011 20:41:54 +0530
Message-ID: <1302448317-32387-9-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKo-0008SI-UB
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab1DJPNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab1DJPNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:48 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=z6tK4xS+Xq9OlIh4Nj7B2BLxsVMu2nMwLj49QWtg3MI=;
        b=v78tUg50DZ8T8k3kXCH8oVnlrHDVuBkWmcFuk8ktjc7c3i3QHLrs4KDBPl3F0hSxL9
         P7DB+P6XugRpaeBjZJe8nmNJf3ChRHumBV0hWyroafSE9RY5zHzEnzVbOsQtGBTdSNZ1
         MXvDpld8Tay8HoODj5q0FBhsmugqBDfgKmTDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tEhQaPlXcAc28f7CtFdvnwsBMZnczy359BBW8xgzaUPQXrsZZkN8qqh/ukr/J3gBrU
         +0E/MKKGSNbpVPztbHsM7aGK+mfQ2swLKdMPct7ArHYZTsqS1iTkQCY8KZQ8zlJPoGBM
         g9/mmeFRzTAeKqtvtOkk8mKISnLW2mEXNSn3o=
Received: by 10.42.11.207 with SMTP id v15mr6811501icv.22.1302448428574;
        Sun, 10 Apr 2011 08:13:48 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171262>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-compat-util.h |    2 ++
 usage.c           |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..00d2815 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -240,10 +240,12 @@ extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
+extern void set_error_routine(void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern int suffixcmp(const char *str, const char *suffix);
diff --git a/usage.c b/usage.c
index b5e67e3..8724b41 100644
--- a/usage.c
+++ b/usage.c
@@ -46,6 +46,11 @@ void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list param
 	die_routine = routine;
 }
 
+void set_error_routine(void (*routine)(const char *err, va_list params))
+{
+	error_routine = routine;
+}
+
 void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
@@ -97,6 +102,35 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+int error_errno(const char *fmt, ...)
+{
+	va_list params;
+	char fmt_with_err[1024];
+	char str_error[256], *err;
+	int i, j;
+
+	err = strerror(errno);
+	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
+		if ((str_error[j++] = err[i++]) != '%')
+			continue;
+		if (j < sizeof(str_error) - 1) {
+			str_error[j++] = '%';
+		} else {
+			/* No room to double the '%', so we overwrite it with
+			 * '\0' below */
+			j--;
+			break;
+		}
+	}
+	str_error[j] = 0;
+	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
+
+	va_start(params, fmt);
+	error_routine(fmt_with_err, params);
+	va_end(params);
+	return -1;
+}
+
 int error(const char *err, ...)
 {
 	va_list params;
-- 
1.7.4.rc1.7.g2cf08.dirty
