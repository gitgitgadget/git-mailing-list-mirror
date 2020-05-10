Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB4CC38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF2E2080C
	for <git@archiver.kernel.org>; Sun, 10 May 2020 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="bAafmPnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEJKmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 06:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEJKmi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 06:42:38 -0400
X-Greylist: delayed 1535 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 May 2020 03:42:38 PDT
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B35C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cpH8X6Y5AZ0fioA9af+4TJ5j3O7YF7WV79mdn3HTA4U=; b=bAafmPnE01P9Mse6ARp1jAvCSj
        hVDlgSSVzo+AgHnja9h1BnNBaRzH+VoVfyzXsTbRTK/mAElYK5cP4XeE4hUqmAq9GB+LIKRmiUwGO
        FeKT1PKBkXfc0bGhewM//1cjwp8wrjEhV9rcvoConfPyD5NxuYgLZhQjzJYgDNwSRugY=;
Received: from [2001:8b0:14bb:e93b:5435:c2c0:635c:9b55] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1jXj12-0004rV-Sn; Sun, 10 May 2020 10:17:00 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH v3] git-p4: recover from inconsistent perforce history
Date:   Sun, 10 May 2020 11:16:50 +0100
Message-Id: <20200510101650.50583-1-andrew@adoakley.name>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perforce allows you commit files and directories with the same name, so
you could have files //depot/foo and //depot/foo/bar both checked in.  A
p4 sync of a repository in this state fails.  Deleting one of the files
recovers the repository.

When this happens we want git-p4 to recover in the same way as perforce.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 git-p4.py                      | 43 ++++++++++++++++++++-
 t/t9834-git-p4-file-dir-bug.sh | 70 ++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100755 t/t9834-git-p4-file-dir-bug.sh

diff --git a/git-p4.py b/git-p4.py
index b8b2a1679e..d551efb0dd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3214,6 +3214,42 @@ def hasBranchPrefix(self, path):
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
 
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
+            path = decode_path(f['path'])
+            to_check.add(path + '/...')
+            while True:
+                path = path.rsplit("/", 1)[0]
+                if path == "/" or path in to_check:
+                    break
+                to_check.add(path)
+        to_check = ['%s@%s' % (wildcard_encode(p), change) for p in to_check
+            if self.hasBranchPrefix(p)]
+        if to_check:
+            stat_result = p4CmdList(["-x", "-", "fstat", "-T",
+                "depotFile,headAction,headRev,headType"], stdin=to_check)
+            for record in stat_result:
+                if record['code'] != 'stat':
+                    continue
+                if record['headAction'] in self.delete_actions:
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
@@ -3222,11 +3258,14 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
         if self.verbose:
             print('commit into {0}'.format(branch))
 
+        files = [f for f in files
+            if self.hasBranchPrefix(decode_path(f['path']))]
+        self.findShadowedFiles(files, details['change'])
+
         if self.clientSpecDirs:
             self.clientSpecDirs.update_client_spec_path_cache(files)
 
-        files = [f for (f, path) in ((f, decode_path(f['path'])) for f in files)
-            if self.inClientSpec(path) and self.hasBranchPrefix(path)]
+        files = [f for f in files if self.inClientSpec(decode_path(f['path']))]
 
         if gitConfigBool('git-p4.keepEmptyCommits'):
             allow_empty = True
diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
new file mode 100755
index 0000000000..031e1f8668
--- /dev/null
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -0,0 +1,70 @@
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
+	start_p4d &&
+	test_might_fail p4 configure set submit.collision.check=0
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
+		p4 submit -d "delete conflicting" &&
+
+		p4 delete -k "add_file_add_dir_del_file/file" &&
+		p4 delete -k "add_file_add_dir_del_dir" &&
+		p4 delete -k "add_dir_add_file_del_file/file" &&
+		p4 delete -k "add_dir_add_file_del_dir" &&
+		p4 submit -d "delete remaining"
+	)
+'
+
+test_expect_success 'clone with git-p4' '
+	git p4 clone --dest="$git" //depot/@1,3
+'
+
+test_expect_success 'check contents' '
+	test_path_is_dir "$git/add_file_add_dir_del_file" &&
+	test_path_is_file "$git/add_file_add_dir_del_dir" &&
+	test_path_is_dir "$git/add_dir_add_file_del_file" &&
+	test_path_is_file "$git/add_dir_add_file_del_dir"
+'
+
+test_expect_success 'rebase and check empty' '
+	git -C "$git" p4 rebase &&
+
+	test_path_is_missing "$git/add_file_add_dir_del_file" &&
+	test_path_is_missing "$git/add_file_add_dir_del_dir" &&
+	test_path_is_missing "$git/add_dir_add_file_del_file" &&
+	test_path_is_missing "$git/add_dir_add_file_del_dir"
+'
+
+test_done
-- 
2.24.1

