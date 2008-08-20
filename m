From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Wed, 20 Aug 2008 20:50:28 +0200
Message-ID: <20080820185028.GA16626@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 20:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsmN-0007aC-Qa
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYHTSuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbYHTSuc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:50:32 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:10219 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYHTSub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:50:31 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (klopstock mo58) (RZmta 16.47)
	with ESMTP id p0129bk7KF2bwK ; Wed, 20 Aug 2008 20:50:28 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C8BAD277AE;
	Wed, 20 Aug 2008 20:50:28 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id AEEA736D18; Wed, 20 Aug 2008 20:50:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93013>

The code handles additionally "refs/remotes/<something>/name",
"remotes/<something>/name", and "refs/<namespace>/name".
Test cases included.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Johannes has likable ideas :)

 builtin-checkout.c |   20 +++++++++++++++-----
 t/t7201-co.sh      |   23 ++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index e95eab9..20466e2 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -447,11 +447,21 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		char *slash;
 		if (!argc || !strcmp(argv[0], "--"))
 			die ("--track needs a branch name");
-		slash = strchr(argv[0], '/');
-		if (slash && !prefixcmp(argv[0], "refs/"))
-			slash = strchr(slash + 1, '/');
-		if (slash && !prefixcmp(argv[0], "remotes/"))
-			slash = strchr(slash + 1, '/');
+		if (!prefixcmp(argv[0], "remotes/"))
+			/* skip the name of a remote */
+			slash = strchr(argv[0] + 8, '/');
+		else if (!prefixcmp(argv[0], "refs/")) {
+			/* skip namespaces, try use the names of their
+			 * branches, but for the target namespace
+			 * (heads) demand a new name. Also skip the
+			 * first element in "remotes" namespace */
+			const char *ns = argv[0] + 5;
+			slash = !prefixcmp(ns, "heads/") ? NULL:
+				!prefixcmp(ns, "remotes/") ?
+				strchr(ns + 8, '/'): strchr(ns, '/');
+		} else
+			/* otherwise - just skip the first element */
+			slash = strchr(argv[0], '/');
 		if (!slash || !slash[1])
 			die ("Missing branch name; try -b");
 		opts.new_branch = slash + 1;
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 943dd57..1dff84d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -340,9 +340,30 @@ test_expect_success \
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
     git update-ref refs/remotes/origin/koala/bear renamer &&
+    git update-ref refs/new/koala/bear renamer &&
+
     git checkout --track origin/koala/bear &&
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"'
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+
+    git checkout master && git branch -D koala/bear &&
+
+    git checkout --track refs/remotes/origin/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+
+    git checkout master && git branch -D koala/bear &&
+
+    git checkout --track remotes/origin/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+
+    git checkout master && git branch -D koala/bear &&
+
+    git checkout --track refs/new/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
+'
 
 test_expect_success \
     'checkout with --track, but without -b, fails with too short tracked name' '
-- 
1.6.0.22.g09248
