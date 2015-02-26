From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 17:07:59 -0500
Message-ID: <20150226220759.GB24663@peff.net>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
 <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
 <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
 <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
 <20150226030416.GA6121@peff.net>
 <xmqqmw40l777.fsf@gitster.dls.corp.google.com>
 <20150226213356.GA14464@peff.net>
 <xmqqa900l57y.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
 <20150226220609.GA24663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR6bI-0008Ch-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 23:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbbBZWID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 17:08:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:53891 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754057AbbBZWIC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 17:08:02 -0500
Received: (qmail 19120 invoked by uid 102); 26 Feb 2015 22:08:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 16:08:01 -0600
Received: (qmail 28525 invoked by uid 107); 26 Feb 2015 22:08:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 17:08:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:07:59 -0500
Content-Disposition: inline
In-Reply-To: <20150226220609.GA24663@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264473>

On Thu, Feb 26, 2015 at 05:06:10PM -0500, Jeff King wrote:

> On Thu, Feb 26, 2015 at 01:47:34PM -0800, Stefan Beller wrote:
> 
> > On Thu, Feb 26, 2015 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:>
> > > Here is what I queued.  Thanks.
> > 
> > I did not follow the thread if there are any intermediate patches,
> > though it applied cleanly.
> 
> What Junio posted is missing the hunk to drop the old static definition
> of get_preferred_languages from http.c.

Here it is, with the commit message and the missing hunk. This works for
me both with and without NO_GETTEXT defined.

-- >8 --
Subject: [PATCH] gettext.c: move get_preferred_languages() from http.c

Calling setlocale(LC_MESSAGES, ...) directly from http.c,
without including <locale.h>, was causing compilation
warnings.  Move the helper function to gettext.c that
already includes the header and where locale-related issues
are handled.

Signed-off-by: Jeff King <peff@peff.net>
---
 gettext.c | 25 +++++++++++++++++++++++++
 gettext.h |  2 ++
 http.c    | 27 +--------------------------
 3 files changed, 28 insertions(+), 26 deletions(-)

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
-- 
2.3.0.449.g1690e78
