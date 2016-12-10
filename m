Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1361F1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbcLJV5z (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 16:57:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36701 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbcLJV5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 16:57:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id x23so6240792pgx.3
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 13:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z6FSR3CMUGBRD6x1Cq2qkQQTFzV2U+MFKbByKwXfOjY=;
        b=AF2HW8DFDA2YctaeOiTULlwxYyY5IGQQKTFAXC9J9dFusGBS5xGJRN6u/SHjvKyEvy
         FaIMdkxh2yXhciSzg7+mXU6jiw3hHE7oYJ7CpLlOdiY99joV6cZC8yiTBvxELzKj9t2M
         uAd37GM257CrxbSNq5aJdG4bO81I/q9AVX8hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z6FSR3CMUGBRD6x1Cq2qkQQTFzV2U+MFKbByKwXfOjY=;
        b=AlvNeGOko26HFyvrOyb+H2MXqmVLSasUPTtHa6wuQc3aVWb8RkHPSfEtzOBphB9e7R
         d/b7laCcDIwnCnjMyFadmlaiJdUsQnbr6X6MrOrLHGmP1knGMCsEzuRx/nK/nDVdmzqz
         UMIJAu9QWQmRhsCSmwb+MLJhbMfggR3TS845SnqB33ElgmI654CknGwfn2WqJ5dQALbQ
         k7uEcxeOmDEIjZlre5EAosi6ml0WAA6zFK8vktvSLRKsPIvBQrcHCkdhllJp4lESozXd
         RvKQ0RpNCc5uUVPrbLaaPbsRG7WG/4I4ejnHsvZKsgkCoPMHZCGnrvoYsTiqkHsFIp8r
         paPg==
X-Gm-Message-State: AKaTC00xXWML/PYKFu1VNr242jHwQ3itcswZC1HtcrfSTTTBw9FnfAzhfW9bcMvUIrfA8A==
X-Received: by 10.84.210.46 with SMTP id z43mr171324732plh.115.1481407073520;
        Sat, 10 Dec 2016 13:57:53 -0800 (PST)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id i124sm66882955pgd.15.2016.12.10.13.57.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Dec 2016 13:57:53 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: support git worktrees
Date:   Sat, 10 Dec 2016 21:57:34 +0000
Message-Id: <20161210215734.7468-2-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
In-Reply-To: <20161210215734.7468-1-luke@diamand.org>
References: <20161210215734.7468-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 would attempt to find the git directory using
its own specific code, which did not know about git
worktrees. This caused git operations to fail needlessly.

Rework it to use "git rev-parse --git-dir" instead, which
knows about worktrees.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 47 ++++++++++++++++++++++++++---------------------
 t/t9800-git-p4-basic.sh | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52..6aa8957 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -49,6 +49,13 @@ defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 # Grab changes in blocks of this many revisions, unless otherwise requested
 defaultBlockSize = 512
 
+def gitdir():
+    d = read_pipe("git rev-parse --git-dir").strip()
+    if not d or len(d) == 0:
+        return None
+    else:
+        return d
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -562,12 +569,6 @@ def currentGitBranch():
     else:
         return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
 
-def isValidGitDir(path):
-    if (os.path.exists(path + "/HEAD")
-        and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
-        return True;
-    return False
-
 def parseRevision(ref):
     return read_pipe("git rev-parse %s" % ref).strip()
 
@@ -3462,7 +3463,7 @@ class P4Sync(Command, P4UserMap):
         if self.tempBranches != []:
             for branch in self.tempBranches:
                 read_pipe("git update-ref -d %s" % branch)
-            os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
+            os.rmdir(os.path.join(gitdir(), self.tempBranchLocation))
 
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
         # a convenient shortcut refname "p4".
@@ -3678,23 +3679,27 @@ def main():
     (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
     global verbose
     verbose = cmd.verbose
+
     if cmd.needsGit:
-        if cmd.gitdir == None:
-            cmd.gitdir = os.path.abspath(".git")
-            if not isValidGitDir(cmd.gitdir):
-                cmd.gitdir = read_pipe("git rev-parse --git-dir").strip()
-                if os.path.exists(cmd.gitdir):
-                    cdup = read_pipe("git rev-parse --show-cdup").strip()
-                    if len(cdup) > 0:
-                        chdir(cdup);
-
-        if not isValidGitDir(cmd.gitdir):
-            if isValidGitDir(cmd.gitdir + "/.git"):
-                cmd.gitdir += "/.git"
-            else:
+        if cmd.gitdir:
+            os.environ["GIT_DIR"] = cmd.gitdir
+
+            # did we get a valid git dir on the command line or via $GIT_DIR?
+            if not gitdir():
                 die("fatal: cannot locate git repository at %s" % cmd.gitdir)
 
-        os.environ["GIT_DIR"] = cmd.gitdir
+        else:
+            # already in a git directory?
+            if not gitdir():
+                die("fatal: not in a valid git repository")
+
+        cdup = read_pipe("git rev-parse --show-cdup").strip()
+        if len(cdup) > 0:
+            chdir(cdup);
+
+        # ensure subshells spawned in the p4 repo directory
+        # get the correct GIT_DIR
+        os.environ["GIT_DIR"] = os.path.abspath(gitdir())
 
     if not cmd.run(args):
         parser.print_help()
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 0730f18..093e9bd 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -257,6 +257,26 @@ test_expect_success 'submit from detached head' '
 	)
 '
 
+test_expect_success 'submit from worktree' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git worktree add ../worktree-test
+	) &&
+	(
+		cd "$git/../worktree-test" &&
+		test_commit "worktree-commit" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		test_path_is_file worktree-commit.t
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.8.2.703.g78b384c.dirty

