Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABFCD209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbcJNNUY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755208AbcJNNSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:09 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B96EE3D95D
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 13:17:28 +0000 (UTC)
Received: from pirat-work.redhat.com (vpn1-4-60.ams2.redhat.com [10.36.4.60])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9EDHAJi008901;
        Fri, 14 Oct 2016 09:17:27 -0400
From:   Petr Stodulka <pstodulk@redhat.com>
To:     git@vger.kernel.org
Cc:     pstodulk@redhat.com
Subject: [PATCH 1/2] Add test for ls-tree with broken symlink under refs/heads
Date:   Fri, 14 Oct 2016 15:16:51 +0200
Message-Id: <1476451012-9925-2-git-send-email-pstodulk@redhat.com>
In-Reply-To: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Oct 2016 13:17:28 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git ls-tree goes into an infinite loop while serving pretty vanilla requests,
if the refs/heads/ directory contains a symlink that's broken. Added test
which check if git ends with expected exit code or timeout expires.
---
 t/t3103-ls-tree-misc.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 09dcf04..faf79c4 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -21,4 +21,13 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+test_expect_success 'ls-tree fails due to broken symlink instead of infinite loop' '
+	mkdir foo_infinit &&
+	cd foo_infinit &&
+	git init testrepo &&
+	cd testrepo &&
+	mkdir -p .git/refs/remotes &&
+	ln -s ../remotes/foo .git/refs/heads/bar &&
+	test_expect_code 128 timeout 2 git ls-tree bar
+'
 test_done
-- 
2.5.5

