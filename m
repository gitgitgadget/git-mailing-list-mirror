From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/2] git-p4: work with a detached head
Date: Sat,  5 Sep 2015 15:02:18 +0100
Message-ID: <1441461738-25066-3-git-send-email-luke@diamand.org>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 16:02:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYE3F-0004KV-BG
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 16:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbbIEOCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 10:02:37 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33862 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbbIEOCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 10:02:34 -0400
Received: by wicfx3 with SMTP id fx3so47183608wic.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7NC+Xwsywmyp/anQQCXtqnLA2hLTw7uo/dUi/OpTBI=;
        b=bMA6MuFuw4xfoycWK4zGAM9XEO63EnXabFzwrMZ5d8oNZZYU0nLncA+IHYKYeF8BUZ
         lDmX3L8CNsHErHgA1SHVhmC0QwP9IM/sXJrziTXL2VZwfsmRZ0VMxkmPLjzhctS9WfHk
         VZYbtpPI2OgQ0BWG6Qz8u3hzHPGmSChG4Dbug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E7NC+Xwsywmyp/anQQCXtqnLA2hLTw7uo/dUi/OpTBI=;
        b=Mqjffs1H2+kUXUw39ik+lD+zyzCfMoMXN8eZbUIl27wDEBH2VXBjoIQ+5+2BOmkces
         4MK5G4/2FEBBt1XVFXNL5wK9IioDOcAnanRqRSuUSFq9maGXnekPP7Wb+dfPXcZeFrGs
         wpBkdB/Mj690e9NF1Jcqg14a0Kz2po5rUlaVop/U4wxr2ONhXSGQ0MeJLH/77mO7QHe3
         3mRzPNnWQ4TFjWAun/97nxrigNb3cfPHNZismH337LfQy3iQZR1i01RcqqTvJg7YYMku
         3Oxgk4gK7Fh1UwprIsh3Z1yodFopYigCj/8Cgsr236FC3c8KUMsrpIdtDHPUI9YX9FGC
         07lw==
X-Gm-Message-State: ALoCoQn2J4/xlz9p5hgeTVzn10pMW37rg2/st/rUcBTX7qWwwdXkulO0uouQHibWQT4SY+rR7Jn0
X-Received: by 10.180.87.198 with SMTP id ba6mr10720969wib.39.1441461751725;
        Sat, 05 Sep 2015 07:02:31 -0700 (PDT)
Received: from lgd-kipper.local.diamand.org (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id fs8sm10225413wib.0.2015.09.05.07.02.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2015 07:02:31 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.133.ga438a11.dirty
In-Reply-To: <1441461738-25066-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277382>

When submitting, git-p4 finds the current branch in
order to know if it is allowed to submit (configuration
"git-p4.allowSubmit").

On a detached head, detecting the branch would fail, and
git-p4 would report a cryptic error.

This change teaches git-p4 to recognise a detached head and
submit successfully.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 18 ++++++++++++------
 t/t9800-git-p4-basic.sh |  2 +-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2677c89..a22ae01 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1651,8 +1651,8 @@ class P4Submit(Command, P4UserMap):
     def run(self, args):
         if len(args) == 0:
             self.master = currentGitBranch()
-            if len(self.master) == 0 or not gitBranchExists("refs/heads/%s" % self.master):
-                die("Detecting current git branch failed!")
+            if self.master == "undefined":
+                self.master = None
         elif len(args) == 1:
             self.master = args[0]
             if not branchExists(self.master):
@@ -1660,9 +1660,10 @@ class P4Submit(Command, P4UserMap):
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
@@ -1730,7 +1731,12 @@ class P4Submit(Command, P4UserMap):
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
2.6.0.rc0.133.ga438a11.dirty
