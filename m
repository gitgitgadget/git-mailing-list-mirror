From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] rebase: fix fork-point with zero arguments
Date: Thu,  9 Jan 2014 19:47:34 +0000
Message-ID: <65fed28c9346aa98a0d9edcbb0c2b483abc0189f.1389296828.git.john@keeping.me.uk>
References: <20140109160603.GR7102@inner.h.apk.li>
Cc: Andreas Krey <a.krey@gmx.de>, Junio@domain.unspecified,
	C@domain.unspecified, "Hamano <gitster"@pobox.com,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 20:48:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1LaD-000379-8m
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 20:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382AbaAITrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 14:47:52 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:60070 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354AbaAITrr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 14:47:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 1151F606509;
	Thu,  9 Jan 2014 19:47:47 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TAigkmj2xy3Q; Thu,  9 Jan 2014 19:47:46 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C49986064CB;
	Thu,  9 Jan 2014 19:47:40 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.226.g0d60d77
In-Reply-To: <20140109160603.GR7102@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240268>

When no arguments are specified, $switch_to is empty so we end up
passing the empty string to "git merge-base --fork-point", which causes
an error.  git-rebase carries on at this point, but in fact we have
failed to apply the fork-point operation.

It turns out that the test in t3400 that was meant to test this didn't
actually need the fork-point behaviour, so enhance it to make sure that
the fork-point is applied correctly.  The modified test fails without
the change to git-rebase.sh in this patch.

Reported-by: Andreas Krey <a.krey@gmx.de>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase.sh     |  3 ++-
 t/t3400-rebase.sh | 12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7185dc8..8a3efa2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -534,7 +534,8 @@ esac
 
 if test "$fork_point" = t
 then
-	new_upstream=$(git merge-base --fork-point "$upstream_name" "$switch_to")
+	new_upstream=$(git merge-base --fork-point "$upstream_name" \
+			"${switch_to:-HEAD}")
 	if test -n "$new_upstream"
 	then
 		upstream=$new_upstream
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 998503d..6d94b1f 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -135,11 +135,19 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 '
 
 test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+	git checkout -b default-base master &&
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
-	git config branch.default.merge refs/heads/master &&
+	git config branch.default.merge refs/heads/default-base &&
 	git rebase &&
-	git rev-parse --verify master >expect &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual &&
+	git checkout default-base &&
+	git reset --hard HEAD^ &&
+	git checkout default &&
+	git rebase &&
+	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
 	test_cmp expect actual
 '
-- 
1.8.5.226.g0d60d77
