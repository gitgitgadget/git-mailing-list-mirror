From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] attr.c::path_matches(): special case paths that end with
 a slash
Date: Thu, 28 Mar 2013 17:49:13 -0400
Message-ID: <20130328214913.GE10936@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:49:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKhg-0002uI-83
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab3C1VtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:49:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44065 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab3C1VtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:49:19 -0400
Received: (qmail 30798 invoked by uid 107); 28 Mar 2013 21:51:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:51:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:49:13 -0400
Content-Disposition: inline
In-Reply-To: <20130328214358.GA10685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219467>

From: Junio C Hamano <gitster@pobox.com>

The function is given a string that ends with a slash to signal that
the path is a directory to make sure that a pattern that ends with a
slash (i.e. MUSTBEDIR) can tell directories and non-directories
apart.  However, the pattern itself (pat->pattern and
pat->patternlen) that came from such a MUSTBEDIR pattern is
represented as a string that ends with a slash, but patternlen does
not count that trailing slash. A MUSTBEDIR pattern "element/" is
represented as a counted string <"element/", 7> and this must match
match pathname "element/".

Because match_basename() and match_pathname() want to see pathname
"element" to match against the pattern <"element/", 7>, reduce the
length of the path to exclude the trailing slash when calling
these functions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Tweaked since v1 to also drop the trailing slash when we pass the path
to match_pathname.

 attr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 4cfe0ee..4d620bc 100644
--- a/attr.c
+++ b/attr.c
@@ -661,18 +661,18 @@ static int path_matches(const char *pathname, int pathlen,
 {
 	const char *pattern = pat->pattern;
 	int prefix = pat->nowildcardlen;
+	int isdir = (pathlen && pathname[pathlen - 1] == '/');
 
-	if ((pat->flags & EXC_FLAG_MUSTBEDIR) &&
-	    ((!pathlen) || (pathname[pathlen-1] != '/')))
+	if ((pat->flags & EXC_FLAG_MUSTBEDIR) && !isdir)
 		return 0;
 
 	if (pat->flags & EXC_FLAG_NODIR) {
 		return match_basename(pathname + basename_offset,
-				      pathlen - basename_offset,
+				      pathlen - basename_offset - isdir,
 				      pattern, prefix,
 				      pat->patternlen, pat->flags);
 	}
-	return match_pathname(pathname, pathlen,
+	return match_pathname(pathname, pathlen - isdir,
 			      base, baselen,
 			      pattern, prefix, pat->patternlen, pat->flags);
 }
-- 
1.8.2.13.g0f18d3c
