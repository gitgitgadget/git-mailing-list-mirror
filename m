From: Jeff King <peff@peff.net>
Subject: [PATCH 02/16] isxdigit: cast input to unsigned char
Date: Fri, 3 Oct 2014 16:22:01 -0400
Message-ID: <20141003202201.GB16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:22:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9Mg-0006mr-HD
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaJCUWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:22:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:54810 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750850AbaJCUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:22:04 -0400
Received: (qmail 2700 invoked by uid 102); 3 Oct 2014 20:22:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:22:03 -0500
Received: (qmail 14925 invoked by uid 107); 3 Oct 2014 20:22:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:22:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:22:01 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257852>

Otherwise, callers must do so or risk triggering
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
 git-compat-util.h | 2 +-
 urlmatch.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 0c4e663..3d5a8fb 100644
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
2.1.1.566.gdb1f904
