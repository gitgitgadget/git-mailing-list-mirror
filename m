Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3579E1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbdA0KWD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:22:03 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:18462 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754787AbdA0KVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:21:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id D79961E2C99;
        Fri, 27 Jan 2017 11:11:43 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wtjpMoEN7EWT; Fri, 27 Jan 2017 11:11:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 6E5D21E2D45;
        Fri, 27 Jan 2017 11:11:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UMVOU85S_5SR; Fri, 27 Jan 2017 11:11:43 +0100 (CET)
Received: from localhost.localdomain (unknown [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 1364B1E2C99;
        Fri, 27 Jan 2017 11:11:43 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v3 3/3] update-ref: add test cases for bare repository
Date:   Fri, 27 Jan 2017 11:09:48 +0100
Message-Id: <20170127100948.29408-3-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170127100948.29408-1-cornelius.weig@tngtech.com>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
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

Notes:
    Changes wrt v2:
    	Remove bashism 'local' from test function

 t/t1400-update-ref.sh | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b9084ca..b0ffc0b 100755
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
 
+create_test_commits ()
+{
+	prfx="$1"
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
+	create_test_commits "" &&
+	mkdir $bare &&
+	cd $bare &&
+	git init --bare &&
+	create_test_commits "bare" &&
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

