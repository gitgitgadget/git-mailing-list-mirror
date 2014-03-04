From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue,  4 Mar 2014 09:31:08 +0100
Message-ID: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKks8-0002Fw-E1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 09:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbaCDIik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 03:38:40 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43724 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756491AbaCDIij (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 03:38:39 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2014 03:38:38 EST
X-AuditID: 12074412-f79d46d000002e58-97-53158f683453
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D8.6F.11864.86F85135; Tue,  4 Mar 2014 03:31:36 -0500 (EST)
Received: from michael.fritz.box (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s248VEi8032080
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 03:31:35 -0500
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqJvRLxpsMPmwgcXsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfGsXWvGQue
	8FT8aFrM3sB4g7OLkZNDQsBEonnhNzYIW0ziwr31QDYXh5DAZUaJH4tWMUE4x5gkmnuPMYFU
	sQnoSizqaQazRQTUJCa2HWIBsZkF0iQebLkCZHNwCAvYScxuNwcJswioSsxavZAZxOYVcJaY
	820b1DI5iSm/F7BPYORewMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMk
	GIR2MK4/KXeIUYCDUYmH12GKSLAQa2JZcWXuIUZJDiYlUV6TXtFgIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8cvpAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCV7j
	PqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCgxxcDQx0kxQO09whIO29xQWIu
	UBSi9RSjopQ4bxdIQgAkkVGaBzcWFuOvGMWBvhTm7QWp4gGmB7juV0CDmYAGm/mJgAwuSURI
	STUw2l14rrVh9r0Tv+6UeOX41+bGW386NG/nnKVC7ELn4zSO3nznb6176r10TPGN3b+CWGuO
	RFX7yXcs+bWy5YH3jVa9fd/55/Zn3ZwSfYm5cPOuMu+8Rr9181iNP8i+6jgguH31+9r3L85M
	rGM1+zCT9Yslx02OZ2zsvSrtqd/P/Rbqvn39bY11qRJLcUaioRZzUXEiAKbhM3fM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243328>

The beginning of the loop ensures that slash can never be NULL.  So
don't keep checking whether it is NULL later in the loop.

Furthermore, there is no need for an early

    return it;

from the loop if slash points at the end of the string, because that
is exactly what will happen when the while condition fails at the
start of the next iteration.

Helped-by: David Kastrup <dak@gnu.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I incorporated David's suggestion, and then realized that yet another
check was superfluous, so I removed that one too.

 cache-tree.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..19252c3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -551,25 +551,22 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	if (!it)
 		return NULL;
 	while (*path) {
-		const char *slash;
 		struct cache_tree_sub *sub;
+		const char *slash = strchr(path, '/');
 
-		slash = strchr(path, '/');
 		if (!slash)
 			slash = path + strlen(path);
-		/* between path and slash is the name of the
-		 * subtree to look for.
+		/*
+		 * Between path and slash is the name of the subtree
+		 * to look for.
 		 */
 		sub = find_subtree(it, path, slash - path, 0);
 		if (!sub)
 			return NULL;
 		it = sub->cache_tree;
-		if (slash)
-			while (*slash && *slash == '/')
-				slash++;
-		if (!slash || !*slash)
-			return it; /* prefix ended with slashes */
 		path = slash;
+		while (*path == '/')
+			path++;
 	}
 	return it;
 }
-- 
1.9.0
