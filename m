From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 10:09:29 -0800
Message-ID: <20130116180929.GD27525@sigill.intra.peff.net>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:09:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXQz-0002kK-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab3APSJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:09:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35430 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916Ab3APSJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:09:33 -0500
Received: (qmail 14113 invoked by uid 107); 16 Jan 2013 18:10:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 13:10:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 10:09:29 -0800
Content-Disposition: inline
In-Reply-To: <20130116180041.GC27525@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213787>

On Wed, Jan 16, 2013 at 10:00:42AM -0800, Jeff King wrote:

> So opterror does not happen to generate any warnings, because we do not
> ever use it in a void context. It should probably be marked the same
> way, though, as future-proofing.
> [...]
> So a more accurate description would be:

Here it is all together:

-- >8 --
From: Max Horn <max@quendi.de>
Subject: [PATCH] fix clang -Wunused-value warnings for error functions

Commit a469a10 wraps some error calls in macros to give the
compiler a chance to do more static analysis on their
constant -1 return value.  We limit the use of these macros
to __GNUC__, since gcc is the primary beneficiary of the new
information, and because we use GNU features for handling
variadic macros.

However, clang also defines __GNUC__, but generates warnings
with -Wunused-value when these macros are used in a void
context, because the constant "-1" ends up being useless.
Gcc does not complain about this case (though it is unclear
if it is because it is smart enough to see what we are
doing, or too dumb to realize that the -1 is unused).  We
can squelch the warning by just disabling these macros when
clang is in use.

Signed-off-by: Max Horn <max@quendi.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h           | 2 +-
 git-compat-util.h | 2 +-
 parse-options.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index c257953..5c8440b 100644
--- a/cache.h
+++ b/cache.h
@@ -1148,7 +1148,7 @@ extern int config_error_nonbool(const char *);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
-#ifdef __GNUC__
+#if defined(__GNUC__) && ! defined(__clang__)
 #define config_error_nonbool(s) (config_error_nonbool(s), -1)
 #endif
 extern const char *get_log_output_encoding(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index 2cecf56..2596280 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -297,7 +297,7 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
  * behavior. But since we're only trying to help gcc, anyway, it's OK; other
  * compilers will fall back to using the function as usual.
  */
-#ifdef __GNUC__
+#if defined(__GNUC__) && ! defined(__clang__)
 #define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
 #endif
 
diff --git a/parse-options.h b/parse-options.h
index e703853..1c8bd8d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,7 +177,7 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
 
 extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
-#ifdef __GNUC__
+#if defined(__GNUC__) && ! defined(clang)
 #define opterror(o,r,f) (opterror((o),(r),(f)), -1)
 #endif
 
-- 
1.8.1.rc1.10.g7d71f7b
