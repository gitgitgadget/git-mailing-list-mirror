From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 6/8] t5520: test --rebase failure on unborn branch with index
Date: Mon, 18 May 2015 21:32:56 +0800
Message-ID: <1431955978-17890-7-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:33:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLB2-0001A5-3O
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbbERNdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:33:47 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33674 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbbERNdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:35 -0400
Received: by pdbqa5 with SMTP id qa5so150007783pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bT0Skw0T7HXrG6kXZ2smyBqOmQ2EwAMvZ7cdzwsLCzc=;
        b=KaUiA/gWMd2Xui1+eqNlGJKQu34MaCrSZkr/9uGeishnvoSsClXpnzUX85MmChomum
         mUk92foXJ6ZpWWOPnqp7Zbc32Ve66futgiHCn0QVq3Zdr79lYAQTQ5K8C7uljVAR8eOT
         fUb8vk78rJtImX9ExYJJ7fbbI9xeuzx+rhbLBZtQtd+slQ/2e0hv7Y9+b1Db6ST5r7+b
         bQhaWaHoIQUxkVlrzE8vfXDNgUadfG0DaIgmUM7LUMDbL+JpYKSzFrNEnzWniHGfqJMm
         83A273lPSvD95WpxqHxuLzegtlSdeXWUDJjtFCtx2lWkjiRGmMPWvMBJ2/fp80vaTpHd
         a7xw==
X-Received: by 10.66.63.106 with SMTP id f10mr44359611pas.0.1431956014988;
        Mon, 18 May 2015 06:33:34 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269239>

Commit 19a7fcb (allow pull --rebase on branch yet to be born,
2009-08-11) special cases git-pull on an unborn branch in a different
code path such that git-pull --rebase is still valid even though there
is no HEAD yet.

This code path still ensures that there is no index in order not to lose
any staged changes. Implement a test to ensure that this check is
triggered.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

* Removed use of "verbose".


 t/t5520-pull.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f991439..4d649a5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -413,6 +413,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
+	test_when_finished "rm -rf empty_repo2" &&
+	git init empty_repo2 &&
+	(
+		cd empty_repo2 &&
+		echo staged-file >staged-file &&
+		git add staged-file &&
+		test "$(git ls-files)" = staged-file &&
+		test_must_fail git pull --rebase .. master 2>../err &&
+		test "$(git ls-files)" = staged-file &&
+		test "$(git show :staged-file)" = staged-file
+	) &&
+	test_i18ngrep "unborn branch with changes added to the index" err
+'
+
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
 	(cd src &&
-- 
2.1.4
