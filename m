Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476DA20986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933699AbcI0PXf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:23:35 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:41174 "EHLO
        homiemail-a15.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933558AbcI0PXe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 11:23:34 -0400
X-Greylist: delayed 54697 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Sep 2016 11:23:34 EDT
Received: from homiemail-a15.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a15.g.dreamhost.com (Postfix) with ESMTP id 58C5C76C072;
        Tue, 27 Sep 2016 08:23:33 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a15.g.dreamhost.com (Postfix) with ESMTPSA id E1CCC76C06F;
        Tue, 27 Sep 2016 08:23:32 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v3 1/3] tree-walk: be more specific about corrupt tree errors
Date:   Tue, 27 Sep 2016 11:23:24 -0400
Message-Id: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
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
 t/t1007-hash-object.sh | 21 +++++++++++++++++++--
 tree-walk.c            | 12 +++++++-----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index acca9ac..0691b88 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -183,9 +183,26 @@ for args in "-w --stdin-paths" "--stdin-paths -w"; do
 	pop_repo
 done
 
-test_expect_success 'corrupt tree' '
+test_expect_success 'too-short tree' '
 	echo abc >malformed-tree &&
-	test_must_fail git hash-object -t tree malformed-tree
+	test_must_fail git hash-object -t tree malformed-tree 2>err &&
+	test_i18ngrep "too-short tree object" err
+'
+
+test_expect_success 'malformed mode in tree' '
+	hex_sha1=$(echo foo | git hash-object --stdin -w) &&
+	bin_sha1=$(echo $hex_sha1 | perl -ne "printf \"\\\\%03o\", ord for /../g") &&
+	printf "9100644 \0$bin_sha1" >tree-with-malformed-mode &&
+	test_must_fail git hash-object -t tree tree-with-malformed-mode 2>err &&
+	test_i18ngrep "malformed mode in tree entry" err
+'
+
+test_expect_success 'empty filename in tree' '
+	hex_sha1=$(echo foo | git hash-object --stdin -w) &&
+	bin_sha1=$(echo $hex_sha1 | perl -ne "printf \"\\\\%03o\", ord for /../g") &&
+	printf "100644 \0$bin_sha1" >tree-with-empty-filename &&
+	test_must_fail git hash-object -t tree tree-with-empty-filename 2>err &&
+	test_i18ngrep "empty filename in tree entry" err
 '
 
 test_expect_success 'corrupt commit' '
diff --git a/tree-walk.c b/tree-walk.c
index ce27842..24f9a0f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -27,12 +27,14 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
 	const char *path;
 	unsigned int mode, len;
 
-	if (size < 24 || buf[size - 21])
-		die("corrupt tree file");
+	if (size < 23 || buf[size - 21])
+		die(_("too-short tree object"));
 
 	path = get_mode(buf, &mode);
-	if (!path || !*path)
-		die("corrupt tree file");
+	if (!path)
+		die(_("malformed mode in tree entry for tree"));
+	if (!*path)
+		die(_("empty filename in tree entry for tree"));
 	len = strlen(path) + 1;
 
 	/* Initialize the descriptor entry */
@@ -81,7 +83,7 @@ void update_tree_entry(struct tree_desc *desc)
 	unsigned long len = end - (const unsigned char *)buf;
 
 	if (size < len)
-		die("corrupt tree file");
+		die(_("too-short tree file"));
 	buf = end;
 	size -= len;
 	desc->buffer = buf;
-- 
2.8.0.rc4.22.g8ae061a

