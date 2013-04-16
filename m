From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] usage: allow pluggable die-recursion checks
Date: Tue, 16 Apr 2013 15:46:22 -0400
Message-ID: <20130416194621.GA11185@sigill.intra.peff.net>
References: <20130416194418.GA7187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBpl-0007zJ-B8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935677Ab3DPTqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:46:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48343 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935589Ab3DPTqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:46:24 -0400
Received: (qmail 7817 invoked by uid 107); 16 Apr 2013 19:48:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 15:48:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 15:46:22 -0400
Content-Disposition: inline
In-Reply-To: <20130416194418.GA7187@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221458>

When any git code calls die or die_errno, we use a counter
to detect recursion into the die functions from any of the
helper functions. However, such a simple counter is not good
enough for threaded programs, which may call die from a
sub-thread, killing only the sub-thread (but incrementing
the counter for everyone).

Rather than try to deal with threads ourselves here, let's
just allow callers to plug in their own recursion-detection
function. This is similar to how we handle the die routine
(the caller plugs in a die routine which may kill only the
sub-thread).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h |  1 +
 usage.c           | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cde442f..e955bb5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -331,6 +331,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern int suffixcmp(const char *str, const char *suffix);
diff --git a/usage.c b/usage.c
index 40b3de5..ed14645 100644
--- a/usage.c
+++ b/usage.c
@@ -6,8 +6,6 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-static int dying;
-
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
@@ -49,12 +47,19 @@ static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 	vreportf("warning: ", warn, params);
 }
 
+static int die_is_recursing_builtin(void)
+{
+	static int dying;
+	return dying++;
+}
+
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
 static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
 static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
+static int (*die_is_recursing)(void) = die_is_recursing_builtin;
 
 void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
 {
@@ -66,6 +71,11 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void set_die_is_recursing_routine(int (*routine)(void))
+{
+	die_is_recursing = routine;
+}
+
 void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
@@ -84,11 +94,10 @@ void NORETURN die(const char *err, ...)
 {
 	va_list params;
 
-	if (dying) {
+	if (die_is_recursing()) {
 		fputs("fatal: recursion detected in die handler\n", stderr);
 		exit(128);
 	}
-	dying = 1;
 
 	va_start(params, err);
 	die_routine(err, params);
@@ -102,12 +111,11 @@ void NORETURN die_errno(const char *fmt, ...)
 	char str_error[256], *err;
 	int i, j;
 
-	if (dying) {
+	if (die_is_recursing()) {
 		fputs("fatal: recursion detected in die_errno handler\n",
 			stderr);
 		exit(128);
 	}
-	dying = 1;
 
 	err = strerror(errno);
 	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
-- 
1.8.2.8.g44e4c28
