From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] attr.c::path_matches(): the basename is part of the
 pathname
Date: Thu, 28 Mar 2013 17:45:00 -0400
Message-ID: <20130328214500.GA10936@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:45:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKde-0006bI-9T
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab3C1VpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:45:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44044 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab3C1VpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:45:07 -0400
Received: (qmail 30712 invoked by uid 107); 28 Mar 2013 21:46:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:46:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:45:00 -0400
Content-Disposition: inline
In-Reply-To: <20130328214358.GA10685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219463>

From: Junio C Hamano <gitster@pobox.com>

The function takes two strings (pathname and basename) as if they
are independent strings, but in reality, the latter is always
pointing into a substring in the former.

Clarify this relationship by expressing the latter as an offset into
the former.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This is identical to the original 1/4.

 attr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index ab2aab2..4cfe0ee 100644
--- a/attr.c
+++ b/attr.c
@@ -655,7 +655,7 @@ static int path_matches(const char *pathname, int pathlen,
 }
 
 static int path_matches(const char *pathname, int pathlen,
-			const char *basename,
+			int basename_offset,
 			const struct pattern *pat,
 			const char *base, int baselen)
 {
@@ -667,8 +667,8 @@ static int path_matches(const char *pathname, int pathlen,
 		return 0;
 
 	if (pat->flags & EXC_FLAG_NODIR) {
-		return match_basename(basename,
-				      pathlen - (basename - pathname),
+		return match_basename(pathname + basename_offset,
+				      pathlen - basename_offset,
 				      pattern, prefix,
 				      pat->patternlen, pat->flags);
 	}
@@ -701,7 +701,7 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 	return rem;
 }
 
-static int fill(const char *path, int pathlen, const char *basename,
+static int fill(const char *path, int pathlen, int basename_offset,
 		struct attr_stack *stk, int rem)
 {
 	int i;
@@ -711,7 +711,7 @@ static int fill(const char *path, int pathlen, const char *basename,
 		struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
-		if (path_matches(path, pathlen, basename,
+		if (path_matches(path, pathlen, basename_offset,
 				 &a->u.pat, base, stk->originlen))
 			rem = fill_one("fill", a, rem);
 	}
@@ -750,7 +750,8 @@ static void collect_all_attrs(const char *path)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
-	const char *basename, *cp, *last_slash = NULL;
+	const char *cp, *last_slash = NULL;
+	int basename_offset;
 
 	for (cp = path; *cp; cp++) {
 		if (*cp == '/' && cp[1])
@@ -758,10 +759,10 @@ static void collect_all_attrs(const char *path)
 	}
 	pathlen = cp - path;
 	if (last_slash) {
-		basename = last_slash + 1;
+		basename_offset = last_slash + 1 - path;
 		dirlen = last_slash - path;
 	} else {
-		basename = path;
+		basename_offset = 0;
 		dirlen = 0;
 	}
 
@@ -771,7 +772,7 @@ static void collect_all_attrs(const char *path)
 
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename, stk, rem);
+		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
 int git_check_attr(const char *path, int num, struct git_attr_check *check)
-- 
1.8.2.13.g0f18d3c
