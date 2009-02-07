From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] refactor exclude handling
Date: Sat, 7 Feb 2009 01:44:05 -0500
Message-ID: <20090207064405.GA14906@coredump.intra.peff.net>
References: <20090207064221.GA14856@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 07:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVgwc-00030f-Al
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 07:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbZBGGoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 01:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbZBGGoJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 01:44:09 -0500
Received: from peff.net ([208.65.91.99]:45501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbZBGGoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 01:44:09 -0500
Received: (qmail 18978 invoked by uid 107); 7 Feb 2009 06:44:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 01:44:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 01:44:05 -0500
Content-Disposition: inline
In-Reply-To: <20090207064221.GA14856@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108815>

The excluded function uses the static helper excluded_1 to
perform the inner loop over all of the exclude patterns. The
helper just tells us whether the path is included, excluded,
or undecided.

However, it may be useful to know _which_ pattern was
triggered. So let's pass out the entire exclude match, which
contains the status information we were already passing out.

Further patches can make use of this.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup for the next patch.

 dir.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index cfd1ea5..0ea81b7 100644
--- a/dir.c
+++ b/dir.c
@@ -291,9 +291,10 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 }
 
 /* Scan the list and let the last match determines the fate.
- * Return 1 for exclude, 0 for include and -1 for undecided.
+ * Returns the exclude_list element which matched, or NULL for
+ * undecided.
  */
-static int excluded_1(const char *pathname,
+static struct exclude *excluded_1(const char *pathname,
 		      int pathlen, const char *basename, int *dtype,
 		      struct exclude_list *el)
 {
@@ -303,7 +304,6 @@ static int excluded_1(const char *pathname,
 		for (i = el->nr - 1; 0 <= i; i--) {
 			struct exclude *x = el->excludes[i];
 			const char *exclude = x->pattern;
-			int to_exclude = x->to_exclude;
 
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
 				if (*dtype == DT_UNKNOWN)
@@ -316,14 +316,14 @@ static int excluded_1(const char *pathname,
 				/* match basename */
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
 					if (!strcmp(exclude, basename))
-						return to_exclude;
+						return x;
 				} else if (x->flags & EXC_FLAG_ENDSWITH) {
 					if (x->patternlen - 1 <= pathlen &&
 					    !strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
-						return to_exclude;
+						return x;
 				} else {
 					if (fnmatch(exclude, basename, 0) == 0)
-						return to_exclude;
+						return x;
 				}
 			}
 			else {
@@ -342,16 +342,16 @@ static int excluded_1(const char *pathname,
 
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
 					if (!strcmp(exclude, pathname + baselen))
-						return to_exclude;
+						return x;
 				} else {
 					if (fnmatch(exclude, pathname+baselen,
 						    FNM_PATHNAME) == 0)
-					    return to_exclude;
+					    return x;
 				}
 			}
 		}
 	}
-	return -1; /* undecided */
+	return NULL;
 }
 
 int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
@@ -363,8 +363,11 @@ int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, basename,
-				   dtype_p, &dir->exclude_list[st])) {
+		struct exclude *x = excluded_1(pathname, pathlen, basename,
+					dtype_p, &dir->exclude_list[st]);
+		if (!x)
+			continue;
+		switch (x->to_exclude) {
 		case 0:
 			return 0;
 		case 1:
-- 
1.6.1.2.552.g1682c.dirty
