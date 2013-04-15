From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 19:08:02 -0400
Message-ID: <20130415230802.GA11267@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 01:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsVS-00043V-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934975Ab3DOXIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:08:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47198 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934152Ab3DOXII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:08:08 -0400
Received: (qmail 30459 invoked by uid 107); 15 Apr 2013 23:10:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 19:10:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 19:08:02 -0400
Content-Disposition: inline
In-Reply-To: <20130415230651.GA16670@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221326>

When any git code calls die(), we chain to a custom
die_routine, which we expect to print a message and exit the
program. To avoid infinite loops, we detect a recursive call
to die() with a simple counter, and break out of the loop by
printing a message and exiting ourselves, without chaining
to the die_routine.

But the user does not get to see the message that would have
been fed to the die_routine, which makes debugging harder.
The user does not know if it was a true infinite loop, or
simply a single re-entrant call, since they cannot compare
the messages. Furthermore, if we are wrong about detecting
the recursion, we have blocked the user from seeing the
original message, which is probably the more useful one.

This patch teaches die() to print the original die message
to stderr before reporting the recursion. The custom
die_routine may or may not have put it the message to
stderr, but this is the best we can do (it is what most
handlers will do anyway, and it is where our recursion error
will go).

While we're at it, let's mark the "recursion detected"
message as a "BUG:", since it should never happen in
practice. And let's factor out the repeated code in die and
die_errno. This loses the information of which function was
called to cause the recursion, but it's important; knowing
the actual message fed to the function (which we now do) is
much more useful, as it can generally pin-point the actual
call-site that caused the recursion.

Signed-off-by: Jeff King <peff@peff.net>
---
This helped me debug the current problem. And factoring it out helps
with patch 3. :)

 usage.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/usage.c b/usage.c
index 40b3de5..c6b7ac5 100644
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
@@ -80,17 +78,24 @@ void NORETURN die(const char *err, ...)
 	usagef("%s", err);
 }
 
+static void check_die_recursion(const char *fmt, va_list ap)
+{
+	static int dying;
+
+	if (!dying++)
+		return;
+
+	vreportf("fatal: ", fmt, ap);
+	fputs("BUG: recursion detected in die handler\n", stderr);
+	exit(128);
+}
+
 void NORETURN die(const char *err, ...)
 {
 	va_list params;
 
-	if (dying) {
-		fputs("fatal: recursion detected in die handler\n", stderr);
-		exit(128);
-	}
-	dying = 1;
-
 	va_start(params, err);
+	check_die_recursion(err, params);
 	die_routine(err, params);
 	va_end(params);
 }
@@ -102,13 +107,6 @@ void NORETURN die_errno(const char *fmt, ...)
 	char str_error[256], *err;
 	int i, j;
 
-	if (dying) {
-		fputs("fatal: recursion detected in die_errno handler\n",
-			stderr);
-		exit(128);
-	}
-	dying = 1;
-
 	err = strerror(errno);
 	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
 		if ((str_error[j++] = err[i++]) != '%')
@@ -126,6 +124,7 @@ void NORETURN die_errno(const char *fmt, ...)
 	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
 
 	va_start(params, fmt);
+	check_die_recursion(fmt_with_err, params);
 	die_routine(fmt_with_err, params);
 	va_end(params);
 }
-- 
1.8.2.8.g44e4c28
