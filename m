From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/2] blame: fix output in case of replacement by using
	parse_commit_repl()
Date: Tue, 17 Aug 2010 03:59:00 +0200
Message-ID: <20100817015901.5592.419.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 04:00:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlBT6-0006mI-TI
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 04:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab0HQB7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 21:59:46 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33396 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab0HQB7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 21:59:45 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B00C5818019;
	Tue, 17 Aug 2010 03:59:39 +0200 (CEST)
X-git-sha1: 1c6d225aa1a398fa70ea18ca6491d04f0499155e 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153684>

git blame was not showing the sha1 of the replacement commit while
it was properly showing other information from the replacement commit,
because parse_commit() is buggy regarding replacement.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/blame.c    |    4 ++--
 t/t6050-replace.sh |    8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8f9e7b0..c469e09 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1226,7 +1226,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 
 			if (sg_origin[i])
 				continue;
-			if (parse_commit(p))
+			if (parse_commit_repl(&p))
 				continue;
 			porigin = find(sb, p, origin);
 			if (!porigin)
@@ -1558,7 +1558,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		origin_incref(suspect);
 		commit = suspect->commit;
 		if (!commit->object.parsed)
-			parse_commit(commit);
+			parse_commit_repl(&commit);
 		if (reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 4185b7c..881a2e8 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -225,6 +225,14 @@ test_expect_success 'index-pack and replacements' '
 	git index-pack test-*.pack
 '
 
+test_expect_success 'blame and replacements' '
+	git blame hello > blame.txt &&
+	grep "$(git rev-parse --short $S)" blame.txt > lines.txt &&
+	grep "O Thor" lines.txt &&
+	grep "line 9" lines.txt &&
+	grep "line 10" lines.txt
+'
+
 #
 #
 test_done
-- 
1.7.2.1.351.g275bf
