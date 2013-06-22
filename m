From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 06/14] t/t5505-remote: test url-with-# in branches-file
Date: Sat, 22 Jun 2013 13:28:13 +0530
Message-ID: <1371887901-5659-7-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIlr-0008Cq-W9
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423766Ab3FVICB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:01 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59935 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423731Ab3FVIBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:54 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so8739802pbb.22
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Zde7/07dBSqLmNlEqvL6MB8fkRKnbtLPjDGsFjacSk8=;
        b=T40DbDXtTGAFY5Ilo5hpbsnuQ+1PwtX1z/aWaLSbOGLYOee56uCK3Tl8+dOJ+ACFYW
         iFsJ8CCyk/Dr0+2wK5otgdLWPZJvwmdVX6TMs2eOHNiPEnS2PNa+bPKT+cTMtRAa4mAF
         36wLm5PLOltp8ydpmt0MQKc60UWPjGdbZ8BAKQ2XEPLK/LlFQ7zaKMo+OsdTeJ6AsvkW
         h/tYFzVZ8awiWEy/1CATsWqZZkq3TsqDbgbIS59bjoJZGAlGm8UovimM+rcViqCYyYD3
         JEMOUq1tH7lmt1yyhF4ZWRQSwnaRqEAVpHgMt/a3vailA7RuTYUs8X7cpp4nhy94Ha3d
         oYKA==
X-Received: by 10.66.4.10 with SMTP id g10mr19791375pag.217.1371888113825;
        Sat, 22 Jun 2013 01:01:53 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228683>

Add one more test similar to "migrate a remote from named file in
$GIT_DIR/branches" to check that a url with a # can be used to specify
the branch name (as opposed to the constant "master").

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 13199d1..229a89c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -767,27 +767,41 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	)
 '
 
-test_expect_success 'remote prune to cause a dangling symref' '
+test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
 	git clone one seven &&
 	(
+		cd seven &&
+		git remote rm origin &&
+		echo "quux#foom" > .git/branches/origin &&
+		git remote rename origin origin &&
+		test_path_is_missing .git/branches/origin &&
+		test "$(git config remote.origin.url)" = "quux" &&
+		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin"
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/foom"
+	)
+'
+
+test_expect_success 'remote prune to cause a dangling symref' '
+	git clone one eight &&
+	(
 		cd one &&
 		git checkout side2 &&
 		git branch -D master
 	) &&
 	(
-		cd seven &&
+		cd eight &&
 		git remote prune origin
 	) >err 2>&1 &&
 	test_i18ngrep "has become dangling" err &&
 
 	: And the dangling symref will not cause other annoying errors &&
 	(
-		cd seven &&
+		cd eight &&
 		git branch -a
 	) 2>err &&
 	! grep "points nowhere" err &&
 	(
-		cd seven &&
+		cd eight &&
 		test_must_fail git branch nomore origin
 	) 2>err &&
 	grep "dangling symref" err
-- 
1.8.3.1.498.gacf2885
