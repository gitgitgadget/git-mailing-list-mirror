From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] filter-branch: do not consider diverging submodules a 'dirty
 worktree'
Date: Thu, 5 Feb 2009 18:37:59 +0100 (CET)
Message-ID: <26931410834b5297493543e2a1cb75c3b6bf008a.1233855372u.git.johannes.schindelin@gmx.de>
References: <cover.1233855372u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 05 18:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8CJ-0000GG-W2
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBERiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbZBERiE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:38:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:51452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbZBERiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:38:02 -0500
Received: (qmail invoked by alias); 05 Feb 2009 17:38:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 05 Feb 2009 18:38:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mBEJwN7bmZL7Wz7/Wh4PowKGI/975Wqj5Z9uiqJ
	RnFf5lXy6ABPqk
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1233855372u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108587>

At the end of filter-branch in a non-bare repository, the work tree is
updated with "read-tree -m -u HEAD", to carry the change forward in case
the current branch was rewritten.  In order to avoid losing any local
change during this step, filter-branch refuses to work when there are
local changes in the work tree.

This "read-tree -m -u HEAD" operation does not affect what commit is
checked out in a submodule (iow, it does not touch .git/HEAD in a
submodule checkout), and checking if there is any local change to the
submodule is not useful.

Staged submodules _are_ considered to be 'dirty', however,  as the
"read-tree -m -u HEAD" could result in loss of staged information
otherwise.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index b75d0ba..9ffa655 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -108,8 +108,8 @@ OPTIONS_SPEC=
 . git-sh-setup
 
 if [ "$(is_bare_repository)" = false ]; then
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
+	git diff-files --ignore-submodules --quiet &&
+	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
 	die "Cannot rewrite branch(es) with a dirty working directory."
 fi
 
-- 
1.6.1.1.598.g140d5
