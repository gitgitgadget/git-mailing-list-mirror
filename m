Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7A0C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385E6246B0
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgB1PQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:16:02 -0500
Received: from srv2.zoy.org ([193.200.42.164]:51979 "EHLO smtp.zoy.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbgB1PQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 10:16:01 -0500
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 10:16:01 EST
Received: by smtp.zoy.org (Postfix, from userid 1000)
        id 82EBF360CAB; Fri, 28 Feb 2020 16:07:10 +0100 (CET)
Date:   Fri, 28 Feb 2020 16:07:10 +0100
From:   Sam Hocevar <sam@hocevar.net>
To:     git@vger.kernel.org
Subject: [PATCH] git-p4: reverse large file detection order
Message-ID: <20200228150710.ikgijcxlft5wjl3h@hocevar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is more efficient to first check for a file's extension against
git-p4.largeFileExtensions before git-p4.largeFileCompressedThreshold
because the latter test may trigger a costly compression task.

Signed-off-by: Sam Hocevar <sam@hocevar.net>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git git-p4.py git-p4.py
index 40d9e7c594..a54970aa74 100755
--- git-p4.py
+++ git-p4.py
@@ -1197,7 +1197,7 @@ def processContent(self, git_mode, relPath, contents):
         """Processes the content of git fast import. This method decides if a
            file is stored in the large file system and handles all necessary
            steps."""
-        if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
+        if self.hasLargeFileExtension(relPath) or self.exceedsLargeFileThreshold(relPath, contents):
             contentTempFile = self.generateTempFile(contents)
             (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
             if pointer_git_mode:
-- 
2.25.1
