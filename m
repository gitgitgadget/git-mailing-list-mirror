From: Jeff King <peff@peff.net>
Subject: [PATCH v2 02/25] isxdigit: cast input to unsigned char
Date: Wed, 15 Oct 2014 18:34:05 -0400
Message-ID: <20141015223405.GB25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeX92-0003dL-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaJOWeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:34:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58918 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751395AbaJOWeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:34:07 -0400
Received: (qmail 2064 invoked by uid 102); 15 Oct 2014 22:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:34:07 -0500
Received: (qmail 27857 invoked by uid 107); 15 Oct 2014 22:34:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:34:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:34:05 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise, callers must do so or risk triggering warnings
-Wchar-subscript (and rightfully so; a signed char might
cause us to use a bogus negative index into the
hexval_table).

While we are dropping the now-unnecessary casts from the
caller in urlmatch.c, we can get rid of similar casts in
actually parsing the hex by using the hexval() helper, which
implicitly casts to unsigned (but note that we cannot
implement isxdigit in terms of hexval(), as it also casts
its return value to unsigned).

Signed-off-by: Jeff King <peff@peff.net>
---
The patch that added more calls to isxdigit later in the series actually
got reworked. So this is purely a cleanup and can be dropped if need be,
though I still think it is an improvement.

 git-compat-util.h | 2 +-
 urlmatch.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index fb41118..44890d5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -677,7 +677,7 @@ extern const unsigned char sane_ctype[256];
 #define iscntrl(x) (sane_istest(x,GIT_CNTRL))
 #define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
 		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
-#define isxdigit(x) (hexval_table[x] != -1)
+#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
diff --git a/urlmatch.c b/urlmatch.c
index 3d4c54b..618d216 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -43,11 +43,11 @@ static int append_normalized_escapes(struct strbuf *buf,
 		from_len--;
 		if (ch == '%') {
 			if (from_len < 2 ||
-			    !isxdigit((unsigned char)from[0]) ||
-			    !isxdigit((unsigned char)from[1]))
+			    !isxdigit(from[0]) ||
+			    !isxdigit(from[1]))
 				return 0;
-			ch = hexval_table[(unsigned char)*from++] << 4;
-			ch |= hexval_table[(unsigned char)*from++];
+			ch = hexval(*from++) << 4;
+			ch |= hexval(*from++);
 			from_len -= 2;
 			was_esc = 1;
 		}
-- 
2.1.2.596.g7379948
