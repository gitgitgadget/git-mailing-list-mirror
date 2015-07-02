From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 07/12] t4150: am with applypatch-msg hook
Date: Fri,  3 Jul 2015 02:16:35 +0800
Message-ID: <1435861000-25278-8-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3O-0006Ry-J5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbbGBSRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:38 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36844 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbGBSR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:28 -0400
Received: by paceq1 with SMTP id eq1so44072621pac.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xt257G4WvT7fJEmcDf8iFeSyUGrt/Pt7rTbBMCntFYw=;
        b=LDTARrbGcYhzpLi24Bs5XjvhcbovaCz0XOpOnAL9OpBcudNEVE2xP6PSMTw8rS+ye8
         Bd7bcrjAI2kq6ehW9jnGWXdLWzt57j1SSSoSrlki9xJi6ZrgkS2nvuTA/5BNvC0l6sNC
         kp+KwZRbDDzzq6aktNqBcck7FygXdbaSI0S/kUlCnfu7ZiuUexKanrbITeMOW1ZMXKEn
         trxVMjqL9IZrQjod3H2+d4k5GvNaIndyTZ+cUdmLUD2v8XhLF7QUGPkQTQtU6mDmKnAZ
         VySyYTtN2oomw+zQnbltKTqPow7phDVtA7i2Mt8x/DZdeGVH6fZi/sp6E7BkD0Rx0vfv
         aQkw==
X-Received: by 10.66.158.65 with SMTP id ws1mr66141024pab.18.1435861048416;
        Thu, 02 Jul 2015 11:17:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273261>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will invoke the applypatch-msg hooks just after extracting the patch
message. If the applypatch-msg hook exits with a non-zero status, git-am
abort before even applying the patch to the index.

Add tests for this hook.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 05494e9..24c1b42 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -198,6 +198,45 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am with applypatch-msg hook' '
+	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/applypatch-msg <<-\EOF &&
+	#!/bin/sh
+	cat "$1" >actual-msg &&
+	echo hook-message >"$1"
+	EOF
+	chmod +x .git/hooks/applypatch-msg &&
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	echo hook-message >expected &&
+	git log -1 --format=format:%B >actual &&
+	test_cmp expected actual &&
+	git log -1 --format=format:%B second >expected &&
+	test_cmp expected actual-msg
+'
+
+test_expect_success 'am with failing applypatch-msg hook' '
+	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/applypatch-msg <<-\EOF &&
+	#!/bin/sh
+	exit 1
+	EOF
+	chmod +x .git/hooks/applypatch-msg &&
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	git diff --exit-code first &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc1.81.gfe77482
