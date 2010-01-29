From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCHv5 1/2] filter-branch: Fix to allow replacing submodules with another content
Date: Fri, 29 Jan 2010 16:27:04 +0100
Message-ID: <1264778825-26401-1-git-send-email-sojkam1@fel.cvut.cz>
References: <201001291620.35269.sojkam1@fel.cvut.cz>
Cc: j.sixt@viscovery.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com, Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 16:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naskp-0002T9-EG
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab0A2P1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765Ab0A2P1V
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:27:21 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:54420 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230Ab0A2P1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:27:20 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id E94B519F3375;
	Fri, 29 Jan 2010 16:27:19 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id G9D7sse7EcqH; Fri, 29 Jan 2010 16:27:19 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id C39AE19F3333;
	Fri, 29 Jan 2010 16:27:19 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id BB129FA003;
	Fri, 29 Jan 2010 16:27:19 +0100 (CET)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <201001291620.35269.sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138325>

When git filter-branch is used to replace a submodule with another
content, it always fails on the first commit. Consider a repository with
submod directory containing a submodule. If I want to remove the
submodule and replace it with a file, the following command fails.

git filter-branch --tree-filter 'rm -rf submod &&
				 git rm -q submod &&
				 mkdir submod &&
				 touch submod/file'

The error message is:
error: submod: is a directory - add files inside instead

The reason is that git diff-index, which generates the first part of the
list of files updated by the tree filter, emits also the removed
submodule even if it was replaced by a real directory.

Adding --ignored-submodules solves the problem for me and
tests in t7003-filter-branch.sh pass correctly.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 195b5ef..7c4ad7d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -331,7 +331,7 @@ while read commit parents; do
 			die "tree filter failed: $filter_tree"
 
 		(
-			git diff-index -r --name-only $commit &&
+			git diff-index -r --name-only --ignore-submodules $commit &&
 			git ls-files --others
 		) > "$tempdir"/tree-state || exit
 		git update-index --add --replace --remove --stdin \
-- 
1.6.6
