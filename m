From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] filter-branch: prevent filters from reading from stdin
Date: Tue, 5 Jun 2007 16:12:08 +0200
Message-ID: <20070605141208.GA23605@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 16:12:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvZmF-0005zP-Gq
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 16:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762519AbXFEOMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 10:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762531AbXFEOMP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 10:12:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:37723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762519AbXFEOMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 10:12:14 -0400
Received: (qmail invoked by alias); 05 Jun 2007 14:12:12 -0000
Received: from pD9EBB5EC.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.236]
  by mail.gmx.net (mp057) with SMTP; 05 Jun 2007 16:12:12 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+3YsFXS923Ou7C9bYAhPJDcRnpENUKOnCpt5vmUd
	EZUOIz+DQ8nCH2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49200>

stdin is the list of commits when the env, tree and index
filter are executed.  The filters are not supposed to read
anything from stdin so the best is to give them /dev/null
for reading.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 git-filter-branch.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index f4cfbea..e220b85 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -352,21 +352,21 @@ while read commit; do
 
 	eval "$(set_ident AUTHOR <../commit)"
 	eval "$(set_ident COMMITTER <../commit)"
-	eval "$filter_env"
+	eval "$filter_env" < /dev/null
 
 	if [ "$filter_tree" ]; then
 		git-checkout-index -f -u -a
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
 		git-ls-files -z --others | xargs -0 rm -f
-		eval "$filter_tree"
+		eval "$filter_tree" < /dev/null
 		git-diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
 			xargs -0 git-update-index --add --replace --remove
 		git-ls-files -z --others | \
 			xargs -0 git-update-index --add --replace --remove
 	fi
 
-	eval "$filter_index"
+	eval "$filter_index" < /dev/null
 
 	parentstr=
 	for parent in $(get_parents $commit); do
-- 
1.5.2.1.120.g3877-dirty
