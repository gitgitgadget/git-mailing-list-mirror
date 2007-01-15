From: Jeff King <peff@peff.net>
Subject: [PATCH] git-{parse-remote,pull}: throw away stderr of git-symbolic-ref
Date: Mon, 15 Jan 2007 16:24:43 -0500
Message-ID: <20070115212442.GA7409@coredump.intra.peff.net>
References: <200701151009.51868.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, andyparkins@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 15 22:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ZVm-0008Ug-Sg
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 22:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbXAOVg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 16:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbXAOVg6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 16:36:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4522 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932067AbXAOVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 16:36:57 -0500
Received: (qmail 29099 invoked from network); 15 Jan 2007 16:25:00 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Jan 2007 16:25:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 16:24:43 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <200701151009.51868.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36885>

We look up the destination of the HEAD symref in order to get the
default remote and merge head for the current branch. However, if we
have a detached HEAD, there is no current branch. We handle this
situation by looking up branch..remote, which is empty.
Unfortunately, git-symbolic-ref complained to stderr, potentially
scaring users.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-parse-remote.sh |    4 ++--
 git-pull.sh         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d2e4c2b..bc2485f 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -49,7 +49,7 @@ get_remote_url () {
 }
 
 get_default_remote () {
-	curr_branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+	curr_branch=$(git-symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
 	origin=$(git-repo-config --get "branch.$curr_branch.remote")
 	echo ${origin:-origin}
 }
@@ -137,7 +137,7 @@ canon_refs_list_for_fetch () {
 		shift
 		if test "$remote" = "$(get_default_remote)"
 		then
-			curr_branch=$(git-symbolic-ref HEAD | \
+			curr_branch=$(git-symbolic-ref HEAD 2>/dev/null | \
 			    sed -e 's|^refs/heads/||')
 			merge_branches=$(git-repo-config \
 			    --get-all "branch.${curr_branch}.merge")
diff --git a/git-pull.sh b/git-pull.sh
index 9592617..f0cc023 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -83,7 +83,7 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	curr_branch=$(git-symbolic-ref HEAD | \
+	curr_branch=$(git-symbolic-ref HEAD 2>/dev/null | \
 		sed -e 's|^refs/heads/||')
 	echo >&2 "Warning: No merge candidate found because value of config option
          \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
-- 
1.5.0.rc1.gd61e-dirty
