Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A08420451
	for <e@80x24.org>; Tue, 13 Dec 2016 22:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbcLMW7Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 17:59:24 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35039 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbcLMW7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 17:59:22 -0500
Received: by mail-pg0-f66.google.com with SMTP id p66so178451pga.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 14:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mf9D5tiWoY2DRzusIkJwfn7qSr/N/rqbnpqU66hcVkc=;
        b=TyT8mFV6uNKEUs2kkY82WlbCkXOj5FxxYz5LRCX/WCeL7Ct6MUBiq4jTuIXr1dhhBH
         CetQduHe8FXueq0k61j3Gp7oDjtRWQbMMFm7yShq6VFQy6OgoYsntrq4ARWkyB7dOxOV
         987dDpqKiSbCh8HK3ZMtgYrepUzBt/inSi2E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mf9D5tiWoY2DRzusIkJwfn7qSr/N/rqbnpqU66hcVkc=;
        b=V9ldpGbhLLew5qRR/HCg4+Wkjkh81Pj1C1wRPYqvWkStJsUck//H6fP+dxVdDPeY5t
         dA5j2sZIrlFVdJzEBMupM6dK1l49ZltOpxLslZFS79cbm4xijLA6nB4j23AVkp8yR2q4
         ZK6p1IPG/JrHxKfjVwyWjHMss4RJ4I+t9c8MKDYOiRWf7TCaLtmDYGam+vooD1ZauLLL
         W/1OBmAMZskbUQB8bnNy5va6chIeeMYju6sY2kqxwK7FMIA0LE2sy3BFu4HEILXyPEqZ
         rZf3QX3PQazPPOYHJsejToQiv+T66pPlO3GWh0644hqfKnjIlecaIUfX90VDu3PaMZuH
         KAUQ==
X-Gm-Message-State: AKaTC02ND6wj0vmPrLLMItUHrlSLWXX4alscO1L1s8SSLVEB+rso6oa3hNN0fO247rCsZg==
X-Received: by 10.84.133.129 with SMTP id f1mr197665955plf.64.1481665900137;
        Tue, 13 Dec 2016 13:51:40 -0800 (PST)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id p13sm82451817pgf.47.2016.12.13.13.51.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 13:51:39 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3] git-p4: support git worktrees
Date:   Tue, 13 Dec 2016 21:51:28 +0000
Message-Id: <20161213215128.20288-2-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
In-Reply-To: <20161213215128.20288-1-luke@diamand.org>
References: <20161213215128.20288-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 would attempt to find the git directory using
its own specific code, which did not know about git
worktrees.

Rework it to use "git rev-parse --git-dir" instead.

Add test cases for worktree usage and specifying
git directory via --git-dir and $GIT_DIR.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                 | 17 +++++++++++++----
 t/t9800-git-p4-basic.sh   | 20 ++++++++++++++++++++
 t/t9806-git-p4-options.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52..6a1f65f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -85,6 +85,16 @@ def p4_build_cmd(cmd):
         real_cmd += cmd
     return real_cmd
 
+def git_dir(path):
+    """ Return TRUE if the given path is a git directory (/path/to/dir/.git).
+        This won't automatically add ".git" to a directory.
+    """
+    d = read_pipe(["git", "--git-dir", path, "rev-parse", "--git-dir"], True).strip()
+    if not d or len(d) == 0:
+        return None
+    else:
+        return d
+
 def chdir(path, is_client_path=False):
     """Do chdir to the given path, and set the PWD environment
        variable for use by P4.  It does not look at getcwd() output.
@@ -563,10 +573,7 @@ def currentGitBranch():
         return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
 
 def isValidGitDir(path):
-    if (os.path.exists(path + "/HEAD")
-        and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
-        return True;
-    return False
+    return git_dir(path) != None
 
 def parseRevision(ref):
     return read_pipe("git rev-parse %s" % ref).strip()
@@ -3682,6 +3689,7 @@ def main():
         if cmd.gitdir == None:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
+                # "rev-parse --git-dir" without arguments will try $PWD/.git
                 cmd.gitdir = read_pipe("git rev-parse --git-dir").strip()
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe("git rev-parse --show-cdup").strip()
@@ -3694,6 +3702,7 @@ def main():
             else:
                 die("fatal: cannot locate git repository at %s" % cmd.gitdir)
 
+        # so git commands invoked from the P4 workspace will succeed
         os.environ["GIT_DIR"] = cmd.gitdir
 
     if not cmd.run(args):
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
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 254d428..1ab76c4 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -269,6 +269,38 @@ test_expect_success 'submit works with two branches' '
 	)
 '
 
+test_expect_success 'use --git-dir option and GIT_DIR' '
+	test_when_finished cleanup_git &&
+	git p4 clone //depot --destination="$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		test_commit first-change &&
+		git p4 submit --git-dir "$git"
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		test_path_is_file first-change.t &&
+		echo "cli_file" >cli_file.t &&
+		p4 add cli_file.t &&
+		p4 submit -d "cli change"
+	) &&
+	(git --git-dir "$git" p4 sync) &&
+	(cd "$git" && git checkout -q p4/master) &&
+	test_path_is_file "$git"/cli_file.t &&
+	(
+		cd "$cli" &&
+		echo "cli_file2" >cli_file2.t &&
+		p4 add cli_file2.t  &&
+		p4 submit -d "cli change2"
+	) &&
+	(GIT_DIR="$git" git p4 sync) &&
+	(cd "$git" && git checkout -q p4/master) &&
+	test_path_is_file "$git"/cli_file2.t
+'
+
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.8.2.703.g78b384c.dirty

