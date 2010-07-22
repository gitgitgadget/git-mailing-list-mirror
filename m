From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/7] revert: fix off by one read when searching the end of a
	commit subject
Date: Thu, 22 Jul 2010 15:18:29 +0200
Message-ID: <20100722131836.2148.57468.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obvui-00053b-80
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab0GVNeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:12 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:56819 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530Ab0GVNeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:07 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 2A3908002751;
	Thu, 22 Jul 2010 15:34:01 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 1A6AE80027CC;
	Thu, 22 Jul 2010 15:34:01 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 830B480021FE;
	Thu, 22 Jul 2010 15:34:00 +0200 (CEST)
X-ME-UUID: 20100722133400536.830B480021FE@mwinf2f18.orange.fr
X-git-sha1: cda13984199536144d1f61da8fbf3dde7f02d4a6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151449>

A test case is added but the problem can only be seen when running
the test case with --valgrind.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c             |    2 +-
 t/t3505-cherry-pick-empty.sh |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b9d829..3092233 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -131,7 +131,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 		p++;
 	if (*p) {
 		p += 2;
-		for (eol = p + 1; *eol && *eol != '\n'; eol++)
+		for (eol = p; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
 	} else
 		eol = p;
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index e51e505..c10b28c 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -13,12 +13,30 @@ test_expect_success setup '
 
 	git checkout -b empty-branch &&
 	test_tick &&
-	git commit --allow-empty -m "empty"
+	git commit --allow-empty -m "empty" &&
+
+	echo third >> file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit --allow-empty-message -m ""
 
 '
 
 test_expect_success 'cherry-pick an empty commit' '
 	git checkout master && {
+		git cherry-pick empty-branch^
+		test "$?" = 1
+	}
+'
+
+test_expect_success 'index lockfile was removed' '
+
+	test ! -f .git/index.lock
+
+'
+
+test_expect_success 'cherry-pick a commit with an empty message' '
+	git checkout master && {
 		git cherry-pick empty-branch
 		test "$?" = 1
 	}
-- 
1.7.2.rc3.267.g400b3
