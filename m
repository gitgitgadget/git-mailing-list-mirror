From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 11/14] t/t5505-remote: test multiple push/pull in remotes-file
Date: Sat, 22 Jun 2013 13:28:18 +0530
Message-ID: <1371887901-5659-12-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqImf-0000fh-Fg
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423768Ab3FVICI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:08 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38762 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423767Ab3FVICF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:02:05 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so8883457pad.37
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TbmDDOOsGr+Sp3mfsWHsZnnJ4u0FwK1u0kigwTRIGBY=;
        b=zhOoP6Nnj8nJWdVuB6VOxplEPZVx7eAr/+iDDrmNx24ztV3cc5jW5mMcMzxemHaj+B
         d13GFYx0MAcNLFKUXI3SkpsxSguFj5kuUYTDMd+7dQF7ZwxRgi091hCBoJHvaxknWHpj
         8lyt9fxBP0k/qA48zByq/SIzALc950erbP3pu+D1XBKqzbuULoOTVJBAEt119/rcZX47
         TY7wxNPbdu2feNojfnZwslqJ0HmU9pQNg4VxDUXFb7doWt2MSGBMogJErC+kEmRgEFgX
         xkl0iHSNwfMITvxDzaOOXjSyQjhI9RCqHGffgLeQhAfO/KzlditKt6/OJileI1plp7Y1
         VoGg==
X-Received: by 10.68.217.7 with SMTP id ou7mr15332796pbc.8.1371888124690;
        Sat, 22 Jun 2013 01:02:04 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.02.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:02:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228687>

Extend the test "migrate a remote from named file in $GIT_DIR/remotes"
to test that multiple "Push:" and "Pull:" lines in the remotes-file
works as expected.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 229a89c..6a622fc 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -735,7 +735,9 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 cat >remotes_origin <<-EOF
 URL: quux
 Push: refs/heads/master:refs/heads/upstream
+Push: refs/heads/master:refs/heads/upstream2
 Pull: refs/heads/master:refs/heads/origin
+Pull: refs/heads/master:refs/heads/origin2
 EOF
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
@@ -748,8 +750,18 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 		git remote rename origin origin &&
 		test_path_is_missing .git/remotes/origin &&
 		test "$(git config remote.origin.url)" = "quux" &&
-		test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+		cat >push_expected <<-\EOF &&
+		refs/heads/master:refs/heads/upstream
+		refs/heads/master:refs/heads/upstream2
+		EOF
+		cat >fetch_expected <<-\EOF &&
+		refs/heads/master:refs/heads/origin
+		refs/heads/master:refs/heads/origin2
+		EOF
+		git config --get-all remote.origin.push >push_actual &&
+		git config --get-all remote.origin.fetch >fetch_actual &&
+		test_cmp push_expected push_actual &&
+		test_cmp fetch_expected fetch_actual
 	)
 '
 
-- 
1.8.3.1.498.gacf2885
