Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D117E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noprivs.com header.i=@noprivs.com header.b="ktJ1DDOX"
Received: from mail-108-mta104.mxroute.com (mail-108-mta104.mxroute.com [136.175.108.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84029FE
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:26:24 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta104.mxroute.com (ZoneMTA) with ESMTPSA id 18b455385bb0008912.003
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 19 Oct 2023 00:26:23 +0000
X-Zone-Loop: aa981cf1c1a333a4fab8cbeaa731886d4a411fd26a62
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=noprivs.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=izMwrpNWH5cAoUSZWkSZlcvjRKeUxsEcy1skm+piHc4=; b=ktJ1DDOXvZx95RLFTaT1RYtXTJ
	isU7z2HqH77bn4qo0vY5/bvS8NqbvR835mopq+mK77Dvw74CBVShjl0sWs2OEoF5c0xLeADzkGg8L
	p1a+C0ZBtmuMTkc2eFTQd4Rn6s8e6Tsbgzwd2AKdMz/iYaTxzHCia8n36L57V1ZZFRTcy/N5Ls0yZ
	Vf85AWXMSoqWbpVVnU5zKaavZ0tr+3ZBJC6oRzZqRC1N3SOmO3z+pnfNwrPHgNpr9aIhR2iyEnCYL
	2gL0c8NZN6Yb8fwwPVaicpNjVZyTN4fbux7f4trLdXea+EslAZZJgn36dyHdD5/40yz/w7cLAG2cg
	IpvCjXQg==;
From: Matthew McClain <mmcclain@noprivs.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	gitster@pobox.com,
	Matthew McClain <mmcclain@noprivs.com>
Subject: [PATCH v2] git-p4 shouldn't attempt to store symlinks in LFS
Date: Wed, 18 Oct 2023 19:25:58 -0500
Message-Id: <20231019002558.867830-1-mmcclain@noprivs.com>
In-Reply-To: <ZTBbqobbqQpxHPI2@tapette.crustytoothpaste.net>
References: <ZTBbqobbqQpxHPI2@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: catch@noprivs.com

git-p4.py would attempt to put a symlink in LFS if its file extension
matched git-p4.largeFileExtensions.

Git LFS doesn't store symlinks because smudge/clean filters don't handle
symlinks. They never get passed to the filter process nor the
smudge/clean filters, nor could that occur without a change to the
protocol or command-line interface. Unless Git learned how to send them
to the filters, Git LFS would have a hard time using them in any useful
way.

Git LFS's goal is to move large files out of the repository history, and
symlinks are functionally limited to 4 KiB or a similar size on most
systems.

Signed-off-by: Matthew McClain <mmcclain@noprivs.com>
---
 git-p4.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index d26a980e5a..0eb3bb4c47 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1522,6 +1522,10 @@ def processContent(self, git_mode, relPath, contents):
            file is stored in the large file system and handles all necessary
            steps.
            """
+        # symlinks aren't processed by smudge/clean filters
+        if git_mode == "120000":
+            return (git_mode, contents)
+
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
             pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
-- 
2.39.3

