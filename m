From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 4/5] bisect: add tests for the --no-checkout option.
Date: Sat, 30 Jul 2011 18:28:30 +1000
Message-ID: <1312014511-7157-5-git-send-email-jon.seymour@gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:29:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4uu-0002JC-2p
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab1G3I27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 04:28:59 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36729 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab1G3I2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 04:28:55 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so7731148pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5TFBUY9hfZiUczyGJCSBBNL1ToKT6vUhEligzGb4IkM=;
        b=eTDmQQL3ZkPk6fY2qzcDwYXy7oOtZCqxjZHJ7W/mZNy1uS//57CsL47RWjb6OJtnRv
         XLfjIazI0b65eU8e2HxkxNHx3WDT4ZguC+eiy41XLlWUh/iMKv3npmMZL0wM4LA1DSo7
         0pTkRLyDM9NWQ3cU8hcIXU8CfjKZfWQ4PisGA=
Received: by 10.68.8.137 with SMTP id r9mr3462471pba.426.1312014535580;
        Sat, 30 Jul 2011 01:28:55 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id p7sm3012490pbn.65.2011.07.30.01.28.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 01:28:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.387.g991c2
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178182>

We expect to git-bisect --no-checkout to tolerate various kinds of repository damage.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   84 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index c28da2d..a9e86d2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -608,6 +608,14 @@ cat > expected.missing-tree.default <<EOF
 fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
 EOF
 
+check_same()
+{
+    echo "Checking $1 is the same as $2" &&
+    git rev-parse "$1" > expected.same &&
+    git rev-parse "$2" > expected.actual &&
+    test_cmp expected.same expected.actual
+}
+
 test_expect_success 'bisect fails if tree is broken on start commit' '
 	git bisect reset &&
 	test_must_fail git bisect start BROKEN_HASH7 BROKEN_HASH4 2>error.txt &&
@@ -622,4 +630,80 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 	test_cmp expected.missing-tree.default error.txt
 '
 
+test_expect_success 'bisect: --no-checkout - start commit bad' '
+	git bisect reset &&
+	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - trial commit bad' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target before breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect bad HEAD &&
+	check_same BROKEN_HASH5 HEAD &&
+	git bisect bad HEAD &&
+	check_same BROKEN_HASH5 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target in breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect bad HEAD &&
+	check_same BROKEN_HASH5 HEAD &&
+	git bisect good HEAD &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout - target after breakage' '
+	git bisect reset &&
+	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	check_same BROKEN_HASH6 HEAD &&
+	git bisect good HEAD &&
+	check_same BROKEN_HASH8 HEAD &&
+	git bisect good HEAD &&
+	check_same BROKEN_HASH9 bisect/bad &&
+	git bisect reset
+'
+
+test_expect_success 'bisect: --no-checkout=CURSOR - check HEAD is unmodified' '
+	git bisect reset &&
+	git checkout broken &&
+	BROKEN=$(git rev-parse broken) &&
+	git bisect start broken BROKEN_HASH4 --no-checkout=CURSOR &&
+	check_same CURSOR BROKEN_HASH6 &&
+	test "refs/heads/broken" = "$(git rev-parse --symbolic-full-name HEAD)" &&
+	git bisect bad CURSOR &&
+	test "refs/heads/broken" = "$(git rev-parse --symbolic-full-name HEAD)" &&
+	check_same CURSOR BROKEN_HASH5 &&
+	test "refs/heads/broken" = "$(git rev-parse --symbolic-full-name HEAD)" &&
+	git bisect good CURSOR &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	test "refs/heads/broken" = "$(git rev-parse --symbolic-full-name HEAD)" &&
+	git bisect reset &&
+	test "refs/heads/broken" = "$(git rev-parse --symbolic-full-name HEAD)" &&
+	check_same HEAD broken &&
+	check_same broken $BROKEN
+'
+
+test_expect_success 'bisect: demonstrate identification of damage boundary' '
+	git bisect reset &&
+	git checkout broken &&
+	git bisect start broken master --no-checkout &&
+	git bisect run eval "git rev-list --objects HEAD && git rev-list --objects HEAD | git pack-objects --stdout >/dev/null || false" &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+'
+
 test_done
-- 
1.7.6.387.g991c2
