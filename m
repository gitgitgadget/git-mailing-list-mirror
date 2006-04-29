From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] cg-admin-rewritehist: fix reappearing files with --filter-tree.
Date: Sat, 29 Apr 2006 23:45:40 +0200 (CEST)
Message-ID: <20060429214540.524C14A5A6@dx.sixt.local>
X-From: git-owner@vger.kernel.org Sat Apr 29 23:45:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZxGB-0003hH-No
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 23:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWD2Vpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 17:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWD2Vpo
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 17:45:44 -0400
Received: from mail.nextra.at ([195.170.70.86]:56973 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1750814AbWD2Vpo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 17:45:44 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k3TLjfun010254
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 23:45:42 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: by dx.sixt.local (Postfix, from userid 1000)
	id 524C14A5A6; Sat, 29 Apr 2006 23:45:40 +0200 (CEST)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19321>

With --filter-tree a working copy is checked out for each commit.
However, if a file is removed by a commit, the file is _not_ removed
from the working copy by git-checkout-index. This must be done explicitly,
otherwise the file becomes added back again.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

---

 cg-admin-rewritehist |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

26bb71a2d3d583d9eee10f4e950ff1b7d400e975
diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 7dd83cf..13ffb5d 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -213,10 +213,13 @@ while read commit; do
 
 	if [ "$filter_tree" ]; then
 		git-checkout-index -f -u -a
+		# files that $commit removed are now still in the working tree;
+		# remove them, else they would be added again
+		git-ls-files -z --others | xargs -0 rm -f
 		eval "$filter_tree"
 		git-diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
 			xargs -0 git-update-index --add --replace --remove
-		git-ls-files --others | tr '\n' '\0' | \
+		git-ls-files -z --others | \
 			xargs -0 git-update-index --add --replace --remove
 	fi
 
-- 
1.3.1.gaa6b
