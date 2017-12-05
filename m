Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D0620A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbdLERDZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:25 -0500
Received: from siwi.pair.com ([209.68.5.199]:15330 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752819AbdLERDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:19 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CC5F3844E8;
        Tue,  5 Dec 2017 12:03:18 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5421C844DE;
        Tue,  5 Dec 2017 12:03:18 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 14/14] t5616: end-to-end tests for partial clone
Date:   Tue,  5 Dec 2017 17:02:54 +0000
Message-Id: <20171205170254.65293-15-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Additional end-to-end tests for partial clone.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5616-partial-clone.sh | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100755 t/t5616-partial-clone.sh

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
new file mode 100755
index 0000000..fa573f8
--- /dev/null
+++ b/t/t5616-partial-clone.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+test_description='git partial clone'
+
+. ./test-lib.sh
+
+# create a normal "src" repo where we can later create new commits.
+# expect_1.oids will contain a list of the OIDs of all blobs.
+test_expect_success 'setup normal src repo' '
+	echo "{print \$1}" >print_1.awk &&
+	echo "{print \$2}" >print_2.awk &&
+
+	git init src &&
+	for n in 1 2 3 4
+	do
+		echo "This is file: $n" > src/file.$n.txt
+		git -C src add file.$n.txt
+		git -C src commit -m "file $n"
+		git -C src ls-files -s file.$n.txt >>temp
+	done &&
+	awk -f print_2.awk <temp | sort >expect_1.oids &&
+	test "$(wc -l <expect_1.oids)" = "4"
+'
+
+# bare clone "src" giving "srv.bare" for use as our server.
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/src" srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+# do basic partial clone from "srv.bare"
+# confirm we are missing all of the known blobs.
+# confirm partial clone was registered in the local config.
+test_expect_success 'do partial clone 1' '
+	git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
+	git -C pc1 rev-list HEAD --quiet --objects --missing=print \
+		| awk -f print_1.awk \
+		| sed "s/?//" \
+		| sort >observed.oids &&
+	test_cmp expect_1.oids observed.oids &&
+	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
+	test "$(git -C pc1 config --local extensions.partialclone)" = "origin" &&
+	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
+'
+
+# checkout master to force dynamic object fetch of blobs at HEAD.
+# confirm we now have the expected blobs in a new packfile.
+test_expect_success 'verify checkout with dynamic object fetch' '
+	git -C pc1 checkout master &&
+	(	cd pc1/.git/objects/pack;
+		git verify-pack -v *.pack
+	) >temp &&
+	grep blob <temp \
+		| awk -f print_1.awk \
+		| sort >observed.oids &&
+	test_cmp expect_1.oids observed.oids
+'
+
+# create new commits in "src" repo and push to "srv.bare".
+# repack srv.bare just to make it easy to count the blobs.
+# expect_2.oids will contain a list of the OIDs of all blobs.
+test_expect_success 'push new commits to server' '
+	git -C src remote add srv "file://$(pwd)/srv.bare" &&
+	for x in a b c d
+	do
+		echo "Mod $x" >>src/file.1.txt
+		git -C src add file.1.txt
+		git -C src commit -m "mod $x"
+	done &&
+	git -C src push -u srv master &&
+	git -C srv.bare repack &&
+	(	cd srv.bare/objects/pack;
+		git verify-pack -v *.pack
+	) >temp &&
+	grep blob <temp \
+		| awk -f print_1.awk \
+		| sort >expect_2.oids &&
+	test "$(wc -l <expect_2.oids)" = "8" &&
+	git -C src blame master -- file.1.txt >expect.blame
+'
+
+# fetch in the partial clone repo from the server (the promisor remote).
+# verify that fetch was a "partial fetch".
+# [] that it inherited the filter settings
+# [] that is DOES NOT have the new blobs.
+test_expect_success 'partial fetch inherits filter settings' '
+	git -C pc1 fetch origin &&
+	(	cd pc1/.git/objects/pack;
+		git verify-pack -v *.pack
+	) >temp &&
+	grep blob <temp \
+		| awk -f print_1.awk \
+		| sort >observed.oids &&
+	test_cmp expect_1.oids observed.oids
+'
+
+# force dynamic object fetch using diff.
+# we should only get 1 new blob (for the file in origin/master).
+# it should be in a new packfile (since the promisor boundary is
+# currently a packfile, it should not get unpacked upon receipt.)
+test_expect_success 'verify diff causes dynamic object fetch' '
+	test "$(wc -l <observed.oids)" = "4" &&
+		cat observed.oids &&
+	git -C pc1 diff master..origin/master -- file.1.txt &&
+	(	cd pc1/.git/objects/pack;
+		git verify-pack -v *.pack
+	) >temp &&
+	grep blob <temp \
+		| awk -f print_1.awk \
+		| sort >observed.oids &&
+		cat observed.oids &&
+	test "$(wc -l <observed.oids)" = "4"
+'
+
+# force dynamic object fetch using blame.
+# we should get the intermediate blobs for the file.
+# we may get multiple packfiles (one for each blob/commit) or
+# we may get a single new packfile, but we don't care.
+test_expect_success 'verify blame causes dynamic object fetch' '
+	git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
+	test_cmp expect.blame observed.blame
+'
+
+test_done
-- 
2.9.3

