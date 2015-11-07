From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 3/3] git-p4: work with a detached head
Date: Sat,  7 Nov 2015 01:07:53 +0000
Message-ID: <1446858473-19911-4-git-send-email-luke@diamand.org>
References: <1446858473-19911-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, sunshine@sunshineco.com,
	larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 02:08:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zurzj-00076V-GT
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 02:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbbKGBIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 20:08:31 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33890 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbbKGBIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 20:08:09 -0500
Received: by padhx2 with SMTP id hx2so130187389pad.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 17:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+tDO49DKPAGA43QxJfjlNkIhQ5gxpsrJMiaW8+b9Pw=;
        b=Z+msRn+PsEmU57IQNtUVPMycSW3d5tsvcbhK0QgWMiWYRVUj2bmR0mi5S2nSWEQBbu
         hanlUP3T29wa4zIsomZsA13R05znQykriVl1gcuUfw4Zf69j6X8hPE/5i4ZzJIB2IhGy
         rPICCJioZIlzbiXXmGBYEqQBwK7wZHJd51sm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+tDO49DKPAGA43QxJfjlNkIhQ5gxpsrJMiaW8+b9Pw=;
        b=WFibIpLj9fwVNvB8zwjZB1MtbUfu8FFmJ0A5ic4ztZGL1hlEPoaf8JEqDKkzjEy1YU
         PK06+glQppVF7NcSNEcHuO/QK0YtpRKt5xryNgOlBfggQjGOGR/SJerpT0L5B2Y2cV6W
         /NJL7dVF7YsSa/J3f1pU5nALU6UPXSTvwfKRCC+erYu/2XLwV1rPSW5AH9ZBmSnavoMp
         uudyFqe5YHXFeLn2XPaotq7vDotIe+gaPbJfQiNO0nn58vF7SA8ZDhZj18rihTCWfOYI
         0qLoldzxlvL1trCaHX50CVUgiywyugxC62U69S6Q4LLBpdHxl9URSJ4/6EWuJoqmbsF1
         X3lA==
X-Gm-Message-State: ALoCoQnZm4KY8l7ljI2sqK25yHOrJZFh7MIP5DVTAsJDzGwhHJsyypWIxvNoVr2p+e6hlsHPeCoo
X-Received: by 10.67.14.201 with SMTP id fi9mr4776616pad.41.1446858489030;
        Fri, 06 Nov 2015 17:08:09 -0800 (PST)
Received: from lgd-kipper.local ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id t13sm2239577pbs.88.2015.11.06.17.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2015 17:08:08 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc3.238.gc07a1e8
In-Reply-To: <1446858473-19911-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281012>

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
