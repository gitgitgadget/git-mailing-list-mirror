From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 09/12] t4150: am with post-applypatch hook
Date: Sun, 19 Jul 2015 23:49:15 +0800
Message-ID: <1437320958-11192-10-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:50:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqn-0005ll-Lu
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbbGSPt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:57 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33617 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbbGSPty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:54 -0400
Received: by pdbnt7 with SMTP id nt7so18595722pdb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cEbYFKDE/V0OgAhr8rCUXFN2WybTPyXVsguxzuodgzU=;
        b=lNukPEQ/ho1FwwMOBnTURFewbXjxvDz5aN9EhVYnV5x+btns5XEyHDSX8hAo3tbiBT
         LPZReGlK9Vml+cgwDOTuv/mHwC+f1a+y1kYMFCouaG+HpxEibYU4DIYTmHhMPZcCqv/m
         8tWJfz+Ay/NQOMCF5h9ua0q+bZAOBhVY8iVHbroCCd50fE/RVGAv5PnuQbyLmlyl8iBG
         2yZgMBfJfUPVq4aO9j1+ucCiU8fzV7a1lfUZnQH42VJXfOgbqdaL95wnI91DpNbAQrkH
         Gtyhar/IcUUR05GoPRilYPha/18Z2Fe8hGEL355WOyLoled0zXd9K9SUei/wpGHpLm8D
         RHgA==
X-Received: by 10.68.94.131 with SMTP id dc3mr49630685pbb.127.1437320994264;
        Sun, 19 Jul 2015 08:49:54 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274221>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the post-applypatch hook after the patch is
applied and a commit is made. The exit code of the hook is ignored.

Add tests for this hook.

Helped-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 957c63c..7494240 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -267,6 +267,44 @@ test_expect_success 'am with failing pre-applypatch hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with post-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/post-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-applypatch <<-\EOF &&
+	git rev-parse HEAD >head.actual
+	git diff second >diff.actual
+	exit 0
+	EOF
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	git rev-parse second >head.expected &&
+	test_cmp head.expected head.actual &&
+	git diff second >diff.expected &&
+	test_cmp diff.expected diff.actual
+'
+
+test_expect_success 'am with failing post-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/post-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-applypatch <<-\EOF &&
+	git rev-parse HEAD >head.actual
+	exit 1
+	EOF
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	git rev-parse second >head.expected &&
+	test_cmp head.expected head.actual
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc2.110.gf2a5fc6
