From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 3/3] git-p4: work with a detached head
Date: Sat, 21 Nov 2015 09:54:41 +0000
Message-ID: <1448099681-20183-4-git-send-email-luke@diamand.org>
References: <1448099681-20183-1-git-send-email-luke@diamand.org>
Cc: larsxschneider@gmail.com, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, sunshine@sunshineco.com,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 10:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a04sz-00084b-2k
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 10:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759882AbbKUJzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 04:55:07 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36105 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbbKUJzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 04:55:04 -0500
Received: by pacdm15 with SMTP id dm15so141302987pac.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+tDO49DKPAGA43QxJfjlNkIhQ5gxpsrJMiaW8+b9Pw=;
        b=PurlrwkWZmdquCsBq9rLgTviqOL4Qkdut6/FeVriRHZBECqFyuuDn4D1e89kS+PmTB
         ckRLxiaWSTkQ+zoCuS1uEcgIPJu1aYLS/XFnXUVGemKuoEYa0WeB/jIK/LqtHmf3SsGs
         B1xYendHj/qK1fY51AUjB8vfJm7NHRCh9OzDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+tDO49DKPAGA43QxJfjlNkIhQ5gxpsrJMiaW8+b9Pw=;
        b=WKSQFbKX54tYgKheQGL5TGnLfYsZYPBj5kLywGEF2REh+5buWMoLjOJcnHgU4bRV0E
         kz6MkT/gt1rMxNPobpvkwy8G2CsYofoxkVvtEdZ02Xfyz8ejEYuPOaUL9pAfPLKwtnhy
         /DFw0/IXF1ZPeUdr4lcm8/0rdmIXzfaNCqG79zDJnuw2BR7Ml5YAflV43guU+XDkGTGv
         ez/MzxgdtdyVsZ3GcdQAynu98tbcUdM+PlQw5CNCEBmCCG6QrC1CooweWc4cphC0JYlM
         ji+jCkNX9kVg8eNyA/xG6sEIGhHAAK8dFfXb1PjtKTDd1EznUBaH6SI+nBX4ZN1czCtr
         D7Gw==
X-Gm-Message-State: ALoCoQlltg6qqc0VqhPaDjXfz8po2UPqNeCCkQcQDjjPziIv6iZzFl83j9/R3NazH2Zvzby7v8UJ
X-Received: by 10.67.23.166 with SMTP id ib6mr24540216pad.82.1448099703147;
        Sat, 21 Nov 2015 01:55:03 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id xi8sm2949984pab.9.2015.11.21.01.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2015 01:55:02 -0800 (PST)
X-Mailer: git-send-email 2.6.3.492.g06488d6
In-Reply-To: <1448099681-20183-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281551>

When submitting, git-p4 finds the current branch in
order to know if it is allowed to submit (configuration
"git-p4.allowSubmit").

On a detached head, detecting the branch would fail, and
git-p4 would report a cryptic error.

This change teaches git-p4 to recognise a detached head and
submit successfully.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 23 ++++++++++++++++-------
 t/t9800-git-p4-basic.sh |  2 +-
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 9d55f9c..0cfc866 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -544,7 +544,12 @@ def p4Where(depotPath):
     return clientPath
 
 def currentGitBranch():
-    return read_pipe("git name-rev HEAD").split(" ")[1].strip()
+    retcode = system(["git", "symbolic-ref", "-q", "HEAD"], ignore_error=True)
+    if retcode != 0:
+        # on a detached head
+        return None
+    else:
+        return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
 
 def isValidGitDir(path):
     if (os.path.exists(path + "/HEAD")
@@ -1653,8 +1658,6 @@ class P4Submit(Command, P4UserMap):
     def run(self, args):
         if len(args) == 0:
             self.master = currentGitBranch()
-            if len(self.master) == 0 or not gitBranchExists("refs/heads/%s" % self.master):
-                die("Detecting current git branch failed!")
         elif len(args) == 1:
             self.master = args[0]
             if not branchExists(self.master):
@@ -1662,9 +1665,10 @@ class P4Submit(Command, P4UserMap):
         else:
             return False
 
-        allowSubmit = gitConfig("git-p4.allowSubmit")
-        if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
-            die("%s is not in git-p4.allowSubmit" % self.master)
+        if self.master:
+            allowSubmit = gitConfig("git-p4.allowSubmit")
+            if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
+                die("%s is not in git-p4.allowSubmit" % self.master)
 
         [upstream, settings] = findUpstreamBranchPoint()
         self.depotPath = settings['depot-paths'][0]
@@ -1732,7 +1736,12 @@ class P4Submit(Command, P4UserMap):
         self.check()
 
         commits = []
-        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, self.master)]):
+        if self.master:
+            commitish = self.master
+        else:
+            commitish = 'HEAD'
+
+        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, commitish)]):
             commits.append(line.strip())
         commits.reverse()
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 114b19f..0730f18 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -241,7 +241,7 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 	)
 '
 
-test_expect_failure 'submit from detached head' '
+test_expect_success 'submit from detached head' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
-- 
2.6.0.rc3.238.gc07a1e8
