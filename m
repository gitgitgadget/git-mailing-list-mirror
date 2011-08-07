From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/3] bisect: add tests for bisection on bare repositories
Date: Sun,  7 Aug 2011 20:50:39 +1000
Message-ID: <1312714240-23647-3-git-send-email-jon.seymour@gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 12:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq0wv-0006pu-1Y
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 12:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1HGKvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 06:51:03 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50269 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1HGKu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 06:50:59 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6576739pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=L3vedhW2xj0uUFJ5wSv61C3VtTKIy8toiuAYJXIU23w=;
        b=F7D5TedHCRlbCGeQbwpqNhxe5E7WbIgg4tuVvMtKd7JmYcumziQPtvMX73ijx1JGGN
         LaCeeuW5e+QhsW1A29znerbKHoIS1zi3jBGcoZrOIBqEJxaWESNW9ezyPydMrKWqCl5u
         UJ7RL32/8xIS/DKZjKo4nmW23pzU002nLl83E=
Received: by 10.142.164.15 with SMTP id m15mr4611656wfe.192.1312714259634;
        Sun, 07 Aug 2011 03:50:59 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id m3sm2740179pbm.28.2011.08.07.03.50.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 03:50:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178900>

We add a test to check that bisection works on bare repositories
both when --no-checkout is specified explicitly and when it
is defaulted.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4fb7d11..eb0412c 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -592,6 +592,34 @@ test_expect_success 'erroring out when using bad path parameters' '
 	grep "bad path parameters" error.txt
 '
 
+test_expect_success 'create bare repo' '
+	git clone --bare . bare
+'
+
+test_expect_success 'test bisection on bare repo - --no-checkout specified' '
+	test_when_finished "cd .." &&
+	cd bare &&
+	git bisect start --no-checkout &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run sh -c \
+		"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
+		>../my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" ../my_bisect_log.txt &&
+	git bisect reset'
+
+test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
+	test_when_finished "cd .." &&
+	cd bare &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run sh -c \
+		"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
+		>../my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" ../my_bisect_log.txt &&
+	git bisect reset'
+
 #
 # This creates a broken branch which cannot be checked out because
 # the tree created has been deleted.
-- 
1.7.6.363.g9b380.dirty
