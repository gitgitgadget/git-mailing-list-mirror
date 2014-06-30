From: Jeff King <peff@peff.net>
Subject: [PATCH 3/9] implement ends_with via strip_suffix
Date: Mon, 30 Jun 2014 12:58:08 -0400
Message-ID: <20140630165808.GC16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1euI-00019Q-CF
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbaF3Q6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 12:58:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:53650 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754567AbaF3Q6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:58:09 -0400
Received: (qmail 7702 invoked by uid 102); 30 Jun 2014 16:58:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:58:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:58:08 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252685>

The ends_with function is essentially a simplified version
of strip_suffix, in which we throw away the stripped length.
Implementing it as an inline on top of strip_suffix has two
advantages:

  1. We save a bit of duplicated code.

  2. The suffix is typically a string literal, and we call
     strlen on it. By making the function inline, many
     compilers can replace the strlen call with a constant.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 7 ++++++-
 strbuf.c          | 9 ---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d044c42..4cfde49 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -347,7 +347,6 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
-extern int ends_with(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
@@ -385,6 +384,12 @@ static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
 	return strip_suffix_mem(str, len, suffix);
 }
 
+static inline int ends_with(const char *str, const char *suffix)
+{
+	size_t len;
+	return strip_suffix(str, suffix, &len);
+}
+
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
diff --git a/strbuf.c b/strbuf.c
index ac62982..99dbeba 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,15 +11,6 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
-int ends_with(const char *str, const char *suffix)
-{
-	int len = strlen(str), suflen = strlen(suffix);
-	if (len < suflen)
-		return 0;
-	else
-		return !strcmp(str + len - suflen, suffix);
-}
-
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
-- 
2.0.0.566.gfe3e6b2
