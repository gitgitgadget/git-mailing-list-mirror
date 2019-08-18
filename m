Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0371F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfHRSoV (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:44:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57730 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfHRSoU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 14:44:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C8F8F60737;
        Sun, 18 Aug 2019 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566153858;
        bh=GeE3xwBrIrluVLDOuzNys1d4xqa5lzvNXINcaEr6Jts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p6cwjioXYhmpKZ3AkZrazuM35pUCvAxh9v0AAgi3RNW8hI+8zd3VBts0JcogE6NMt
         Tog900RHUPHjDP3rMNUrDko2UV37j9Nz4CyRT3KcK8TNQ6trs9fKPFRTWwUTPjohb0
         1fsOfPoyewS06fxCmtAOmf9aFlSEVKaZiPPbWr4UtMrQ4d1iRjN07PMBrfB9su1Igl
         Y4uY5p6eY5gkwcm67VWnkhi7ctEVWz/jqnu1ZzgUZRapft0suLa2xSubx95XG8iN33
         ib0K+8quHUaTSX08LGb2sOY1kdZt7S14sDjI/a7sAXuEwz4xokBIMZ8UxylzOYeIF5
         vxXOcGLlvF522yOooy97xZ8AQl8tniOapbjijUeoLWfDMrzp5ISHixxfPnKX5A4v3O
         KoOYwgLnfcPiX0EVCtZOVrzmo3o1v9PEkn1V9zbGcWLD9Um3npj2ok7JHtFW3KjLMB
         Si45z0fZeW1u5OimtohuLioSY4de9KJdue1K26vqnN9E4hYIEYI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/2] apply: reload .gitattributes after patching it
Date:   Sun, 18 Aug 2019 18:44:03 +0000
Message-Id: <20190818184403.861907-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818184403.861907-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
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
 t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index cde95369bb..d57bc635e4 100644
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
+			if ((patch->new_name && ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE)) ||
+			    (patch->old_name && ends_with_path_components(patch->old_name, GITATTRIBUTES_FILE)))
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
index 80b23fd326..23469cc789 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -301,6 +301,42 @@ test_expect_success 'rebase --am and --show-current-patch' '
 	)
 '
 
+test_expect_success 'rebase --am and .gitattributes' '
+	test_create_repo attributes &&
+	(
+		cd attributes &&
+		test_commit init &&
+		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
+		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
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
+
+		git checkout -b removal HEAD^ &&
+		git rm .gitattributes &&
+		git add -u &&
+		test_commit fifth &&
+		git cherry-pick test &&
+
+		git checkout test &&
+		git rebase master &&
+		grep "smudged" a.txt &&
+
+		git checkout removal &&
+		git reset --hard &&
+		git rebase master &&
+		grep "clean" a.txt
+	)
+'
+
 test_expect_success 'rebase--merge.sh and --show-current-patch' '
 	test_create_repo conflict-merge &&
 	(
