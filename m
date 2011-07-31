From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 5/7] bisect: add tests for the --no-checkout and --update-ref options.
Date: Sun, 31 Jul 2011 21:55:19 +1000
Message-ID: <1312113321-28760-6-git-send-email-jon.seymour@gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 13:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUdY-0002qW-DA
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab1GaL4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:56:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1GaL4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:56:47 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9556049pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 04:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VgTE5epFMCLX0zkA5rt1AtbZ3OfpNh79reL+MyXr+oE=;
        b=WQ4MZSlTwnLc1S8QuzAgzTraw9OLFA3ix4TaNxQa6FNWsUrm+OEELVWaR5mYkdeQL9
         SlwfDeg+8yKcI+vfOnD9FK/N+J0chdzPj/aVeFnDSJf8Pze7KC9w/3iaIO6t0JWnTkFM
         mFjXdFkjOvP/sZsDU/Ud3VX19cOn+rfinSDgM=
Received: by 10.68.54.35 with SMTP id g3mr5350762pbp.459.1312113407340;
        Sun, 31 Jul 2011 04:56:47 -0700 (PDT)
Received: from localhost.localdomain ([120.16.239.154])
        by mx.google.com with ESMTPS id g4sm4306620pbj.41.2011.07.31.04.56.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 04:56:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g62761
In-Reply-To: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178242>

These tests verify that git-bisect --no-checkout can successfully
bisect commit histories that reference damaged trees.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   90 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9ae2de8..69d77fa 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -616,6 +616,14 @@ cat > expected.missing-tree.default <<EOF
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
@@ -630,4 +638,86 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
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
+test_expect_success 'bisect: --no-checkout --update-ref=CURSOR - check HEAD is unmodified' '
+	git bisect reset &&
+	git checkout broken &&
+	BROKEN=$(git rev-parse broken) &&
+	git bisect start broken BROKEN_HASH4 --no-checkout --update-ref=CURSOR &&
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
+test_expect_success 'bisect: demonstrate identification of damage boundary' "
+	git bisect reset &&
+	git checkout broken &&
+	git bisect start broken master --no-checkout &&
+	git bisect run eval '
+rc=1;
+if git rev-list --objects HEAD >tmp.$$; then
+   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
+fi;
+rm tmp.$$;
+test \$rc -eq 0;' &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+"
+
 test_done
-- 
1.7.6.391.g168d0.dirty
