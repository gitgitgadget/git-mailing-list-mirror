From: Jeff King <peff@peff.net>
Subject: [PATCH] git-pull: disallow implicit merging to detached HEAD
Date: Mon, 15 Jan 2007 17:25:33 -0500
Message-ID: <20070115222533.GA12928@coredump.intra.peff.net>
References: <7vk5zo0ws1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 23:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6aGp-0006Wm-By
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXAOWZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbXAOWZg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:25:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2838 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751453AbXAOWZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:25:35 -0500
Received: (qmail 1288 invoked from network); 15 Jan 2007 17:25:51 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Jan 2007 17:25:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 17:25:33 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk5zo0ws1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36895>

Instead, we complain to the user and suggest that they explicitly
specify the remote and branch. We depend on the exit status of
git-symbolic-ref, so let's go ahead and document that.

Signed-off-by: Jeff King <peff@peff.net>
---

This is on top of your other patch.

> I think what I sent out was a moral equivalent, but generally
> speaking I do not think we should discard stderr output
> indiscriminatingly.

Agreed.

> I think it makes more sense to say "your HEAD is detached and
> you need to explicitly say which branch you would want to merge
> in" in this case.

Something like this?

 Documentation/git-symbolic-ref.txt |    4 ++++
 git-pull.sh                        |   13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 1e818bb..fec3b4f 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -44,6 +44,10 @@ cumbersome.  On some platforms, `ln -sf` does not even work as
 advertised (horrors).  Therefore symbolic links are now deprecated
 and symbolic refs are used by default.
 
+git-symbolic-ref will exit with status 0 if the contents of the
+symbolic ref were printed correctly, with status 1 if the requested
+name is not a symbolic ref, or 128 if another error occurs.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
diff --git a/git-pull.sh b/git-pull.sh
index 9592617..3e96569 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -83,8 +83,17 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	curr_branch=$(git-symbolic-ref HEAD | \
-		sed -e 's|^refs/heads/||')
+	curr_branch=$(git-symbolic-ref -q HEAD)
+	case $? in
+	  0) ;;
+	  1) echo >&2 "You are not currently on a branch; you must explicitly"
+	     echo >&2 "indicate which branch you wish to merge with"
+	     echo >&2 "  git pull <remote> <branch>"
+	     exit 1;;
+	  *) exit $?;;
+	esac
+	curr_branch=${curr_branch#refs/heads/}
+
 	echo >&2 "Warning: No merge candidate found because value of config option
          \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
 	echo >&2 "No changes."
-- 
1.5.0.rc1.gb329-dirty
