From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Introduce a global level warn() function.
Date: Thu, 21 Dec 2006 19:48:32 -0500
Message-ID: <20061222004832.GB14789@spearce.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYaV-0002yc-53
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423164AbWLVAsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbWLVAsg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:48:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57672 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423164AbWLVAsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:48:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYaF-0005Pk-SS; Thu, 21 Dec 2006 19:48:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6234E20FB65; Thu, 21 Dec 2006 19:48:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35100>

Like the existing error() function the new warn() function can be
used to describe a situation that probably should not be occuring,
but which the user (and Git) can continue to work around without
running into too many problems.

An example situation is a bad commit SHA1 found in a reflog.
Attempting to read this record out of the reflog isn't really an
error as we have skipped over it in the past.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-compat-util.h |    2 ++
 usage.c           |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 41fa7f6..304cdbf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -71,10 +71,12 @@
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern void warn(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 extern void set_usage_routine(void (*routine)(const char *err) NORETURN);
 extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 
 #ifdef NO_MMAP
 
diff --git a/usage.c b/usage.c
index 52c2e96..4dc5c77 100644
--- a/usage.c
+++ b/usage.c
@@ -29,12 +29,17 @@ static void error_builtin(const char *err, va_list params)
 	report("error: ", err, params);
 }
 
+static void warn_builtin(const char *warn, va_list params)
+{
+	report("warning: ", warn, params);
+}
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
 static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
 static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
+static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
 void set_usage_routine(void (*routine)(const char *err) NORETURN)
 {
@@ -51,6 +56,11 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void set_warn_routine(void (*routine)(const char *warn, va_list params))
+{
+	warn_routine = routine;
+}
+
 
 void usage(const char *err)
 {
@@ -75,3 +85,12 @@ int error(const char *err, ...)
 	va_end(params);
 	return -1;
 }
+
+void warn(const char *warn, ...)
+{
+	va_list params;
+
+	va_start(params, warn);
+	warn_routine(warn, params);
+	va_end(params);
+}
-- 
1.4.4.3.ga78a1
