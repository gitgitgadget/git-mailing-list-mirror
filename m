Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A528D20986
	for <e@80x24.org>; Tue, 27 Sep 2016 00:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756226AbcI0AMD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 20:12:03 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:36194 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756200AbcI0AL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 20:11:59 -0400
Received: from homiemail-a12.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id AF577E4389
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 17:11:58 -0700 (PDT)
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id B6CA4103006A;
        Mon, 26 Sep 2016 17:11:56 -0700 (PDT)
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 465171030063;
        Mon, 26 Sep 2016 17:11:56 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, David Turner <dturner@twosigma.com>
Subject: [PATCH 1/3] tree-walk: be more specific about corrupt tree errors
Date:   Mon, 26 Sep 2016 20:11:31 -0400
Message-Id: <1474935093-26757-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When the tree-walker runs into an error, it just calls
die(), and the message is always "corrupt tree file".
However, we are actually covering several cases here; let's
give the user a hint about what happened.

Let's also avoid using the word "corrupt", which makes it
seem like the data bit-rotted on disk. Our sha1 check would
already have found that. These errors are ones of data that
is malformed in the first place.

Signed-off-by: David Turner <dturner@twosigma.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1007-hash-object.sh           |  15 +++++++++++++--
 t/t1007/.gitattributes           |   1 +
 t/t1007/tree-with-empty-filename | Bin 0 -> 28 bytes
 t/t1007/tree-with-malformed-mode | Bin 0 -> 39 bytes
 tree-walk.c                      |  12 +++++++-----
 5 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 t/t1007/.gitattributes
 create mode 100644 t/t1007/tree-with-empty-filename
 create mode 100644 t/t1007/tree-with-malformed-mode

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index acca9ac..f21848b 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -183,9 +183,20 @@ for args in "-w --stdin-paths" "--stdin-paths -w"; do
 	pop_repo
 done
 
-test_expect_success 'corrupt tree' '
+test_expect_success 'too-short tree' '
 	echo abc >malformed-tree &&
-	test_must_fail git hash-object -t tree malformed-tree
+	test_must_fail git hash-object -t tree malformed-tree 2>err &&
+	grep "too-short tree object" err
+'
+
+test_expect_success 'malformed mode in tree' '
+	test_must_fail git hash-object -t tree ../t1007/tree-with-malformed-mode 2>err &&
+	grep "malformed mode in tree entry" err
+'
+
+test_expect_success 'empty filename in tree' '
+	test_must_fail git hash-object -t tree ../t1007/tree-with-empty-filename 2>err &&
+	grep "empty filename in tree entry" err
 '
 
 test_expect_success 'corrupt commit' '
diff --git a/t/t1007/.gitattributes b/t/t1007/.gitattributes
new file mode 100644
index 0000000..7352ef5
--- /dev/null
+++ b/t/t1007/.gitattributes
@@ -0,0 +1 @@
+tree-with-*	-diff
diff --git a/t/t1007/tree-with-empty-filename b/t/t1007/tree-with-empty-filename
new file mode 100644
index 0000000000000000000000000000000000000000..aeb1ceb20e485eebd0acbb81c974d1c6fedcc1fe
GIT binary patch
literal 28
kcmXpsFfcPQQDAsB_tET47q2;ccWbUIkGgT_Nl)-Z0Hx{;SO5S3

literal 0
HcmV?d00001

diff --git a/t/t1007/tree-with-malformed-mode b/t/t1007/tree-with-malformed-mode
new file mode 100644
index 0000000000000000000000000000000000000000..24aa84d60ef8e269fb0b29c67b5208639b9da3ae
GIT binary patch
literal 39
vcmYewPcJRb%}+^HNXyJg%}dNpWq3CC(d<nZuQ_{nYpyGgx^d`9Pw+$lU*Quk

literal 0
HcmV?d00001

diff --git a/tree-walk.c b/tree-walk.c
index ce27842..ba544cf 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -27,12 +27,14 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
 	const char *path;
 	unsigned int mode, len;
 
-	if (size < 24 || buf[size - 21])
-		die("corrupt tree file");
+	if (size < 23 || buf[size - 21])
+		die("too-short tree object");
 
 	path = get_mode(buf, &mode);
-	if (!path || !*path)
-		die("corrupt tree file");
+	if (!path)
+		die("malformed mode in tree entry for tree");
+	if (!*path)
+		die("empty filename in tree entry for tree");
 	len = strlen(path) + 1;
 
 	/* Initialize the descriptor entry */
@@ -81,7 +83,7 @@ void update_tree_entry(struct tree_desc *desc)
 	unsigned long len = end - (const unsigned char *)buf;
 
 	if (size < len)
-		die("corrupt tree file");
+		die("too-short tree file");
 	buf = end;
 	size -= len;
 	desc->buffer = buf;
-- 
2.8.0.rc4.22.g8ae061a

