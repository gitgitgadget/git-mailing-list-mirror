Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB531F453
	for <e@80x24.org>; Wed,  6 Feb 2019 20:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBFUIa (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 15:08:30 -0500
Received: from adoakley.name ([88.198.105.104]:55628 "EHLO adoakley.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBFUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 15:08:29 -0500
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 15:08:28 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Rsg/blQbnzFHzwtPUXcKsS4OaEFntM53qEvQ7i934w=; b=EHgkCp1217nnysxyR7fLDxcTS3
        klJp7ZoQxm3V82Q6wG7NuEih8Si0wSZlJy8CLS77YjfHR+a2Tb7xYt200OTppxR8QQB+6sgehy5h/
        4VvTzT45F0hgzfv4S+61z4lw10fjSOnfc75UOplkb65MGcId84cbCMD1iA1PuzjsRbu8=;
Received: from ado-amd-gentoo.home.adoakley.name ([2001:8b0:14bb:e93b:b0a2:3603:6426:932f])
        by adoakley.name with esmtpa (Exim 4.91)
        (envelope-from <andrew@adoakley.name>)
        id 1grT5V-0004ay-Ro; Wed, 06 Feb 2019 19:42:25 +0000
From:   andrew@adoakley.name
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 1/1] git-p4: recover from inconsistent perforce history
Date:   Wed,  6 Feb 2019 19:42:19 +0000
Message-Id: <20190206194219.15507-1-andrew@adoakley.name>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Oakley <andrew@adoakley.name>

Perforce allows you commit files and directories with the same name, so
you could have files //depot/foo and //depot/foo/bar both checked in.  A
p4 sync of a repository in this state fails.  Deleting one of the files
recovers the repository.

When this happens we want git-p4 to recover in the same way as perforce.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 git-p4.py                      | 41 ++++++++++++++++++++++--
 t/t9834-git-p4-file-dir-bug.sh | 58 ++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100755 t/t9834-git-p4-file-dir-bug.sh

diff --git a/git-p4.py b/git-p4.py
index 3e12774f96..6bf2bbbcec 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3012,6 +3012,43 @@ def hasBranchPrefix(self, path):
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
 
+    def isIncluded(self, path):
+        return self.inClientSpec(path) and self.hasBranchPrefix(path)
+
+    def findShadowedFiles(self, files, change):
+        # Perforce allows you commit files and directories with the same name,
+        # so you could have files //depot/foo and //depot/foo/bar both checked
+        # in.  A p4 sync of a repository in this state fails.  Deleting one of
+        # the files recovers the repository.
+        #
+        # Git will not allow the broken state to exist and only the most recent
+        # of the conflicting names is left in the repository.  When one of the
+        # conflicting files is deleted we need to re-add the other one to make
+        # sure the git repository recovers in the same way as perforce.
+        deleted = [f for f in files if f['action'] in self.delete_actions]
+        to_check = set()
+        for f in deleted:
+            path = f['path']
+            to_check.add(path + '/...')
+            while True:
+                path = path.rsplit("/", 1)[0]
+                if path == "/" or path in to_check:
+                    break
+                to_check.add(path)
+        to_check = [p for p in to_check if self.isIncluded(p)]
+        if to_check:
+            stat_result = p4CmdList(
+                ["fstat", "-T", "depotFile,headRev,headType"] +
+                    ["%s@%s" % (p, change) for p in to_check])
+            for record in stat_result:
+                if record['code'] != 'stat':
+                    continue
+                files.append({
+                    'action': 'add',
+                    'path': record['depotFile'],
+                    'rev': record['headRev'],
+                    'type': record['headType']})
+
     def commit(self, details, files, branch, parent = "", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
@@ -3023,8 +3060,8 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
         if self.clientSpecDirs:
             self.clientSpecDirs.update_client_spec_path_cache(files)
 
-        files = [f for f in files
-            if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]
+        files = [f for f in files if self.isIncluded(f['path'])]
+        self.findShadowedFiles(files, details["change"])
 
         if gitConfigBool('git-p4.keepEmptyCommits'):
             allow_empty = True
diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
new file mode 100755
index 0000000000..9839a3d2bb
--- /dev/null
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='git p4 directory/file bug handling
+
+This test creates files and directories with the same name in perforce and
+checks that git-p4 recovers from the error at the same time as the perforce
+repository.'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+
+		touch add_file_add_dir_del_file add_file_add_dir_del_dir &&
+		p4 add add_file_add_dir_del_file add_file_add_dir_del_dir &&
+		mkdir add_dir_add_file_del_file add_dir_add_file_del_dir &&
+		touch add_dir_add_file_del_file/file add_dir_add_file_del_dir/file &&
+		p4 add add_dir_add_file_del_file/file add_dir_add_file_del_dir/file &&
+		p4 submit -d "add initial" &&
+
+		rm -f add_file_add_dir_del_file add_file_add_dir_del_dir &&
+		mkdir add_file_add_dir_del_file add_file_add_dir_del_dir &&
+		touch add_file_add_dir_del_file/file add_file_add_dir_del_dir/file &&
+		p4 add add_file_add_dir_del_file/file add_file_add_dir_del_dir/file &&
+		rm -rf add_dir_add_file_del_file add_dir_add_file_del_dir &&
+		touch add_dir_add_file_del_file add_dir_add_file_del_dir &&
+		p4 add add_dir_add_file_del_file add_dir_add_file_del_dir &&
+		p4 submit -d "add conflicting" &&
+
+		p4 delete -k add_file_add_dir_del_file &&
+		p4 delete -k add_file_add_dir_del_dir/file &&
+		p4 delete -k add_dir_add_file_del_file &&
+		p4 delete -k add_dir_add_file_del_dir/file &&
+		p4 submit -d "delete conflicting"
+	)
+'
+
+test_expect_success 'clone with git-p4' '
+	git p4 clone --dest="$git" //depot/@all
+'
+
+test_expect_success 'check final contents' '
+	test_path_is_dir "$git/add_file_add_dir_del_file" &&
+	test_path_is_file "$git/add_file_add_dir_del_dir" &&
+	test_path_is_dir "$git/add_dir_add_file_del_file" &&
+	test_path_is_file "$git/add_dir_add_file_del_dir"
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.19.2

