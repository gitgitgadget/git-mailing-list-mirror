From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 03/18] usage: implement error_errno() the same way as
	die_errno()
Date: Thu, 25 Nov 2010 22:20:34 +0100
Message-ID: <20101125212050.5188.56613.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGa-0006bE-H6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab0KZFy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:29 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47285 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab0KZFy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:28 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 61B3EA6101;
	Fri, 26 Nov 2010 06:54:21 +0100 (CET)
X-git-sha1: 613822cf4304cbfc56fdee10b3459e0ea956cce2 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162186>

die_errno() is very useful, but sometimes we don't want to
die after printing an error message and the error message
from errno. So let's implement error_errno() that does the
same thing as die_errno() except that it calls
error_routine() instead of die_routine().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h |    1 +
 usage.c           |   28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 490f969..32294cc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -230,6 +230,7 @@ extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
diff --git a/usage.c b/usage.c
index ec4cf53..f3ac869 100644
--- a/usage.c
+++ b/usage.c
@@ -69,10 +69,9 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
-void die_errno(const char *fmt, ...)
+static void format_errno(char *fmt_with_err, size_t fmt_with_err_size,
+			 const char *fmt)
 {
-	va_list params;
-	char fmt_with_err[1024];
 	char str_error[256], *err;
 	int i, j;
 
@@ -90,13 +89,34 @@ void die_errno(const char *fmt, ...)
 		}
 	}
 	str_error[j] = 0;
-	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
+	snprintf(fmt_with_err, fmt_with_err_size, "%s: %s", fmt, str_error);
+}
+
+void die_errno(const char *fmt, ...)
+{
+	va_list params;
+	char fmt_with_err[1024];
+
+	format_errno(fmt_with_err, sizeof(fmt_with_err), fmt);
 
 	va_start(params, fmt);
 	die_routine(fmt_with_err, params);
 	va_end(params);
 }
 
+int error_errno(const char *fmt, ...)
+{
+	va_list params;
+	char fmt_with_err[1024];
+
+	format_errno(fmt_with_err, sizeof(fmt_with_err), fmt);
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
1.7.3.2.504.g59d466
