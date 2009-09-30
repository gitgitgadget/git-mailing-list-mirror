From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 1/2] increase portability of NORETURN declarations
Date: Wed, 30 Sep 2009 18:05:49 +0000
Message-ID: <1254333950-2440-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, gitster@pobox.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 20:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt3Z7-0005FB-AI
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 20:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbZI3SGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 14:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbZI3SGC
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 14:06:02 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43097 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbZI3SGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 14:06:01 -0400
Received: by bwz6 with SMTP id 6so3012031bwz.37
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=aTu/RVfeM/Sst0d12xV3jjcFfnfc0meyuvRjKeg1vdI=;
        b=lt9Nvo5AVmDO16NPP/+Huk3zINIFNiXE4yGYI0OZKBS1ejmAgsi45giwGEkVahINmV
         pJDN0EXO17Qxv3fRNqvmINWuA0hQdrsj/6aX3wtlc9QAi45QugxIgkm7pQeJGCFfRcKO
         bh2tPIBNAg44e9H+gjNy7OY2PAphU5gmkgjHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=c/Z7ExK3tFqpLeMpqspZXGUNb/U5sQ5YFKopJGsczGNGaONbNaxBP5EDwaaszpQmia
         6hco+O6c4YPRVR7fWVkDMjxqU0Kfb90HQBhjq0iKeZta0JmWC8QZ5S6P3P2Pj7MC3OHq
         2BqHhhTTQcwD9lLAe+Qcj6WH5go5EVj1TH3wA=
Received: by 10.204.10.2 with SMTP id n2mr92609bkn.91.1254333963632;
        Wed, 30 Sep 2009 11:06:03 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 21sm253215fkx.4.2009.09.30.11.06.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 11:06:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129346>

Some compilers (including at least MSVC) supports NORETURN
on function declarations, but only before the function-name.

This patch makes it possible to define NORETURN to something
meaningful for those compilers.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 git-compat-util.h |    8 ++++----
 index-pack.c      |    4 ++--
 usage.c           |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9f941e4..33dd4f3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -177,13 +177,13 @@ extern char *gitbasename(char *);
 #endif
 
 /* General helper functions */
-extern void usage(const char *err) NORETURN;
-extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
-extern void die_errno(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
+extern NORETURN void usage(const char *err);
+extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
-extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
+extern void set_die_routine(NORETURN void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern time_t tm_to_time_t(const struct tm *tm);
diff --git a/index-pack.c b/index-pack.c
index 340074f..b4f8278 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -206,8 +206,8 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
 
-static void bad_object(unsigned long offset, const char *format,
-		       ...) NORETURN __attribute__((format (printf, 2, 3)));
+static NORETURN void bad_object(unsigned long offset, const char *format,
+		       ...) __attribute__((format (printf, 2, 3)));
 
 static void bad_object(unsigned long offset, const char *format, ...)
 {
diff --git a/usage.c b/usage.c
index b6aea45..0555ce6 100644
--- a/usage.c
+++ b/usage.c
@@ -36,12 +36,12 @@ static void warn_builtin(const char *warn, va_list params)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
-static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
+static NORETURN void (*usage_routine)(const char *err) = usage_builtin;
+static NORETURN void (*die_routine)(const char *err, va_list params) = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
-void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN)
+void set_die_routine(NORETURN void (*routine)(const char *err, va_list params))
 {
 	die_routine = routine;
 }
-- 
1.6.4.msysgit.0.17.g82372.dirty
