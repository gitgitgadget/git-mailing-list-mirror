From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] cg-admin-rewritehist: fix reappearing files with --filter-tree.
Date: Thu,  4 May 2006 21:36:09 +0200 (CEST)
Message-ID: <20060504193609.94E1E4AEEC@dx.sixt.local>
X-From: git-owner@vger.kernel.org Thu May 04 21:36:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbjco-0003RU-Bf
	for gcvg-git@gmane.org; Thu, 04 May 2006 21:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEDTgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 15:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWEDTgb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 15:36:31 -0400
Received: from mail.nextra.at ([195.170.70.86]:6717 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1750843AbWEDTga (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 15:36:30 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k44JaFdr012875;
	Thu, 4 May 2006 21:36:16 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: by dx.sixt.local (Postfix, from userid 1000)
	id 94E1E4AEEC; Thu,  4 May 2006 21:36:09 +0200 (CEST)
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19575>

With --filter-tree a working copy is checked out for each commit.
However, if a file is removed by a commit, the file is _not_ removed
from the working copy by git-checkout-index. This must be done explicitly,
otherwise the file becomes added back again.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

---

I'm posting this again, because I haven't received any feedback nor has
the patch been applied.

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
