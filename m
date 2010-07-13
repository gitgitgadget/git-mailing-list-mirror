From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] revert: improve success message by adding abbreviated
	commit sha1
Date: Wed, 14 Jul 2010 01:28:15 +0200
Message-ID: <20100713232816.7738.78221.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 11:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZKjB-0008Km-6r
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 11:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885Ab0GOJ1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 05:27:24 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:15515 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab0GOJ1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 05:27:21 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 8D91180005F7;
	Thu, 15 Jul 2010 11:27:20 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 7EEFE800061B;
	Thu, 15 Jul 2010 11:27:20 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id D44FC80005F7;
	Thu, 15 Jul 2010 11:27:19 +0200 (CEST)
X-ME-UUID: 20100715092719869.D44FC80005F7@mwinf2f14.orange.fr
X-git-sha1: a819e1464eab1e2bf014c09f13e7956aa57aac4b 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151068>

Instead of "Finished one cherry-pick." or "Finished one
revert.", we now print "Finished cherry-pick commit
<abbreviated sha1>." or "Finished revert commit
<abbreviated sha1>." which is more informative especially
when cherry-picking or reverting many commits.

In case of failure the message is now "Automatic
cherry-pick commit <abbreviated sha1> failed." instead of
"Automatic cherry-pick failed.".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c                    |    5 +++--
 t/t3508-cherry-pick-many-commits.sh |   12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ec931bd..36479f9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -492,7 +492,8 @@ static int do_pick_commit(void)
 		}
 	}
 
-	strbuf_addstr(&mebuf, me);
+	strbuf_addf(&mebuf, "%s commit %s", me,
+		    find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
@@ -521,7 +522,7 @@ static int do_pick_commit(void)
 		if (!no_commit)
 			res = run_git_commit(defmsg);
 		if (!res)
-			fprintf(stderr, "Finished one %s.\n", mebuf.buf);
+			fprintf(stderr, "Finished %s.\n", mebuf.buf);
 	}
 
 	strbuf_release(&mebuf);
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 6555f92..1bd3ca1 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -24,9 +24,9 @@ test_expect_success setup '
 
 test_expect_success 'cherry-pick first..fourth works' '
 	cat <<-EOF > expected &&
-	Finished one cherry-pick.
-	Finished one cherry-pick.
-	Finished one cherry-pick.
+	Finished cherry-pick commit $(git rev-parse --short second).
+	Finished cherry-pick commit $(git rev-parse --short third).
+	Finished cherry-pick commit $(git rev-parse --short fourth).
 	EOF
 
 	git checkout -f master &&
@@ -41,9 +41,9 @@ test_expect_success 'cherry-pick first..fourth works' '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
 	cat <<-EOF > expected &&
-	Finished one cherry-pick with strategy resolve.
-	Finished one cherry-pick with strategy resolve.
-	Finished one cherry-pick with strategy resolve.
+	Finished cherry-pick commit $(git rev-parse --short second) with strategy resolve.
+	Finished cherry-pick commit $(git rev-parse --short third) with strategy resolve.
+	Finished cherry-pick commit $(git rev-parse --short fourth) with strategy resolve.
 	EOF
 
 	git checkout -f master &&
-- 
1.7.2.rc1.215.g2dff2.dirty
