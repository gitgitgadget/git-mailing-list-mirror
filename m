From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 6/9] bisect: enable --ignore-checkout-failure in the porcelain.
Date: Sun, 24 Jul 2011 15:57:51 +1000
Message-ID: <1311487074-25070-7-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhz-0007mm-JP
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab1GXF6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:30 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab1GXF6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:21 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RcUsuW+Q/vCIih4XpF/sZGK+y7UVuGd3qfp46hkTHkA=;
        b=idxzV8AW5pIRqk8Wwvr5rYsm/SB3PP7p6oqSfV5LEdbloboKas2/g2UZ/jQlpzxNQ/
         y/VzoOcdIVe7mQ2BtQvyamtVX3+EUAFiE5hDEtb9Jx/l7rgYH+MnOd14eTLBTkp4ven8
         iljAPxYGgSzvniRn6tE5CeK+MvfvQcB9Es1+4=
Received: by 10.68.41.165 with SMTP id g5mr5431913pbl.106.1311487101759;
        Sat, 23 Jul 2011 22:58:21 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177725>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ecbd5bf..f3913ba 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
         print this long help message.
-git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--ignore-checkout-failure] [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
@@ -116,6 +116,11 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --ignore-checkout-failure)
+		IGNORE_CHECKOUT_FAILURE=$arg
+		echo "$arg" > $GIT_DIR/BISECT_IGNORE_CHECKOUT_FAILURE
+		shift
+		;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -293,7 +298,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all ${IGNORE_CHECKOUT_FAILURE}
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -379,6 +384,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_IGNORE_CHECKOUT_FAILURE" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 
-- 
1.7.6.347.g96e0b.dirty
