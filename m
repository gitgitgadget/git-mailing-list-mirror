From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 02/18] Add t1510 for setup tests
Date: Sun, 24 Oct 2010 19:11:34 +0700
Message-ID: <1287922310-14678-3-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zR6-0008WA-Oz
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560Ab0JXMML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53526 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:10 -0400
Received: by pwj8 with SMTP id 8so245656pwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=C5uwNjs/kTHRLkXHzkLuSeOfcri7HEMcdrIok4YL/LI=;
        b=IrudEjz8PjCWSJMsaxtgqVa56RAKLBNpREUMyowKfFpNrumwqfZMwYWTOUAtuO7oav
         1sWZLiu5z/tqdX2Ndx5fhDn3fMHF3buo5zBDnCrV4WGazYXxdHoK/0A70R3Z8p/w+752
         KJm0VkES35W2Jn0EeZzc19n6Q/P5qVtehTwbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HyMv4Olx3lPdxQiJ9ckbOIyTh3SLeWrmc8EJFw0s88i3HDfgVjd5ca5AglpVOEPZ6c
         lz8LZRQ0P3slCsqHGHD+c1LtFMTU9wGqR8ev2P7SUCoHU7iR4vOHzLT8A8SQ0s6pj+wH
         hbPTuPLDAunVO5JwnH0x8PaN/XJUEESRj+I3I=
Received: by 10.142.242.16 with SMTP id p16mr542397wfh.19.1287922329627;
        Sun, 24 Oct 2010 05:12:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm9126172wfj.2.2010.10.24.05.12.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:05 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159858>

---
 t/t1510-repo-setup.sh |   56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-repo-setup.sh

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
new file mode 100755
index 0000000..d618787
--- /dev/null
+++ b/t/t1510-repo-setup.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='Tests of cwd/prefix/worktree/gitdir setup in all cases'
+
+. ./test-lib.sh
+
+# A few principles for repo setup:
+#
+# 1. GIT_DIR is relative to user's cwd. This directory is refered as
+#    "git_dir" below. Auto discovered repo is also "git_dir".
+#    --git-dir is equivalent to GIT_DIR.
+#
+# 2. core.worktree is relative to git_dir
+#
+# 3. GIT_WORK_TREE is relative to user's cwd. --work-tree is
+#    equivalent to GIT_WORK_TREE.
+#
+# 4. .git file is relative to git_dir. Note that the repo where .git
+#    file points to is not considered "git_dir" in the above.
+#
+# 5. GIT_WORK_TREE is only effective if GIT_DIR is
+#    set (hence "Effective GIT_WORK_TREE"
+#    below). Uneffective GIT_WORK_TREE should be warned.
+#
+# 6. Effective GIT_WORK_TREE will override core.worktree
+#
+# 7. During repo discovery, if "." is found a repo, it is considered a
+#    bare repo unless core.worktree is set
+#
+# 8. core.bare conflicts with core.worktree
+#
+# 9. Effective GIT_WORK_TREE will override core.bare
+#
+# 10. When user's cwd is outside worktree, cwd will remain unchanged,
+#     prefix be NULL.
+
+test_repo() {
+	(
+	if [ -n "$1" ]; then cd "$1"; fi &&
+	git symbolic-ref HEAD >/dev/null && # git_dir reachability test first
+	git rev-parse --internal-git-dir >result &&
+	git rev-parse --show-toplevel >>result &&
+	git rev-parse --internal-cwd >>result &&
+	git rev-parse --show-prefix >>result &&
+	test_cmp expected result
+	)
+}
+
+# Bit 0 = GIT_WORK_TREE
+# Bit 1 = GIT_DIR
+# Bit 2 = core.worktree
+# Bit 3 = .git is a file
+# Bit 4 = bare repo
+# Case# = encoding of the above 5 bits
+
+test_done
-- 
1.7.0.2.445.gcbdb3
