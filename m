From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 6/6] RFC - Notes merge: die when asked to merge a non-existent ref.
Date: Sat, 18 Jun 2011 23:06:48 +0200
Message-ID: <1308431208-13353-7-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2js-0007jg-9J
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1FRVHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:09 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42443 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab1FRVHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:04 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 96A5FD4804B;
	Sat, 18 Jun 2011 23:06:57 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003VD-RD; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308431208-13353-1-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175989>

This causes the "merge empty notes ref (z => y)" test in t3308-notes-merge.sh
to fail - obviously, it is removing the functionnality that is tested for.

Is there any real use for this ?  It just seems so different from
"git merge", which errors out in the similar situation:

$ git merge foo
fatal: 'foo' does not point to a commit

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 builtin/notes.c        |    3 +++
 t/t3308-notes-merge.sh |    6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6bff44f..058b14d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -908,6 +908,9 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref, 1);
 	o.remote_ref = remote_ref.buf;
 
+	if (!peel_to_type(o.remote_ref, 0, NULL, OBJ_COMMIT))
+		die("'%s' does not point to a commit", o.remote_ref);
+
 	if (strategy) {
 		if (!strcmp(strategy, "manual"))
 			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 24d82b4..2dcc1db 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -104,12 +104,6 @@ test_expect_success 'merge notes into empty notes ref (x => y)' '
 	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
 '
 
-test_expect_success 'merge empty notes ref (z => y)' '
-	git notes merge z &&
-	# y should not change (still == x)
-	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
-'
-
 test_expect_success 'change notes on other notes ref (y)' '
 	# Not touching notes to 1st commit
 	git notes remove 2nd &&
-- 
1.7.5.3
