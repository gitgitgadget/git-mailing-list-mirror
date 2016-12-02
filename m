Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E391FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755561AbcLBWnc (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 17:43:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34573 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbcLBWna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 17:43:30 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so9057674pgc.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUlFwoUFJplGhwMXd4wmKhhinMySzhB9+rJ7G+rfF68=;
        b=I560lchF1QuBy68FAEHwdVaSu4PHdNXsxpk4bonuHDsyoMcgJtQvwEaMCIIrZNsePF
         yd52vhHuuJKReINkjYwIZfQfhXzb/YoakaYQPTIxjE9X5kO3OF8x0ut+yQukd/gJmRb1
         rYKtqeW9WHNznwQVRxKoonnTnKvuMLgndA7HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUlFwoUFJplGhwMXd4wmKhhinMySzhB9+rJ7G+rfF68=;
        b=mOHN45d3SZcdqPoyDr95D7kAGrxAKuglFruLm7oHWsRO/0ULkhrsXSdibJw/4Dwn4r
         51JDu3t7WHlBTQCmwFrQsEYU/Anfs4lxtZdiumlWit1cBFQ4CdcIYpKD2vXrhVGkn2EY
         wJKkntuMp32+lq7UGUm2nMRSmzRdi6xe0X8f7MIJkPTN2k1bxDnoSMGKTcsb6+xYfsUO
         N6463EtjhMrpF4zMpt+2LFHG3o+dk11pDGDPFF+bvo/16VFWZz+VZRwRsRrJfmIdKmLP
         qXaRHu3KQxPlz99v5Z6C23tZX7n3PB5R4cebpq3pGkvajOVcji37HfZZhoAXgfs32PjG
         VeoA==
X-Gm-Message-State: AKaTC02k0YAsT8euSlV3dvN9nCpXRMK3TALXuOJ2LqC7ziWnbkXSocttV/ecKsi4g1ol5A==
X-Received: by 10.84.212.2 with SMTP id d2mr102778629pli.24.1480718609743;
        Fri, 02 Dec 2016 14:43:29 -0800 (PST)
Received: from lgd-kipper.corp.roku ([50.224.7.248])
        by smtp.gmail.com with ESMTPSA id 16sm9992784pfk.54.2016.12.02.14.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 14:43:29 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/2] git-p4: support updating an existing shelved changelist
Date:   Fri,  2 Dec 2016 22:43:19 +0000
Message-Id: <20161202224319.5385-3-luke@diamand.org>
X-Mailer: git-send-email 2.11.0.274.g0ea315c
In-Reply-To: <20161202224319.5385-1-luke@diamand.org>
References: <20161202224319.5385-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds new option "--update-shelve CHANGELIST" which updates
an existing shelved changelist.

The original changelist must have been created by the current user.

This allows workflow something like:

   hack hack hack
   git commit
   git p4 submit --shelve
   $mail interested parties about shelved changelist
   make corrections
   git commit --amend
   git p4 submit --update-shelve $CHANGELIST
   $mail interested parties about shelved changelist
   etc

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  4 ++++
 git-p4.py                | 33 +++++++++++++++++++++++++++++----
 t/t9807-git-p4-submit.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 1bbf43d15..ce40b9a54 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -308,6 +308,10 @@ These options can be used to modify 'git p4 submit' behavior.
 	After creating each shelve, the relevant files are reverted/deleted.
 	If you have multiple commits pending multiple shelves will be created.
 
+--update-shelve CHANGELIST::
+	Update an existing shelved changelist with this commit. Implies
+	--shelve.
+
 --conflict=(ask|skip|quit)::
 	Conflicts can occur when applying a commit to p4.  When this
 	happens, the default behavior ("ask") is to prompt whether to
diff --git a/git-p4.py b/git-p4.py
index 5e2db1919..36242d384 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -262,6 +262,10 @@ def p4_revert(f):
 def p4_reopen(type, f):
     p4_system(["reopen", "-t", type, wildcard_encode(f)])
 
+def p4_reopen_in_change(changelist, files):
+    cmd = ["reopen", "-c", str(changelist)] + files
+    p4_system(cmd)
+
 def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
@@ -1298,6 +1302,9 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--shelve", dest="shelve", action="store_true",
                                      help="Shelve instead of submit. Shelved files are reverted, "
                                      "restoring the workspace to the state before the shelve"),
+                optparse.make_option("--update-shelve", dest="update_shelve", action="store", type="int",
+                                     metavar="CHANGELIST",
+                                     help="update an existing shelved changelist, implies --shelve")
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -1306,6 +1313,7 @@ class P4Submit(Command, P4UserMap):
         self.preserveUser = gitConfigBool("git-p4.preserveUser")
         self.dry_run = False
         self.shelve = False
+        self.update_shelve = None
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
@@ -1474,7 +1482,7 @@ class P4Submit(Command, P4UserMap):
                     return 1
         return 0
 
-    def prepareSubmitTemplate(self):
+    def prepareSubmitTemplate(self, changelist=None):
         """Run "p4 change -o" to grab a change specification template.
            This does not use "p4 -G", as it is nice to keep the submission
            template in original order, since a human might edit it.
@@ -1486,7 +1494,11 @@ class P4Submit(Command, P4UserMap):
 
         template = ""
         inFilesSection = False
-        for line in p4_read_pipe_lines(['change', '-o']):
+        args = ['change', '-o']
+        if changelist:
+            args.append(str(changelist))
+
+        for line in p4_read_pipe_lines(args):
             if line.endswith("\r\n"):
                 line = line[:-2] + "\n"
             if inFilesSection:
@@ -1585,11 +1597,14 @@ class P4Submit(Command, P4UserMap):
         editedFiles = set()
         pureRenameCopy = set()
         filesToChangeExecBit = {}
+        all_files = list()
 
         for line in diff:
             diff = parseDiffTreeEntry(line)
             modifier = diff['status']
             path = diff['src']
+            all_files.append(path)
+
             if modifier == "M":
                 p4_edit(path)
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
@@ -1715,6 +1730,10 @@ class P4Submit(Command, P4UserMap):
             mode = filesToChangeExecBit[f]
             setP4ExecBit(f, mode)
 
+        if self.update_shelve:
+            print("all_files = %s" % str(all_files))
+            p4_reopen_in_change(self.update_shelve, all_files)
+
         #
         # Build p4 change description, starting with the contents
         # of the git commit message.
@@ -1723,7 +1742,7 @@ class P4Submit(Command, P4UserMap):
         logMessage = logMessage.strip()
         (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
 
-        template = self.prepareSubmitTemplate()
+        template = self.prepareSubmitTemplate(self.update_shelve)
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
@@ -1795,7 +1814,10 @@ class P4Submit(Command, P4UserMap):
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
                 submitTemplate = message[:message.index(separatorLine)]
-                if self.shelve:
+
+                if self.update_shelve:
+                    p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
+                elif self.shelve:
                     p4_write_pipe(['shelve', '-i'], submitTemplate)
                 else:
                     p4_write_pipe(['submit', '-i'], submitTemplate)
@@ -1921,6 +1943,9 @@ class P4Submit(Command, P4UserMap):
         if len(self.origin) == 0:
             self.origin = upstream
 
+        if self.update_shelve:
+            self.shelve = True
+
         if self.preserveUser:
             if not self.canChangeChangelists():
                 die("Cannot preserve user names without p4 super-user or admin permissions")
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 42a5fada5..e37239e65 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -444,6 +444,44 @@ test_expect_success 'submit --shelve' '
 	)
 '
 
+# Update an existing shelved changelist
+
+test_expect_success 'submit --update-shelve' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 revert ... &&
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		test_commit "test-update-shelved-change" &&
+		git p4 submit --origin=HEAD^ --shelve &&
+
+		shelf_cl=$(p4 -G changes -s shelved -m 1 |\
+			marshal_dump change) &&
+		test -n $shelf_cl &&
+		echo "updating shelved change list $shelf_cl" &&
+
+		echo "updated-line" >>shelf.t &&
+		echo added-file.t >added-file.t &&
+		git add shelf.t added-file.t &&
+		git rm -f test-update-shelved-change.t &&
+		git commit --amend -C HEAD &&
+		git show --stat HEAD &&
+		git p4 submit -v --origin HEAD^ --update-shelve $shelf_cl &&
+		echo "done git p4 submit"
+	) &&
+	(
+		cd "$cli" &&
+		change=$(p4 -G changes -s shelved -m 1 //depot/... | \
+			 marshal_dump change) &&
+		p4 unshelve -c $change -s $change &&
+		grep -q updated-line shelf.t &&
+		p4 describe -S $change | grep added-file.t &&
+		test_path_is_missing test-update-shelved-change.t
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.11.0.274.g0ea315c

