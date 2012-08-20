From: "Patrick C. McGinty" <casey.mcginty@gmail.com>
Subject: [PATCH] git-p4: Strip branch name prefixes if --use-client-spec enabled
Date: Mon, 20 Aug 2012 13:43:30 -1000
Message-ID: <1345506210-17382-1-git-send-email-casey.mcginty@gmail.com>
To: casey.mcginty@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 02:25:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3cHv-0004Kh-4R
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 02:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab2HUAZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 20:25:37 -0400
Received: from 74-123-216-239.mgmt.sandwichisles.net ([74.123.216.239]:10760
	"EHLO casey.ia.akimeka.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752442Ab2HUAZf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 20:25:35 -0400
X-Greylist: delayed 2524 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2012 20:25:35 EDT
Received: from localhost ([127.0.0.1] helo=casey.ia.akimeka.com)
	by casey.ia.akimeka.com with esmtp (Exim 4.76)
	(envelope-from <casey.mcginty@gmail.com>)
	id 1T3bd5-0004Wv-0w; Mon, 20 Aug 2012 13:43:31 -1000
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203910>

From: "Patrick C. McGinty" <casey.mcginty@gmail.com>

This removes the branch names from being included in the file system
path when using the both --use-client-spec and --detect-branches
options.

Used alone, the --detect-branches option did the right thing, removing
the branch names from the relative git path. By adding the
--use-client-spec option, the old logic would incorrectly bypass this
step.

Signed-off-by: Patrick C. McGinty <casey.mcginty@gmail.com>
---
 git-p4.py |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index e67d37d..9489845 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1819,7 +1819,15 @@ class P4Sync(Command, P4UserMap):
 
     def stripRepoPath(self, path, prefixes):
         if self.useClientSpec:
-            return self.clientSpecDirs.map_in_client(path)
+            # map path to user defined client location
+            path = self.clientSpecDirs.map_in_client(path)
+            # Remove prefixes (e.g. branch names) from path. Apply the
+            # clientSpecDirs map to the prefix paths to match the
+            # modified path value.
+            for p in map(self.clientSpecDirs.map_in_client, prefixes):
+               if p and p4PathStartsWith( path, p):
+                  path = path[len(p):]
+            return path
 
         if self.keepRepoPath:
             prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
-- 
1.7.9.5
