Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F881F45A
	for <e@80x24.org>; Sun, 11 Aug 2019 17:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHKRsO (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 13:48:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57464 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfHKRsO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Aug 2019 13:48:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e9dc:6bd6:18c8:c98f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 529A260821;
        Sun, 11 Aug 2019 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565545691;
        bh=gGu6v6eNS4vhrghqEcYFQnM0C/e0lCtMYaXmf2NN7ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PykWM/dhSsbpiGzLbVT5NItzrnpZIRpropyy1miHtoXRuKxHrr0WoOzRARdU/Mdbh
         XYwtduwIaIwW1A/jii2DDU19/nn0/v0w3Haga4wV7wkAJTI5VXJxfrKbOe5gh+44vN
         vci8mbDH86FWSw9vzvzgCSYtJQVkkotruRJWrwxZItZqcHXiS9i6zab16wOh1ACVOR
         40Jpy6j3mlNtVbYNK0vkh/S72hkgJmctzOzeSU3FctSTx/iB6EHkqj/0hValiRQ8G8
         gMsg6q9rqAA9ftbPSRcGnT5J7KS6Nfs8xanvqTvbBrn29Nr/lkeYKcnpB39dLDTT2Z
         yw3aok8Uzi/+y2GpCULkjZpvdtY+9gyA1o1rIK4mRuyu5dZb6606IOkuBAMJGGpewn
         1gZs7bcylMw9DUgSq/cbMGh6r3dtWMurCFbywu28AdL7qQrU/OYzbvZzy8bpQr+gAN
         hFlz4HQ8TB5t1mmuL6luSWLu8FKDvlNAO6IhD3f3hItw0JNhVhC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] apply: reload .gitattributes after patching it
Date:   Sun, 11 Aug 2019 17:47:48 +0000
Message-Id: <20190811174748.33552-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190811174748.33552-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying multiple patches with git am, or when rebasing using the
am backend, it's possible that one of our patches has updated a
gitattributes file. Currently, we cache this information, so if a
file in a subsequent patch has attributes applied, the file will be
written out with the attributes in place as of the time we started the
rebase or am operation, not with the attributes applied by the previous
patch. This problem does not occur when using the -m or -i flags to
rebase.

To ensure we write the correct data into the working tree, expire the
cache after each patch that touches a path ending in ".gitattributes".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 apply.c           |  7 +++++++
 convert.c         |  9 ++++++++-
 convert.h         |  6 ++++++
 t/t3400-rebase.sh | 23 +++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index cde95369bb..201ee12e21 100644
--- a/apply.c
+++ b/apply.c
@@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 	int res = 0;
+	int flush_attributes = 0;
 
 	state->patch_input_file = filename;
 	if (read_patch_file(&buf, fd) < 0)
@@ -4670,6 +4671,10 @@ static int apply_patch(struct apply_state *state,
 			patch_stats(state, patch);
 			*listp = patch;
 			listp = &patch->next;
+
+			if (!flush_attributes && patch->new_name &&
+			    has_path_suffix(patch->new_name, GITATTRIBUTES_FILE))
+				flush_attributes = 1;
 		}
 		else {
 			if (state->apply_verbosity > verbosity_normal)
@@ -4746,6 +4751,8 @@ static int apply_patch(struct apply_state *state,
 	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
+	if (flush_attributes)
+		reset_parsed_attributes();
 end:
 	free_patch_list(list);
 	strbuf_release(&buf);
diff --git a/convert.c b/convert.c
index 94ff837649..030e9b81b9 100644
--- a/convert.c
+++ b/convert.c
@@ -1293,10 +1293,11 @@ struct conv_attrs {
 	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
+static struct attr_check *check;
+
 static void convert_attrs(const struct index_state *istate,
 			  struct conv_attrs *ca, const char *path)
 {
-	static struct attr_check *check;
 	struct attr_check_item *ccheck = NULL;
 
 	if (!check) {
@@ -1339,6 +1340,12 @@ static void convert_attrs(const struct index_state *istate,
 		ca->crlf_action = CRLF_AUTO_INPUT;
 }
 
+void reset_parsed_attributes(void)
+{
+	attr_check_free(check);
+	check = NULL;
+}
+
 int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
 {
 	struct conv_attrs ca;
diff --git a/convert.h b/convert.h
index 831559f10d..3710969d43 100644
--- a/convert.h
+++ b/convert.h
@@ -94,6 +94,12 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 int would_convert_to_git_filter_fd(const struct index_state *istate,
 				   const char *path);
 
+/*
+ * Reset the internal list of attributes used by convert_to_git and
+ * convert_to_working_tree.
+ */
+void reset_parsed_attributes(void);
+
 /*****************************************************************
  *
  * Streaming conversion support
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 80b23fd326..062dc41df7 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -301,6 +301,29 @@ test_expect_success 'rebase --am and --show-current-patch' '
 	)
 '
 
+test_expect_success 'rebase --am and .gitattributes' '
+	test_create_repo attributes &&
+	(
+		cd attributes &&
+		test_commit init &&
+		test_config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
+		test_config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
+
+		test_commit second &&
+		git checkout -b test HEAD^ &&
+
+		echo "*.txt filter=test" >.gitattributes &&
+		git add .gitattributes &&
+		test_commit third &&
+
+		echo "This text is smudged." >a.txt &&
+		git add a.txt &&
+		test_commit fourth &&
+		git rebase master &&
+		grep "smudged" a.txt
+	)
+'
+
 test_expect_success 'rebase--merge.sh and --show-current-patch' '
 	test_create_repo conflict-merge &&
 	(
