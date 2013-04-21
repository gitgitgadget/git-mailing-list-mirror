From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 4/8] t3200.39: tracking setup should fail if there is no matching refspec.
Date: Sun, 21 Apr 2013 23:52:02 +0200
Message-ID: <1366581126-3880-5-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2Bx-0000Ui-WC
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab3DUVww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:52 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:42645 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3DUVwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:50 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so1400470lab.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iG3zNUlrAJrfJIR2JQr/weRdwJXZWxaJVFx375ssSLY=;
        b=QkY5kdRipi0DEqeJwaMBYO1Ffxp7hoFfo9jctdzTHVNI5mOzhRjwiWGQBmQR91s//4
         hur7dTe5N+Qol0BvF22w3LS/9lJ9GcpQyT1zel/Wubp4p2OK4mCqM24rXkxBkafu/SGp
         AykrTbxr0r32avoEfkwfI2xDocXSjpTBaR9nv83BmVArtUQhnnmL/Ton6qI03S9jsK6F
         tE7p7/NJ5tekC+65fuS4OMCY9Bnq/CgIP1U44yxI49r/SUsCQRtHcHpJMOjKzYVpFyVm
         ReKQgshVT+yYw1pZThbqyAKiCk2m6HPNNxEacxtsl3SOpVtNdHlpxYW7tLFSBLPiI869
         VlXQ==
X-Received: by 10.112.199.230 with SMTP id jn6mr11912140lbc.131.1366581169291;
        Sun, 21 Apr 2013 14:52:49 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.47
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221972>

We are formalizing a requirement that any remote-tracking branch to be used
as an upstream (i.e. as an argument to --track), _must_ "belong" to a
configured remote by being matched by the "dst" side of a fetch refspec.

This patch encodes the new expected behavior of this test, and marks the
test with "test_expect_failure" in anticipation of a following patch to
introduce the new behavior.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3200-branch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d969f0e..1bfdadc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -317,13 +317,13 @@ test_expect_success 'test tracking setup (non-wildcard, matching)' '
 	test $(git config branch.my4.merge) = refs/heads/master
 '
 
-test_expect_success 'test tracking setup (non-wildcard, not matching)' '
+test_expect_failure 'tracking setup fails on non-matching refspec' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track my5 local/master &&
-	! test "$(git config branch.my5.remote)" = local &&
-	! test "$(git config branch.my5.merge)" = refs/heads/master
+	test_must_fail git branch --track my5 local/master &&
+	test_must_fail git config branch.my5.remote &&
+	test_must_fail git config branch.my5.merge
 '
 
 test_expect_success 'test tracking setup via config' '
-- 
1.8.1.3.704.g33f7d4f
