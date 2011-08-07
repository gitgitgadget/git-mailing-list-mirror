From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/4] git-p4: commit time should be most recent p4 change time
Date: Sun, 7 Aug 2011 09:37:19 -0400
Message-ID: <20110807133719.GD27737@arf.padd.com>
References: <20110807133144.GA27521@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 15:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq3Xu-0003Fu-6B
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 15:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1HGNhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 09:37:34 -0400
Received: from honk.padd.com ([74.3.171.149]:57081 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab1HGNhd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 09:37:33 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 9CE811F9E;
	Sun,  7 Aug 2011 06:37:32 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0AC213143E; Sun,  7 Aug 2011 09:37:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110807133144.GA27521@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178915>

When importing a repo, the time on the initial commit had been
just "now".  But this causes problems when trying to share among
git-p4 repos that were created identically, although at different
times.  Instead, use the time in the top-most p4 change as the
time for the git import commit.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |   15 ++++++++++++++-
 t/t9800-git-p4.sh          |   19 +++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)

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
index b304707..97ec975 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -249,6 +249,25 @@ test_expect_success 'not preserving user with mixed authorship' '
 	p4_check_commit_author usernamefile3 alice
 '
 
+marshal_dump() {
+	what=$1
+	python -c 'import marshal, sys; d = marshal.load(sys.stdin); print d["'$what'"]'
+}
+
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
