From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC 3/3] tests: Add 'rebase -i commits that overwrite untracked
 files'
Date: Tue, 27 May 2014 00:19:28 +0200
Message-ID: <5383BDF0.2040904@gmail.com>
References: <533C913C.20106@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 00:19:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3F5-0001bV-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbaEZWTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:19:35 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:39746 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaEZWTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:19:32 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so5849541lab.25
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9EEV1C3g0wLucBNHJeTmev9C2J0G/Vwj2e6s4LUBfho=;
        b=w6FV/Jg4bkEDJnTJSdDpiQda5nNX4u4pc+PcdQaAJ5iGIWnHEQV/4oOhvKLwq5TZ2y
         VB7win27dUJbwB4NU9uC42xk8bclUF1k+bB6yZ/+jd5xgmPRzrdSqabFPl/sc07N7u8+
         8ZSHqJZhhZ/AEE1WOS6tm3uSgF+rLZc1MCnvvMmdPuXxnqhYfDqVTPOx2aj1BbEosrPc
         AdvI2dJ+IrwH1HKDoqmeOYxQmWf750l3NyWzVC/F30wuehrqkjhwvPYC90wGBL01shux
         kwIZJy7apUUS5fP+0MDGr51C4s51xgOb1NA6Q0usDe3zbu/jNtccDnNJ8sa/oDyH1kUj
         PKrA==
X-Received: by 10.152.29.66 with SMTP id i2mr115067lah.82.1401142770831;
        Mon, 26 May 2014 15:19:30 -0700 (PDT)
Received: from client.googlemail.com (dhcp-185073.eduroam.chalmers.se. [129.16.185.73])
        by mx.google.com with ESMTPSA id ax10sm13263384lbc.7.2014.05.26.15.19.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 15:19:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <533C913C.20106@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250127>

If a todo list will cherry-pick a commit that adds some file and the
working tree already contains a file with the same name, the rebase
sequence for that todo list will be interrupted and the cherry-picked
commit will be lost after the rebasing process is resumed.

This is fixed.

Add as a test case for regression testing to the "rebase-interactive"
test suite.

Reported-by: Phil Hord <hordp@cisco.com>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 t/t3404-rebase-interactive.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 50e22b1..7f5ac18 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1074,4 +1074,48 @@ test_expect_success 'short SHA-1 collide' '
 	)
 '
 
+test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
+	git checkout branch2 &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 2" git rebase -i A &&
+	test_cmp_rev HEAD F &&
+	test_path_is_missing file6 &&
+	touch file6 &&
+	test_must_fail git rebase --continue &&
+	test_cmp_rev HEAD F &&
+	rm file6 &&
+	git rebase --continue &&
+	test_cmp_rev HEAD I
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (squash)' '
+	git checkout branch2 &&
+	git tag original-branch2 &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 squash 2" git rebase -i A &&
+	test_cmp_rev HEAD F &&
+	test_path_is_missing file6 &&
+	touch file6 &&
+	test_must_fail git rebase --continue &&
+	test_cmp_rev HEAD F &&
+	rm file6 &&
+	git rebase --continue &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
+	git reset --hard original-branch2
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
+	git checkout branch2 &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 2" git rebase -i --no-ff A &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
+	test_path_is_missing file6 &&
+	touch file6 &&
+	test_must_fail git rebase --continue &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
+	rm file6 &&
+	git rebase --continue &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = I
+'
+
 test_done
-- 
1.9.3
