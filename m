From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/6] git-p4: support single file p4 client view maps
Date: Mon,  2 Jan 2012 18:05:52 -0500
Message-ID: <1325545554-16540-5-git-send-email-pw@padd.com>
References: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:07:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhqyQ-0006g5-Ty
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab2ABXHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:07:19 -0500
Received: from honk.padd.com ([74.3.171.149]:43664 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:07:18 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 4C7EA1C7E;
	Mon,  2 Jan 2012 15:07:17 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7739F313FA; Mon,  2 Jan 2012 18:07:14 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
In-Reply-To: <1325545554-16540-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187847>

From: Gary Gibbons <ggibbons@perforce.com>

Perforce client views can map individual files,
mapping one //depot file path to one //client file path.
These mappings contain no meta/masking characters.
This patch add support for these file maps to
the currently supported '...' view mappings.

[pw: one test now suceeds]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4    |   29 ++++++++++++++++++++---------
 t/t9809-git-p4-client-view.sh |    2 +-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2fd4d3b..8f28e0a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1217,6 +1217,7 @@ class P4Sync(Command, P4UserMap):
         self.cloneExclude = []
         self.useClientSpec = False
         self.clientSpecDirs = []
+        self.haveSingleFileClientViews = False
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -1274,6 +1275,16 @@ class P4Sync(Command, P4UserMap):
             # will end up putting all foo/branch files into
             #  branch/foo/
             for val in self.clientSpecDirs:
+                if self.haveSingleFileClientViews and len(path) == abs(val[1][0]) and path == val[0]:
+                    # since 'path' is a depot file path, if it matches the LeftMap,
+                    # then the View is a single file mapping, so use the entire rightMap
+                    # first two tests above avoid the last == test for common cases
+                    path =  val[1][1]
+                    # now strip out the client (//client/...)
+                    path = re.sub("^(//[^/]+/)", '', path)
+                    # the rest is local client path
+                    return path
+
                 if path.startswith(val[0]):
                     # replace the depot path with the client path
                     path = path.replace(val[0], val[1][1])
@@ -1905,19 +1916,19 @@ class P4Sync(Command, P4UserMap):
                     # save the "client view"; i.e the RHS of the view
                     # line that tells the client where to put the
                     # files for this view.
-                    cv = v[index+3:].strip() # +3 to remove previous '...'
 
-                    # if the client view doesn't end with a
-                    # ... wildcard, then we're going to mess up the
-                    # output directory, so fail gracefully.
-                    if not cv.endswith('...'):
-                        print 'Sorry, client view in "%s" needs to end with wildcard' % (k)
-                        sys.exit(1)
-                    cv=cv[:-3]
+                    # check for individual file mappings - those which have no '...'
+                    if  index < 0 :
+                        v,cv = v.strip().split()
+                        v = v[start:]
+                        self.haveSingleFileClientViews = True
+                    else:
+                        cv = v[index+3:].strip() # +3 to remove previous '...'
+                        cv=cv[:-3]
+                        v = v[start:index]
 
                     # now save the view; +index means included, -index
                     # means it should be filtered out.
-                    v = v[start:index]
                     if v.startswith("-"):
                         v = v[1:]
                         include = -len(v)
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 06652cb..1cc83c5 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -191,7 +191,7 @@ test_expect_success 'exclusion wildcard, client rhs different (normal)' '
 	git_verify $files
 '
 
-test_expect_failure 'exclusion single file' '
+test_expect_success 'exclusion single file' '
 	client_view "//depot/... //client/..." \
 		    "-//depot/dir2/file22 //client/file22" &&
 	files="dir1/file11 dir1/file12 dir2/file21" &&
-- 
1.7.8.1.407.gd70cb
