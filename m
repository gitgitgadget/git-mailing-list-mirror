From: Jeff King <peff@peff.net>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 01:43:05 -0500
Message-ID: <20111212064305.GA16511@sigill.intra.peff.net>
References: <4EE4F97B.9000202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 12 07:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZzbX-0006Mw-P7
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 07:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab1LLGnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 01:43:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47978
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab1LLGnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 01:43:09 -0500
Received: (qmail 29740 invoked by uid 107); 12 Dec 2011 06:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 01:49:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 01:43:05 -0500
Content-Disposition: inline
In-Reply-To: <4EE4F97B.9000202@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186876>

On Sun, Dec 11, 2011 at 07:42:03PM +0100, Michael Haggerty wrote:

> 2. The configure problem causes git_vsnprintf() to be wrapped around the
> C library version.  This leads to many failures in the test suite.  I
> suppose that git_vsnprintf() is broken in some way.

I enabled SNPRINTF_RETURNS_BOGUS manually and was able to see the test
suite failures. Very oddly, I could get them while running the full
suite in parallel, but when I ran individual scripts, the problem went
away. Which makes no sense to me at all.

However, I peeked at the git_vsnprintf function, and one obvious error
is that it calls vsnprintf multiple times on the same va_list.

Fixing that (patch below) makes the test failures go away. I think it's
an Obviously Correct thing to do, anyway, but I'm slightly unnerved by
not understanding why it sometimes caused failures and sometimes not.
Clearly the existing code invokes nasal daemons and anything is allowed
to happen, but it would be nice to understand what triggers the
difference.

I'll leave the issue of "-std=c89" triggering SNPRINTF_RETURNS_BOGUS to
people who know and care about autoconf. My gut is to say "don't do
that". Git is not actually pure c89. We typically target systems that
are _at least_ c89, but it's more important to match and run well on
real-world systems than what was defined in the standard. So we don't
depend on c99, but we do depend on quirks and features that were
prominent in mid-90's Unix variants.

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
 compat/snprintf.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index e1e0e75..38fc08d 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -19,11 +19,13 @@
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
 		if (ret == maxsize-1)
 			ret = -1;
 		/* Windows does not NUL-terminate if result fills buffer */
@@ -42,7 +44,8 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 		if (! str)
 			break;
 		s = str;
-		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		va_copy(cp, ap);
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
 		if (ret == maxsize-1)
 			ret = -1;
 	}
-- 
1.7.8.13.g74677
