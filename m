From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/6] git-p4: sort client views by reverse View number
Date: Mon,  2 Jan 2012 18:05:51 -0500
Message-ID: <1325545554-16540-4-git-send-email-pw@padd.com>
References: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhqy9-0006ad-65
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab2ABXHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:07:00 -0500
Received: from honk.padd.com ([74.3.171.149]:43661 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:06:59 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 0281E1C7E;
	Mon,  2 Jan 2012 15:06:59 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6D758313FA; Mon,  2 Jan 2012 18:06:54 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
In-Reply-To: <1325545554-16540-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187846>

From: Gary Gibbons <ggibbons@perforce.com>

Correct view sorting to support the Perforce order,
where client views are ordered and later views
override earlier view mappings.

[pw: one test now succeeds]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4    |   11 +++++++++--
 t/t9809-git-p4-client-view.sh |    2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c144c89..2fd4d3b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1924,10 +1924,17 @@ class P4Sync(Command, P4UserMap):
                     else:
                         include = len(v)
 
-                    temp[v] = (include, cv)
+                    # store the View #number for sorting
+                    # and the View string itself (this last for documentation)
+                    temp[v] = (include, cv, int(k[4:]),k)
 
         self.clientSpecDirs = temp.items()
-        self.clientSpecDirs.sort( lambda x, y: abs( y[1][0] ) - abs( x[1][0] ) )
+        # Perforce ViewNN with higher #numbers override those with lower
+        # reverse sort on the View #number
+        self.clientSpecDirs.sort( lambda x, y:  y[1][2] -  x[1][2]  )
+        if self.verbose:
+            for val in self.clientSpecDirs:
+                    print "clientSpecDirs: %s %s" % (val[0],val[1])
 
     def run(self, args):
         self.depotPaths = []
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index cbf2213..06652cb 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -133,7 +133,7 @@ test_expect_failure 'single file map' '
 	git_verify $files
 '
 
-test_expect_failure 'later mapping takes precedence (entire repo)' '
+test_expect_success 'later mapping takes precedence (entire repo)' '
 	client_view "//depot/dir1/... //client/cli1/..." \
 		    "//depot/... //client/cli2/..." &&
 	files="cli2/dir1/file11 cli2/dir1/file12
-- 
1.7.8.1.407.gd70cb
