Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAC1A593
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noprivs.com header.i=@noprivs.com header.b="HRMGR+o/"
Received: from mail-108-mta198.mxroute.com (mail-108-mta198.mxroute.com [136.175.108.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A10109
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:59:36 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta198.mxroute.com (ZoneMTA) with ESMTPSA id 18b442852a0000ff68.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 18 Oct 2023 18:59:35 +0000
X-Zone-Loop: ba9e7d830a02a0536b4459a6100640cb80b3b91ac182
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=noprivs.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To
	:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=XQOVDX2z4K3ImGFVbco+vXm66M0opAmis9PvRfrxDfg=; b=H
	RMGR+o/AMSKSK5Yp+a71ee3/68Uk1Rh03H8pHJku9h9s8+tt9CiKMrwIAmqdeuOnKR1iFJNqHCgcb
	iXSEIefg0RCfFS69aSjtXTgw/mMkDyQgSKOrk5QLPpLYA+tsD0rtsqpPn50Bo+KHRgA+X6TCckIiT
	oaIRDIG/z4inBtKfouzHe7tC81b+gqy7Lp4cHcFBADABLi5TFxlmbGGmAQ/3Gv7FJU3yZ/U6qR5Xb
	jE2TGMD4+5T0UWnvGTNHS9zCerFk9KEjV7eNZjuvDBxwHu0pMd2uhRVXcgfu9u10uoTe/gn1bIF/j
	kQ+S0AoK5vtKcWNzbQB05rFq82vLeGAJw==;
From: Matthew McClain <mmcclain@noprivs.com>
To: git@vger.kernel.org
Cc: Matthew McClain <mmcclain@noprivs.com>
Subject: [PATCH] git-p4 shouldn't attempt to store symlinks in LFS
Date: Wed, 18 Oct 2023 13:58:54 -0500
Message-Id: <20231018185854.857674-1-mmcclain@noprivs.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: catch@noprivs.com

If a symlink in your Perforce repository matches
git-p4.largeFileExtensions, git-p4.py will attempt to put the symlink in
LFS but will blow up when it passes a string to generateTempFile.

Git LFS normal behavior does not stash symlinks in LFS.

Importing revision 42889 (100%)Traceback (most recent call last):
  File "./git/git-p4.py", line 4621, in <module>
    main()
  File "./git/git-p4.py", line 4615, in main
    if not cmd.run(args):
  File "./git/git-p4.py", line 4225, in run
    self.importRevisions(args, branch_arg_given)
  File "./git/git-p4.py", line 4002, in importRevisions
    self.importChanges(changes)
  File "./git/git-p4.py", line 3876, in importChanges
    self.initialParent)
  File "./git/git-p4.py", line 3496, in commit
    self.streamP4Files(files)
  File "./git/git-p4.py", line 3336, in streamP4Files
    cb=streamP4FilesCbSelf)
  File "./git/git-p4.py", line 910, in p4CmdList
    cb(entry)
  File "./git/git-p4.py", line 3321, in streamP4FilesCbSelf
    self.streamP4FilesCb(entry)
  File "./git/git-p4.py", line 3266, in streamP4FilesCb
    self.streamOneP4File(self.stream_file, self.stream_contents)
  File "./git/git-p4.py", line 3217, in streamOneP4File
    git_mode, contents = self.largeFileSystem.processContent(git_mode, relPath, contents)
  File "./git/git-p4.py", line 1656, in processContent
    return LargeFileSystem.processContent(self, git_mode, relPath, contents)
  File "./git/git-p4.py", line 1526, in processContent
    contentTempFile = self.generateTempFile(contents)
  File "./git/git-p4.py", line 1488, in generateTempFile
    contentFile.write(d)
  File "/usr/lib64/python3.6/tempfile.py", line 485, in func_wrapper
    return func(*args, **kwargs)
TypeError: a bytes-like object is required, not 'str'

Signed-off-by: Matthew McClain <mmcclain@noprivs.com>
---
 git-p4.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index d26a980e5a..f5fda2a3dc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1522,6 +1522,10 @@ def processContent(self, git_mode, relPath, contents):
            file is stored in the large file system and handles all necessary
            steps.
            """
+        # no need to store symlinks in LFS (generateTempFile wants bytes)
+        if git_mode == "120000":
+            return (git_mode, contents)
+
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
             pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
-- 
2.39.3

