Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27BA207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966577AbcIZTdB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:33:01 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:57463 "EHLO
        homiemail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966564AbcIZTc7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 15:32:59 -0400
Received: from homiemail-a19.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTP id 78CDA604078;
        Mon, 26 Sep 2016 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=novalis.org;
         bh=nBNXFkMHQzYJwFIc5JRs/GuU/90=; b=i3OLJAG9mTGnoQkLlrQbVjQvIgjf
        Em48E8lWkncvCzKiwAJZ/A8h9POm/jfQjLxQcCxWsQzskgacpwSZ5FKMJx9rpUTB
        n2LIyYUyMJaTqb8wwbXRHhxBdPSM+UKq6UnS156XMEDPrbDtBgZd3ajlbOKjsNdf
        xHrZVXjD+vWujek=
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTPSA id C1B59604061;
        Mon, 26 Sep 2016 12:32:57 -0700 (PDT)
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 1/2] tree-walk: be more specific about corrupt tree errors
Date:   Mon, 26 Sep 2016 15:32:44 -0400
Message-Id: <1474918365-10937-2-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
In-Reply-To: <1474918365-10937-1-git-send-email-novalis@novalis.org>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
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
 t/t1007/tree-with-empty-filename | Bin 0 -> 28 bytes
 t/t1007/tree-with-malformed-mode | Bin 0 -> 39 bytes
 tree-walk.c                      |  12 +++++++-----
 4 files changed, 20 insertions(+), 7 deletions(-)
 create mode 100644 t/t1007/tree-with-empty-filename
 create mode 100644 t/t1007/tree-with-malformed-mode

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index acca9ac..cd10c73 100755
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
+	grep "malformed mode in tree entry for tree" err
+'
+
+test_expect_success 'empty filename in tree' '
+	test_must_fail git hash-object -t tree ../t1007/tree-with-empty-filename 2>err &&
+	grep "empty filename in tree entry for tree" err
 '
 
 test_expect_success 'corrupt commit' '
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

