From: Sam Hocevar <sam@hocevar.net>
Subject: [PATCH 1/2] git-p4: support multiple depot paths in p4 submit
Date: Sat, 5 Dec 2015 12:22:03 +0100
Message-ID: <20151205112203.GA15745@hocevar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 12:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5B0Q-0003S7-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 12:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbbLEL1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 06:27:32 -0500
Received: from poulet.zoy.org ([193.200.42.166]:38457 "EHLO smtp.zoy.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753580AbbLEL1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 06:27:31 -0500
Received: from w00t.w00t (localhost [IPv6:::1])
	by smtp.zoy.org (Postfix) with ESMTP id 93015360FC0;
	Sat,  5 Dec 2015 12:22:06 +0100 (CET)
Received: by w00t.w00t (Postfix, from userid 1000)
	id 06E9321AF6; Sat,  5 Dec 2015 12:22:03 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Virus-Scanned: clamav-milter 0.98.7 at poulet
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282033>

When submitting from a repository that was cloned using a client spec,
use the full list of paths when ruling out files that are outside the
view.  This fixes a bug where only files pertaining to the first path
would be included in the p4 submit.

Signed-off-by: Sam Hocevar <sam@hocevar.net>
---
 git-p4.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a79b6d8..210f100 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1253,6 +1253,8 @@ class P4Submit(Command, P4UserMap):
            Remove lines in the Files section that show changes to files
            outside the depot path we're committing into."""
 
+        [upstream, settings] = findUpstreamBranchPoint()
+
         template = ""
         inFilesSection = False
         for line in p4_read_pipe_lines(['change', '-o']):
@@ -1265,8 +1267,13 @@ class P4Submit(Command, P4UserMap):
                     lastTab = path.rfind("\t")
                     if lastTab != -1:
                         path = path[:lastTab]
-                        if not p4PathStartsWith(path, self.depotPath):
-                            continue
+                        if settings.has_key('depot-paths'):
+                            if not [p for p in settings['depot-paths']
+                                    if p4PathStartsWith(path, p)]:
+                                continue
+                        else:
+                            if not p4PathStartsWith(path, self.depotPath):
+                                continue
                 else:
                     inFilesSection = False
             else:
-- 
2.6.2
