From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/4] git-p4: commit time should be most recent p4 change time
Date: Sat, 30 Jul 2011 20:39:53 -0400
Message-ID: <20110731003953.GE4867@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 02:40:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnK4X-0000sC-6G
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 02:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab1GaAj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 20:39:57 -0400
Received: from honk.padd.com ([74.3.171.149]:36344 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab1GaAj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 20:39:56 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 085D5223A;
	Sat, 30 Jul 2011 17:39:56 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 78B0331731; Sat, 30 Jul 2011 20:39:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110731003557.GA4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178226>

When importing a repo, the time on the initial commit had been
just "now".  But this causes problems when trying to share among
git-p4 repos that were created identically, although at different
times.  Instead, use the time in the top-most p4 change as the
time for the git import commit.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   15 ++++++++++++++-
 t/t9800-git-p4.sh          |   14 ++++++++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 98d2aee..6b9de9e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1649,7 +1649,8 @@ class P4Sync(Command, P4UserMap):
     def importHeadRevision(self, revision):
         print "Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
 
-        details = { "user" : "git perforce import user", "time" : int(time.time()) }
+        details = {}
+        details["user"] = "git perforce import user"
         details["desc"] = ("Initial import of %s from the state at revision %s\n"
                            % (' '.join(self.depotPaths), revision))
         details["change"] = revision
@@ -1689,6 +1690,18 @@ class P4Sync(Command, P4UserMap):
             fileCnt = fileCnt + 1
 
         details["change"] = newestRevision
+
+        # Use time from top-most change so that all git-p4 clones of
+        # the same p4 repo have the same commit SHA1s.
+        res = p4CmdList("describe -s %d" % newestRevision)
+        newestTime = None
+        for r in res:
+            if r.has_key('time'):
+                newestTime = int(r['time'])
+        if newestTime is None:
+            die("\"describe -s\" on newest change %d did not give a time")
+        details["time"] = newestTime
+
         self.updateOptionDict(details)
         try:
             self.commit(details, self.extractFilesFromCommit(details), self.branch, self.depotPaths)
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 24a8b79..1b5f4b2 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -265,6 +265,20 @@ test_expect_success 'not preserving user with mixed authorship' '
 	p4_check_commit_author usernamefile3 alice
 '
 
+# Sleep a bit so that the top-most p4 change did not happen "now".  Then
+# import the repo and make sure that the initial import has the same time
+# as the top-most change.
+test_expect_success 'initial import time from top change time' '
+	p4change=$(p4 -G changes -m 1 //depot/... | marshal_dump change) &&
+	p4time=$(p4 -G changes -m 1 //depot/... | marshal_dump time) &&
+	sleep 3 &&
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	cd "$git" &&
+	gittime=$(git show -s --raw --pretty=format:%at HEAD) &&
+	echo $p4time $gittime &&
+	test $p4time = $gittime
+'
 
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
-- 
1.7.5.4
