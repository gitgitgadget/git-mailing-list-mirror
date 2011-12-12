From: Jeff King <peff@peff.net>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 09:25:51 -0500
Message-ID: <20111212142550.GA23875@sigill.intra.peff.net>
References: <4EE4F97B.9000202@alum.mit.edu>
 <20111212064305.GA16511@sigill.intra.peff.net>
 <m262hmgmrw.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 15:25:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra6pK-0007ar-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 15:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab1LLOZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 09:25:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48174
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab1LLOZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 09:25:53 -0500
Received: (qmail 805 invoked by uid 107); 12 Dec 2011 14:32:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 09:32:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 09:25:51 -0500
Content-Disposition: inline
In-Reply-To: <m262hmgmrw.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186912>

On Mon, Dec 12, 2011 at 10:30:27AM +0100, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  	if (maxsize > 0) {
> > -		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> > +		va_copy(cp, ap);
> > +		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
> 
> You also need to call va_end on the copy.

Silly me. Thanks for catching.

Junio, here's a corrected version.

-- >8 --
Subject: [PATCH] compat/snprintf: don't look at va_list twice

If you define SNPRINTF_RETURNS_BOGUS, we use a special
git_vsnprintf wrapper assumes that vsnprintf returns "-1"
instead of the number of characters that you would need to
store the result.

To do this, it invokes vsnprintf multiple times, growing a
heap buffer until we have enough space to hold the result.
However, this means we evaluate the va_list parameter
multiple times, which is generally a bad thing (it may be
modified by calls to vsnprintf, yielding undefined
behavior).

Instead, we must va_copy it and hand the copy to vsnprintf,
so we always have a pristine va_list.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/snprintf.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index e1e0e75..42ea1ac 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -19,11 +19,14 @@
 #undef vsnprintf
 int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 {
+	va_list cp;
 	char *s;
 	int ret = -1;
 
 	if (maxsize > 0) {
-		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		va_copy(cp, ap);
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
+		va_end(cp);
 		if (ret == maxsize-1)
 			ret = -1;
 		/* Windows does not NUL-terminate if result fills buffer */
@@ -42,7 +45,9 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 		if (! str)
 			break;
 		s = str;
-		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		va_copy(cp, ap);
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
+		va_end(cp);
 		if (ret == maxsize-1)
 			ret = -1;
 	}
-- 
1.7.8.13.g74677
