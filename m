From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH 2/2] t/t9802: explicitly name the upstream branch to use as a base
Date: Mon, 17 Jun 2013 18:40:50 -0700
Message-ID: <1371519650-17869-2-git-send-email-bcasey@nvidia.com>
References: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	<pw@padd.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 03:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uokvg-0008IV-5J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 03:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3FRBls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 21:41:48 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:15126 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab3FRBlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 21:41:47 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51bfbc730000>; Mon, 17 Jun 2013 18:48:35 -0700
Received: from hqemhub03.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2013 18:41:28 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 17 Jun 2013 18:41:28 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.298.1; Mon, 17 Jun 2013
 18:41:27 -0700
X-Mailer: git-send-email 1.8.2.415.g63cec41
In-Reply-To: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228128>

From: Brandon Casey <drafnel@gmail.com>

Prior to commit fa83a33b, the 'git checkout' DWIMery would create a
new local branch if the specified branch name did not exist and it
matched exactly one ref in the "remotes" namespace.  It searched
the "remotes" namespace for matching refs using a simple comparison
of the trailing portion of the remote ref names.  This approach
could sometimes produce false positives or negatives.

Since fa83a33b, the DWIMery more strictly excludes the remote name
from the ref comparison by iterating through the remotes that are
configured in the .gitconfig file.  This has the side-effect that
any refs that exist in the "remotes" namespace, but do not match
the destination side of any remote refspec, will not be used by
the DWIMery.

This change in behavior breaks the tests in t9802 which relied on
the old behavior of searching all refs in the remotes namespace,
since the git-p4 script does not configure any remotes in the
.gitconfig.  Let's work around this in these tests by explicitly
naming the upstream branch to base the new local branch on when
calling 'git checkout'.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t9802-git-p4-filetype.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index eeefa67..b0d1d94 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -95,7 +95,7 @@ test_expect_success 'gitattributes setting eol=lf produces lf newlines' '
 		git init &&
 		echo "* eol=lf" >.gitattributes &&
 		git p4 sync //depot@all &&
-		git checkout master &&
+		git checkout -b master p4/master &&
 		test_cmp "$cli"/f-unix-orig f-unix &&
 		test_cmp "$cli"/f-win-as-lf f-win
 	)
@@ -109,7 +109,7 @@ test_expect_success 'gitattributes setting eol=crlf produces crlf newlines' '
 		git init &&
 		echo "* eol=crlf" >.gitattributes &&
 		git p4 sync //depot@all &&
-		git checkout master &&
+		git checkout -b master p4/master &&
 		test_cmp "$cli"/f-unix-as-crlf f-unix &&
 		test_cmp "$cli"/f-win-orig f-win
 	)
-- 
1.8.2.415.g63cec41
