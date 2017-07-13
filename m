Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA988202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbdGMRfl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:11060 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbdGMRfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 069C0844E9;
        Thu, 13 Jul 2017 13:35:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4C9EF844E5;
        Thu, 13 Jul 2017 13:35:37 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 10/19] t6112: rev-list object filtering test
Date:   Thu, 13 Jul 2017 17:34:50 +0000
Message-Id: <20170713173459.3559-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t6112-rev-list-filters-objects.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 t/t6112-rev-list-filters-objects.sh

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
new file mode 100644
index 0000000..ded2b04
--- /dev/null
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='git rev-list with object filtering'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	for n in 1 2 3 4 5 ; do \
+		echo $n > file.$n ; \
+		git add file.$n ; \
+		git commit -m "$n" ; \
+	done
+'
+
+test_expect_success 'omit-all-blobs omitted 5 blobs' '
+	git rev-list HEAD --objects --filter-print-manifest --filter-omit-all-blobs >omit_all &&
+	grep "^~" omit_all >omitted &&
+	test $(cat omitted | wc -l) = 5
+'
+
+test_expect_success 'omit-all-blobs blob sha match' '
+	git rev-list HEAD --objects >normal &&
+	awk "/file/ {print \$1;}" <normal | sort >normal_sha &&
+	sed "s/~//" <omitted | awk "{print \$1;}" | sort >omit_all_sha &&
+	test_cmp normal_sha omit_all_sha
+'
+
+test_expect_success 'omit-all-blobs nothing else changed' '
+	grep -v "file" <normal | sort >normal_other &&
+	grep -v "~" <omit_all | sort >omit_other &&
+	test_cmp normal_other omit_other
+'
+
+# TODO test filter-omit-large-blobs
+# TODO test filter-use-sparse
+
+test_done
-- 
2.9.3

