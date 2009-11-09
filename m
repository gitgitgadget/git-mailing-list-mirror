From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/24] Let usage() take a printf-style format
Date: Mon,  9 Nov 2009 09:05:02 -0600
Message-ID: <1257779104-23884-22-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfF-0002nn-1I
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbZKIOzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbZKIOzu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:50 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZKIOzt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:49 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FL4FoLA/+e1uCNWOCqP8AZSOUJbkokwepEPIFj4z2Lc=;
        b=iEm0Ghet78QbPtYyDYWcnmYwcgau17stcuFmv9UZ/s/k3U4KiA5THh2EtX1DQd5jP2
         los1b72g1dqKKq/vX8hlBEzWDY0AZ1TyIXWGAEsiIYlARdC/26qEQWkDo58EmuWgOnW8
         34qSWUuOniX9MxThfjqbrJ4xm/5ErABxLzZo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eG/DwNqQSob2QEVqBwwgd9WsaosOQygtoyN/wcss0rRjmcCZya/oJWdPQtCRyO9oNV
         9fvbI/yNH7Xak9iOG4ME/sqD+MggAu4Jxuv2VmPivxG+bc6xvMm1z35XQ1otv8wSMW0z
         LRSh0XZ9zmNywi9jruM9Nhvg02TKNASrxkLm4=
Received: by 10.216.89.14 with SMTP id b14mr2618449wef.76.1257778554493;
        Mon, 09 Nov 2009 06:55:54 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:53 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132480>

merge-recursive and diff --no-index are not able to use usage()
because their usage strings depend on the circumstances in which
they are called.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |    2 +-
 usage.c           |   14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..42048e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -188,7 +188,7 @@ extern char *gitbasename(char *);
 #include "compat/bswap.h"
 
 /* General helper functions */
-extern NORETURN void usage(const char *err);
+extern NORETURN void usage(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/usage.c b/usage.c
index c488f3a..f6d9ff5 100644
--- a/usage.c
+++ b/usage.c
@@ -12,9 +12,9 @@ static void report(const char *prefix, const char *err, va_list params)
 	fprintf(stderr, "%s%s\n", prefix, msg);
 }
 
-static NORETURN void usage_builtin(const char *err)
+static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	fprintf(stderr, "usage: %s\n", err);
+	report("usage: ", err, params);
 	exit(129);
 }
 
@@ -36,7 +36,7 @@ static void warn_builtin(const char *warn, va_list params)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static NORETURN_PTR void (*usage_routine)(const char *err) = usage_builtin;
+static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
 static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
@@ -46,9 +46,13 @@ void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list param
 	die_routine = routine;
 }
 
-void usage(const char *err)
+void usage(const char *err, ...)
 {
-	usage_routine(err);
+	va_list params;
+
+	va_start(params, err);
+	usage_routine(err, params);
+	va_end(params);
 }
 
 void die(const char *err, ...)
-- 
1.6.5.2
