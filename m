From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Wed, 25 Feb 2015 22:04:16 -0500
Message-ID: <20150226030416.GA6121@peff.net>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
 <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
 <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
 <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 04:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQokS-0005jM-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 04:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbbBZDET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 22:04:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:53454 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbbBZDET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 22:04:19 -0500
Received: (qmail 29428 invoked by uid 102); 26 Feb 2015 03:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 21:04:19 -0600
Received: (qmail 21038 invoked by uid 107); 26 Feb 2015 03:04:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 22:04:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2015 22:04:16 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264422>

On Wed, Feb 25, 2015 at 02:52:26PM -0800, Junio C Hamano wrote:

> This is now in 'master', but I wonder if people are getting
> compilation errors because of this change.  I do.

I usually compile with NO_GETTEXT, but if I stop doing so, I see the
problem, too.

> I really do not like a conditional inclusion of system header files
> inside any *.c file, but here is a minimum emergency fix-up I am
> running with today.  It should go to somewhere in git-compat-util.h.

Perhaps it would be less risky to stick get_preferred_languages() into
gettext.c, like the patch below. Then we do not have to worry about
locale.h introducing other disruptive includes. The function is not
technically about gettext, but it seems reasonable to me to stuff all of
the i18n code together.

Another variant of this would for gettext.c to provide a git_setlocale
that just wraps setlocale (and does nothing when NO_GETTEXT is given).

diff --git a/gettext.c b/gettext.c
index 8b2da46..7378ba2 100644
--- a/gettext.c
+++ b/gettext.c
@@ -18,6 +18,31 @@
 #	endif
 #endif
 
+/*
+ * Guess the user's preferred languages from the value in LANGUAGE environment
+ * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
+ *
+ * The result can be a colon-separated list like "ko:ja:en".
+ */
+const char *get_preferred_languages(void)
+{
+	const char *retval;
+
+	retval = getenv("LANGUAGE");
+	if (retval && *retval)
+		return retval;
+
+#ifndef NO_GETTEXT
+	retval = setlocale(LC_MESSAGES, NULL);
+	if (retval && *retval &&
+		strcmp(retval, "C") &&
+		strcmp(retval, "POSIX"))
+		return retval;
+#endif
+
+	return NULL;
+}
+
 #ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
diff --git a/gettext.h b/gettext.h
index dc1722d..5d8d2df 100644
--- a/gettext.h
+++ b/gettext.h
@@ -89,4 +89,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 #define N_(msgid) (msgid)
 #endif
 
+const char *get_preferred_languages();
+
 #endif
diff --git a/http.c b/http.c
index 0153fb0..9c825af 100644
--- a/http.c
+++ b/http.c
@@ -8,6 +8,7 @@
 #include "credential.h"
 #include "version.h"
 #include "pkt-line.h"
+#include "gettext.h"
 
 int active_requests;
 int http_is_verbose;
@@ -1002,32 +1003,6 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
-
-/*
- * Guess the user's preferred languages from the value in LANGUAGE environment
- * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
- *
- * The result can be a colon-separated list like "ko:ja:en".
- */
-static const char *get_preferred_languages(void)
-{
-	const char *retval;
-
-	retval = getenv("LANGUAGE");
-	if (retval && *retval)
-		return retval;
-
-#ifndef NO_GETTEXT
-	retval = setlocale(LC_MESSAGES, NULL);
-	if (retval && *retval &&
-		strcmp(retval, "C") &&
-		strcmp(retval, "POSIX"))
-		return retval;
-#endif
-
-	return NULL;
-}
-
 static void write_accept_language(struct strbuf *buf)
 {
 	/*
