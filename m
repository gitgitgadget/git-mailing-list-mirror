From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 07/12] t4150: am with applypatch-msg hook
Date: Sun, 19 Jul 2015 23:49:13 +0800
Message-ID: <1437320958-11192-8-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqh-0005iY-4g
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbbGSPtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36856 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbbGSPts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:48 -0400
Received: by pdjr16 with SMTP id r16so91180201pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ii6EOLn40ZKdKYdXgg5fZ4HyPU6P4IsnropHbTnt8+w=;
        b=Z5rREgnextazAzBkA74MLbs28Fm/hQPS+NnRbFvR0hH3zqGKbNdeLgH82oC0BnruvD
         YE58/HzFloyZkseKjZJqd4yrBHdPgprFDGJH7oiNJy2GEcoOdqKo3evS1OzA0T+LLa3z
         NMXwXbaJkDbwv5OQZFDaIxCMu31g5ETIIQY04XZB+KwUeZvX7SKetmeViv1mQDj+ueF2
         auYZm69xa6t/pkHSZ7ptQbhDva/UBLRGfUU3zCp3iUPrlaTXcR7FFiB6gvkdzHpVbywb
         f6KRkFAtUQqfW++1wxbOz4tibi1FZm8LoyM0W/7upy0VwoTilMpTefMVgi/uTAnFrZWp
         EoqA==
X-Received: by 10.66.150.169 with SMTP id uj9mr48978166pab.125.1437320988012;
        Sun, 19 Jul 2015 08:49:48 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274219>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will invoke the applypatch-msg hooks just after extracting the patch
message. If the applypatch-msg hook exits with a non-zero status, git-am
abort before even applying the patch to the index.

Add tests for this hook.

Helped-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index c1ec4d5..7878e32 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -199,6 +199,41 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am with applypatch-msg hook' '
+	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	cat "$1" >actual-msg &&
+	echo hook-message >"$1"
+	EOF
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
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	exit 1
+	EOF
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
2.5.0.rc2.110.gf2a5fc6
