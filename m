From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 1/2] filter-branch: Fix to allow replacing submodules with another content
Date: Mon, 25 Jan 2010 14:06:24 +0100
Message-ID: <1264424786-26231-2-git-send-email-sojkam1@fel.cvut.cz>
References: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Johannes.Schindelin@gmx.de, Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 14:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZOet-00066U-KW
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab0AYNGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908Ab0AYNGk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:06:40 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:58817 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab0AYNGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:06:39 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id D582719F3393;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id rxXMyG0u7Mh5; Mon, 25 Jan 2010 14:06:37 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 354A819F3349;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 244CAFA003;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137962>

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

If somebody wants to replace one revision of the module with another, it
can be done with --index-filter. Using --tree-filter for this has no
sense since --tree-filter "git submodule update --init" fails with
  Clone of '/tmp/submod' into submodule path 'submod' failed
so that the revision must be replaced only in index.

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
