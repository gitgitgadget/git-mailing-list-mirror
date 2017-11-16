Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6FE202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966673AbdKPSST (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:18:19 -0500
Received: from siwi.pair.com ([209.68.5.199]:46770 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966652AbdKPSRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:17:44 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 74E3A8455E;
        Thu, 16 Nov 2017 13:17:43 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC55584559;
        Thu, 16 Nov 2017 13:17:37 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 06/15] pack-objects: test support for blob filtering
Date:   Thu, 16 Nov 2017 18:17:14 +0000
Message-Id: <20171116181723.62033-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

As part of an effort to improve Git support for very large repositories
in which clients typically have only a subset of all version-controlled
blobs, test pack-objects support for --filter=blob:limit=<n>, packing only
blobs not exceeding that size unless the blob corresponds to a file
whose name starts with ".git". upload-pack will eventually be taught to
use this new parameter if needed to exclude certain blobs during a fetch
or clone, potentially drastically reducing network consumption when
serving these very large repositories.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5300-pack-object.sh  | 26 ++++++++++++++++++++++++++
 t/test-lib-functions.sh | 12 ++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9c68b99..8e3db12 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -457,6 +457,32 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
+lcut () {
+	perl -e '$/ = undef; $_ = <>; s/^.{'$1'}//s; print $_'
+}
+
+test_expect_success 'filtering by size works with multiple excluded' '
+	rm -rf server &&
+	git init server &&
+	printf a > server/a &&
+	printf b > server/b &&
+	printf c-very-long-file > server/c &&
+	printf d-very-long-file > server/d &&
+	git -C server add a b c d &&
+	git -C server commit -m x &&
+
+	git -C server rev-parse HEAD >objects &&
+	git -C server pack-objects --revs --stdout --filter=blob:limit=10 <objects >my.pack &&
+
+	# Ensure that only the small blobs are in the packfile
+	git index-pack my.pack &&
+	git verify-pack -v my.idx >objectlist &&
+	grep $(git hash-object server/a) objectlist &&
+	grep $(git hash-object server/b) objectlist &&
+	! grep $(git hash-object server/c) objectlist &&
+	! grep $(git hash-object server/d) objectlist
+'
+
 #
 # WARNING!
 #
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2..07b79c7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1020,3 +1020,15 @@ nongit () {
 		"$@"
 	)
 }
+
+# Converts big-endian pairs of hexadecimal digits into bytes. For example,
+# "printf 61620d0a | hex_pack" results in "ab\r\n".
+hex_pack () {
+	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'
+}
+
+# Converts bytes into big-endian pairs of hexadecimal digits. For example,
+# "printf 'ab\r\n' | hex_unpack" results in "61620d0a".
+hex_unpack () {
+	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)'
+}
-- 
2.9.3

