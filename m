From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH/RFC] filter-branch: Fix to allow replacing submodules with another content
Date: Mon, 11 Jan 2010 17:33:54 +0100
Message-ID: <1263227634-11259-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 17:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUNNi-0000DH-Se
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab0AKQoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 11:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822Ab0AKQoj
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:44:39 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:43475 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab0AKQoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 11:44:38 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 8D04A19F3381;
	Mon, 11 Jan 2010 17:34:10 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id OQutCfZt9fCV; Mon, 11 Jan 2010 17:34:10 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 6DE1219F336E;
	Mon, 11 Jan 2010 17:34:10 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3FA9C15C040;
	Mon, 11 Jan 2010 17:34:10 +0100 (CET)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136643>

When git filter-branch is used to replace a submodule with another
content, it always fails on the first commit. Consider a repository with
directory submodule containing a submodule. If I want to remove the
submodule and replace it with a file, the following command fails.

git filter-branch --tree-filter 'rm -rf submodule &&
				 git rm -q submodule &&
				 mkdir submodule &&
				 touch submodule/file'

The error message is:
error: submodule: is a directory - add files inside instead

The reason is that git diff-index, which generates a part of the list of
files to update-index, emits also the removed submodule even if it was
replaced by a real directory.

Adding --ignored-submodules solves the problem for me and
tests in t7003-filter-branch.sh passes correctly.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 195b5ef..d4ac7fb 100755
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
