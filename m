From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 4/8] t3200.39: tracking setup should fail if there is no matching refspec.
Date: Sat, 20 Apr 2013 17:05:59 +0200
Message-ID: <1366470363-22309-5-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZNC-0000BZ-1s
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab3DTPGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:34 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56043 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:33 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so4507806lbi.39
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iG3zNUlrAJrfJIR2JQr/weRdwJXZWxaJVFx375ssSLY=;
        b=SZw7BbNVpHT8ORDndZYiLQr+0WZnup4lJIGrVVR2B4JB36s5O97Q8JAGlfSlznVLoe
         4AfhVur+P8i6zT6oFiDdtBfwSEpjG+7SN0gZ6LIO2lcqJDJe9HoxXDw60qQHGYTOEEmc
         8YrTyjBGx0LLQtyvJJGuonxJ9tJzQXkYL6JfK1YsL3cSKlRneCoNXOokp5/nstKBWdqH
         8oFpI+9nzDSpJGZGB1GPLVjOapdhytR41X7/fqijSDBjAsxlnyEYTiYZQtSym/HNJRsF
         GM0Cy0Ne4ydKxckezhAEOZJyQlmPX7vacwLMxK1W/986jEF/Oius/vjLVcr3vGKiD1nX
         mj5A==
X-Received: by 10.152.19.10 with SMTP id a10mr10168483lae.8.1366470391293;
        Sat, 20 Apr 2013 08:06:31 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.29
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221864>

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
