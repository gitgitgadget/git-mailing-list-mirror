From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: fix exiting when checkout failed in bisect_start()
Date: Wed, 21 Sep 2011 07:17:24 +0200
Message-ID: <20110921051725.5255.6756.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Joel Kaasinen <joel@zenrobotics.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 07:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6FD4-0003pY-98
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 07:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530Ab1IUFSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 01:18:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49904 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab1IUFSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 01:18:52 -0400
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DDF63A60F5;
	Wed, 21 Sep 2011 07:18:44 +0200 (CEST)
X-git-sha1: b7a3a770a1be36df4e49ff4b7e7d0fd42a8c5bb3 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181815>

Commit 4796e823 ("bisect: introduce --no-checkout support into porcelain." Aug 4 2011)
made checking out the branch where we started depends on the "checkout" mode. But
unfortunately it lost the "|| exit" part after the checkout command.

As it makes no sense to continue if the checkout failed and as people have already
complained that the error message given when we just exit in this case is not clear, see:

http://thread.gmane.org/gmane.comp.version-control.git/180733/

this patch adds a "|| die <hopefully clear message>" part after the checkout command.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index e0ca3fb..5fb4291 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -129,7 +129,8 @@ bisect_start() {
 		start_head=$(cat "$GIT_DIR/BISECT_START")
 		if test "z$mode" != "z--no-checkout"
 		then
-			git checkout "$start_head" --
+			git checkout "$start_head" -- ||
+			die "$(eval_gettext "Checking out '\$start_head' failed. Try 'git bisect reset <validbranch>'.")"
 		fi
 	else
 		# Get rev from where we start.
-- 
1.7.7.rc0.72.g4b5ea.dirty
