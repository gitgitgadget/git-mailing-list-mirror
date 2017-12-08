Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6CF20C33
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754445AbdLHP72 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:28 -0500
Received: from siwi.pair.com ([209.68.5.199]:55916 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754461AbdLHP7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:22 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B9F0E844F3;
        Fri,  8 Dec 2017 10:59:16 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3F5E5844DE;
        Fri,  8 Dec 2017 10:59:16 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 16/16] t5616: test bulk prefetch after partial fetch
Date:   Fri,  8 Dec 2017 15:58:51 +0000
Message-Id: <20171208155851.855-17-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add test to t5616 to bulk fetch missing objects following
a partial fetch.  A technique like this could be used in
a pre-command hook for example.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5616-partial-clone.sh | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 433e07e..29d8631 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -105,7 +105,7 @@ test_expect_success 'push new commits to server for file.2.txt' '
 	git -C src push -u srv master
 '
 
-# Do FULL fetch by disabling filter-spec using --no-filter.
+# Do FULL fetch by disabling inherited filter-spec using --no-filter.
 # Verify we have all the new blobs.
 test_expect_success 'override inherited filter-spec using --no-filter' '
 	git -C pc1 fetch --no-filter origin &&
@@ -113,4 +113,34 @@ test_expect_success 'override inherited filter-spec using --no-filter' '
 	test_line_count = 0 observed
 '
 
+# create new commits in "src" repo to establish a history on file.3.txt
+# and push to "srv.bare".
+test_expect_success 'push new commits to server for file.3.txt' '
+	for x in a b c d e f
+	do
+		echo "Mod file.3.txt $x" >>src/file.3.txt
+		git -C src add file.3.txt
+		git -C src commit -m "mod $x"
+	done &&
+	git -C src push -u srv master
+'
+
+# Do a partial fetch and then try to manually fetch the missing objects.
+# This can be used as the basis of a pre-command hook to bulk fetch objects
+# perhaps combined with a command in dry-run mode.
+test_expect_success 'manual prefetch of missing objects' '
+	git -C pc1 fetch --filter=blob:none origin &&
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
+		| awk -f print_1.awk \
+		| sed "s/?//" \
+		| sort >observed.oids &&
+	test_line_count = 6 observed.oids &&
+	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
+		| awk -f print_1.awk \
+		| sed "s/?//" \
+		| sort >observed.oids &&
+	test_line_count = 0 observed.oids
+'
+
 test_done
-- 
2.9.3

