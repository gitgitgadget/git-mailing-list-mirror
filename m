From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 08/12] t4150: am with pre-applypatch hook
Date: Fri,  3 Jul 2015 02:16:36 +0800
Message-ID: <1435861000-25278-9-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3S-0006V0-DT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbGBSRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:41 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36544 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbbGBSRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:31 -0400
Received: by pdcu2 with SMTP id u2so49997273pdc.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hh0dI3GthmnR9uhU7q2NLKnFfVVkqlIH8A9rJTtjxYQ=;
        b=gtu+DhKmFl+fLpTi1UjdRzRN7xIvrej258lNS9Z7R8WhybTIZQ836JeXXS2/OKqqU8
         m9tnI9ojuWg0SRr7sdKRy+wmVAv2fgiW3piOBeDOfH/fc4d4cA6Pn4yPVfaslutD2lGe
         gIuptHrfySAt4cs4JATTauSCwUgbxmyUWZ3ZSYsg5wZ/eKNhJKdg82Oy1eFq2iLorJiM
         xrRxdzK7+nP9FtZj9g9MlUcU3+eE76Qvi2saO1ELuGIvGxT0VmB+uZBb6TZkOJ+ml05Q
         KRoDWmFikkw/xo9JCSRGzb3cGMTKwVvI9YgCLt3INdYeyVoHnAcXs4ReVOD9Yg16OSqZ
         LxHA==
X-Received: by 10.66.146.33 with SMTP id sz1mr10099533pab.114.1435861051525;
        Thu, 02 Jul 2015 11:17:31 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273262>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sg will invoke the pre-applypatch hook after applying the patch
to the index, but before a commit is made. Should the hook exit with a
non-zero status, git am will exit.

Add tests for this hook.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 24c1b42..dd6fe81 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -237,6 +237,44 @@ test_expect_success 'am with failing applypatch-msg hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with pre-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/pre-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-applypatch <<-\EOF &&
+	#!/bin/sh
+	git diff first >diff.actual
+	exit 0
+	EOF
+	chmod +x .git/hooks/pre-applypatch &&
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	test_cmp_rev second^ HEAD^ &&
+	git diff first..second >diff.expected &&
+	test_cmp diff.expected diff.actual
+'
+
+test_expect_success 'am with failing pre-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/pre-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-applypatch <<-\EOF &&
+	#!/bin/sh
+	exit 1
+	EOF
+	chmod +x .git/hooks/pre-applypatch &&
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc1.81.gfe77482
