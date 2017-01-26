Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A33C1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 22:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbdAZWlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 17:41:12 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:23232 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbdAZWlK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 17:41:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 36C3F1E3817;
        Thu, 26 Jan 2017 23:33:03 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t0eEZfbDGM-k; Thu, 26 Jan 2017 23:33:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id BB6211E2FAF;
        Thu, 26 Jan 2017 23:33:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nKUei1uIQvVE; Thu, 26 Jan 2017 23:33:02 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-204-63.dynamic.mnet-online.de [185.17.204.63])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id EBF8D1E3830;
        Thu, 26 Jan 2017 23:33:01 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     peff@peff.net
Cc:     git@vger.kernel.org, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 3/3] update-ref: add test cases for bare repository
Date:   Thu, 26 Jan 2017 23:31:59 +0100
Message-Id: <20170126223159.16439-3-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170126223159.16439-1-cornelius.weig@tngtech.com>
References: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
 <20170126223159.16439-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The default behavior of update-ref to create reflogs differs in
repositories with worktree and bare ones. The existing tests cover only
the behavior of repositories with worktree.

This commit adds tests that assert the correct behavior in bare
repositories for update-ref. Two cases are covered:

 - If core.logAllRefUpdates is not set, no reflogs should be created
 - If core.logAllRefUpdates is true, reflogs should be created

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 t/t1400-update-ref.sh | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b9084ca..bad88c8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -8,23 +8,33 @@ test_description='Test git update-ref and basic ref logging'
 
 Z=$_z40
 
-test_expect_success setup '
+m=refs/heads/master
+n_dir=refs/heads/gu
+n=$n_dir/fixes
+outside=refs/foo
+bare=bare-repo
 
+create_test_objects ()
+{
+	local T, sha1, prfx="$1"
 	for name in A B C D E F
 	do
 		test_tick &&
 		T=$(git write-tree) &&
 		sha1=$(echo $name | git commit-tree $T) &&
-		eval $name=$sha1
+		eval $prfx$name=$sha1
 	done
+}
 
+test_expect_success setup '
+	create_test_objects "" &&
+	mkdir $bare &&
+	cd $bare &&
+	git init --bare &&
+	create_test_objects "bare" &&
+	cd -
 '
 
-m=refs/heads/master
-n_dir=refs/heads/gu
-n=$n_dir/fixes
-outside=refs/foo
-
 test_expect_success \
 	"create $m" \
 	"git update-ref $m $A &&
@@ -93,6 +103,25 @@ test_expect_success 'update-ref creates reflogs with --create-reflog' '
 	git reflog exists $outside
 '
 
+test_expect_success 'creates no reflog in bare repository' '
+	git -C $bare update-ref $m $bareA &&
+	git -C $bare rev-parse $bareA >expect &&
+	git -C $bare rev-parse $m >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C $bare reflog exists $m
+'
+
+test_expect_success 'core.logAllRefUpdates=true creates reflog in bare repository' '
+	test_when_finished "git -C $bare config --unset core.logAllRefUpdates && \
+		rm $bare/logs/$m" &&
+	git -C $bare config core.logAllRefUpdates true &&
+	git -C $bare update-ref $m $bareB &&
+	git -C $bare rev-parse $bareB >expect &&
+	git -C $bare rev-parse $m >actual &&
+	test_cmp expect actual &&
+	git -C $bare reflog exists $m
+'
+
 test_expect_success 'core.logAllRefUpdates=true does not create reflog by default' '
 	test_config core.logAllRefUpdates true &&
 	test_when_finished "git update-ref -d $outside" &&
-- 
2.10.2

