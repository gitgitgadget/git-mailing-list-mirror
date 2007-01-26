From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] show-ref: allow glob-style ref matching
Date: Fri, 26 Jan 2007 10:50:26 +0100
Message-ID: <20070126095026.GA31802@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 10:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANj6-0002HZ-Ak
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbXAZJu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbXAZJu3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:50:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:46855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161017AbXAZJu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:50:29 -0500
Received: (qmail invoked by alias); 26 Jan 2007 09:50:27 -0000
Received: from pD9EB9FC4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.159.196]
  by mail.gmx.net (mp052) with SMTP; 26 Jan 2007 10:50:27 +0100
X-Authenticated: #5358227
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37828>

show-ref without --verify will try to match pattern with
fnmatch against the full refname and every suffix starting
at a / in refname
---
I've been using ls .git/refs/tags/v1.4.* and other glob patterns to
take a look at refs.  This allows to use such patterns with show-ref.
If this patch is accepted I'll add the missing documentation.
---
 builtin-show-ref.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 853f13f..64a1246 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -34,21 +34,20 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 			return 0;
 	}
 	if (pattern) {
-		int reflen = strlen(refname);
 		const char **p = pattern, *m;
 		while ((m = *p++) != NULL) {
-			int len = strlen(m);
-			if (len > reflen)
-				continue;
-			if (memcmp(m, refname + reflen - len, len))
-				continue;
-			if (len == reflen)
-				goto match;
+			const char *r = refname;
 			/* "--verify" requires an exact match */
-			if (verify)
+			if (verify) {
+				if (strcmp(m, refname))
+					goto match;
 				continue;
-			if (refname[reflen - len - 1] == '/')
-				goto match;
+			}
+			do {
+				if (!fnmatch(m, r, 0))
+					goto match;
+				r = index(r, '/');
+			} while (r++);
 		}
 		return 0;
 	}
-- 
1.5.0.rc2.g18af
